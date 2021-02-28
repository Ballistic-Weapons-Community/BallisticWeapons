class DT_Mk781Bolt extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k plugged %o into an X-007 bolt."
     DeathStrings(1)="%o's was overstimulated by %k's X-007 bolt."
     DeathStrings(2)="%k happily defibrilated %o with an X-007."
     DeathStrings(3)="%k dropped an electric bolt into %o's bath."
     SimpleKillString="Mk781 Electric Bolt"
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     bIgniteFires=True
     InvasionDamageScaling=2.000000
     DamageIdent="Shotgun"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_SKC_Pro.MK781Shotgun'
     DeathString="%k plugged %o into an X-007 bolt."
     FemaleSuicide="%o brought a capacitor to a wall fight."
     MaleSuicide="%o brought a capacitor to a wall fight."
     bCauseConvulsions=True
     PawnDamageSounds(0)=Sound'BWBP_SKC_Sounds.Misc.XM84-StunEffect'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=1.250000
}
