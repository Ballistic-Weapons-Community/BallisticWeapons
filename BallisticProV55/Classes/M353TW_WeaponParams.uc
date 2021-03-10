class M353TW_WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		RangeAtten=0.35
		Damage=20
		HeadMult=1.5f
		LimbMult=0.8f
		DamageType=Class'BallisticProV55.DTM353MGDeploy'
		DamageTypeHead=Class'BallisticProV55.DTM353MGDeployHead'
		DamageTypeArm=Class'BallisticProV55.DTM353MGDeploy'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=64.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.08000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
	 	HipMultiplier=1.000000
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.03000
		YRandFactor=0.03000
        ViewBindFactor=1.000000
		MaxRecoil=12288.000000
		DeclineTime=0.500000
		DeclineDelay=0.150000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.300000
		AimAdjustTime=0.800000
		AimSpread=(Min=0,Max=0)
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		ViewBindFactor=1.000000
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=3000.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=0.950000
        PlayerJumpFactor=0.950000
        SightMoveSpeedFactor=0.8
		MagAmmo=100
		SightingTime=0.55
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}