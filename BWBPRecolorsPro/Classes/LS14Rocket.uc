//=============================================================================
// MRLRocket.
//
// A Crazy, unpredictable and not too powerful small 'drunk' rocket. They move
// fast and unpredictably, but usually come with lots of others.
//
// Drunkness:
// -Initial low accuracy
// -Duds
// -Strafing
// -Sidewinders
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LS14Rocket extends BallisticProjectile;

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = Normal(Velocity) * AccelSpeed;
	
	SetTimer(0.5, false);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

simulated function Timer()
{
	SetCollision(true,true);

	InitProjectile();
	
	Velocity = vector(Rotation) * MaxSpeed;
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	if (Victim == None)
	{
		DamageAmount *= 0.5;
		DamageRadius *= 0.75;
	}
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (!FastTrace(Victims.Location, Location))
			{
				if (!bCoverPenetrator)
					continue;
				else DmgRadiusScale = (DamageRadius - GetCoverReductionFor(Victims.Location)) / DamageRadius;
				
				if (DamageRadius * DmgRadiusScale < 16)
					continue;
			}
			else DmgRadiusScale = 1;
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			if (bCoverPenetrator && DmgRadiusScale < 1 && VSize(dir) > DamageRadius * DmgRadiusScale)
				continue;
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ (DamageRadius * DmgRadiusScale));
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
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
     ImpactManager=Class'BallisticProV55.IM_MRLRocket'
     bRandomStartRotaion=False
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_LS14RocketRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     bCoverPenetrator=True
     Speed=600.000000
     MaxSpeed=14000.000000
     Damage=100.000000
     DamageRadius=384.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_LS14Rocket'
     StaticMesh=StaticMesh'BWBP4-Hardware.MRL.MRLRocket'
     AmbientSound=Sound'BWBP4-Sounds.MRL.MRL-RocketFly'
     SoundVolume=64
     bCollideActors=False
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
