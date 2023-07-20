//=============================================================================
//The Missile Barrage damage type for the KH MarkII Cobra.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class KHMKIIDamTypeBarrage extends BE_DT_Manager
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
     DeathStrings(0)="%o couldn't stop dancing in %k's Missile rain."
     DeathStrings(1)="%o got caught in %k's fire rain."
     DeathStrings(2)="%k's TOW Missiles helped %o loosen up."
     DeathStrings(3)="%o couldn't get out of %k's firestorm."
     FemaleSuicides(0)="%o couldn't get enough of her own Missile rain."
     FemaleSuicides(1)="%o's fire barrage button got stuck, or so she says."
     FemaleSuicides(2)="%o defied the laws of physics and caught her own Missiles."
     FemaleSuicides(3)="%o proved why children shouldn't play with loaded Cobras."
     MaleSuicides(0)="%o couldn't get enough of his own Missile rain."
     MaleSuicides(1)="%o's fire barrage button got stuck, or so he says."
     MaleSuicides(2)="%o defied the laws of physics and caught his own Missiles."
     MaleSuicides(3)="%o proved why children shouldn't play with loaded Cobras."
     WeaponClass=Class'XWeapons.RocketLauncher'
     bDelayedDamage=True
     bThrowRagdoll=True
     bFlaming=True
     GibPerterbation=0.150000
     KDamageImpulse=20000.000000
     VehicleMomentumScaling=1.300000
}
