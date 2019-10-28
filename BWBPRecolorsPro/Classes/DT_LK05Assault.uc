//=============================================================================
// DT_LK05Assault.
//
// DamageType for the LK05 Carbine primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LK05Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's LK05 confirmed a kill on %o."
     DeathStrings(1)="%o was cleanly dropped by %k's LK05."
     DeathStrings(2)="%k engaged and eliminated %o with an LK05."
     DeathStrings(3)="%k removed %o from the battlefield via LK05."
     DamageIdent="Assault"
     WeaponClass=Class'BWBPRecolorsPro.LK05Carbine'
     DeathString="%k's LK05 confirmed a kill on %o."
     FemaleSuicide="%o took the easy way out with an LK05."
     MaleSuicide="%o took the easy way out with an LK05."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
