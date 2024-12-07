//=============================================================================
// DTXMK5Dart.
//
// DamageType for the XMK5 dart secondary fire
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM14Dart extends DT_BWBlunt;

static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Super.Hurt(Victim, Damage, Instigator, HitLocation, Momentum, DT);

	DoDartEffect(Victim, Instigator);
}

static function DoDartEffect(Actor Victim, Pawn Instigator)
{
    local int i;
    local FM14DartViewMesser VM;
	local FM14DartPoisoner DP; //DPE

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	if (PlayerController(Pawn(Victim).Owner) != None)
	{
		for (i=0;i<Pawn(Victim).Owner.Attached.length;i++)
		{
			if (FM14DartViewMesser(Pawn(Victim).Owner.Attached[i]) != None)
			{
				VM = FM14DartViewMesser(Pawn(Victim).Owner.Attached[i]);
				break;
			}
		}
		if (VM == None)
		{
			VM = Victim.Level.Spawn(class'FM14DartViewMesser', Pawn(Victim).Owner);
			VM.SetBase(Pawn(Victim).Owner);
		}
		VM.SetupTimer();
		VM.AddImpulse(1.0);
	}
	else if (AIController(Pawn(Victim).Owner) != None)
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Owner), 2, 12);

	DP = Victim.Level.Spawn(class'FM14DartPoisoner', Pawn(Victim).Owner);

	DP.Instigator = Instigator;

	if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		DP.InstigatorController = Instigator.Controller;

	DP.Initialize(Victim);
}

defaultproperties
{
     DeathStrings(0)="%o was nailed by %k's FM14 stun dart."
     DeathStrings(1)="%o was drilled by %k's FM14 dart."
     DeathStrings(2)="%o was implanted with %k's FM14 dart."
     SimpleKillString="FM14 Dart"
     WeaponClass=Class'BWBP_APC_Pro.FM14Shotgun'
     DeathString="%o was nailed by %k's FM14 stun dart."
     FemaleSuicide="%o became her own FM14 dartboard."
     MaleSuicide="%o became his own FM14 dartboard."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
