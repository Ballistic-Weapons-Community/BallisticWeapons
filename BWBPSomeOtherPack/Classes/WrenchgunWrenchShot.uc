//=============================================================================
// Launched AK-47 knife.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class WrenchgunWrenchShot extends WrenchgunWrench;

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_GunHit'
     bRandomStartRotaion=True
     bUsePositionalDamage=True
	 bIgnoreTerminalVelocity=True
     DamageHead=21.000000
     DamageLimb=14.000000
     DamageTypeHead=Class'BWBPSomeOtherPack.DTWrenchgunShotHead'
     bWarnEnemy=False
     Speed=8500.000000
     MaxSpeed=8500.000000
     Damage=14.000000
     MyDamageType=Class'BWBPSomeOtherPack.DTWrenchgunShot'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.Wrench.WrenchPickup' 
     Physics=PHYS_Falling
     LifeSpan=0.000000
     DrawScale=0.50000
	 MomentumTransfer=17000.000000
     bUnlit=True
}
