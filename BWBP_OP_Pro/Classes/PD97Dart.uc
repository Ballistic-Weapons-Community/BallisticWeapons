class PD97Dart extends BallisticProjectile;

var Actor StuckActor;
var bool bPlaced;

var PD97Bloodhound Master;

simulated function bool Impact(Actor Other, vector HitLocation )
{
	if(Pawn(Other) != None)
	{
		StuckActor = Other;
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
        return true;
	}

    return false;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local PD97DartControl DC;
	
	if(bPlaced)
		return;

	bPlaced = true;
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController());
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if(Role < ROLE_Authority || Pawn(StuckActor) == None || Master == None)
	{
		Destroy();
		Return;
	}
		
	//Check for an existing dart control
	foreach StuckActor.BasedActors(class'PD97DartControl', DC)
	{
		if (DC.Instigator == Instigator && !DC.bTearOff)
		{
			DC.AddDart();
			Destroy();
			return;
		}
	}
	
	if (Level.TimeSeconds - Pawn(StuckActor).SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime)
	    return;

	if (Pawn(StuckActor).Controller != None && Instigator.Controller != None && Pawn(StuckActor).Controller.SameTeamAs(Instigator.Controller))
		DC = Spawn (class'PD97HealControl',StuckActor,, StuckActor.Location,StuckActor.Rotation);
	else DC = Spawn (class'PD97DartControl',StuckActor,, StuckActor.Location,StuckActor.Rotation);
	DC.Initialize(Pawn(StuckActor), Master);
	if (Instigator.Controller != None)
		DC.InstigatorController = Instigator.Controller;
	Master.AddControl(DC);

	Destroy();
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BWBP_OP_Pro.PD97DartTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTPD97Dart'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     Speed=15000.000000
     Damage=10.000000
     MyDamageType=Class'BWBP_OP_Pro.DTPD97Dart'
     StaticMesh=StaticMesh'BWBP_OP_Static.Bloodhound.BHPoisonDart'
     LifeSpan=2.500000
     bIgnoreTerminalVelocity=True
}
