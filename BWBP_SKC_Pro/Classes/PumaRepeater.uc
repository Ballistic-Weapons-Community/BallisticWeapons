//=============================================================================
// PumaRepeater.
//
// Automatic GL. Light grenades. Energy. Airburst. Combat Effective. Simon.
// Alt fire activates a shielding system.
//
// Shield will block 200 damage. (100 HP) Dmg > 50 will bleed through.
// Shield can be used to shield jump by firing a grenade into it.
// A shield jump with an intact shield will cost 30 hp and will propell player.
// A shield jump with a damaged shield will not protect or propell the player.
// Intact shields will either be turned off or damaged.
// Damaged shields will be completely destroyed.
//
// If the shield goes below -40 hp it gets destroyed. Heavy weapons and close
// range dets are the best way to accomplish this.
//
// Grenades can be proximity airburst at a slow RoF, or dumb/timer det at high RoF.
// Gun has a working range finder.
//
// by Sarge with netcode by Azarael
// based on code by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUMARepeater extends BallisticWeapon;
var bool		bFirstDraw;
var bool		bPierce;
var bool		bBroken; //Ooops, your broke the shield emitter.
var name			BulletBone;
var() name			ShieldBone;			// Bone to attach SightFX to
var float		ShieldPower;	// From 100 to 0
var Sound       ShieldHitSound;
var Sound       ShieldOnSound;
var Sound       ShieldOffSound;
var Sound       ShieldPierceSound;
var String		ShieldHitForce;
var bool	bShieldUp; //Shield is online
var bool	bOldShieldUp;
var() Sound		DamageSound;		// Sound to play when it first breaks
var() Sound		BrokenSound;		// Sound to play when its very damaged

var() Sound		ClipOutSoundEmpty;		// For reloading


var float FrequencyModulator; //Distance before det
var float LastRangeFound;
var int LastRangeFoundM; //Metric distance. Is a bit off.
var float PriDetRange;
var int PriDetRangeM;
var() ScriptedTexture WeaponScreen;

var	int	NumpadYOffset1; //Used for rangefinder
var	int	NumpadYOffset2;
var	int	NumpadYOffset3;


var	int	NumpadYOffset4; //Used for rangefinder post designation
var	int	NumpadYOffset5;
var	int	NumpadYOffset6;

var() Material	Screen;
var() Material	ScreenBaseX; //Used for shield power - selector
var() Material	ScreenBaseY; //Used for rangefinder - selector
var() Material	ScreenBase1; //Used for range finder
var() Material	ScreenBase2; //
var() Material	ScreenBase3; //Low shield power
var() Material	ScreenBase4; //Rangefinder screen + range set
var() Material	ScreenBase5; //Rangefinder screen + range set + danger close
var() Material	Numbers;
var protected const color MyFontColor; //Why do I even need this?
var bool		bRangeSet;


var() sound		RangeBeepSound;		// Rangefinder's beep!

var Actor	Arc;				// The top arcs
var actor GlowFX;
var PumaShieldEffect PumaShieldEffect;
var() float AmmoRegenTime;
var() float ChargeupTime;
var	  float RampTime;
var Sound ChargingSound;                // charging sound
var() byte	ShieldSoundVolume;


replication
{
	// Things the server should send to the client.
	reliable if( bNetOwner && bNetDirty && (Role==ROLE_Authority) )
		ShieldPower;
	reliable if (Role == ROLE_Authority)
        	ClientTakeHit, ClientScreenStart, ClientSwitchCannonMode, ClientAdjustProps, bShieldUp;
	reliable if( Role<ROLE_Authority )
		ServerSwitchRange, ServerSwitchShield, ServerAdjustProps;
		
}


simulated event PostNetReceive()
{
	if (bShieldUp != bOldShieldUp)
	{
		bOldShieldUp = bShieldUp;
		AdjustShieldProperties(bShieldUp);
	}
	Super.PostNetReceive();
}


//========================== RANGE FINDER NON-STATIC TEXTURE ============


simulated function ClientScreenStart()
{
	ScreenStart();
}
// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[4] = Screen;
	if (!bRangeSet)
		ScreenBaseY=ScreenBase1;
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}


simulated event Destroyed()
{

	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;


	if (Arc != None)	
		Arc.Destroy();
	if (GlowFX != None)
		GlowFX.Destroy();
	if (Instigator.AmbientSound != None)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}

	super.Destroyed();
}

