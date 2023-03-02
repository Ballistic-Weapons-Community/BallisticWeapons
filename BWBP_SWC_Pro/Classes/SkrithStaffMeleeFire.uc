//=============================================================================
// SkrithStaff Melee Fire.
//
// Bayonette melee attack for the SkrithStaff
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SkrithStaffMeleeFire extends BallisticMeleeFire;

defaultproperties
{
     DamageType=Class'BWBP_SWC_Pro.DT_SkrithStaffStab'
     DamageTypeHead=Class'BWBP_SWC_Pro.DT_SkrithStaffStabHead'
     DamageTypeArm=Class'BWBP_SWC_Pro.DT_SkrithStaffStab'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Stab',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepStab"
     FireAnim="Stab"
     FireAnimRate=1.350000
     TweenTime=0.000000
     FireRate=0.600000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.050000
}
