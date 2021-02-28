//=============================================================================
// DTXM84Hit.
//
// Damage type for the XM84 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXM84Hit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k beaned %o with an XM84, who promptly died."
     DeathStrings(1)="%k bounced a tech grenade off %o's head! Fatality!"
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageIdent="Grenade"
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BWBP_SKC_Pro.XM84Flashbang'
     DeathString="%k beaned %o with an XM84, who promptly died."
     FemaleSuicide="%o tripped on her own XM84."
     MaleSuicide="%o tripped on his own XM84."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
