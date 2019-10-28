//=============================================================================
// DT_X82.
//
// DamageType for the M30A2 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_X82Torso extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k tore up %o with a .50 BMG sniper round."
     DeathStrings(1)="%o lost %vh life to %k's X-83 A1."
     DeathStrings(2)="%o was shattered by %k's .50 Cal sniper."
     AimedString="Scoped"
     bIgniteFires=True
     bSnipingDamage=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     bDisplaceAim=True
     AimDisplacementDuration=0.500000
     WeaponClass=Class'BWBPRecolorsPro.X82Rifle'
     DeathString="%k ripped up %o with a .50 BMG sniper round."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibPerterbation=0.100000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=1.000000
}
