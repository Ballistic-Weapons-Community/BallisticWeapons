//=============================================================================
// DTGRS9Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGRS9Tazer extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was tazed instead of shot by %k."
     DeathStrings(1)="%k stuck a tazer into %o's eye."
     DeathStrings(2)="%o was tazed instead of shot by %k."
     DeathStrings(3)="%k stuck a tazer into %o's eye."
     DeathStrings(4)="%k extracted %o's eyes!!"
     FlashThreshold=0
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     FlashF=-0.250000
     bCanBeBlocked=True
     ShieldDamage=15
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 InvasionDamageScaling=3
     AimDisplacementDuration=1.00
     DamageDescription=",Blunt,Electro"
     ImpactManager=Class'BallisticProV55.IM_MRS138TazerHit'
     WeaponClass=Class'BallisticProV55.GRS9Pistol'
     DeathString="%o was tazed instead of shot by %k."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
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
