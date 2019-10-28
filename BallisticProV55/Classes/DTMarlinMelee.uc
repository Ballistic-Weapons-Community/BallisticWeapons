//=============================================================================
// DTMarlinMelee.
//
// Damagetype for Deermaster! Melee attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMarlinMelee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k smashed %o's chest with the back of %kh Deermaster."
     DeathStrings(1)="%o crumpled and fell before %k's Redwood rifle."
     DeathStrings(2)="%k's Deermaster stock pulverised the life out of %o."
     DamageIdent="Melee"
     bDisplaceAim=True
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=1.700000
     WeaponClass=Class'BallisticProV55.MarlinRifle'
     DeathString="%k smashed %o's chest with the back of %kh Deermaster."
     FemaleSuicide="%o bashed herself with a Deermaster."
     MaleSuicide="%o bashed himself with a Deermaster."
}
