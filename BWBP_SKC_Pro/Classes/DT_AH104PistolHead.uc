//=============================================================================
// DTAH104PistolHead.
//
// Damage type for the AH104 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AH104PistolHead extends DT_BWBullet;

var() float ArmorDrain;

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local Armor BestArmor;

	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);

	if (Instigator.Controller != None && Pawn(Victim).Controller != Instigator.Controller && Instigator.Controller.SameTeamAs(Pawn(Victim).Controller))
		return; //Yeah no melting teammate armor. that's mean

	// Do additional damage to armor..
	if(Pawn(Victim) != None)
	{
		BestArmor = Pawn(Victim).Inventory.PrioritizeArmor(Damage*Default.ArmorDrain,Default.Class,HitLocation);
		if(BestArmor != None)
		{
			Victim.TakeDamage(Damage*Default.ArmorDrain, Instigator, HitLocation, Momentum, DT);
			BestArmor.ArmorAbsorbDamage(Damage*Default.ArmorDrain,Default.Class,HitLocation);
		}
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
	ArmorDrain=0.200000
	bHeaddie=True
	DeathStrings(0)="%k blew %o's head off with %kh AH104."
	DeathStrings(1)="%k cracked %o's skull with AH104 rounds."
	DeathStrings(2)="%o lost %vh head in a fight with %k's AH104 Pounder."
	WeaponClass=Class'BWBP_SKC_Pro.AH104Pistol'
	DeathString="%k blew %o's head off with %kh AH104."
	FemaleSuicide="%o headshotted herself with the AH104."
	MaleSuicide="%o headshotted himself with the AH104."
//     bArmorStops=False
	bAlwaysSevers=True
	bSpecial=True
	PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'

	TagMultiplier=0.6
	TagDuration=0.2
}
