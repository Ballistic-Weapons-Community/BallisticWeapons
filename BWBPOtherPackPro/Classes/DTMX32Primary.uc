//=============================================================================
// DTM50Assault.
//
// DamageType for the M50 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMX32Primary extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k eliminated %o with the M50."
     DeathStrings(1)="%o was drilled by %k's M50."
     DeathStrings(2)="%k purified %o with M50 rounds."
     DamageIdent="Assault"
     WeaponClass=Class'BWBPOtherPackPro.MX32Weapon'
     DeathString="%k eliminated %o with the M50."
     FemaleSuicide="%o nailed herself with the M50."
     MaleSuicide="%o nailed himself with the M50."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
