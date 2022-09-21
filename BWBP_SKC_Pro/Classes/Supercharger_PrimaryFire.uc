//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_PrimaryFire extends BallisticInstantFire;

var   Actor		Ignition;
var   Actor		MuzzleFlame;
var   Actor		Heater;
var   bool		bIgnited;
var() sound		FireSoundLoop;
var() sound		BotFireSound;
var() float		HeatPerShot;

var() 	bool		bDoOverCharge;


function StartBerserk()
{
 	FireRate = 0.03;
    FireAnimRate = default.FireAnimRate/0.75;
    ReloadAnimRate = default.ReloadAnimRate/0.75;
}

function StopBerserk()
{
    FireRate = default.FireRate;
    FireAnimRate = default.FireAnimRate;
    ReloadAnimRate = default.ReloadAnimRate;
}

function StartSuperBerserk()
{
    FireRate = 0.03;
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
}


function float MaxRange()	{	return 6400;	}

function Supercharger_ChargeControl GetChargeControl()
{
	return Supercharger_AssaultWeapon(Weapon).GetChargeControl();
}

function DoFireEffect()
{
    local Vector Start, Dir, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local float Dist;
	local int i;

    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);

	DoTrace(Start, Aim);

    Dir = Vector(Aim);
	End = Start + (Dir*MaxRange());
	Weapon.bTraceWater=true;
	for (i=0;i<20;i++)
	{
		Other = Trace(HitLocation, HitNormal, End, Start, true);
		if (Other == None || Other.bWorldGeometry || Mover(Other) != none || Vehicle(Other)!=None || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
			break;
		Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
	}
	Weapon.bTraceWater=false;

	if (Other == None)
		HitLocation = End;
	if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		Other = None;

	Dist = VSize(HitLocation-Start);


	if (Supercharger_AssaultWeapon(Weapon).CurrentWeaponMode == 2)
	{
		if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
			GetChargeControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other, 1);
		else
			GetChargeControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None, 1);
	}
	SendFireEffect(Other, HitLocation, HitNormal, 0);

	Super(BallisticFire).DoFireEffect();
	Supercharger_AssaultWeapon(Weapon).AddHeat(HeatPerShot);
}

//Do the spread on the client side
function PlayFiring()
{
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	if(Level.NetMode == NM_Client)
		Supercharger_AssaultWeapon(BW).AddHeat(HeatPerShot);
		
	
	if (Level.NetMode != NM_Client && !bDoOverCharge && Supercharger_AssaultWeapon(Weapon).HeatLevel > 10)
	{
		bDoOverCharge = true;
		Weapon.PlaySound(Supercharger_AssaultWeapon(Weapon).OverHeatSound,Slot_None,0.7,,64,1.0,true);
		Supercharger_AssaultWeapon(Weapon).ClientOverCharge();
		Weapon.ServerStopFire(ThisModeNum);
	}
	
	if (Supercharger_AssaultWeapon(Weapon).CurrentWeaponMode == 1)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	else if ( AIController(Instigator.Controller) != None)
	{
		Weapon.PlayOwnedSound(BotFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	else
	{
		if (FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;

		if (!bIgnited)
		{
			BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		}
		if (MuzzleFlame == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlame, class'HVCMk9MuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip');
	}
}

function ServerPlayFiring()
{
	if (!bIgnited)
	{
		bIgnited = true;
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	
	if (Weapon.Role == Role_Authority && !bDoOverCharge && Supercharger_AssaultWeapon(Weapon).HeatLevel > 10)
	{
		bDoOverCharge = true;
		Weapon.PlaySound(Supercharger_AssaultWeapon(Weapon).OverHeatSound,Slot_None,0.7,,64,1.0,true);
		Supercharger_AssaultWeapon(Weapon).ClientOverCharge();
		Weapon.ServerStopFire(ThisModeNum);
	}
	
}

simulated function bool AllowFire()
{
	if (!super.AllowFire() || Supercharger_AssaultWeapon(Weapon).HeatLevel >= 10 || Supercharger_AssaultWeapon(Weapon).bIsVenting || Instigator.HeadVolume.bWaterVolume)
	{
		if (bIgnited)
			StopFiring();
		return false;
	}
	return true;
}

function StopFiring()
{
	bIgnited = false;
	Instigator.AmbientSound = None;
	if (MuzzleFlame != None)
	{
		Emitter(MuzzleFlame).Kill();
		MuzzleFlame = None;
	}
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();
	if (MuzzleFlame != None)
		MuzzleFlame.Destroy();
}



defaultproperties
{
	HeatPerShot=0.15
     aimerror=900.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     AmmoPerFire=1
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireEnd',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bCockAfterEmpty=True
     BotFireSound=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireSingle'
     bPawnRapidFireAnim=True
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-FireStart2',Volume=1.000000,Radius=48.000000,bAtten=True)
//     Damage=1
//     DamageHead=2
//     DamageLimb=1
     DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifle'
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-OverHeat',Volume=1.000000)
//     FireChaos=0.010000
	 FireAnim=""
     FireEndAnim=
//     FireRate=0.0631500
     FireSoundLoop=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireLoop'
     FlashBone="Muzzle"
     FlashScaleFactor=0.250000
     KickForce=20000
     MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
     PenetrateForce=180
     PreFireAnim=
//     RangeAtten=0.950000
//     RecoilPerShot=130.000000
     RunningSpeedThresh=1000.000000
     ShakeOffsetMag=(X=-15.000000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     TraceRange=(Min=6400.000000,Max=6400.000000)
     TweenTime=0.000000
     WarnTargetPct=0.200000
//     WaterRangeAtten=0.100000
//     WaterRangeFactor=0.800000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
//     Damage=(Min=15.000000,Max=15.000000)
//     DamageHead=(Min=20.000000,Max=20.000000)
//     DamageLimb=(Min=10.000000,Max=10.000000)
}
