class SX45WeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// FIRE PARAMS WEAPON MODE 0 - STANDARD
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaStandardPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=32
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45FlashEmitter'
		FlashScaleFactor=0.9
		FireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.SX45.SX45-Fire',Volume=1.700000)
		Recoil=192.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ArenaStandardPrimaryFireParams
		FireInterval=0.20000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ArenaStandardPrimaryEffectParams'
	End Object
		
	//=================================================================
	// FIRE PARAMS WEAPON MODE 1 - CRYOGENIC
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaCryoPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=28
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_Cryo'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45CryoFlash'
		FlashScaleFactor=0.06
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-FrostFire',Volume=1.200000)
		Recoil=512.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ArenaCryoPrimaryFireParams
		FireInterval=0.240000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ArenaCryoPrimaryEffectParams'
	End Object
	
//=================================================================
	// FIRE PARAMS WEAPON MODE 2 - RADIATION
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaRadPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=22
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_RAD'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45RadMuzzleFlash'
		FlashScaleFactor=2.5
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-RadFire',Volume=1.200000)
		Recoil=128.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ArenaRadPrimaryFireParams
		FireInterval=0.500000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ArenaRadPrimaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.500000
		DeclineDelay=0.250000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=0.33
		PlayerSpeedFactor=1.05
		SightingTime=0.200000
		MagAmmo=9
        InventorySize=3
		ViewOffset=(X=0.000000,Y=7.000000,Z=-12.000000)
		SightOffset=(y=-3.140000,Z=14.300000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardPrimaryFireParams'
		FireParams(1)=FireParams'ArenaCryoPrimaryFireParams'
		FireParams(2)=FireParams'ArenaRadPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}