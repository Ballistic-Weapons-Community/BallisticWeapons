class MDKWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
		RangeAtten=0.2
		Damage=20
		HeadMult=2.25f
        LimbMult=0.75f
		DamageType=Class'BWBP_SWC_Pro.DTMDKSMG'
		DamageTypeHead=Class'BWBP_SWC_Pro.DTMDKSMGHead'
		DamageTypeArm=Class'BWBP_SWC_Pro.DTMDKSMG'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SWC_Pro.MDKFlashEmitter'
		Recoil=72.000000
		Chaos=0.025000
		FireSound=(Sound=SoundGroup'BWBP_SWC_Sounds.MDK.MDK-Fire',Volume=1.000000,Radius=384.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		DeclineDelay=0.15
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=7500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.25
		SightPivot=(Pitch=16)
		SightOffset=(X=10.000000,Y=-0.050000,Z=41.000000)
		ViewOffset=(X=25.000000,Y=11.000000,Z=-33.000000)
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.000000
		MagAmmo=35
		SightingTime=0.250000
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}