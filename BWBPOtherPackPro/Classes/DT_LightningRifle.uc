//=============================================================================
// DTR78Rifle.
//
// Damage type for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LightningRifle extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o's body was fried by %k's lightning rifle."
     DeathStrings(1)="%k's lightning bolt cooked %o's carcass to a perfect temperature in an instant."
     DeathStrings(2)="%o felt the full force of a lightning strike from %k's lightning bolt."
     AimedString="Scoped"
     bSnipingDamage=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     WeaponClass=Class'BWBPOtherPackPro.LightningRifle'
     DeathString="%o was silenced by %k's R78."
     FemaleSuicide="%o held her lightning rifle the wrong way around."
     MaleSuicide="%o held his lightning rifle the wrong way around."
	 DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.500000
     VehicleDamageScaling=0.150000
     VehicleMomentumScaling=0.300000
}
