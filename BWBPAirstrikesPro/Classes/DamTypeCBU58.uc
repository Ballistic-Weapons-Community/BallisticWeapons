class DamTypeCBU58 extends DT_BWFire
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitFlame';
    HitEffects[1] = class'HitFlameBig';
    HitEffects[2] = class'HitFlame';
    HitEffects[3] = class'HitFlameBig';
    HitEffects[4] = class'HitFlame';
    HitEffects[5] = class'HitFlameBig';
}

defaultproperties
{
     SimpleKillString="CBU-58 Incendiary Cluster Bomb"
     WeaponClass=Class'BWBPAirstrikesPro.TargetDesignator'
     DeathString="%o was caught in %k's napalm strike."
     FemaleSuicide="%o immolated herself."
     MaleSuicide="%o immolated himself."
     bSuperWeapon=True
     KDamageImpulse=40000.000000
     VehicleDamageScaling=1.500000
}
