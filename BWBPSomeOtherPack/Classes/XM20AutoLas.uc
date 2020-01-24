//=============================================================================
// LS-14 Laser Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
// Modified by Marc 'Sergeant Kelly' Moylan
// Scope code by Kaboodles
// Reloading code and handling change by Azarael, yaaaay!
//=============================================================================
class XM20AutoLas extends BallisticWeapon;

var bool		bPierce;
var bool		bBroken; //Ooops, your broke the shield emitter.
var name			BulletBone;
var() name			ShieldBone;			// Bone to attach SightFX to
var float		ShieldPower;	// From 200 to 0
var Sound       ShieldHitSound;
var Sound       ShieldOnSound;
var Sound       ShieldOffSound;
var Sound       ShieldPierceSound;
var String		ShieldHitForce;
var bool	bShieldUp; //Shield is online
var bool	bOldShieldUp;
var() Sound		DamageSound;		// Sound to play when it first breaks
var() Sound		BrokenSound;		// Sound to play when its very damaged
var Actor	Arc;				// The top arcs
var actor GlowFX;
var XM20ShieldEffect XM20ShieldEffect;
var() float AmmoRegenTime;
var() float ChargeupTime;
var	  float RampTime;
var Sound ChargingSound;                // charging sound
var() byte	ShieldSoundVolume;
var actor VentSteamL1;
var actor VentSteamL2;
var actor VentSteamR1;
var actor VentSteamR2;