simulated event RenderTexture( ScriptedTexture Tex )
{

	if (bShieldUp)
		Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenBaseX, MyFontColor);
	else
		Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenBaseY, MyFontColor);
	Tex.DrawTile(0,70,100,100,30,NumpadYOffset1,50,50,Numbers, MyFontColor);
	Tex.DrawTile(50,70,100,100,30,NumpadYOffset2,50,50,Numbers, MyFontColor);
	Tex.DrawTile(100,70,100,100,30,NumpadYOffset3,50,50,Numbers, MyFontColor);

	if (bRangeSet && !bShieldUp)
	{
		Tex.DrawTile(90,5,50,50,30,NumpadYOffset4,50,50,Numbers, MyFontColor);
		Tex.DrawTile(110,5,50,50,30,NumpadYOffset5,50,50,Numbers, MyFontColor);
		Tex.DrawTile(130,5,50,50,30,NumpadYOffset6,50,50,Numbers, MyFontColor);
	}
	
}

	
simulated function UpdateScreen() //Force a screen update
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;
	if (ShieldPower < 40)
		ScreenBaseX=ScreenBase3;
	else
		ScreenBaseX=ScreenBase2;

	if (bRangeSet)
	{
		if (PriDetRangeM >= 100)
		{
			NumpadYOffset4=(5+(PriDetRangeM/100)*49); //Hundreds place
			NumpadYOffset5=(5+(PriDetRangeM/10 % 10)*49);  //Tens place
			NumpadYOffset6=(5+((PriDetRangeM%100)%10)*49);  //Ones place
		}
		else if (PriDetRangeM >= 15)
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(5+(PriDetRangeM/10)*49);
			NumpadYOffset6=(5+(PriDetRangeM%10)*49);
		}
		else //Won't go lower than 15
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(54);
			NumpadYOffset6=(250);
		}
	}

	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}

//=====================================================================

function ServerSwitchWeaponMode (byte newMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		PumaPrimaryFire(FireMode[0]).SwitchCannonMode(CurrentWeaponMode);
	ClientSwitchCannonMode (CurrentWeaponMode);
}
simulated function ClientSwitchCannonMode (byte newMode)
{
	PumaPrimaryFire(FireMode[0]).SwitchCannonMode(newMode);
}


//Adjusts fire rate properties for close range airburst and blue rapid-firing variant
function ServerAdjustProps(byte newMode)
{
	if (!Instigator.IsLocallyControlled())
		PumaPrimaryFire(FireMode[0]).AdjustProps(newMode);
	ClientAdjustProps(newMode);
}
simulated function ClientAdjustProps(byte newMode)
{
	PumaPrimaryFire(FireMode[0]).AdjustProps(newMode);
}




simulated function BringUp(optional Weapon PrevWeapon)
{

	if (Instigator != None && AIController(Instigator.Controller) == None)
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}

	SetBoneScale (0, 0.0, ShieldBone);

    	if (PumaShieldEffect == None)
        	PumaShieldEffect = Spawn(class'PumaShieldEffect', instigator);


//	AttachToBone(PumaShieldEffect, ShieldBone);

	if (bFirstDraw && MagAmmo > 0)
	{
     		BringUpTime=default.BringUpTime*2;
     		SelectAnim='Pullout';
		bFirstDraw=false;
	}
	else
	{
     		BringUpTime=default.BringUpTime;
		SelectAnim='Pullout';
	}

	Super.BringUp(PrevWeapon);
	GunLength = default.GunLength;

}


simulated function bool PutDown()
{
	if (bShieldUp)
	{
		bShieldUp=false;
		AdjustShieldProperties();
	}
	if (super.PutDown())
	{
		if (Arc != None)	Arc.Destroy();
		return true;
	}
	return false;
}

//=====================================================
//			RANGE SETTING
//=====================================================


//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i) //Programs PUMA distance det
{
	PriDetRange = LastRangeFound/6000;
	PriDetRangeM = LastRangeFoundM; //Shows distance in 'meters'
	ServerAdjustProps(2);
	ServerSwitchRange(PriDetRange);
	SwitchRange(PriDetRange);

}


