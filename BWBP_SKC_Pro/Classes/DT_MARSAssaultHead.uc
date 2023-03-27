//=============================================================================
// DT_MASRAssaultHead.
//
// DamageType for MASR headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSAssaultHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's brain shut down under %k's MARS fire."
     DeathStrings(1)="%k terminated a fleeing %o with a MARS headshot."
     DeathStrings(2)="%k tactically disabled %o with a MARS bullet to the head."
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     DeathString="%o's brain shut down under %k's MARS-2 fire."
     FemaleSuicide="%o HEADSHOT SELF?!"
     MaleSuicide="%o HEADSHOT SELF?!"
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
