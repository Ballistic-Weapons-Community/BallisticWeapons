//=============================================================================
// DTorthraxe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTorthraxe extends DTJunkDamage;

static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Super.Hurt(Victim, Damage, Instigator, HitLocation, Momentum, DT);

	DoDartEffect(Victim, Instigator);
}

static function DoDartEffect(Actor Victim, Pawn Instigator)
{
    local or_blood DP;

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	if (AIController(Pawn(Victim).Owner) != None)
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Owner), 2, 12);

	DP = Victim.Level.Spawn(class'or_blood', Pawn(Victim).Owner);

	DP.Instigator = Instigator;

    if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		DP.InstigatorController = Instigator.Controller;

	DP.Initialize(Victim);
}

defaultproperties
{
     DeathStrings(0)="%k sliced %o up with an orcish throwing axe."
     DeathStrings(1)="%k went Grom Hellscream all over the place and killed %o."
     DeathStrings(2)="%k's bloodlust caused %km to slaughter %o."
     ShieldDamage=40
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
     DeathString="%k plunged an orcish throwing axe into %o's face."
     FemaleSuicide="%o poked herself with an orcish throwing axe."
     MaleSuicide="%o poked himself with an orcish throwing axe."
}
