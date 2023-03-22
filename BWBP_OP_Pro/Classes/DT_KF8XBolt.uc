//=============================================================================
// DT_KF8XBolt.
//
// DamageType for the KF8X bolts
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_KF8XBolt extends DT_BWBlunt;

static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Super.Hurt(Victim, Damage, Instigator, HitLocation, Momentum, DT);

	DoDartEffect(Victim, Instigator);
}

static function DoDartEffect(Actor Victim, Pawn Instigator)
{
    local int i;
    local KF8XBoltViewMesser VM;
	local KF8XBoltPoisoner DP;

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	if (PlayerController(Pawn(Victim).Owner) != None)
	{
		for (i=0;i<Pawn(Victim).Owner.Attached.length;i++)
		{
			if (KF8XBoltViewMesser(Pawn(Victim).Owner.Attached[i]) != None)
			{
				VM = KF8XBoltViewMesser(Pawn(Victim).Owner.Attached[i]);
				break;
			}
		}
		if (VM == None)
		{
			VM = Victim.Level.Spawn(class'KF8XBoltViewMesser', Pawn(Victim).Owner);
			VM.SetBase(Pawn(Victim).Owner);
		}
		VM.SetupTimer();
		VM.AddImpulse(1.0);
	}
	else if (AIController(Pawn(Victim).Owner) != None)
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Owner), 2, 12);

	DP = Victim.Level.Spawn(class'KF8XBoltPoisoner', Pawn(Victim).Owner);

	DP.Instigator = Instigator;

    if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		DP.InstigatorController = Instigator.Controller;

	DP.Initialize(Victim);
}

defaultproperties
{
     DeathStrings(0)="%o was assassinated from the shadows by %k's K-F8X bolt."
     DeathStrings(1)="%k planted a crossbow bolt into %o."
     DeathStrings(2)="%o was discreetly decommissioned by %k's silent bolt."
     FlashThreshold=0
     FlashV=(Y=2000.000000)
     FlashF=0.300000
     SimpleKillString="KF-8X Bolt"
     WeaponClass=Class'BWBP_OP_Pro.KF8XCrossbow'
     DeathString="%%o was assassinated from the shadows by %k's KF-8X bolt."
     FemaleSuicide="%o dropped her own crossbow."
     MaleSuicide="%o dropped his own crossbow."
     PawnDamageSounds(0)=Sound'BWBP_SKC_Sounds.VSK.VSK-ImpactFlesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.100000
     VehicleMomentumScaling=0.100000
}
