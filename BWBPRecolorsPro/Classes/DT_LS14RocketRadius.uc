//=============================================================================
// DT_MRLRadius.
//
// DamageType for the JL-21 PeaceMaker radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LS14RocketRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's LS-14 rocket turned %o into a crawler."
     DeathStrings(1)="%k blew off %o's toes with a wild rocket."
     DeathStrings(2)="%k's rocket ignited %o's brains."
     SimpleKillString="LS-14 Rocket"
     DamageIdent="Sniper"
	 InvasionDamageScaling=2
     WeaponClass=Class'BWBPRecolorsPro.LS14Carbine'
     DeathString="%k made %o crawl for %vh life by the LS-14."
     FemaleSuicide="%o blew herself up with an LS-14 rocket."
     MaleSuicide="%o blew himself up with an LS-14 rocket."
     bDelayedDamage=True
     bExtraMomentumZ=True
}
