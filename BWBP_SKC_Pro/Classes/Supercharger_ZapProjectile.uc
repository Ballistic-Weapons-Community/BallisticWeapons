//=============================================================================
// RX22AProjectile.
//
// The flamer projectile is special. It has a fat collision and is only used
// for finding actors to burn. It does not collide with the world and must die
// when it goes beyond its EndPoint. This reports back to the FireControl when
// it hits something.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_ZapProjectile extends BallisticProjectile;

var   Supercharger_ChargeControl	ChargeControl;
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
//	LifeSpan = VSize(FireDir) / 3000;
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

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
//    local Vector X;
    local int i;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;
	if (Other.Base == Instigator)
		return;
	for(i=0;i<AlreadyHit.length;i++)
		if (AlreadyHit[i] == Other)
			return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		AlreadyHit[AlreadyHit.length] = Other;
		HitActor = Other;
	}
	else
		Destroy();

	if (Pawn(Other) != None)
		ChargeControl.FireSinge(Pawn(Other), Instigator, 1); //The 1 designates this weapon is an supercharger, used for death messages
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
	bApplyParams=False
	bPenetrate=True
	StartDelay=0.050000
	Speed=3000.000000
	Damage=5.000000
	MyDamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
	bHidden=True
	RemoteRole=ROLE_None
	LifeSpan=0.600000
	CollisionRadius=32.000000
	CollisionHeight=32.000000
	bCollideActors=False
	bCollideWorld=False
	bBlockZeroExtentTraces=False
	bBlockNonZeroExtentTraces=False
}
