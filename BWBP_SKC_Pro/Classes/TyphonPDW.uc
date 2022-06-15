//=============================================================================
// TyphonPDW.
//
// Powerful PDW with a pre-fire time and good accuracy.
// Has a firemode with an even larger pre-fire time and light AoE.
// Secondary is the PUMA shield.
//
// by SK
// Copyright(c) 2020 SK. All Rights Reserved.
//=============================================================================
class TyphonPDW extends BallisticWeapon;

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


var() ScriptedTexture WeaponScreen;

var	int	NumpadYOffset1; //Used for ammo counter
var	int	NumpadYOffset2;
var	int	NumpadYOffset3;

var	int	NumpadYOffset4; //Used for shield power
var	int	NumpadYOffset5;
var	int	NumpadYOffset6;

var() Material	Screen;
var() Material	ScreenBaseX; //Used for shield power (base tex)
var() Material	ScreenBaseY; //Used for ammo (base tex)
var() Material	ScreenBase1; //Ammo Counter
var() Material	ScreenBase2; //Shield Power
var() Material	ScreenBase3; //Low shield power
var() Material	ScreenBase4; //Low Ammo
var() Material	ScreenBase5; //unused
var() Material	Numbers;
var protected const color MyFontColor; //Why do I even need this?
var bool		bRangeSet;


var Actor	Arc;				// The damage shield effect
var actor GlowFX;
var PumaShieldEffect PumaShieldEffect;
var() float AmmoRegenTime;
var() float ChargeupTime;
var	  float RampTime;
var   bool			bIsCharging;
var Sound ChargingSound;                // charging sound
var() byte	ShieldSoundVolume;

var   float ChargeRate, ChargeRateOvercharge;
var()     float Heat, CoolRate;

replication
{
	// Things the server should send to the client.
	reliable if( bNetOwner && bNetDirty && (Role==ROLE_Authority) )
		ShieldPower;
	reliable if (Role == ROLE_Authority)
        	ClientTakeHit, ClientScreenStart, ClientSwitchCannonMode, bShieldUp;
	reliable if( Role<ROLE_Authority )
		ServerSwitchShield;
		
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

//=====================================================
//			SCREEN CODE
//=====================================================

simulated function ClientScreenStart()
{
	ScreenStart();
}
// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[6] = Screen;
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
	Tex.DrawTile(90,5,50,50,30,NumpadYOffset4,50,50,Numbers, MyFontColor);
	Tex.DrawTile(110,5,50,50,30,NumpadYOffset5,50,50,Numbers, MyFontColor);
	Tex.DrawTile(130,5,50,50,30,NumpadYOffset6,50,50,Numbers, MyFontColor);
	
}
	
simulated function UpdateScreen() //Force a screen update
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;
	if (ShieldPower < 40)
		ScreenBaseX=ScreenBase3;
	else
		ScreenBaseX=ScreenBase2;
	if (MagAmmo <= 5)
		ScreenBaseY=ScreenBase4;
	else
		ScreenBaseY=ScreenBase1;

	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}

//=====================================================
//			FIRE MODES
//=====================================================
function ServerSwitchWeaponMode (byte newMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		TyphonPDWPrimaryFire(FireMode[0]).SwitchCannonMode(CurrentWeaponMode);
	ClientSwitchCannonMode (CurrentWeaponMode);
}
simulated function ClientSwitchCannonMode (byte newMode)
{
	TyphonPDWPrimaryFire(FireMode[0]).SwitchCannonMode(newMode);
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
    	local TyphonPDWAttachment Attachment;

	bShieldUp = bNewValue;
    	Attachment = TyphonPDWAttachment(ThirdPersonActor);
   
    	if( Attachment != None && Attachment.PUMAShieldEffect3rd != None )
	{
		if (bShieldUp)
        		Attachment.PUMAShieldEffect3rd.bHidden = false;
		else
        		Attachment.PUMAShieldEffect3rd.bHidden = true;
	}

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
			class'bUtil'.static.InitMuzzleFlash(Arc, class'M2020ShieldEffect', DrawScale, self, 'tip2');
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
	
	if (FireMode[1].bIsFiring)
	{
		CoolRate = 0;
		bIsCharging = true;
	}
	else 
	{
		CoolRate = default.CoolRate;
		bIsCharging = false;
	}
    Heat = FMax(0, Heat - CoolRate*DT);

   	if (level.Netmode == NM_DedicatedServer)
		Heat = 0;
	
}

