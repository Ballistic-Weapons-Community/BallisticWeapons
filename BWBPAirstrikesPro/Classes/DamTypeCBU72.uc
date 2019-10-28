class DamTypeCBU72 extends DT_BWExplode
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitFlame';
    HitEffects[1] = class'HitFlameBig';
}

defaultproperties
{
     SimpleKillString="CBU-72 Cluster Bomb"
     WeaponClass=Class'BWBPAirstrikesPro.TargetDesignator'
     DeathString="%o was pulverized by %k's multiple fuel-air explosive shockwaves."
     FemaleSuicide="%o didn't get out of the way of her fuel-air explosives fast enough."
     MaleSuicide="%o didn't get out of the way of his fuel-air explosives fast enough."
     bSuperWeapon=True
     KDamageImpulse=40000.000000
     VehicleDamageScaling=2.000000
}
