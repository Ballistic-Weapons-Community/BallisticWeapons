//=============================================================================
// DT_FG50Head
//
// Damage type for FG50 headsharts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FG50Head extends DT_BWBullet;

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
     DeathStrings(0)="%k's FG50 sent a huge round through %o's head."
     DeathStrings(1)="%k's FG50 popped %o's head like a little grape."
     DeathStrings(2)="%o lost more than half %vh head to %k's FG50 round."
     DeathStrings(3)="%o's brains were sauteed by %k's FG50 incendiary ammo."
     HipString="Luck"
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Machinegun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.FG50MachineGun'
     DeathString="%k's FG50 sent a huge round through %o's head."
     FemaleSuicide="%o's FG50 took her head off."
     MaleSuicide="%o's FG50 took his head off."
     bFastInstantHit=True
     bAlwaysSevers=True
     GibModifier=1.200000
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
}
