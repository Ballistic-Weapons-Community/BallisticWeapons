//=============================================================================
// RSDarkFlameProjectile.
//
// An invisible porjectile used for DarkStar plasma collision detection
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkFlameProjectile extends BallisticProjectile;

var   Vector			EndPoint, StartPoint;
var   array<actor>		AlreadyHit;
var   bool				bHitWall;

simulated event PreBeginPlay()
{
	if (Owner != None && Pawn(Owner) != None)
		Instigator = Pawn(Owner);
	super.PreBeginPlay();
}

function InitFlame(vector End)
{
	EndPoint = End;
	StartPoint = Location;
//	LifeSpan = VSize(FireDir) / 3000;
}
event Tick(float DT)
{
	super.Tick(DT);
	if (vector(Rotation) Dot Normal(EndPoint-Location) < 0.0)
	{
		if (bHitWall)
			SpecialHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, EndPoint);
		Destroy();
	}
}

simulated function SpecialHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local bool bWasAlive;
//	local RSDarkSoul Soul;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != HurtWall)
		{
			if (xPawn(Victims) != None && Pawn(Victims).Health > 0)
			{
				if (Monster(Victims) == None || Pawn(Victims).default.Health > 275)
					bWasAlive = true;
			}
			else if (Vehicle(Victims) != None && Vehicle(Victims).Driver!=None && Vehicle(Victims).Driver.Health > 0)
				bWasAlive = true;
			else
				bWasAlive = false;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
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
			if (bWasAlive && Pawn(Victims).Health <= 0)
				class'RSDarkSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Victims), self);
/*			{
				Soul = Spawn(class'RSDarkSoul',,, HitLocation);
				if (Soul!=None)
					Soul.Assailant = Instigator;
			}
*/		}
	}
	bHurtEntry = false;
}

simulated function Timer()
{
	if (StartDelay > 0)
	{
		SetCollision(true, false, false);
		StartDelay = 0;
		SetPhysics(default.Physics);
		bDynamicLight=default.bDynamicLight;
		bHidden=false;
		InitProjectile();
	}
	else
		super.Timer();
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
//    local Vector X;
    local int i;
	local bool bWasAlive;
//	local RSDarkSoul Soul;
	local RSDarkPlasmaBurner PB;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local float AdjustedDamage;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;
	if (Other.Base == Instigator)
		return;
	for(i=0;i<AlreadyHit.length;i++)
		if (AlreadyHit[i] == Other)
			return;

	if (Role == ROLE_Authority)
	{
		HealObjective = DestroyableObjective(Other);
		if ( HealObjective == None )
			HealObjective = DestroyableObjective(Other.Owner);
		if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
		{
			AdjustedDamage = Damage * Instigator.DamageScaling * 4;
			if (Instigator.HasUDamage())
				AdjustedDamage *= 2;
			HealObjective.HealDamage(AdjustedDamage, Instigator.Controller, class'DT_RSDarkPlasma');
		}
		else
		{
			HealVehicle = Vehicle(Other);
			if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
			{
				AdjustedDamage = Damage * Instigator.DamageScaling * 4;
				if (Instigator.HasUDamage())
					AdjustedDamage *= 2;
				HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, class'DT_RSDarkPlasma');
			}
			else if (Pawn(Other) != None && Instigator!=None && (Instigator.Controller == None || Instigator.Controller.SameTeamAs(Pawn(Other).Controller)))
			{
				AdjustedDamage = Damage * Instigator.DamageScaling;
				if (Instigator.HasUDamage())
					AdjustedDamage *= 2;
				Other.HealDamage(AdjustedDamage, Instigator.Controller, class'DT_RSDarkPlasma');
			}
			else
			{
				if (xPawn(Other) != None && Pawn(Other).Health > 0)
					bWasAlive = true;
				else if (Vehicle(Other) != None && Vehicle(Other).Driver!=None && Vehicle(Other).Driver.Health > 0)
					bWasAlive = true;

				DoDamage(Other, HitLocation);

				if (bWasAlive && Pawn(Other).Health <= 0)
					class'RSDarkSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Other), self);

			if (Pawn(other) != None)
				{
					for (i=0;i<Other.Attached.length;i++)
					{
						if (RSDarkPlasmaBurner(Other.Attached[i])!=None)
						{
							RSDarkPlasmaBurner(Other.Attached[i]).AddPower(0.15);
							break;
						}
					}
					if (i>=Other.Attached.length)
					{
						PB = Spawn(class'RSDarkPlasmaBurner',Other,,Other.Location);
						PB.Initialize(Other);
						if (Instigator!=None)
						{
							PB.Instigator = Instigator;
							PB.InstigatorController = Instigator.Controller;
						}
					}
				}
			}
		}
	}
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		AlreadyHit[AlreadyHit.length] = Other;
		HitActor = Other;
	}
	else
	{
		HurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, EndPoint);
		Destroy();
	}
}

defaultproperties
{
     bPenetrate=True
     MyRadiusDamageType=Class'BallisticProV55.DT_RSDarkPlasma'
     Speed=3000.000000
     Damage=6.000000
     DamageRadius=192.000000
     MomentumTransfer=5000.000000
     MyDamageType=Class'BallisticProV55.DT_RSDarkPlasma'
     bHidden=True
     RemoteRole=ROLE_None
     LifeSpan=0.600000
     CollisionRadius=24.000000
     CollisionHeight=24.000000
     bCollideWorld=False
     bBlockZeroExtentTraces=False
     bBlockNonZeroExtentTraces=False
}
