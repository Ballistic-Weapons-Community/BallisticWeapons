//=============================================================================
// DTX4Knife.
//
// Damagetype for X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX4KnifeTox extends DT_BWBlade;

static function IncrementKills(Controller Killer)
{
    Killer.AwardAdrenaline(10);
}
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Super.Hurt(Victim, Damage, Instigator, HitLocation, Momentum, DT);

	DoKnifeEffect(Victim, Instigator);
}

static function DoKnifeEffect(Actor Victim, Pawn Instigator)
{
    local int i;
    local X4KnifeViewMesser VM;
	local X4KnifePoisoner DP;

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	if (PlayerController(Pawn(Victim).Owner) != None)
	{
		for (i=0;i<Pawn(Victim).Owner.Attached.length;i++)
		{
			if (X4KnifeViewMesser(Pawn(Victim).Owner.Attached[i]) != None)
			{
				VM = X4KnifeViewMesser(Pawn(Victim).Owner.Attached[i]);
				break;
			}
		}
		if (VM == None)
		{
			VM = Victim.Level.Spawn(class'X4KnifeViewMesser', Pawn(Victim).Owner);
			VM.SetBase(Pawn(Victim).Owner);
		}
		VM.SetupTimer();
		VM.AddImpulse(1.0);
	}
	else if (AIController(Pawn(Victim).Owner) != None)
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Owner), 2, 12);

	DP = Victim.Level.Spawn(class'X4KnifePoisoner', Pawn(Victim).Owner);

	DP.Instigator = Instigator;

    if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		DP.InstigatorController = Instigator.Controller;

	DP.Initialize(Victim);
}
defaultproperties
{
     DeathStrings(0)="%k cut up %o like a paper-shredder with %kh X4 knife."
     DeathStrings(1)="%o pounced onto %k's X4, and disembowelled %vs."
     DeathStrings(2)="%k jammed and jabbed %kh X4 knife into %o's staggering body."
     DeathStrings(3)="%o was stabbed to death by an enraged %k and %kh X4."
     DamageDescription=",Slash,Stab,"
     WeaponClass=Class'BallisticProV55.X4Knife'
     DeathString="%k cut up %o like a paper-shredder with %kh X4 knife."
     FemaleSuicide="%o fell on her X4 knife."
     MaleSuicide="%o fell on his X4 knife."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
