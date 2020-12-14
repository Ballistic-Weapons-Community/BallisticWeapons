//=============================================================================
// DTMRS138Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRS138Tazer extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was electrified by %k's MRS-138."
     DeathStrings(1)="%k zapped %o good with %kh combat shotgun."
     FlashThreshold=0
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     FlashF=-0.250000
     bCanBeBlocked=True
     ShieldDamage=15
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 InvasionDamageScaling=3
     AimDisplacementDuration=0.75
     DamageDescription=",Blunt,Electro"
     ImpactManager=Class'BallisticProV55.IM_MRS138TazerHit'
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     DeathString="%o was electrified by %k's MRS-138."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
     bArmorStops=False
     bInstantHit=True
     bCauseConvulsions=True
     bNeverSevers=True
	 BlockFatiguePenalty=0.3
     bExtraMomentumZ=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroFlesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     VehicleDamageScaling=0.000000
     VehicleMomentumScaling=0.050000
}
