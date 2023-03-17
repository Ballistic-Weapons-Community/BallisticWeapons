class XOXONukeProjectile extends BallisticProjectile;

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
		BlowUp(Location + ExploWallOut * HitNormal);

		if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
			GotoState('NetTrapped');
		else
			Destroy();
	}

	else if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry && (Pawn(Wall) == None || Vehicle (Wall) != None)) // ignore pawns when using HitWall
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			DoDamage(Wall, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);

	HurtWall = None;
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 2, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 2, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
		GotoState('NetTrapped');
	else
		Destroy();
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if (!FastTrace(Location, Victims.Location))
				damageScale *= 0.65;
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.XOXOStaff'
     ImpactManager=Class'BWBP_OP_Pro.IM_XOXO'
     PenetrateManager=Class'BWBP_OP_Pro.IM_XOXO'
     bRandomStartRotation=False
     TrailClass=Class'BWBP_OP_Pro.XOXONukeTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTXOXOSexplosion'
     
     
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=2500.000000
     MaxSpeed=4500.000000
     bSwitchToZeroCollision=True
     Damage=250.000000
     DamageRadius=2048.000000
     MomentumTransfer=100.000000
     MyDamageType=Class'BWBP_OP_Pro.DTXOXOSexplosion'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=220
     LightSaturation=120
     LightBrightness=192.000000
     LightRadius=6.000000
     StaticMesh=StaticMesh'BWBP_OP_Static.XOXO.O'
     bDynamicLight=True
     bNetTemporary=False
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     AmbientSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2FlyBy'
     LifeSpan=4.000000
     DrawScale=3.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bNetNotify=True
     bFixedRotationDir=True
     RotationRate=(Roll=16384)
}
