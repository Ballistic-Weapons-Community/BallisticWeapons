//=============================================================================
// CX61's flame projectile.
//=============================================================================
class CX61HealProjectile extends BallisticProjectile;

var   array<actor>		AlreadyHit;

simulated event PreBeginPlay()
{
	if (Owner != None && Pawn(Owner) != None)
		Instigator = Pawn(Owner);
	super.PreBeginPlay();
}

function DoDamage (Actor Other, vector HitLocation)
{
	local Pawn	HealTarget;
	
	HealTarget = Pawn(Other);
	
	if (HealTarget == None || !HealTarget.bProjTarget)
		return;

	//bProjTarget is set False when a pawn is frozen in Freon.
	if (Instigator.Controller != None && HealTarget.Controller != None && HealTarget.Controller.SameTeamAs(Instigator.Controller))
	{
		if (BallisticPawn(Other) != None)
			BallisticPawn(HealTarget).GiveAttributedHealth(Damage, HealTarget.HealthMax, Instigator, False);
		else HealTarget.GiveHealth(Damage, HealTarget.HealthMax);
		return;
	}
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local int i;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;
	if (Other.Base == Instigator)
		return;
	for(i=0;i<AlreadyHit.length;i++)
		if (AlreadyHit[i] == Other)
			return;

	if (Role == ROLE_Authority)
		DoDamage(Other, HitLocation);
	
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		AlreadyHit[AlreadyHit.length] = Other;
		HitActor = Other;
	}
	else	Destroy();
}

defaultproperties
{
     bPenetrate=True
     Speed=3000.000000
     Damage=5.000000
     MyDamageType=Class'BWBPOtherPackPro.DT_CX61Burned'
     bHidden=True
     RemoteRole=ROLE_None
     LifeSpan=0.300000
     CollisionRadius=40.000000
     CollisionHeight=40.000000
     bCollideWorld=False
     bBlockZeroExtentTraces=False
     bBlockNonZeroExtentTraces=False
}
