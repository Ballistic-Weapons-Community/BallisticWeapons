//=============================================================================
// DT_FG50Limb
//
// DamageType for FG50 Limb Hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FG50Limb extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's FG50 round took %o's leg with it."
     DeathStrings(1)="%o's arm stumps were a gift from %k's FG50."
     DeathStrings(2)="%k blew off %o arm with an FG50."
     DeathStrings(3)="%k's FG50 ensured %o would never walk again."
     bIgniteFires=True
     DamageIdent="Machinegun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.FG50MachineGun'
     DeathString="%k's FG50 round took %o's leg with it."
     FemaleSuicide="%o did some self amputation with an FG50."
     MaleSuicide="%o did some self amputation with an FG50."
     bFastInstantHit=True
     GibModifier=1.500000
     GibPerterbation=0.200000
     KDamageImpulse=3500.000000
     VehicleDamageScaling=0.500000
}
