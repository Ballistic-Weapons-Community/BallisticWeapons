//=============================================================================
// DTLAW.
//
// NUKES. NUKES EVERYWHERE.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLAW extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o wandered into %k's flying mini-nuke."
     DeathStrings(1)="%o unwittingly caught %k's firey mini-nuke."
     DeathStrings(2)="%k launched a mini-nuke at %o, who successfully caught it."
     SimpleKillString="LAW Rocket"
     InvasionDamageScaling=3.000000
     DamageIdent="Killstreak"
     bDisplaceAim=True
     AimDisplacementDuration=1.000000
     WeaponClass=Class'BWBPRecolorsPro.LAWLauncher'
     DeathString="%o was disintegrated by %k's mini-nuke."
     FemaleSuicide="%o ran in front of her own mini-nuke."
     MaleSuicide="%o ran in front of his own mini-nuke."
     bAlwaysGibs=True
     bAlwaysSevers=True
     bDelayedDamage=True
     GibPerterbation=4.000000
     VehicleDamageScaling=7.000000
}
