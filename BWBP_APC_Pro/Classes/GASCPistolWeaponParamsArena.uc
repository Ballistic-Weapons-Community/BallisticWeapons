class GASCPistolWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
			TraceRange=(Min=4000.000000,Max=4000.000000)
			RangeAtten=0.200000
			Damage=26
			DamageType=Class'BWBP_APC_Pro.DTGASCPistol'
			DamageTypeHead=Class'BWBP_APC_Pro.DTGASCPistolHead'
			DamageTypeArm=Class'BWBP_APC_Pro.DTGASCPistol'
			PenetrateForce=150
			bPenetrate=True
			MuzzleFlashClass=Class'BWBP_APC_Pro.GASCFlashEmitter'
			FlashScaleFactor=0.10000
			Recoil=64.000000
			Chaos=0.100000
			BotRefireRate=0.900000
			WarnTargetPct=0.300000
			FireSound=(Sound=Sound'BWBP_CC_Sounds.GASC.GASC-Fire',Volume=0.800000)
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryFireParams
			FireInterval=0.095000
			FireEndAnim=
			AimedFireAnim="SightFire"
			FireAnimRate=1.450000	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.05),(InVal=0.400000,OutVal=0.10000),(InVal=0.5500000,OutVal=0.120000),(InVal=0.800000,OutVal=0.15000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.400000,OutVal=0.420000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15000
		YRandFactor=0.3000
		MaxRecoil=4096
		DeclineTime=0.5
		DeclineDelay=0.35000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=None
		AimSpread=(Min=16,Max=512)
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=7500.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=3
		SightMoveSpeedFactor=0.9
		SightingTime=0.150000
		DisplaceDurationMult=1
		MagAmmo=16
		ViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
		SightOffset=(X=-5.000000,Y=-6.350000,Z=9.700000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}