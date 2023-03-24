class VSKWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE - Heavy
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectHeavyParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		Damage=50
		DamageType=Class'BWBP_SKC_Pro.DT_VSKTranq'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_VSKTranqHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_VSKTranq'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.600000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.VSK.VSK-SuperShot',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=128.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireHeavyParams
		FireInterval=0.400000
		FireAnim="FireHeavy"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectHeavyParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Standard
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectStandardParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		Damage=35
		DamageType=Class'BWBP_SKC_Pro.DT_VSKTranq'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_VSKTranqHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_VSKTranq'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.VSK.VSK-Shot',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=88.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireStandardParams
		FireInterval=0.150000
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectStandardParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.10000
		YRandFactor=0.20000
		DeclineDelay=0.25
		DeclineTime=0.65
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.2
		AimSpread=(Min=24,Max=1024)
		SprintOffset=(Pitch=-4000,Yaw=-6000)
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=15000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.6
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=15
		SightOffset=(X=-20.000000,Y=-1.250000,Z=31.000000)
		ViewOffset=(X=10.000000,Y=15.000000,Z=-27.000000)
		ZoomType=ZT_Fixed
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireHeavyParams'
		FireParams(1)=FireParams'ArenaPrimaryFireStandardParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}