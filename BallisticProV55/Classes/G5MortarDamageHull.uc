//=============================================================================
// G5MortarDamageHull.
//
// Sum kind o fing to get shot to break da morta fing...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G5MortarDamageHull extends Triggers;

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (Projectile(Base) != None)
		Base.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType);
	else if (Projectile(Owner) != None)
		Owner.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType);
}

defaultproperties
{
     bCanBeDamaged=True
     bHardAttach=True
     CollisionRadius=8.000000
     CollisionHeight=8.000000
     bProjTarget=True
}
