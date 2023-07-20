class M7A3TazerProj extends BallisticProjectile;

var M7A3Attachment Master;

function DoDamage(Actor Other, vector HitLocation)
{
	Super.DoDamage(Other, HitLocation);
	
	if (Pawn(Other) != None && Master != None && Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime)
	{
		if (Pawn(Other).Controller != None && InstigatorController != None && !Pawn(Other).Controller.SameTeamAs(InstigatorController))
			Master.GotTarget(Pawn(Other));
	}
}

defaultproperties
{
	WeaponClass=class'M7A3AssaultRifle'
	ModeIndex=1
	ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
	TrailClass=Class'BWBP_JCF_Pro.M7A3TazerTrail'
	MyRadiusDamageType=Class'BWBP_JCF_Pro.DTM7A3Tazer'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=0.000000
	MotionBlurRadius=0.000000
	MotionBlurFactor=0.000000
	MotionBlurTime=0.000000
	Speed=10240.000000
	Damage=5.000000
	MyDamageType=Class'BWBP_JCF_Pro.DTM7A3Tazer'
	DrawType=DT_None
	StaticMesh=StaticMesh'BWBP_OP_Static.Bloodhound.BHTazerDart'
	LifeSpan=0.100000
	DrawScale=1.500000
	bIgnoreTerminalVelocity=True
}
