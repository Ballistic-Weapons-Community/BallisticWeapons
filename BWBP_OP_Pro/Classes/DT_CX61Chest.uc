//=============================================================================
// CX61 Body DamageType
//=============================================================================
class DT_CX61Chest extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was sent to the grave by %k's Spectre."
     DeathStrings(1)="%o was spooked by %k's CX61."
     DeathStrings(2)="%k's Spectre ushered %o into the afterlife."
     DeathStrings(3)="%k's CX61 cast %o's soul to the ethereal winds."
     DeathStrings(4)="%o was disembodied by %k's CX61."
     DeathStrings(5)="%k's Spectre banished %o from the land of the living."
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_OP_Pro.CX61AssaultRifle'
     DeathString="%o was disembodied by %k's CX61."
     FemaleSuicide="%o scared herself to death."
     MaleSuicide="%o scared himself to death."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
