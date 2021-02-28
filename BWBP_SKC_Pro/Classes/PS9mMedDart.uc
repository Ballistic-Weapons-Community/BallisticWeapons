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

function DoDamage (Actor Other, vector HitLocation)
{
	local PS9mDartHeal HP;
	
	super.DoDamage (Other, HitLocation);
	if (xPawn(other) != None && Pawn(Other).Health > 0 && Pawn(Other).Controller != None && Pawn(Owner).Controller.SameTeamAs(Instigator.Controller))
	{
		HP = Spawn(class'PS9mDartHeal', Pawn(Other).Owner);

		HP.Instigator = Instigator;

		if(Other.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
			HP.InstigatorController = Instigator.Controller;

		HP.Initialize(Other);
	}
}

defaultproperties
{
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
