//=============================================================================
// ChaffRifleGrenade.
//
// Chaff Grenade fired by MJ51Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SHADRACHRifleGrenade extends BallisticGrenade;


simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
		
	BlowUp(HitLocation);
	
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}
	
	Destroy();
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
    local bool can_see;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	if (Pawn(Victim) != None && Pawn(Victim).Health > 0 && Vehicle(Victim) == None)
		ApplyPlague(Victim, 1);
	
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( Victims.bCanBeDamaged && (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
            can_see = FastTrace(Victims.Location, Location);

			if (!can_see)
            {
                if (WallPenetrationForce == 0)
                    continue;
            }

            // UNDerwater EXplosion damage
            else if (PhysicsVolume.bWaterVolume && Victims.PhysicsVolume == PhysicsVolume)
                DamageRadius *= 3;

            damageScale = 1f;

            dir = Victims.Location;
            if (Victims.Location.Z > HitLocation.Z)
                dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
            else 
                dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
            dir -= HitLocation;
            dist = FMax(1, VSize(dir));
            dir /= dist;

            if (can_see)
            {
                if (RadiusFallOffType != RFO_None)
                    damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius) / DamageRadius);
                if (RadiusFallOffType == RFO_Quadratic)
                    damageScale = Square(damageScale);
            }
            else 
            {
                damageScale = GetPenetrationDamageScale(dir, dist);

                if (damageScale < 0.01f)
                    continue;

                if (RadiusFallOffType == RFO_Quadratic)
                    damageScale = Square(damageScale);
            }

			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );

			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				GetMomentumVector(damageScale * dir),
				DamageType
			);
			if (Pawn(Victims) != None && Pawn(Victims).Health > 0 && Vehicle(Victims) == None)
				ApplyPlague(Victims, damageScale);
		 }
	}
	bHurtEntry = false;
}

function bool AllowPlague(Actor Other)
{
	return 
		Pawn(Other) != None 
		&& Pawn(Other).Health > 0 
		&& Vehicle(Other) == None 
		&& (Pawn(Other).GetTeamNum() == 255 || Pawn(Other).GetTeamNum() != Instigator.GetTeamNum())
		&& Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime;
}

function ApplyPlague(Actor Other, float DamageScale)
{
	local SHADRACHPlagueEffect SPE;
	
	foreach Other.BasedActors(class'SHADRACHPlagueEffect', SPE)
		SPE.ExtendDuration(8 * DamageScale);

	if (SPE == None)
	{
		SPE = Spawn(class'SHADRACHPlagueEffect',Other,,Other.Location);// + vect(0,0,-30));
		SPE.Initialize(Other);
		SPE.Duration = FMax(1, 8 * DamageScale);
		
		if (Instigator!=None)
		{
			SPE.Instigator = Instigator;
			SPE.InstigatorController = Instigator.Controller;
		}
	}
}

function DoDamage (Actor Other, vector HitLocation)
{
	local SHADRACHPlagueEffect SPE;
	
	super.DoDamage (Other, HitLocation);
	
	if (AllowPlague(Other))
	{
		foreach Other.BasedActors(class'SHADRACHPlagueEffect', SPE)
		{
			SPE.ExtendDuration(4);
		}
		if (SPE == None)
		{
			SPE = Spawn(class'SHADRACHPlagueEffect',Other,,Other.Location);// + vect(0,0,-30));
			SPE.Initialize(Other);
			if (Instigator!=None)
			{
				SPE.Instigator = Instigator;
				SPE.InstigatorController = Instigator.Controller;
			}
		}
	}
}

defaultproperties
{
     DetonateOn=DT_Impact
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=90
     ImpactDamageType=Class'BWBP_SKC_Pro.DTChaffGrenade'
     ImpactManager=Class'BWBP_APC_Pro.IM_SHADRACHChaffGrenade'
     TrailClass=Class'BWBP_APC_Pro.SRKSmgTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTChaffGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=768.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=10.000000
     Speed=3750.000000
     MaxSpeed=4500.000000
     Damage=65.000000
     DamageRadius=320.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTChaffGrenadeRadius'
     StaticMesh=StaticMesh'BWBP_CC_Static.SPXSmg.SHADRACH_Proj'
     DrawScale=0.200000
     bUnlit=False
	 ModeIndex=1
}
