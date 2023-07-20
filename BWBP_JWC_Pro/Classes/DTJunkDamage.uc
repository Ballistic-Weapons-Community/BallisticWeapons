//=============================================================================
// DTJunkDamage.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkDamage extends BallisticDamageType;

var() class<JunkObject>	JunkClass;	//FIXME

//FIXME!!!
simulated static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
//	if (default.ImpactManager != None)
//		default.ImpactManager.static.StartSpawn(HitLocation, -Normal(Momentum), 6/*EST_Flesh*/, Victim);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     BloodManagerName="BallisticFix.BloodMan_Blunt"
     bCanBeBlocked=True
     ShieldDamage=20
     DamageDescription=",Blunt,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkPipeCorner'
     WeaponClass=Class'BWBP_JWC_Pro.JunkWeapon'
     DeathString="%o was junked by %k."
     FemaleSuicide="%o junked herself."
     MaleSuicide="%o junked himself."
     bInstantHit=True
     bNeverSevers=True
}
