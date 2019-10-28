class DamTypeBLU82 extends DT_BWExplode
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitFlame';
    HitEffects[1] = class'HitFlameBig';
}

defaultproperties
{
     SimpleKillString="BLU-82 'Daisy Cutter'"
     InvasionDamageScaling=15.000000
     WeaponClass=Class'BWBPAirstrikesPro.TargetDesignator'
     DeathString="%o didn't notice %k's BLU82 drifting towards him. "
     FemaleSuicide="%o forgot to get out of the way of her BLU82."
     MaleSuicide="%o forgot to get out of the way of his BLU82."
     bSuperWeapon=True
     KDamageImpulse=40000.000000
     VehicleDamageScaling=15.000000
}