function ServerSwitchRange(float NewRange)
{
	if (!Instigator.IsLocallyControlled())
	{
		PumaPrimaryFire(FireMode[0]).SetDet(NewRange);
	}
        bRangeSet=true;
	if (LastRangeFoundM < 30)
		ScreenBaseY=ScreenBase5;
	else
        	ScreenBaseY=ScreenBase4;
	UpdateScreen();
}


simulated function SwitchRange(float NewRange)
{
	PumaPrimaryFire(FireMode[0]).SetDet(NewRange);
    	PlaySound(RangeBeepSound, SLOT_None);
        bRangeSet=true;
	if (LastRangeFoundM < 30)
		ScreenBaseY=ScreenBase5;
	else
        	ScreenBaseY=ScreenBase4;
	UpdateScreen();
}

//=====================================================
//			SHIELD CODE
//=====================================================

exec simulated function ShieldDeploy(optional byte i) //Was previously weapon special
{
	if (Clientstate != WS_ReadyToFire || bBroken)
		return;
	if (bShieldUp)
    		PlaySound(ShieldOffSound, SLOT_None);
	else
    		PlaySound(ShieldOnSound, SLOT_None);
	bShieldUp = !bShieldUp;

	ServerSwitchShield(bShieldUp);
	AdjustShieldProperties();
}

function ServerSwitchShield(bool bNewValue)
{
    local PUMAAttachment Attachment;

	bShieldUp = bNewValue;
    Attachment = PUMAAttachment(ThirdPersonActor);
   
    if( Attachment != None && Attachment.PUMAShieldEffect3rd != None )
	{
		if (bShieldUp)
        		Attachment.PUMAShieldEffect3rd.bHidden = false;
		else
        		Attachment.PUMAShieldEffect3rd.bHidden = true;
	}
	
	//Change projectile
	//OnFireParamsChanged

	AdjustShieldProperties();
}


simulated function AdjustShieldProperties(optional bool bDepleted)
{
    local ShieldAttachment Attachment;

	if (bShieldUp && !bDepleted && !bBroken)
	{
    		Instigator.AmbientSound = ChargingSound;
    		Instigator.SoundVolume = ShieldSoundVolume;
    		if( Attachment != None && Attachment.ShieldEffect3rd != None )
        		Attachment.ShieldEffect3rd.bHidden = false;

		UpdateScreen();

		if (Arc == None)
			class'bUtil'.static.InitMuzzleFlash(Arc, class'M2020ShieldEffect', DrawScale, self, 'tip');
        	PumaShieldEffect.Flash(0, ShieldPower);
	}
	else
	{

    		Attachment = ShieldAttachment(ThirdPersonActor);
		Instigator.AmbientSound = None;
    		Instigator.SoundVolume = Instigator.Default.SoundVolume;
    
    		if( Attachment != None && Attachment.ShieldEffect3rd != None )
    		{
        		Attachment.ShieldEffect3rd.bHidden = true;
        		StopForceFeedback( "ShieldNoise" );  // jdf
    		}

		if (Arc != None)
			Emitter(Arc).kill();
	}
}


simulated event Tick (float DT)
{
	if (ShieldPower < 100)
	{
		if (!bShieldUp && !bBroken)
			ShieldPower = FMin(ShieldPower + 5.0 * DT, 100);
	}

	super.Tick(DT);
}


function SetBrightness(bool bHit)
{
    local PUMAAttachment Attachment;
 	local float Brightness;

	Brightness = ShieldPower;
	if ( RampTime < ChargeUpTime )
		Brightness *= RampTime/ChargeUpTime; 
    if (PumaShieldEffect != None)
        PumaShieldEffect.SetBrightness(Brightness);

    Attachment = PUMAAttachment(ThirdPersonActor);
    if( Attachment != None )
        Attachment.SetBrightness(Brightness, bHit);
}


simulated function TakeHit(int Drain)
{
    if (PumaShieldEffect != None)
    {
        PumaShieldEffect.Flash(Drain, ShieldPower);
    }
	if (ShieldPower < 10 )
	{
		ServerSwitchShield(false);
		bShieldUp=false;
            	AdjustShieldProperties(true);
		if (ShieldPower <= -40)
		{
			bBroken=true;
			AmbientSound = None;
			Instigator.AmbientSound = BrokenSound;
			Instigator.SoundVolume = default.SoundVolume;
			Instigator.SoundPitch = default.SoundPitch;
			Instigator.SoundRadius = default.SoundRadius;
			Instigator.bFullVolume = true;
    			if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
				class'BUtil'.static.InitMuzzleFlash (GlowFX, class'PumaGlowFXDamaged', DrawScale, self, 'tip');
		}
	}
	UpdateScreen();
    SetBrightness(true);
}

