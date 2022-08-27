//=============================================================================
// AK91SecondaryFire.
//
// Weak close range pulse attack.
// Main use in overheating gun for primary fire and for pulse jumping.
// Can damage gun to state beyond repair with overuse.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK91SecondaryFire extends BallisticShotgunFire;

simulated function bool AllowFire()
{
	if (AK91ChargeRifle(BW).HeatLevel <= 5.0 || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	AK91ChargeRifle(BW).AddHeat(-10.00);
}


// Get aim then run trace...
function DoFireEffect()
{
 	local Vector Start;
 	local Rotator Aim;
 
 	Start = Instigator.Location + Instigator.EyePosition();
 
 	Aim = GetFireAim(Start);
 	Aim = Rotator(GetFireSpread() >> Aim);
 
 	AK91ChargeRifle(BW).ConicalBlast(Damage*2, 512, Vector(Aim)); //Wave damage here scales with heat on the main gun
	AK91ChargeRifle(BW).AddHeat(-10.00);
	Super.DoFireEffect();
}


defaultproperties
{
     FlashBone="LAM"
     TraceCount=1
     TracerChance=1.000000
     ImpactManager=Class'BWBP_SKC_Pro.IM_GRSXXLaser'
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
     TraceRange=(Min=600.000000,Max=600.000000)
     Damage=5
     RangeAtten=0.200000
     DamageType=Class'BWBP_SKC_Pro.DTA49Shockwave'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTA49Shockwave'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTA49Shockwave'
     KickForce=12000
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'A49FlashEmitter'
     AmmoPerFire=0
     bUseWeaponMag=False
     FlashScaleFactor=1.200000
     BrassOffset=(X=15.000000,Y=-13.000000,Z=7.000000)
     FireChaos=0.500000
     XInaccuracy=2000.000000
     YInaccuracy=2000.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-SecFire',Volume=1.000000)
     FireAnim="AltFire"
     TweenTime=0.000000
     FireRate=1.700000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
