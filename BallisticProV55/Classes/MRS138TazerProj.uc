class MRS138TazerProj extends BallisticProjectile;

var MRS138Attachment Master;

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
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.MRS138TazerProjTrail'
     MyRadiusDamageType=Class'BallisticProV55.DTMRS138Tazer'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     Speed=12800.000000
     MaxSpeed=12800.000000
     Damage=5.000000
     MyDamageType=Class'BallisticProV55.DTMRS138Tazer'
     DrawType=DT_None
     StaticMesh=StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Dart'
     LifeSpan=0.200000
     DrawScale=1.500000
     bIgnoreTerminalVelocity=True
}