//=====================================================
//			MISC
//=====================================================


simulated event Timer()
{
	local vector Start, HitLoc, HitNorm;
	local actor T;

	if (ClientState == WS_ReadyToFire)
	{
		Start = Instigator.Location + Instigator.EyePosition();
		T = Trace(HitLoc, HitNorm, Start + vector(Instigator.GetViewRotation()) * 15000, Start, true);
		if (T == None)
			LastRangeFound = -1;
		else
		{
			LastRangeFound = VSize(HitLoc-Start);
			LastRangeFoundM = int(LastRangeFound/44);
		}
		return;
	}
	if (ClientState == WS_BringUp)
		SetTimer(0.2, true);
	else
		SetTimer(0.0, false);

	if (Clientstate == WS_PutDown)
		class'BUtil'.static.KillEmitterEffect(GlowFX);

	super.Timer();
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 400)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
		return 1;

	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	// Enemy too far away
	if (Dist > 1000)
		Result -= (Dist-1000) / 2000;
	// If the enemy has a knife too, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.1 * B.Skill;
	// Sniper bad, very bad
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.3;
	Result += 1 - Dist / 1000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

//=====================================================
//			SHIELD DAMAGE + OVERLAYS
//=====================================================


simulated event RenderOverlays( Canvas Canvas )
{
	local coords Z;

	if (bShieldUp)
	{
		if (ShieldPower >= 100)
		{
			NumpadYOffset1=(5+(int(ShieldPower)/100)*49); //Hundreds place
			NumpadYOffset2=(5+(int(ShieldPower)/10 % 10)*49);  //Tens place
			NumpadYOffset3=(5+((int(ShieldPower)%100)%10)*49);  //Ones place
		}
		else if (ShieldPower >= 10)
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5+(int(ShieldPower)/10)*49);
			NumpadYOffset3=(5+(int(ShieldPower)%10)*49);
		}
		else if (ShieldPower >= 0)
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5);
			NumpadYOffset3=(5+int(ShieldPower)*49);
		}
		else
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5);
			NumpadYOffset3=(5);
		}

	}
	else
	{
		if (LastRangeFoundM >= 100)
		{
			NumpadYOffset1=(5+(LastRangeFoundM/100)*49); //Hundreds place
			NumpadYOffset2=(5+(LastRangeFoundM/10 % 10)*49);  //Tens place
			NumpadYOffset3=(5+((LastRangeFoundM%100)%10)*49);  //Ones place
		}
		else if (LastRangeFoundM >= 10)
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5+(LastRangeFoundM/10)*49);
			NumpadYOffset3=(5+(LastRangeFoundM%10)*49);
		}
		else if (LastRangeFoundM >= 0)
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5);
			NumpadYOffset3=(5+LastRangeFoundM*49);
		}
		else
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5);
			NumpadYOffset3=(5);
		}
	}


	if (Instigator.IsLocallyControlled())
	{
		WeaponScreen.Revision++;
	}

	if (bShieldUp && PumaShieldEffect != None)
	{
		Z = GetBoneCoords(ShieldBone);
        	PumaShieldEffect.SetLocation(Z.Origin);
		PumaShieldEffect.SetRotation( Instigator.GetViewRotation() );
//                PumaShieldEffect.SetRelativeRotation(rotation  + rot(0, 32768, 32768));
        	Canvas.DrawActor( PumaShieldEffect, false, false, DisplayFOV );
    	}
    Super.RenderOverlays(Canvas);

}
/*

simulated function StartShield()
{
	if (Role==ROLE_Authority)
		MRS138Attachment(ThirdPersonActor).bTazerOn = true;
	if (Instigator.IsLocallyControlled() && TazerEffect == None)
	{
		TazerEffect = Spawn(class'MRS138TazerEffect',self,,location);
		class'BallisticEmitter'.static.ScaleEmitter(TazerEffect, DrawScale);
		AttachToBone(TazerEffect, 'tip2');
	}

}

simulated function KillShield()
{
	if (TazerEffect != None)
		TazerEffect.Kill();
	if (Role==ROLE_Authority && ThirdPersonActor != None)
		MRS138Attachment(ThirdPersonActor).bTazerOn = false;
}*/



