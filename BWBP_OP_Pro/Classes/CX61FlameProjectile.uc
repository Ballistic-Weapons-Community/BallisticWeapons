//=============================================================================
// CX61's flame projectile.
//
// by Azarael
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//=============================================================================
class CX61FlameProjectile extends BallisticProjectile;

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
	super(BallisticProjectile).Tick(DT);
	if (vector(Rotation) Dot Normal(EndPoint-Location) < 0.0)
	{
		if (bHitWall)
			HurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, EndPoint);
		Destroy();
	}
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
    local int i;
    local CX61ActorFire Burner;

    DoDamage(Other, HitLocation);

    if (Pawn(Other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
    {
        for (i=0;i<Other.Attached.length;i++)
        {
            if (CX61ActorFire(Other.Attached[i])!=None)
            {
                CX61ActorFire(Other.Attached[i]).AddFuel(0.15);
                break;
            }
        }
        if (i>=Other.Attached.length)
        {
            Burner = Spawn(class'CX61ActorFire',Other,,Other.Location);
            Burner.Initialize(Other);
            if (Instigator!=None)
            {
                Burner.Instigator = Instigator;
                Burner.InstigatorController = Instigator.Controller;
            }
        }
    }
}

simulated function Penetrate(Actor Other, Vector HitLocation)
{
    AlreadyHit[AlreadyHit.length] = Other;
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.CX61AssaultRifle'
	 bApplyParams=False
    ModeIndex=1
    bPenetrate=True
    MyRadiusDamageType=Class'BWBP_OP_Pro.DT_CX61Burned'
    Speed=3000.000000
    Damage=8.000000
    DamageRadius=192.000000
    MomentumTransfer=0.000000
    MyDamageType=Class'BWBP_OP_Pro.DT_CX61Burned'
    bHidden=True
    RemoteRole=ROLE_None
    LifeSpan=0.300000
    CollisionRadius=28.000000
    CollisionHeight=28.000000
    bCollideWorld=False
    bBlockZeroExtentTraces=False
    bBlockNonZeroExtentTraces=False
}
