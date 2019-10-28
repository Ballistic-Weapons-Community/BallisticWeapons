class DamTypeW54 extends DT_BWExplode
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitFlame';
    HitEffects[1] = class'HitFlameBig';
}

defaultproperties
{
     SimpleKillString="W54 Nuclear Warhead"
     InvasionDamageScaling=15.000000
     WeaponClass=Class'BWBPAirstrikesPro.TargetDesignator'
     DeathString="%o was wiped off the map by %k's tactical nuke."
     FemaleSuicide="%o didn't duck and cover."
     MaleSuicide="%o didn't duck and cover."
     bSkeletize=True
     bSuperWeapon=True
     KDamageImpulse=40000.000000
     VehicleDamageScaling=15.000000
}
