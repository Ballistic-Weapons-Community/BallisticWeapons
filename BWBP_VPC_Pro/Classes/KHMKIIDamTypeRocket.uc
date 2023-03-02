//=============================================================================
//The TOW Missile damage type for the KH MarkII Cobra.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================

class KHMKIIDamTypeRocket extends BE_DT_Manager
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'HitFlameBig';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'HitFlame';
}

defaultproperties
{
     DeathStrings(0)="%o got caught in %k's underTOW."
     DeathStrings(1)="%o's limp body got TOWed away by %k."
     DeathStrings(2)="%o with his foot fetish mistook %k's TOW for a toe."
     DeathStrings(3)="%o was splattered like so many spanish tomatos by %k's TOW Missiles."
     FemaleSuicides(0)="%o stuck her ugly face infront of her own TOW Missiles."
     FemaleSuicides(1)="%o was inspecting the integrity of her TOW Missiles with her obscene face."
     FemaleSuicides(2)="%o got carried away with the little red button that launches TOW Missiles."
     FemaleSuicides(3)="%o proved why children shouldn't play with loaded Cobras."
     MaleSuicides(0)="%o stuck his ugly face infront of his own TOW Missiles."
     MaleSuicides(1)="%o was inspecting the integrity of his TOW Missiles with his obscene face."
     MaleSuicides(2)="%o got carried away with the little red button that launches TOW Missiles."
     MaleSuicides(3)="%o proved why children shouldn't play with loaded Cobras."
     WeaponClass=Class'XWeapons.RocketLauncher'
     bDelayedDamage=True
     bThrowRagdoll=True
     bFlaming=True
     GibPerterbation=0.150000
     KDamageImpulse=20000.000000
     VehicleMomentumScaling=1.300000
}
