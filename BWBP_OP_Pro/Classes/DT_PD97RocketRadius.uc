//=============================================================================
// DT_MRLRadius.
//
// DamageType for the PD97 Bloodhound radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_PD97RocketRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's LS-14 rocket turned %o into a crawler."
     DeathStrings(1)="%k blew off %o's toes with a wild rocket."
     DeathStrings(2)="%k's rocket ignited %o's brains."
     SimpleKillString="PD97 Rocket"
     DamageIdent="Sniper"
	 InvasionDamageScaling=2
     WeaponClass=Class'BWBP_OP_Pro.PD97Bloodhound'
     DeathString="%k made %o crawl for %vh life by the PD97."
     FemaleSuicide="%o blew herself up with an PD97 rocket."
     MaleSuicide="%o blew himself up with an PD97 rocket."
     bDelayedDamage=True
     bExtraMomentumZ=True
}
