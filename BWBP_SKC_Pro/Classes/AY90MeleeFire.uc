//=============================================================================
// A90SecondaryFire.
//
// Bayonette melee attack for the AY90
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90MeleeFire extends BallisticMeleeFire;

defaultproperties
{
     TraceRange=(Min=160.000000,Max=160.000000)
     Damage=85
     HeadMult=1.5
     LimbMult=0.5
     DamageType=Class'BWBP_SKC_Pro.DTAY90Stab'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTAY90StabHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTAY90Stab'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bUseRunningDamage=True
     RunningSpeedThresh=1000.000000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.EKS43.EKS-Slash',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PreMeleeFire"
     FireAnim="MeleeFire"
     TweenTime=0.000000
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.050000
}
