//=============================================================================
// DT_MRL.
//
// DamageType for the JL-21 PeaceMaker
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MRL extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k bombarded a terrified %o with an enfilade of PeaceMaker missiles."
     DeathStrings(1)="%k's JL-21 PeaceMaker barrage plagued %o to death."
     DeathStrings(2)="%o absorbed %k's JL-21 barrage."
     DeathStrings(3)="%k's drunken PeaceMaker misslies surged into %o's head."
     DamageIdent="Streak"
     WeaponClass=Class'BallisticProV55.MRocketLauncher'
     DeathString="%k bombarded a terrified %o with an enfilade of PeaceMaker missiles."
     FemaleSuicide="%o cracked herself open with her own JL-21 rockets."
     MaleSuicide="%o cracked himself open with his own JL-21 rockets."
     bDelayedDamage=True
}
