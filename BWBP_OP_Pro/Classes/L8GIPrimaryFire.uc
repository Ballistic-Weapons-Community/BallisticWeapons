//=============================================================================
// FP7PrimaryFire.
//
// FP7 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class L8GIPrimaryFire extends BallisticHandGrenadeFire;

defaultproperties
{
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassBone="tip"
     BrassOffset=(X=-20.000000,Z=-2.000000)
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     AmmoClass=Class'BWBP_OP_Pro.Ammo_L8GI'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-8.00)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_OP_Pro.L8GIThrown'
}
