//=============================================================================
// Unarmed Hydra damagetype
//=============================================================================
class DTHydraUnarmed extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o had several of %vh bones fractured by %k's Unarmed Hydra."
     DeathStrings(1)="%k made sure that %o can never, EVER repopulate by annihiliating %vh groin with unarmed rockets."
     SimpleKillString="Hydra Bazooka Impact"
     HipString="Luck"
     AimedString="Scoped"
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BallisticProV55.G5Bazooka'
     DeathString="%o was knocked into next week by %k's unarmed Hydra."
     FemaleSuicide="%o somehow managed to hit herself with her own Hydra rocket."
     MaleSuicide="%o somehow managed to hit himself with his own Hydra rocket."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleMomentumScaling=0.200000
}
