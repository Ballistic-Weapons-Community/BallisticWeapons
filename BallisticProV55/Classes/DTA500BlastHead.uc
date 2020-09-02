//=============================================================================
// DTA500Blast.
//
// Damage type for the A500 Blast projectiles.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA500BlastHead extends DT_BWMiscDamage;

var() float ArmorDrain;

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local Armor BestArmor;

	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);

	// Do additional damage to armor..
	if(Pawn(Victim) != None && Pawn(Victim).Inventory != None)
	{
		BestArmor = Pawn(Victim).Inventory.PrioritizeArmor(Damage*Default.ArmorDrain,Default.Class,HitLocation);
		if(BestArmor != None)
			BestArmor.ArmorAbsorbDamage(Damage*Default.ArmorDrain,Default.Class,HitLocation);
	}
}

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.headcount++;
		if ( (xPRI.headcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('HeadHunter',15);
	}
}
// --------------------------------------------------------

defaultproperties
{
     ArmorDrain=0.230000
     DeathStrings(0)="%o was melted into a gooey mess by %k's A500 acid blast."
     DeathStrings(1)="%k acidified %o with the A500."
     DeathStrings(2)="%k's Reptile blast chewed up and spat out %o."
     DeathStrings(3)="%o got liquidised by %k's Skrith Reptile acid."
     FlashThreshold=0
     FlashV=(Y=2000.000000)
     FlashF=0.250000
     bHeaddie=True
	 InvasionDamageScaling=2
     DamageIdent="Shotgun"
     DamageDescription=",Corrosive,Hazard,NonSniper,"
     WeaponClass=Class'BallisticProV55.A500Reptile'
     DeathString="%o was melted into a gooey mess by %k's A500 acid blast."
     FemaleSuicide="%o melted herself with a face full of A500 acid."
     MaleSuicide="%o melted himself with a face full of A500 acid."
     bDelayedDamage=True
}
