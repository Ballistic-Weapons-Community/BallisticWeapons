//=============================================================================
// corroded.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class corroded extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k's portable fallout killed %o."
     DeathStrings(1)="%o got radiated by %k's alien axe."
     ShieldDamage=160
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkConcretePole'
     DeathString="%k killed %o with radiation."
     FemaleSuicide="%o killed herself to death with radiation."
     MaleSuicide="%o killed himself to death with radiation."
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
}