function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation,
						         out Vector Momentum, class<DamageType> DamageType)
{
    local int Drain;
	local vector Reflect;
    local vector HitNormal;
    local float DamageMax;



	DamageMax = 50.0;
	//if (CamoIndex == 3)
	if ( DamageType == class'Fell' )
		DamageMax = 20.0;
	else if (class<DT_PumaSelf>(DamageType) != none && bShieldUp &&  ShieldPower > 0) //Shield Jump
	{
		Damage = 70;
		if (ShieldPower >= 40)
		{
			Damage = 30;
        		Momentum *= -2.00;
		}
		ShieldPower -= 80;
    		ClientTakeHit(80);
		return;
	}
	else if (class<DTXM84GrenadeRadius>(DamageType) != none && bShieldUp)
	{
//		ShieldPower = -200;
    		ClientTakeHit(200, 200);
		return;
	}
    	else if( !DamageType.default.bArmorStops /*|| !DamageType.default.bLocationalHit */|| (DamageType == class'DamTypeShieldImpact' && InstigatedBy == Instigator) )
        	return;

    if ( CheckReflect(HitLocation, HitNormal, 0) )
    {
        Drain = Min( ShieldPower*2, Damage );
	Drain = Min(Drain,DamageMax);
	Reflect = MirrorVectorByNormal( Normal(Location - HitLocation), Vector(Instigator.Rotation) );
	if (Damage > DamageMax) //Piercing (50+) damage will bleed through and heavily damage shield.
	{
		bPierce=true;
		Drain+=10;
	}
        Damage -= Drain;
        Momentum *= 1.25;
        if ( (Instigator != None) && (Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.HasFlag != None) )
        {
			Drain = Min(ShieldPower, Drain);
			ShieldPower -= Drain;
			DoReflectEffectA(Drain, bPierce);
	}
        else
        {
			ShieldPower -= Drain/2;
			DoReflectEffectA(Drain/2, bPierce);
	}
	bPierce=false;
    }
}

function DoReflectEffectA(int Drain, bool bPierce)
{
    	if (bPierce)
    		PlaySound(ShieldPierceSound, SLOT_None);
    	else
    		PlaySound(ShieldHitSound, SLOT_None);
    	ClientTakeHit(Drain);
}

simulated function ClientTakeHit(int Drain, optional int ExtDrain)
{
	
//	ShieldPower = ExtDrain;
	ClientPlayForceFeedback(ShieldHitForce);
	TakeHit(Drain);
}


function bool CheckReflect( Vector HitLocation, out Vector RefNormal, int AmmoDrain )
{
    local Vector HitDir;
    local Vector FaceDir;

    if (!bShieldUp || ShieldPower <= 0) return false;

    FaceDir = Vector(Instigator.Controller.Rotation);
    HitDir = Normal(Instigator.Location - HitLocation + Vect(0,0,8));
    //Log(self@"HitDir"@(FaceDir dot HitDir));

    RefNormal = FaceDir;

    if ( FaceDir dot HitDir < -0.37 ) // 68 degree protection arc
    {
        if (AmmoDrain > 0)
            ShieldPower -= AmmoDrain;
        return true;
    }
    return false;
}


simulated function float ChargeBar()
{
	return (ShieldPower/100);
}

