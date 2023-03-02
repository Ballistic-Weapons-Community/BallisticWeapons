class Proj_Caltrop extends JunkProjectile;

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	if (bStuckInWall && Role == ROLE_Authority)
	{
		DoDamage(Other, HitLocation);
		if (Pawn(Other) != None)
			ApplySlowdown(Pawn(Other));
		Destroy();
		return;
	}
	if (Other == Instigator && !bCanHitOwner)
		return;
	if (Base != None)
		return;

	if (!bHitPlayer && Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (ActorImpactType == IT_Bounce)
		HitWall( Normal(HitLocation - Other.Location), Other );
	else if (ActorImpactType == IT_Stick)
	{
		if (bHitPlayer)
			return;
		bHitPlayer = true;
		SetLocation(HitLocation);
		Velocity = Normal(HitLocation-Other.Location)*100;
	}
	else if (ActorImpactType == IT_Explode)
	{
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

function ApplySlowdown(pawn Other)
{
	local Inv_Slowdown Slow;
	
	Slow = Inv_Slowdown(Other.FindInventoryType(class'Inv_Slowdown'));
	
	if (Slow != None)
		Slow.ExtendDuration(4);
	
	else Other.CreateInventory("BWBP_JWC_Pro.Inv_Slowdown");
}

defaultproperties
{
}
