class DT_HB4Bolt extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k deadened %o's arms, then their legs, and finally, their heart."
     DeathStrings(1)="%o was stunned long enough for them to be murdered by %k."
     DeathStrings(2)="%k fried %o to a nice, crispy, well done with a stun bolt."
     DeathStrings(3)="%o got blasted to bits by %k's grenade blaster."
     SimpleKillString="HB4 Electric Bolt"
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     bIgniteFires=True
     InvasionDamageScaling=2.000000
     DamageIdent="Shotgun"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_APC_Pro.HB4GrenadeBlaster'
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
