class AkeronRocket extends BallisticProjectile;

var float ArmingDelay;
var sound ImpactSounds[6];
var float OutwardDamageRadius;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	//SetTimer(ArmingDelay, False);
}

/*
simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	bBounce=False;
}
*/

simulated function Landed (vector HitNormal)
{
	Explode(Location, HitNormal);
}	

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	
	if (Other == HitActor)
		return;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
				
	if (Role == ROLE_Authority)		// Do damage for direct hits, but only once to the same actor
		DoDamage(Other, HitLocation);
	HitActor = Other;
	Explode(HitLocation, Normal(HitLocation-Other.Location));
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    if ( !Wall.bStatic && !Wall.bWorldGeometry 
		&& ((Mover(Wall) == None) || Mover(Wall).bDamageTriggered) )
    {
        if ( Level.NetMode != NM_Client )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
            Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		}
        Destroy();
        return;
    }
    		
	if(bBounce)
	{	
		if ( !Level.bDropDetail && (FRand() < 0.4) )
		Playsound(ImpactSounds[Rand(6)]);
		bBounce=False;
		Velocity = 0.75 * (Velocity - 1.25*HitNormal*(Velocity dot HitNormal));
		return;
   	}
   	
   	Explode(Location, -vector(Rotation));
}

// Useful if you want to spare a directly hit enemy from the radius damage
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir, ClosestLinePoint;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			dir = Victims.Location - HitLocation;
			if (Vector(Rotation) dot Normal(Dir) < 0)
				continue;
			ClosestLinePoint = Location + vector(Rotation) * (( Vector(Rotation) * DamageRadius ) dot ( Victims.Location - Location )) / DamageRadius;
			if (VSize(Victims.Location - ClosestLinePoint) > OutwardDamageRadius)
				continue;
			if (!FastTrace(Victims.Location, Location))
			{
				DmgRadiusScale = (DamageRadius - GetCoverReductionFor(Victims.Location)) / DamageRadius;
				
				if (DamageRadius * DmgRadiusScale < 16)
					continue;
			}
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - 0.65 * FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);	
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

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
    local Vector ClosestLocation, BoneTestLocation, temp;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (xPawn(Other) != None)
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the hit along the projectile's Velocity to a point where it is closest to the victim's Z axis.
		temp = Normal(Velocity);
		temp *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation = temp;
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(temp);
		BoneTestLocation += HitLocation;
		
		class'BallisticDamageType'.static.GenericHurt (GetDamageVictim(Other, BoneTestLocation, Normal(Velocity), Dmg, DT), Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);
	}
	else class'BallisticDamageType'.static.GenericHurt (GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT), Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);
}

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	local string	Bone;
	local float		BoneDist;
	local Vector 	HitLocationMatchZ;
	local Pawn		DriverPawn;

	Dmg = Damage;
	DT = MyDamageType;

	if (!bUsePositionalDamage || Monster(Other) != None)
		return Other;

	if (Pawn(Other) != None)
	{
		if (Vehicle(Other) != None)
		{
			// Try to relieve driver of his head...
			DriverPawn = Vehicle(Other).CheckForHeadShot(HitLocation, Dir, 1.0);
			if (DriverPawn != None)
			{
				Other = DriverPawn;
				Dmg *= HeadMult;

				if (DamageTypeHead != None)
					DT = DamageTypeHead;
			}
		}
		
		else
		{
			HitLocationMatchZ = HitLocation;
			HitLocationMatchZ.Z = Other.Location.Z;
			
			// Check for head shot
			Bone = string(Other.GetClosestBone(HitLocation, Dir, BoneDist, 'head', 10));
			if (InStr(Bone, "head") > -1)
			{
				Dmg *= HeadMult;

				if (DamageTypeHead != None)
					DT = DamageTypeHead;
			}
			
			// Limb shots
			else if (HitLocation.Z < Other.GetBoneCoords('spine').Origin.Z - 14 || VSize(HitLocationMatchZ - Other.Location) > 22) //accounting for groin region here
			{
				Dmg *= LimbMult;
				if (DamageTypeLimb != None)
					DT = DamageTypeLimb;
			}
		}
	}
	return Other;
}

defaultproperties
{
     ArmingDelay=0.050000
     ImpactSounds(0)=Sound'XEffects.Impact4Snd'
     ImpactSounds(1)=Sound'XEffects.Impact6Snd'
     ImpactSounds(2)=Sound'XEffects.Impact7Snd'
     ImpactSounds(3)=Sound'XEffects.Impact3'
     ImpactSounds(4)=Sound'XEffects.Impact1'
     ImpactSounds(5)=Sound'XEffects.Impact2'
     OutwardDamageRadius=96.000000
     ImpactManager=Class'BWBPOtherPackPro.IM_Akeron'
     bRandomStartRotaion=False
     AccelSpeed=100000.000000
     TrailClass=Class'BallisticProV55.G5RocketTrail'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTAkeron'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=4000.000000
     MaxSpeed=35000.000000
     Damage=105.000000
     DamageRadius=300.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BWBPOtherPackPro.DTAkeron'
     StaticMesh=StaticMesh'BallisticHardware_25.BOGP.BOGP_Grenade'
     AmbientSound=Sound'BWBP4-Sounds.MRL.MRL-RocketFly'
     DrawScale=0.750000
     SoundVolume=64
     bBounce=False
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
