//=============================================================================
// DTpener.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTpener extends DTJunkDamage;

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
     DeathStrings(0)="%k smashed %o with a blazing dildo."
     DeathStrings(1)="%o just thought WTF before being killed by a fiery giant dildo."
     DeathStrings(2)="%o's anus was ruptured by %k's phoenix penetrator."
     DeathStrings(3)="%o just got killed by %k's giant phoenix fire dildo. Uuuuuh."
     DeathStrings(4)="%o expected a grenade after %k screamed "
     ShieldDamage=30
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTwoByFour'
     DeathString="%k beat in the frail kneecaps of %o with a Fire Penetrator."
     FemaleSuicide="%o beat herself to death with a Fire Penetrator."
     MaleSuicide="%o beat himself to death with a Fire Penetrator."
}
