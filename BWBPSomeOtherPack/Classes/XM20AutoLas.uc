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

var() name			BulletBone;

var bool			bShieldUp; 			//Shield is online
var bool			bOldShieldUp;

var bool			bBroken; 			//Ooops, your broke the shield emitter.
var() name			ShieldBone;			// Bone to attach SightFX to
var 	int			ShieldPower;		// max 200
var   float			ShieldPowerFraction; // recharge
var() Sound       	ShieldHitSound;
var() Sound       	ShieldOnSound;
var() Sound       	ShieldOffSound;
var() Sound       	ShieldPierceSound;
var() String		ShieldHitForce;
var() byte			ShieldSoundVolume;

var() int			ShieldDrainMax;
var() float			ShieldMinDamageFactor;
var() int 			PierceThreshold;

var() Sound 		ChargingSound;      // charging sound
var() Sound			DamageSound;		// Sound to play when it first breaks
var() Sound			BrokenSound;		// Sound to play when its very damaged

var Actor			Arc;				// The top arcs
var Actor 			GlowFX;
var XM20ShieldEffect XM20ShieldEffect;
var() float 		AmmoRegenTime;
var() float 		ChargeupTime;
var() float 		RampTime;

var actor 			VentSteamL1;
var actor 			VentSteamL2;
var actor 			VentSteamR1;
var actor 			VentSteamR2;

replication
{
	// Things the server should send to the client.
	reliable if( bNetOwner && bNetDirty && (Role==ROLE_Authority) )
		ShieldPower, bBroken;
	reliable if (Role == ROLE_Authority)
        ClientTakeHit, bShieldUp;
	reliable if (Role < ROLE_Authority)
		ServerSwitchShield;
}

simulated function DebugMessage(coerce string message)
{
	//if (PlayerController(Instigator.Controller) != None)
	//	PlayerController(Instigator.Controller).ClientMessage("DEBUG:"@message);
}

