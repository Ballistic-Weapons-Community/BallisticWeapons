class Proj_Shuriken extends JunkProjectile;

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float SpeedFactor, Dmg;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (bUsePositionalDamage)
		Other = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);
	else
	{
		Dmg = Damage;
		DT = MyDamageType;
	}
	if (bHasImpacted && bBounceDamageScaling && FireInfo != None)
	{
		SpeedFactor = VSize(Velocity) / FireInfo.ProjSpeed;
		Dmg *= SpeedFactor;
		MomentumTransfer *= SpeedFactor;
	}
	class'BallisticDamageType'.static.GenericHurt (Other, Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);
	if (Pawn(Other) != None)
		ApplySlowdown(Pawn(Other));
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