function SetBrightness(bool bHit)
{
    local TyphonPDWAttachment Attachment;
 	local float Brightness;

	Brightness = ShieldPower;
	if ( RampTime < ChargeUpTime )
		Brightness *= RampTime/ChargeUpTime; 
    if (PumaShieldEffect != None)
        PumaShieldEffect.SetBrightness(Brightness);

    Attachment = TyphonPDWAttachment(ThirdPersonActor);
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
				class'BUtil'.static.InitMuzzleFlash (GlowFX, class'PumaGlowFXDamaged', DrawScale, self, 'tip2');
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
	if (Clientstate == WS_PutDown)
		class'BUtil'.static.KillEmitterEffect(GlowFX);

	super.Timer();
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;
	
	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();
	
	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
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
		
		if (MagAmmo >= 100)
		{
			NumpadYOffset4=(5+(MagAmmo/100)*49); //Hundreds place
			NumpadYOffset5=(5+(MagAmmo/10 % 10)*49);  //Tens place
			NumpadYOffset6=(5+((MagAmmo%100)%10)*49);  //Ones place
		}
		else if (MagAmmo >= 10)
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(5+(MagAmmo/10)*49);
			NumpadYOffset6=(5+(MagAmmo%10)*49);
		}
		else if (MagAmmo >= 0)
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(5);
			NumpadYOffset6=(5+MagAmmo*49);
		}
		else
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(5);
			NumpadYOffset6=(5);
		}

	}
	else
	{
		if (MagAmmo >= 100)
		{
			NumpadYOffset1=(5+(MagAmmo/100)*49); //Hundreds place
			NumpadYOffset2=(5+(MagAmmo/10 % 10)*49);  //Tens place
			NumpadYOffset3=(5+((MagAmmo%100)%10)*49);  //Ones place
		}
		else if (MagAmmo >= 10)
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5+(MagAmmo/10)*49);
			NumpadYOffset3=(5+(MagAmmo%10)*49);
		}
		else if (MagAmmo >= 0)
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5);
			NumpadYOffset3=(5+MagAmmo*49);
		}
		else
		{
			NumpadYOffset1=(5);
			NumpadYOffset2=(5);
			NumpadYOffset3=(5);
		}
		
		if (ShieldPower >= 100)
		{
			NumpadYOffset4=(5+(int(ShieldPower)/100)*49); //Hundreds place
			NumpadYOffset5=(5+(int(ShieldPower)/10 % 10)*49);  //Tens place
			NumpadYOffset6=(5+((int(ShieldPower)%100)%10)*49);  //Ones place
		}
		else if (ShieldPower >= 10)
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(5+(int(ShieldPower)/10)*49);
			NumpadYOffset6=(5+(int(ShieldPower)%10)*49);
		}
		else if (ShieldPower >= 0)
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(5);
			NumpadYOffset6=(5+int(ShieldPower)*49);
		}
		else
		{
			NumpadYOffset4=(5);
			NumpadYOffset5=(5);
			NumpadYOffset6=(5);
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
        Canvas.DrawActor( PumaShieldEffect, false, false, DisplayFOV );
    }
    Super.RenderOverlays(Canvas);

}


