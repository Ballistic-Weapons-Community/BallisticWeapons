//=============================================================================
// TrenchGunFlameProjectile.
//
// The flamer projectile is special. It has a fat collision and is only used
// for finding actors to burn. It does not collide with the world and must die
// when it goes beyond its EndPoint. This reports back to the FireControl when
// it hits something.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class TrenchGunFlameProjectile extends BallisticProjectile;

var   TrenchGunFireControl	FireControl;
var   Vector			EndPoint, StartPoint;
var   array<actor>		AlreadyHit;

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
}

event Tick(float DT)
{
	super.Tick(DT);
	if (vector(Rotation) Dot Normal(EndPoint-Location) < 0.0)
		Destroy();
}

simulated function Timer()
{
	if (StartDelay > 0)
	{
		SetCollision(true, false, false);
		StartDelay = 0;
		SetPhysics(default.Physics);
		bDynamicLight=default.bDynamicLight;
		bHidden=default.bHidden;
		InitProjectile();
	}
	else
		super.Timer();
}

simulated function bool CanTouch (Actor Other)
{
    local int i;
    
    if (!Super.CanTouch(Other))
        return false;

    if (Other.Base == Instigator)
		return false;

	for(i=0;i<AlreadyHit.length;i++)
		if (AlreadyHit[i] == Other)
			return false;

    return true;
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);

    if (Pawn(Other) != None)
		FireControl.FireSinge(Pawn(Other), Instigator);
}

simulated function Penetrate(Actor Other, Vector HitLocation)
{
	AlreadyHit[AlreadyHit.length] = Other;
}

simulated function Explode (vector a, vector b)
{
    Destroy();
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.TrenchGun'
	 bApplyParams=False
     bPenetrate=True
     StartDelay=0.030000
     Speed=3000.000000
     Damage=18.000000
     MyDamageType=Class'BWBP_OP_Pro.DTTrenchBurned'
     bHidden=True
     RemoteRole=ROLE_None
     LifeSpan=0.350000
     CollisionRadius=30.000000
     CollisionHeight=30.000000
     bCollideActors=False
     bCollideWorld=False
     bBlockZeroExtentTraces=False
     bBlockNonZeroExtentTraces=False
}
