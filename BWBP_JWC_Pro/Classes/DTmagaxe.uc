//=============================================================================
// DTJunkMagaxe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTmagaxe extends DTJunkDamage;

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
     DeathStrings(0)="%o didn't know magic axes existed until now."
     DeathStrings(1)="%k used an artifact to scorch %o's face."
     DeathStrings(2)="%k tore %o apart with %kh magic axe."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=180
     DamageDescription=",Hack,"
     ImpactManager=None
     DeathString="%o was completey halved by %k's Magic Axe assault."
     FemaleSuicide="%o halved herself with a Magic Axe."
     MaleSuicide="%o halved himself with a Magic Axe."
     bNeverSevers=False
}
