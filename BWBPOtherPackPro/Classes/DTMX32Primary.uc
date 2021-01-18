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
     DeathStrings(0)="%o's rib cage was shattered by %k's MX32."
     DeathStrings(1)="%k opened up several holes in %o's lungs with the MX32."
     DeathStrings(2)="%o got a much needed colon cleansing thanks to %k."
     DeathStrings(3)="%k reduced %o's limbs to beef jerky."
     DamageIdent="Assault"
     WeaponClass=Class'BWBPOtherPackPro.MX32Weapon'
     DeathString="%o's rib cage was shattered by %k's MX32."
     FemaleSuicide="%o nailed herself with the MX32."
     MaleSuicide="%o nailed himself with the MX32."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
