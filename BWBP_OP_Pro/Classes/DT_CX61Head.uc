//=============================================================================
// CX61 Head DamageType
//=============================================================================
class DT_CX61Head extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's CX61 round evacuated %o's cranium."
     DeathStrings(1)="%k's Spectre took umbrage to %o's ugly face."
     DeathStrings(2)="%k's CX61 performed long-range cerebral surgery upon %o."
     DamageIdent="Assault"
     bHeaddie=True
     WeaponClass=Class'BWBP_OP_Pro.CX61AssaultRifle'
     DeathString="%o was disembodied by %k's CX61."
     FemaleSuicide="%o scared herself to death."
     MaleSuicide="%o scared himself to death."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
}
