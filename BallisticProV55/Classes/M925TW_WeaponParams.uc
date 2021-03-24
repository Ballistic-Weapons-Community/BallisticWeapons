class M925TW_WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		RangeAtten=0.65
		Damage=60
		HeadMult=1.5f
		LimbMult=0.85f
		DamageType=Class'BallisticProV55.DTM925MGDeploy'
		DamageTypeHead=Class'BallisticProV55.DTM925MGDeployHead'
		DamageTypeArm=Class'BallisticProV55.DTM925MGDeploy'
		PenetrateForce=300
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=250.000000
		Chaos=0.150000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.M925.M925-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.145000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		HipMultiplier=1.000000
		CrouchMultiplier=1.000000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.00000),(InVal=0.500000,OutVal=0.100000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.250000,OutVal=0.230000),(InVal=0.400000,OutVal=0.40000),(InVal=0.550000,OutVal=0.58000),(InVal=0.750000,OutVal=0.720000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.030000
		YRandFactor=0.030000
		MaxRecoil=8192.000000
		DeclineTime=0.750000
		DeclineDelay=0.400000
  	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=0,Max=2)
		ViewBindFactor=1.000000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=850.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.8
		SightingTime=0.700000
		MagAmmo=50
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}