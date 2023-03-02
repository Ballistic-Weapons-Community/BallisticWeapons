//=============================================================================
// DTsyringe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTsyringe extends DTJunkDamage;

static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Super.Hurt(Victim, Damage, Instigator, HitLocation, Momentum, DT);

	DoDartEffect(Victim, Instigator);
}

static function DoDartEffect(Actor Victim, Pawn Instigator)
{
    local int i;
    local syr_view VM;
	local syr_poison DP;

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	if (PlayerController(Pawn(Victim).Owner) != None)
	{
		for (i=0;i<Pawn(Victim).Owner.Attached.length;i++)
		{
			if (syr_view(Pawn(Victim).Owner.Attached[i]) != None)
			{
				VM = syr_view(Pawn(Victim).Owner.Attached[i]);
				break;
			}
		}
		if (VM == None)
		{
			VM = Victim.Level.Spawn(class'syr_view', Pawn(Victim).Owner);
			VM.SetBase(Pawn(Victim).Owner);
		}
		VM.SetupTimer();
		VM.AddImpulse(1.0);
	}
	else if (AIController(Pawn(Victim).Owner) != None)
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Owner), 2, 12);

	DP = Victim.Level.Spawn(class'syr_poison', Pawn(Victim).Owner);

	DP.Instigator = Instigator;

    if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		DP.InstigatorController = Instigator.Controller;

	DP.Initialize(Victim);
}

defaultproperties
{
     DeathStrings(0)="%k euthanized %o."
     DeathStrings(1)="%k poisoned %o with a dirty syringe."
     DeathStrings(2)="%k used his junkie needle to give %o herpes."
     DeathStrings(3)="%o thought %k was a doctor."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh syringe."
     FemaleSuicide="%o cracked herself with a syringe."
     MaleSuicide="%o cracked himself with a syringe."
     VehicleDamageScaling=0.000000
}
