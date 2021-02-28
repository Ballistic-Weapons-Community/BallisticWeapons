//=============================================================================
// DT_AK47Assault.
//
// DamageType for the AK-490 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK47Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was destroyed by the Russian might of %k."
     DeathStrings(1)="%o lost his vodka and life to %k and an AK-490."
     DeathStrings(2)="%k's AK-490 turned %o into a leaky barrel of blood."
     DeathStrings(3)="%o was executed under the order of Czar %k and %kh AK."
     DeathStrings(4)="%o was liberated by Comrade %k's AK-490."
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.AK47AssaultRifle'
     DeathString="%o was destroyed by the Russian might of %k."
     FemaleSuicide="%o shot herself with an Awesome Kelly-490."
     MaleSuicide="%o shot himself with an Awesome Kelly-490."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
