//=============================================================================
// DTR78RifleHead.
//
// Damage type for the R78 Sniper Rifle headshots
//
// Removed A1 designation, as M16 and M4 death messages rarely list it.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LightningHead extends DT_BWMiscDamage;

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
     DeathStrings(0)="%o's head was fried by %k's lightning rifle."
     DeathStrings(1)="%k's lightning bolt cooked %o's face to a perfect temperature in an instant."
     DeathStrings(2)="%o felt the full force of a lightning strike to the head from %k's lightning bolt."
     AimedString="Scoped"
     bSnipingDamage=True
     bHeaddie=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     WeaponClass=Class'BWBPOtherPackPro.LightningRifle'
     DeathString="%o's head was fried by %k's lightning rifle."
     FemaleSuicide="%o sniped off her own head."
     MaleSuicide="%o sniped off his own head."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
	 DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.300000
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.150000
}