replication
{
	// Things the server should send to the client.
	reliable if( bNetOwner && bNetDirty && (Role==ROLE_Authority) )
		ShieldPower;
	reliable if (Role == ROLE_Authority)
        	ClientTakeHit, bShieldUp;
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

simulated function BringUp(optional Weapon PrevWeapon)
{
    	if (XM20ShieldEffect == None)
        	XM20ShieldEffect = Spawn(class'XM20ShieldEffect', instigator);

	Super.BringUp(PrevWeapon);

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

simulated function Notify_VentSteam()
{
	if (VentSteamL1 != None)
		VentSteamL1.Destroy();

	if (VentSteamL2 != None)
		VentSteamL2.Destroy();
		
	if (VentSteamR1 != None)
		VentSteamR1.Destroy();

	if (VentSteamR2 != None)
		VentSteamR2.Destroy();

	class'BUtil'.static.InitMuzzleFlash (VentSteamL1, class'CoachSteam', DrawScale, self, 'Vent1L');
	class'BUtil'.static.InitMuzzleFlash (VentSteamL2, class'CoachSteam', DrawScale, self, 'Vent2L');
	class'BUtil'.static.InitMuzzleFlash (VentSteamR1, class'CoachSteam', DrawScale, self, 'Vent1R');
	class'BUtil'.static.InitMuzzleFlash (VentSteamR2, class'CoachSteam', DrawScale, self, 'Vent2R');

	/*if (VentSteamL1 != None)
		VentSteamL1.SetRelativeRotation(rot(0,32768,0));
	if (VentSteamL2 != None)
		VentSteamL2.SetRelativeRotation(rot(0,32768,0));
	if (VentSteamR1 != None)
		VentSteamR1.SetRelativeRotation(rot(0,32768,0));
	if (VentSteamR2 != None)
		VentSteamR2 != None.SetRelativeRotation(rot(0,32768,0));*/
}

simulated function Destroyed()
{
	if (Arc != None)	Arc.Destroy();
	if (VentSteamL1 != None)
		VentSteamL1.Destroy();
	if (VentSteamL2 != None)
		VentSteamL2.Destroy();
	if (VentSteamR1 != None)
		VentSteamR1.Destroy();
	if (VentSteamR2 != None)
		VentSteamR2.Destroy();
	super.Destroyed();
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
    	local XM20Attachment Attachment;

	bShieldUp = bNewValue;
    Attachment = XM20Attachment(ThirdPersonActor);
   
    if( Attachment != None && Attachment.XM20ShieldEffect3rd != None )
	{
		if (bShieldUp)
        		Attachment.XM20ShieldEffect3rd.bHidden = false;
		else
        		Attachment.XM20ShieldEffect3rd.bHidden = true;
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

		if (Arc == None)
			class'bUtil'.static.InitMuzzleFlash(Arc, class'M2020ShieldEffect', DrawScale, self, 'tip');
        	XM20ShieldEffect.Flash(0, ShieldPower);
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
	if (ShieldPower < 200)
	{
		if (!bShieldUp /*&& !bBroken*/)
			ShieldPower = FMin(ShieldPower + 5.0 * DT, 200);
	}
	if (ShieldPower >= 200)	
		bBroken=False;

	super.Tick(DT);
}


function SetBrightness(bool bHit)
{
    local XM20Attachment Attachment;
 	local float Brightness;

	Brightness = ShieldPower;
	if ( RampTime < ChargeUpTime )
		Brightness *= RampTime/ChargeUpTime; 
    if (XM20ShieldEffect != None)
        XM20ShieldEffect.SetBrightness(Brightness);

    Attachment = XM20Attachment(ThirdPersonActor);
    if( Attachment != None )
        Attachment.SetBrightness(Brightness, bHit);
}


simulated function TakeHit(int Drain)
{
    if (XM20ShieldEffect != None)
    {
        XM20ShieldEffect.Flash(Drain, ShieldPower);
    }
	if (ShieldPower <= 0 )
	{
		ServerSwitchShield(false);
		bShieldUp=false;
		AdjustShieldProperties(true);
		bBroken=true;
		AmbientSound = None;
		Instigator.AmbientSound = BrokenSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = true;
//		if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
//			class'BUtil'.static.InitMuzzleFlash (GlowFX, class'XM20GlowFXDamaged', DrawScale, self, 'tip');
	}
    SetBrightness(true);
}


//=====================================================
//			SHIELD DAMAGE + OVERLAYS
//=====================================================


simulated event RenderOverlays( Canvas Canvas )
{
	local coords Z;

	if (bShieldUp && XM20ShieldEffect != None)
	{
		Z = GetBoneCoords(ShieldBone);
        	XM20ShieldEffect.SetLocation(Z.Origin);
		XM20ShieldEffect.SetRotation( Instigator.GetViewRotation() );
//                XM20ShieldEffect.SetRelativeRotation(rotation  + rot(0, 32768, 32768));
        	Canvas.DrawActor( XM20ShieldEffect, false, false, DisplayFOV );
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
	if (Damage > DamageMax) //Piercing (75+) damage will bleed through and heavily damage shield.
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
	return (ShieldPower/200);
}

//=====================================================
//			HEAT MANAGEMENT CODE
//=====================================================

function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local XM20HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'XM20HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'XM20HeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
}

// AI Interface =====
simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

function byte BestMode()
{
	return 0;
}

defaultproperties
{
     ShieldBone="tip"
     ShieldHitSound=ProceduralSound'WeaponSounds.ShieldGun.ShieldReflection'
     ShieldOnSound=Sound'PackageSounds4ProExp.PUMA.PUMA-ShieldOn'
     ShieldOffSound=Sound'PackageSounds4ProExp.PUMA.PUMA-ShieldOff'
     ShieldPierceSound=Sound'PackageSounds4ProExp.PUMA.PUMA-ShieldPierce'
     ShieldHitForce="ShieldReflection"
     DamageSound=Sound'PackageSounds4Pro.NEX.NEX-Overload'
     BrokenSound=Sound'BWBP2-Sounds.LightningGun.LG-Ambient'
     ChargingSound=Sound'WeaponSounds.BaseFiringSounds.BShield1'
     ShieldSoundVolume=220	 
	 ShieldPower=100
	 bShowChargingBar=True
     ManualLines(0)="Each hit heats up the target, causing subsequent shots to inflict greater damage. This effect on the target decays with time."
     ManualLines(1)="Unfortunately, it's not the Wrenchgun, but secondary fire will toggle a directional shield that will greatly reduce incoming damage."
     ManualLines(2)="Effective at moderate range and against enemies using healing weapons and items."
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPSomeOtherPackTex.XM20.BigIcon_XM20'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Energy=True
	 bWT_Machinegun=True
	 bNoCrosshairInScope=True
     SpecialInfo(0)=(Info="240.0;15.0;1.1;90.0;1.0;0.0;0.3")
     BringUpSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Select')
     PutDownSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Deselect')
     MagAmmo=30
     CockSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Cock')
     ReloadAnimRate=1.000000
     ClipHitSound=(Sound=Sound'BWBP2-Sounds.LightningGun.LG-LeverDown')
     ClipOutSound=(Sound=Sound'BWBP4-Sounds.VPR.VPR-ClipOut')
     ClipInSound=(Sound=Sound'BWBP4-Sounds.VPR.VPR-ClipIn')
     ClipInFrame=0.650000 
     CurrentWeaponMode=2
     SightOffset=(X=20.000000,Y=16.8500000,Z=29.000000)
	 SightDisplayFOV=15
     GunLength=80.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     JumpOffSet=(Pitch=-6000,Yaw=2000)
     AimSpread=14
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3000
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.10000),(InVal=0.400000,OutVal=0.130000),(InVal=0.600000,OutVal=-0.160000),(InVal=1.000000,OutVal=-0.080000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.450000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.320000
     RecoilMinRandFactor=0.08000
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPSomeOtherPack.XM20PrimaryFire'
     FireModeClass(1)=Class'BWBPSomeOtherPack.XM20SecondaryFire'
     SelectAnimRate=1.500000
     PutDownAnimRate=2.000000
     PutDownTime=0.500000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     Description="XM-20 Auto Las||Manufacturer: UTC Defense Tech|Primary: High Intensity Laser Beam|Secondary: Diffused High Intesity Beams||Having a long history with the UTC, the XM-20 managed to find its place even after most other energy weapons were rendered largely ineffective against Skrith shielding technology, thanks to its own integrated force field generator and ability to turn Cryon ballistic armor to slag with relative ease through concentrated fire."
     Priority=194
     HudColor=(B=255,G=150,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=4
     PickupClass=Class'BWBPSomeOtherPack.XM20Pickup'
     PlayerViewOffset=(X=-12.000000,Y=0.000000,Z=-22.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBPSomeOtherPack.XM20Attachment'
	 bUseBigIcon=True
     IconMaterial=Texture'BWBPSomeOtherPackTex.XM20.Icon_XM20'
     IconCoords=(X2=127,Y2=31)
     ItemName="XM-20 Auto Las"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.XM20_FP'
     DrawScale=0.500000
}
