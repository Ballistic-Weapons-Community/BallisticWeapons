class DTProtonShield extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o fried on %k's proton shield."
     DeathStrings(1)="%k's E90-N shield reflected %o into oblivion."
     DeathStrings(2)="%o couldn't penetrate %k's particle shield."
     SimpleKillString="E90-N Proton Shield"
     BloodManagerName="BallisticProV55.BloodMan_NovaLightning"
     FlashThreshold=0
     FlashV=(Z=350.000000)
     FlashF=0.700000
     ShieldDamage=15
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Electro,"
     WeaponClass=Class'BWBP_OP_Pro.ProtonStreamer'
     DeathString="%o fried on %k's proton shield."
     FemaleSuicide="%o shielded herself to death."
     MaleSuicide="%o shielded himself to death."
     bInstantHit=True
     bLocationalHit=False
     bCauseConvulsions=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
}
