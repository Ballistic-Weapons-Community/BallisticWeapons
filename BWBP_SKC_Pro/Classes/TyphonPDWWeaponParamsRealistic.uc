class TyphonPDWWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		DecayRange=(Min=1800,Max=3600)
		TraceRange=(Max=6000.000000)
		RangeAtten=0.30000
		Damage=50.000000
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_TyphonPDWHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		Inaccuracy=(X=32,Y=32)
		PenetrationEnergy=16.000000
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.100000
		Recoil=40.000000
		Chaos=-1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Typhon.Typhon-HFire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.165000
		FireAnim="SightFire"
		AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Charged	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParamsCharged
		DamageType=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_TyphonPDWHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		DecayRange=(Min=1800,Max=3600)
		TraceRange=(Max=6000.000000)
		Damage=100.000000
		RangeAtten=0.30000
		Inaccuracy=(X=32,Y=32)
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.050000
		Recoil=140.000000
		Chaos=0.150000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Typhon.Typhon-Blast',Volume=7.800000)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsCharged
		FireInterval=1.500000
		FireAnim="Fire"
		AimedFireAnim="Fire"
		AmmoPerFire=5
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParamsCharged'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.550000,OutVal=0.10000),(InVal=0.800000,OutVal=-0.100000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
        XRandFactor=0.15000
		YRandFactor=0.15000
		DeclineTime=0.9
		DeclineDelay=0.4000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.0500000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.450000
		SprintChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=575.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="Ladder",Slot=52,Scale=0f)
		SightingTime=0.250000
		SightOffset=(X=-4.000000,Y=0.200000,Z=14.800000)
		SightPivot=(Pitch=0)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		DisplaceDurationMult=1
		MagAmmo=25
		WeaponName="LRX-5 'Typhon' Pulse PDW"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParamsCharged'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}