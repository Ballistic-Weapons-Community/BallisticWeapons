class DamTypeCBU100 extends DT_BWExplode
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitFlame';
    HitEffects[1] = class'HitFlameBig';
}

defaultproperties
{
     SimpleKillString="CBU-100 Cluster Bomb"
     WeaponClass=Class'BWBPAirstrikesPro.TargetDesignator'
     DeathString="%o didn't see %k's bomblets from his cluster bomb."
     FemaleSuicide="%o cluster bombed herself."
     MaleSuicide="%o cluster bombed himself."
     KDamageImpulse=40000.000000
     VehicleDamageScaling=2.000000
}
