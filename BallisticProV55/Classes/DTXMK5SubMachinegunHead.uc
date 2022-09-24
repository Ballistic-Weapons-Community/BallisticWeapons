//=============================================================================
// DTXMK5SubMachinegunHead.
//
// DamageType for XMK5 headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMK5SubMachinegunHead extends DT_BWBullet;

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
     DeathStrings(0)="%o had %vh head hollowed out by %k's XMk5."
     DeathStrings(1)="%k drilled various XMk5 SMG rounds into %o's head."
     DeathStrings(2)="%k eventually split %o's thick skull with %kh SMG."
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BallisticProV55.XMK5SubMachinegun'
     DeathString="%o had %vh head hollowed out by %k's XMk5."
     FemaleSuicide="%o annihilated her head with an XMk5."
     MaleSuicide="%o annihilated his head with an XMk5."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.150000
}
