//=============================================================================
// DTEKS43Katana.
//
// Damagetype for EKS43 Katana
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRiotShield extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bashed %o with his riot shield."
     DeathStrings(1)="%k showed %o the finer points of riot shield defense."
     DeathStrings(2)="%o didn't realise %k's riot shield could be so effective."
     DeathStrings(3)="%k's shield cleared a path through %o."
     DeathStrings(4)="%k's shield slam sent %o flying."
     DamageIdent="Melee"
     bDisplaceAim=True
     WeaponClass=Class'BallisticProV55.RiotShield'
     DeathString="%k demonstrated seppuku on %o."
     FemaleSuicide="%o came back on her shield, not with it."
     MaleSuicide="%o came back on his shield, not with it."
     KDamageImpulse=1000.000000
}
