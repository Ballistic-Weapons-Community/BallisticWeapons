//=============================================================================
// DT_TrenchGunElectro
// 
// Damage type for Trenchgun single electrics.
//=============================================================================
class DT_TrenchGunElectro extends DT_BWMiscDamage;

defaultproperties

     DeathStrings(0)="%k electrocuted %o with %kh modified trenchgun."
     DeathStrings(1)="%k's skeletized shotgun zapped %o to death."
     DeathStrings(2)="%k's electric shot exorcised a convulsing %o."
     SimpleKillString="Trenchgun Electroshock Shell"
     FlashThreshold=0
     FlashV=(X=128.000000,Y=128.000000,Z=128.000000)
     DisplacementType=DSP_Scaling
     AimDisplacementDamageThreshold=10
     AimDisplacementDuration=0.10000
     InvasionDamageScaling=2.000000
     bExtraMomentumZ=True
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_OP_Pro.TrenchGun'
     DeathString="%k electrocuted %o with %kh modified trenchgun."
     FemaleSuicide="%o put the fork in the power outlet."
     MaleSuicide="%o put the spoon in the power outlet."
	 DamageDescription=",Shell,Electro,"
     bCauseConvulsions=True
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BWBP_SKC_Sounds.Misc.XM84-StunEffect'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleDamageScaling=1.250000
}
