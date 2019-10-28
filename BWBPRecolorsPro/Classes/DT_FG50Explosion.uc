//=============================================================================
// DTCyloMk2Rifle.
//
// Damage type for the incendiary Mk2 CYLO.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FG50Explosion extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o took %k's FG50 round straight to the spine."
     DeathStrings(1)="%o couldn't survive %k's firey tempest of FG50 rounds."
     DeathStrings(2)="%k drilled several large holes into %o with %kh FG50."
     DeathStrings(3)="%k's FG50 put some lead into %o's diet."
     SimpleKillString="FG50 Explosive Rounds"
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     InvasionDamageScaling=2.000000
     DamageIdent="Machinegun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.FG50MachineGun'
     DeathString="%o took %k's FG50 round straight to the spine."
     FemaleSuicide="%o trashed herself with her own explosive rounds."
     MaleSuicide="%o trashed himself with his own explosive rounds."
     bFastInstantHit=True
     bAlwaysSevers=True
     bFlaming=True
     GibModifier=1.500000
     GibPerterbation=0.200000
     KDamageImpulse=3500.000000
     VehicleDamageScaling=0.500000
}
