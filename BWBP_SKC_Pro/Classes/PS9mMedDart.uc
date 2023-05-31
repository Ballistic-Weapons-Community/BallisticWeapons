//=============================================================================
// PS9mMedDart.
//
// Dart fired by PS9m ballistic attachment. Heals and cures radiation poisoning
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mMedDart extends BallisticProjectile;

function DoDamage (Actor Victim, vector HitLocation)
{
	local PS9mDartHeal HP;
	
	super.DoDamage (Victim, HitLocation);

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;
	
	if (Pawn(Victim).Controller != None && Pawn(Victim).Controller.SameTeamAs(Instigator.Controller))
	{
		HP = Spawn(class'PS9mDartHeal', Pawn(Victim).Owner);

		HP.Instigator = Instigator;

		if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
			HP.InstigatorController = Instigator.Controller;

		HP.Initialize(Victim);
	}
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.PS9mPistol'
	ModeIndex=1
	ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
	TrailClass=Class'BallisticProV55.PineappleTrail'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_PS9mMedDart'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=0.000000
	MotionBlurRadius=0.000000
	MotionBlurFactor=0.000000
	MotionBlurTime=0.000000
	Speed=6500.000000
	Damage=5.000000
	MyDamageType=Class'BWBP_SKC_Pro.DT_PS9mMedDart'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart'
	LifeSpan=1.500000
}
