class ZX98WeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
			TraceRange=(Min=8000.000000,Max=12000.000000)
			RangeAtten=0.350000
			Damage=22
			DamageType=Class'BWBP_APC_Pro.DTZX98Rifle'
			DamageTypeHead=Class'BWBP_APC_Pro.DTZX98RifleHead'
			DamageTypeArm=Class'BWBP_APC_Pro.DTZX98Rifle'
			PenetrateForce=180
			bPenetrate=True
			MuzzleFlashClass=Class'BWBP_APC_Pro.ZX98FlashEmitter'
			FlashScaleFactor=0.500000
			Recoil=180.000000
			Chaos=0.032000
			WarnTargetPct=0.200000
			FireSound=(Sound=Sound'BWBP_CC_Sounds.ZX98.ZX98-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryFireParams
			FireInterval=0.5500000
			PreFireAnim=
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
			TraceRange=(Min=15000.000000,Max=20000.000000)
			RangeAtten=0.350000
			Damage=80
			DamageType=Class'BWBP_APC_Pro.DTZX98Gauss'
			DamageTypeHead=Class'BWBP_APC_Pro.DTZX98GaussHead'
			DamageTypeArm=Class'BWBP_APC_Pro.DTZX98Gauss'
			PenetrateForce=512
			bPenetrate=True
			MuzzleFlashClass=Class'BWBP_APC_Pro.ZX98SFlashEmitter'
			FlashScaleFactor=0.500000
			Recoil=180.000000
			Chaos=0.032000
			WarnTargetPct=0.200000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-QFire',Volume=1.500000)
		End Object

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=1.000000
			AmmoPerFire=4
			PreFireAnim=
			FireAnim="ChargedFire"
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.1,OutVal=0.09),(InVal=0.2,OutVal=0.12),(InVal=0.25,OutVal=0.13),(InVal=0.3,OutVal=0.11),(InVal=0.35,OutVal=0.08),(InVal=0.40000,OutVal=0.050000),(InVal=0.50000,OutVal=-0.020000),(InVal=0.600000,OutVal=-0.040000),(InVal=0.700000,OutVal=0.04),(InVal=0.800000,OutVal=0.070000),(InVal=1.000000,OutVal=0.13)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.2600000),(InVal=0.400000,OutVal=0.4000),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.15000
		YRandFactor=0.15000
		DeclineTime=0.160000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=768)
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=0.50000
		ChaosSpeedThreshold=7000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.400000
		ZoomType=ZT_Fixed
		SightOffset=(X=-10.000000,Y=-0.500000,Z=12.500000)
		ViewOffset=(X=7.000000,Y=5.000000,Z=-10.500000)
		SightPivot=(Pitch=64)
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=5
		SightMoveSpeedFactor=0.9
		SightingTime=0.450000		
		DisplaceDurationMult=1
		MagAmmo=40
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}