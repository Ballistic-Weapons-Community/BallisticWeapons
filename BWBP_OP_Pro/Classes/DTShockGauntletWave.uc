//=============================================================================
// DTMRS138Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTShockGauntletWave extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k gave %o shock therapy with his fists of retribution."
     DeathStrings(1)="%k administered a healthy dose of ass-whuppin' to %o."
     DeathStrings(2)="%k prescribed a dose of electro-gauntlet fury for %o."
     DeathStrings(3)="%k operated %o's face off with %vh fists of vengeance."
     DeathStrings(4)="%k surgically removed %o's life with the Combat Defibrillator!"
     FlashThreshold=45
     FlashV=(X=400.000000,Y=400.000000,Z=1000.000000)
     FlashF=0.100000
     bCanBeBlocked=True
     ShieldDamage=15
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=25
     AimDisplacementDuration=0.500000
     DamageDescription=",Blunt,Electro"
     ImpactManager=Class'BallisticProV55.IM_MRS138TazerHit'
     WeaponClass=Class'BWBP_OP_Pro.DefibFists'
     DeathString="%k administered a healthy dose of ass-whuppin' to %o."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
     bArmorStops=False
     bInstantHit=True
     bCauseConvulsions=True
     bNeverSevers=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroFlesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     VehicleDamageScaling=0.100000
     VehicleMomentumScaling=0.050000
}