simulated event PostNetReceive()
{
	if (bShieldUp != bOldShieldUp)
	{
		bOldShieldUp = bShieldUp;
		AdjustShieldProperties();
	}
	Super.PostNetReceive();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (XM20ShieldEffect == None)
	{
		XM20ShieldEffect = Spawn(class'XM20ShieldEffect', instigator);
		if (Level.Game.bTeamGame && Instigator.GetTeamNum() == 0)
		    XM20ShieldEffect.SetRedSkin();
	}

	Super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{
	if (Role == ROLE_Authority && bShieldUp)
	{
		bShieldUp=false;
		AdjustShieldProperties();
	}
	
	if (super.PutDown())
	{
		if (Arc != None)	
			Arc.Destroy();
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
	if (Arc != None)	
		Arc.Destroy();
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
	if (ClientState != WS_ReadyToFire || bBroken)
		return;
		
	if (bShieldUp)
    	PlaySound(ShieldOffSound, SLOT_None);
	else
    	PlaySound(ShieldOnSound, SLOT_None);
		
	ServerSwitchShield(!bShieldUp);
}

function ServerSwitchShield(bool bNewValue)
{
    local XM20Attachment Attachment;

	DebugMessage("ServerSwitchShield:"@bNewValue);
	
	bShieldUp = bNewValue;
	
    Attachment = XM20Attachment(ThirdPersonActor);
   
    if (Attachment != None && Attachment.XM20ShieldEffect3rd != None)
	{
		if (bShieldUp)
        	Attachment.XM20ShieldEffect3rd.bHidden = false;
		else
        	Attachment.XM20ShieldEffect3rd.bHidden = true;
	}

	AdjustShieldProperties();
}

simulated function AdjustShieldProperties()
{
    local ShieldAttachment Attachment;

	if (bShieldUp)
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
			Emitter(Arc).Kill();
	}
}

simulated event Tick (float DT)
{
	if (ShieldPower < 200)
	{
		if (!bShieldUp)
		{
			ShieldPowerFraction += 5.0 * DT;
			
			while (ShieldPowerFraction > 1.0f)
			{
				++ShieldPower;
				ShieldPowerFraction -= 1.0f;
			}
		}
	}
	
	if (Role == ROLE_Authority && bBroken && ShieldPower > 25)
		bBroken = False;

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
	DebugMessage("TakeHit: Shield power:"@ShieldPower);
	
    if (XM20ShieldEffect != None)
    {
        XM20ShieldEffect.Flash(Drain, ShieldPower);
    }
	
	if (ShieldPower <= 0)
	{
		DebugMessage("TakeHit: Shield cancel");
		
		bShieldUp=false;
		ServerSwitchShield(false);
		AdjustShieldProperties();
		
		bBroken=true;
		AmbientSound = None;
		Instigator.AmbientSound = BrokenSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = true;
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
        Canvas.DrawActor( XM20ShieldEffect, false, false, DisplayFOV );
    }
    Super.RenderOverlays(Canvas);
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation,
						         out Vector Momentum, class<DamageType> DamageType)
{
    local float Drain;
	local vector Reflect;
    local vector HitNormal;
	
	if (InstigatedBy != None && InstigatedBy.Controller != None && InstigatedBy.Controller.SameTeamAs(InstigatorController))
		return;
	
	if (bBerserk)
		Damage *= 0.75;

	if(!DamageType.default.bArmorStops)
        return;
	
	if (class<DTXM84GrenadeRadius>(DamageType) != None && bShieldUp)
	{
    	ClientTakeHit(200);
		return;
	}

    if (!CheckReflect(HitLocation, HitNormal, 0))
		return;

	Drain = Min(ShieldPower, Damage);
	
	Drain = Min(Drain, ShieldDrainMax);
	
	Reflect = MirrorVectorByNormal( Normal(Location - HitLocation), Vector(Instigator.Rotation) );
		
	if (class<DT_BWShell>(DamageType) == None)
		Damage = Max(Damage * ShieldMinDamageFactor, Damage - Drain);
	else if (Drain > 5)
		Damage *= 0.5; // average case - can be tuned

	Momentum *= 2;
	
	Drain = Min(ShieldPower, Drain);
	ShieldPower -= Drain;
	DoReflectEffectA(Drain, Damage > PierceThreshold);
}

function DoReflectEffectA(int Drain, bool Pierce)
{
	DebugMessage("DoReflectEffectA");
	
	if (Pierce)
		PlaySound(ShieldPierceSound, SLOT_None);
	else
		PlaySound(ShieldHitSound, SLOT_None);
		
	ClientTakeHit(Drain);
}

simulated function ClientTakeHit(int Drain)
{
	DebugMessage("ClientTakeHit: Drain:"@Drain);
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
	return (ShieldPower * 0.005f);
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
	 ShieldDrainMax=35
	 ShieldMinDamageFactor=0.05
	 PierceThreshold=80
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
	 ShieldPower=75
	 bShowChargingBar=True
     ManualLines(0)="Each hit heats up the target, causing subsequent shots to inflict greater damage. This effect on the target decays with time."
     ManualLines(1)="Secondary fire will toggle a directional shield. The shield has a maximum of 200 health points and will reduce incoming damage by 35 points or by 90% of its value, whichever is smaller. If the shield is broken, a minimum reserve level is required to reactivate it."
     ManualLines(2)="Effective at moderate range, against small arms, and against enemies using healing weapons and items."
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPSomeOtherPackTex.XM20.BigIcon_XM20'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Energy=True
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
     AimSpread=14
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3000
	 RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.150000,OutVal=0.020000),(InVal=0.200000,OutVal=-0.050000),(InVal=0.300000),(InVal=0.400000,OutVal=-0.080000),(InVal=0.600000,OutVal=0.050000),(InVal=0.800000,OutVal=-0.030000),(InVal=1.000000,OutVal=0.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.500000,OutVal=0.600000),(InVal=0.600000,OutVal=0.500000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.050000
	 RecoilYFactor=0.05
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
     Description="XM20 Laser Rifle||Manufacturer: UTC Defense Tech|Primary: High Intensity Laser Beam|Secondary: Diffused High Intesity Beams||Having a long history with the UTC, the XM-20 managed to find its place even after most other energy weapons were rendered largely ineffective against Skrith shielding technology, thanks to its own integrated force field generator and ability to turn Cryon ballistic armor to slag with relative ease through concentrated fire."
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
     ItemName="XM20 Laser Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.XM20_FP'
     DrawScale=0.500000
}
