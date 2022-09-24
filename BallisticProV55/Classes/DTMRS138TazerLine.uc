class DTMRS138TazerLine extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o got shocked by %k's MRS-138 tazer."
     DeathStrings(1)="%k defibrillated %o with a MRS-138 tazer."
     DeathStrings(2)="%o got zapped hard by %k's shotgun tazer."
     SimpleKillString="MRS-138 Taser"
     BloodManagerName="BallisticProV55.BloodMan_NovaLightning"
     FlashThreshold=0
     FlashV=(Z=350.000000)
     FlashF=0.700000
     ShieldDamage=15
	 InvasionDamageScaling=4
     bIgniteFires=True
     DamageIdent="Sidearm"
     DamageDescription=",Electro,"
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     DeathString="%o got shocked by %k's MRS-138 tazer."
     FemaleSuicide="%o struck herself."
     MaleSuicide="%o struck himself."
     bInstantHit=True
     bLocationalHit=False
     bCauseConvulsions=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'BallisticEpicEffects.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
}
