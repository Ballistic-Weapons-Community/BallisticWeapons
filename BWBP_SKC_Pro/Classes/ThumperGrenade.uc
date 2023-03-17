//=============================================================================
// BOGPGrenade.
//
// Grenade fired by the BGOP Grenade Pistol.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ThumperGrenade extends BallisticGrenade;

var bool bArmed;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	SetTimer(0.20, False);
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	if (!bHasImpacted)
		DetonateOn=DT_Impact;
		
	else Explode(Location, vect(0,0,1));
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;
	
	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
	{
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.2;
		DampenFactorParallel *= 0.2;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	
	Speed = VSize(Velocity/2);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
		if (ReflectImpactManager != None)
		{
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);			
		}
    }
}
			
// Useful if you want to spare a directly hit enemy from the radius damage
/*function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir, NewMomentum;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
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

			// Increase self damage and convert vertical momentum to horizontal momentum to curb OOB exploits while still offering some mobility fun -Xav
			NewMomentum = damageScale * Momentum * dir; 
			if (NewMomentum.Z < Momentum * 0.50 * damageScale)
				NewMomentum.Z = Momentum * 0.50 * damageScale;
			if (Victims == Instigator && xPawn(Victims) != None)
			{
				DamageAmount *= 1.50;
				NewMomentum.X *= 1.50;
				NewMomentum.Y *= 1.50;
				NewMomentum.Z *= 0.50;
			}	
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				NewMomentum,
				DamageType
			);
		 }
		 
	}
	bHurtEntry = false;
}*/			
			
defaultproperties
{
     DetonateOn=DT_ImpactTimed
	 PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=25
     ImpactDamageType=Class'BWBP_SKC_Pro.DTTOPORGrenade'
     ImpactManager=Class'BWBP_SKC_Pro.IM_ThumperGrenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTTOPORGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=256.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=3500.000000
     Damage=60.000000
     DamageRadius=512.000000
	 MomentumTransfer=100000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTTOPORGrenade'
     ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_Grenade'
     DrawScale=0.300000
     bIgnoreTerminalVelocity=True
}
