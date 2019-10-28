class BX85Bolt extends BallisticProjectile;

simulated event ProcessTouch(Actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Base != None)
		return;

	if(Pawn(Other) != None)
	{
		HitActor = Other;
		class'BallisticDamageType'.static.GenericHurt(Other, Damage, Instigator, HitLocation, Velocity, MyDamageType);
	}
	else
		Super.ProcessTouch(Other,HitLocation);
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.PineappleTrail'
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTBX85Bolt'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     Speed=15000.000000
     Damage=75.000000
     MyDamageType=Class'BWBPOtherPackPro.DTBX85Bolt'
     StaticMesh=StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Dart'
     LifeSpan=2.500000
     bIgnoreTerminalVelocity=True
}