defaultproperties
{
     bFirstDraw=True
     BulletBone="Bullet1"
     ShieldBone="Shield"
     ShieldHitSound=ProceduralSound'WeaponSounds.ShieldGun.ShieldReflection'
     ShieldOnSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-ShieldOn'
     ShieldOffSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-ShieldOff'
     ShieldPierceSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-ShieldPierce'
     ShieldHitForce="ShieldReflection"
     DamageSound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Overload'
     BrokenSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Ambient'
     ClipOutSoundEmpty=Sound'BWBP_SKC_Sounds.SK410.SK410-MagOut'
     WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.PUMA.PUMA-ScriptLCD'
     screen=Shader'BWBP_SKC_Tex.PUMA.PUMA-ScriptLCD-SD'
     ScreenBase1=Texture'BWBP_SKC_Tex.PUMA.PUMA-Screen'
     ScreenBase2=Texture'BWBP_SKC_Tex.PUMA.PUMA-Screen2' //Shield
     ScreenBase3=Texture'BWBP_SKC_Tex.PUMA.PUMA-Screen3' //Shield Low
     ScreenBase4=Texture'BWBP_SKC_Tex.PUMA.PUMA-Screen4' //Range Set
     ScreenBase5=Texture'BWBP_SKC_Tex.PUMA.PUMA-Screen5' //Range Set Close
     Numbers=Texture'BWBP_SKC_Tex.PUMA.PUMA-Numbers'
     MyFontColor=(B=255,G=255,R=255,A=255)
     RangeBeepSound=Sound'MenuSounds.select3'
     ChargingSound=Sound'WeaponSounds.BaseFiringSounds.BShield1'
     ShieldSoundVolume=200
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	 BigIconMaterial=Texture'BWBP_SKC_Tex.PUMA.BigIcon_PUMA'
     
     bWT_Shotgun=True
     bWT_Machinegun=True
	 LongGunOffset=(X=8.000000,Y=-5.000000,Z=-3.000000)
     SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
     MagAmmo=8
	 bNeedCock=False
	 bNonCocking=True
     CockSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Cock',Volume=1.100000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-MagOut',Volume=1.000000)
     ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-MagIn',Volume=1.000000)
     NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M763OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M763InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,A=192),Color2=(G=0,A=192),StartSize1=113,StartSize2=120)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),SizeFactors=(X1=0.750000,X2=0.750000),MaxScale=8.000000)
     WeaponModes(0)=(ModeName="Airburst: Impact Detonation",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Airburst: Proximity Detonation",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="Airburst: Variable Range Detonation")
     CurrentWeaponMode=1
     bNoCrosshairInScope=True
     GunLength=48.000000
     FireModeClass(0)=Class'BWBP_SKC_Pro.PumaPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.PumaSecondaryFire'
     PutDownTime=0.800000
     BringUpTime=1.000000
     AIRating=0.600000
     CurrentRating=0.600000
     bShowChargingBar=True
	 SightBobScale=0.35f
     Description="PUMA-77 Repeating Pulse Rifle||Manufacturer: Majestic Firearms 12|Primary: Programmable Smart Round|Secondary: Shield Projector||The Type-77 RPR, better known as the 'PUMA', is one of the more recognizable light grenade launchers on the market. It was used extensively by the UTC before their widespread adoption of the SRAC-21/G during the first Skrith war. This powerful weapon differs from other conventional grenade launchers in that it utilizes specialized fission batteries as ammunition, which both power and act as the carrier of the projectile. The projectiles themselves can be programmed by the side-mounted rangefinding module and allow soldiers to selectively airburst the rounds to hit targets behind cover. The PUMA-77s seen here are equipped with Frontier Tech's lightweight X57 shield projector, which is a reverse-engineered prototype of the Skrith personal energy shields."
     Priority=245
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBP_SKC_Pro.PumaPickup'

     PlayerViewOffset=(X=6.00,Y=4.00,Z=-3.50)
     SightOffset=(X=-3.00,Y=0.00,Z=2.00)
	 SightPivot=(Pitch=150)

     AttachmentClass=Class'BWBP_SKC_Pro.PumaAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.PUMA.SmallIcon_PUMA'
     IconCoords=(X2=127,Y2=35)
     ItemName="PUMA-77 Repeater"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
	 ParamsClasses(0)=Class'PUMAWeaponParamsComp'
	 ParamsClasses(1)=Class'PUMAWeaponParamsClassic'
	 ParamsClasses(2)=Class'PUMAWeaponParamsRealistic'
     ParamsClasses(3)=Class'PUMAWeaponParamsTactical'
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_PUMA'
     DrawScale=0.300000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBP_SKC_Tex.PUMA.PUMA-MainShine'
     Skins(2)=Shader'BWBP_SKC_Tex.PUMA.PUMA-BackShine'
     Skins(3)=Texture'BWBP_SKC_Tex.Typhon.Typhon-Misc'
     Skins(4)=Texture'BWBP_SKC_Tex.PUMA.PUMA-ScreenBasic'
}
