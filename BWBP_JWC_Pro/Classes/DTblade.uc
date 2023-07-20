//=============================================================================
// DTblade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTblade extends DTJunkDamage;

static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Super.Hurt(Victim, Damage, Instigator, HitLocation, Momentum, DT);

	DoDartEffect(Victim, Instigator);
}

static function DoDartEffect(Actor Victim, Pawn Instigator)
{
	local JW_Fire DP;

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	DP = Victim.Level.Spawn(class'JW_Fire', Pawn(Victim).Owner);

	DP.Instigator = Instigator;

    if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		DP.InstigatorController = Instigator.Controller;

	DP.Initialize(Victim);
}

defaultproperties
{
     DeathStrings(0)="%k's blazing blade made quick work of %o."
     DeathStrings(1)="%k ignited %o in a dramatic 1v1."
     DeathStrings(2)="%k let %o burn to death painfully."
     ShieldDamage=30
     ImpactManager=None
     DeathString="%k's Blazing Blade went screaming into %o's exposed face."
     FemaleSuicide="%o sliced herself up with a Blazing Blade."
     MaleSuicide="%o sliced himself up with a Blazing Blade."
}
