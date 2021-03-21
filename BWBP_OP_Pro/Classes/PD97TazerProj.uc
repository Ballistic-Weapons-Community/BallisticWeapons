class PD97TazerProj extends BallisticProjectile;

var PD97Attachment Master;

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
     ModeIndex=1
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BWBP_OP_Pro.PD97TazerTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTPD97Tazer'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     Speed=10240.000000
     Damage=5.000000
     MyDamageType=Class'BWBP_OP_Pro.DTPD97Tazer'
     DrawType=DT_None
     StaticMesh=StaticMesh'BWBP_OP_Static.Bloodhound.BHTazerDart'
     LifeSpan=0.100000
     DrawScale=1.500000
     bIgnoreTerminalVelocity=True
}
