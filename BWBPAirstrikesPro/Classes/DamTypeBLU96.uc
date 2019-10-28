class DamTypeBLU96 extends DT_BWExplode
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitFlame';
    HitEffects[1] = class'HitFlameBig';
}

defaultproperties
{
     SimpleKillString="BLU-96 Fuel-Air Bomb'"
     InvasionDamageScaling=15.000000
     WeaponClass=Class'BWBPAirstrikesPro.TargetDesignator'
     DeathString="%o was obliterated by %k's fuel air bomb. "
     FemaleSuicide="%o was pulverized by her fuel air bomb."
     MaleSuicide="%o was pulverized by his fuel air bomb."
     bSuperWeapon=True
     KDamageImpulse=40000.000000
     VehicleDamageScaling=15.000000
}