function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation,
						         out Vector Momentum, class<DamageType> DamageType)
{
    local int Drain;
	local vector Reflect;
    local vector HitNormal;
    local float DamageMax;

	DamageMax = 50.0;
	if ( DamageType == class'Fell' )
		DamageMax = 20.0;

	else if (class<DTXM84GrenadeRadius>(DamageType) != none && bShieldUp)
	{
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
	if (!bShieldUp)
		return FMin(TyphonPDWPrimaryFire(FireMode[0]).LaserCharge, TyphonPDWPrimaryFire(FireMode[0]).MaxCharge);
	else
		return (ShieldPower/100);
}


defaultproperties
{
	 ChargeRate=5.000000
	 ChargeRateOvercharge=2.400000
	 CoolRate=1.0
     BrokenSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Ambient'
     DamageSound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Overload'
     ShieldHitSound=ProceduralSound'WeaponSounds.ShieldGun.ShieldReflection'
     ShieldOnSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-ShieldOn'
     ShieldOffSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-ShieldOff'
     ShieldPierceSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-ShieldPierce'
     ChargingSound=Sound'WeaponSounds.BaseFiringSounds.BShield1'
     ClipOutSoundEmpty=Sound'BWBP_SKC_Sounds.Saiga.SK410-MagOut'
     ShieldSoundVolume=220
     ShieldHitForce="ShieldReflection"
     ShieldBone="Shield"
     bShowChargingBar=True

	 Screen=Shader'BWBP_SKC_TexExp.PUMA.PUMA-ScriptLCD-SD'
	 ScreenBase1=Texture'BWBP_SKC_Tex.Typhon.Typhon-ScreenAmmo'
	 ScreenBase2=Texture'BWBP_SKC_TexExp.PUMA.PUMA-Screen2' //Shield
	 ScreenBase3=Texture'BWBP_SKC_TexExp.PUMA.PUMA-Screen3' //Shield Low
	 ScreenBase4=Texture'BWBP_SKC_Tex.Typhon.Typhon-ScreenAmmoLow' //Ammo Low
	 ScreenBase5=Texture'BWBP_SKC_TexExp.PUMA.PUMA-Screen5'
	 Numbers=Texture'BWBP_SKC_Tex.PUMA.PUMA-Numbers'
	 MyFontColor=(R=255,G=255,B=255,A=255)
     WeaponScreen=ScriptedTexture'BWBP_SKC_TexExp.PUMA.PUMA-ScriptLCD'
	 
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
//	 FullZoomFOV=70
     BigIconMaterial=Texture'BWBP_SKC_TexExp.PUMA.BigIcon_PUMA'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	 bWT_Bullet=True
     SpecialInfo(0)=(Info="0.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Draw')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	 //ScopeViewTex=Texture'BWBP_CC_Tex.Bullpup.EP110-Scope'
     CockSound=(Sound=Sound'BWBP_SKC_SoundsExp.PUMA.PUMA-Cock',Volume=1.100000)
     ReloadAnim="Reload"
     ClipInSound=(Sound=Sound'BWBP_SKC_SoundsExp.PUMA.PUMA-MagIn',Volume=1.000000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_SoundsExp.PUMA.PUMA-MagOut',Volume=1.000000)
	 WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
	 WeaponModes(1)=(ModeName="Charged Fire",ModeID="WM_FullAuto")
	 WeaponModes(2)=(ModeName="Charged Shot",bUnavailable=True)
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
	 ZoomType=ZT_Irons
     SightPivot=(Pitch=-1024)
     SightOffset=(X=-4.000000,Y=0.250000,Z=11.750000)
	 SightingTime=0.250000
	 BobDamping=2.300000
     FireModeClass(0)=Class'BWBP_SKC_Pro.TyphonPDWPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.TyphonPDWSecondaryFire'
     SelectForce="SwitchToAssaultRifle"
	 //NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.R78InA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=0,R=137,A=255),Color2=(B=255,G=25,R=23,A=126),StartSize1=96,StartSize2=51)
	 //NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     AIRating=0.600000
     CurrentRating=0.600000
     Description="Before the Skrith wars broke out, photon weaponry was declared inhumane by the Neo-Geneva convention due to the effects it had against animal test subjects.  It wasn’t until one battle on Gahanna where photon weaponry found it’s value against the Cyron troopers, discombobulating their gyroscopic sensors long enough to turn the tide, living to fight another day.  Since then, photon weaponry has been deemed legal to use in both wartime situations and underground blood sports. The EP110 is the latest in this field, a bullpup SMG not only able to clear out enclosed spaces, but it also has a discombobulator field able to disorient and destroy anyone caught in its path."
     Priority=19
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	 InventoryGroup=3
     GroupOffset=18
     PickupClass=Class'BWBP_SKC_Pro.TyphonPDWPickup'
     PlayerViewOffset=(X=-4.000000,Y=6.000000,Z=-11.000000)
     PutDownTime=0.800000
     BringUpTime=1.000000
     AttachmentClass=Class'BWBP_SKC_Pro.TyphonPDWAttachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.PUMA.SmallIcon_PUMA'
     IconCoords=(X2=127,Y2=31)
     ItemName="LRX-5 'Typhon' Pulse PDW"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClasses(0)=Class'TyphonPDWWeaponParamsArena'
	 ParamsClasses(1)=Class'TyphonPDWWeaponParamsClassic'
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_PUMA'
     DrawScale=0.350000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBP_SKC_TexExp.PUMA.PUMA-Shine'
     Skins(2)=Shader'BWBP_SKC_TexExp.PUMA.PUMA-ShineMag'
     Skins(3)=Shader'BWBP_SKC_Tex.PUMA.PUMA-ShieldSD'
     Skins(4)=Texture'BWBP_SKC_TexExp.PUMA.PUMA-Misc'
     Skins(5)=Shader'BWBP_SKC_TexExp.PUMA.PUMA-HolosightGlow'
     Skins(6)=Texture'BWBP_SKC_TexExp.PUMA.PUMA-ScreenBasic'
}
