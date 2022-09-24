//=============================================================================
// DTA73SkrithHead.
//
// Damage type for A73 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA73SkrithHead extends DT_BWMiscDamage;

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	//PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
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
     DeathStrings(0)="%k seared %o's head off with A73 bolts."
     DeathStrings(1)="%k's Skrith bolts lanced through %o's face."
     DeathStrings(2)="%o's head was fried by %k's searing blue death."
     DeathStrings(3)="%o chowed down on %k's energy blast."
     DeathStrings(4)="%k's A73 bolt rendered %o's head a fading memory."
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BallisticProV55.A73SkrithRifle'
     DeathString="%k's Skrith bolts lanced through %o's face."
     FemaleSuicide="%o's A73 turned on her."
     MaleSuicide="%o's A73 turned on him."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
	 InvasionDamageScaling=1.5
}
