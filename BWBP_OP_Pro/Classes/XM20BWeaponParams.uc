class XM20BWeaponParams extends BallisticWeaponParams;

defaultproperties
{ 
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=5000.000000,Max=7500.000000)
		RangeAtten=0.900000
		Damage=16
		DamageType=Class'BWBP_OP_Pro.DT_XM20B_Body'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_XM20B_Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_XM20B_Body'
		PenetrateForce=600
		MuzzleFlashClass=Class'BWBP_OP_Pro.XM20BFlashEmitter'
		FlashScaleFactor=0.300000
		Recoil=96.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.150000
		AmmoPerFire=2
		FireEndAnim=None	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaQuickChargeEffectParams
		RangeAtten=0.350000
		Damage=16
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_OP_Pro.DT_XM20B_Body'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_XM20B_Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_XM20B_Body'
		PenetrateForce=300
		bPenetrate=True
		FlashScaleFactor=0.300000
		Recoil=32
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XM20B.XM20-LaserStart',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaQuickChargeFireParams
		FireInterval=0.070000
		PreFireTime=0.100000
		PreFireAnim="LoopStart"
		FireLoopAnim="LoopFire"
		FireEndAnim="LoopEnd"	
		FireEffectParams(0)=InstantEffectParams'ArenaQuickChargeEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ArenaOverChargeEffectParams
		RangeAtten=0.350000
		Damage=20
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_OP_Pro.DT_XM20B_Body'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_XM20B_Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_XM20B_Body'
		PenetrateForce=300
		bPenetrate=True
		FlashScaleFactor=0.500000
		Recoil=32
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XM20B.XM20-LaserStart',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaOverChargeFireParams
		FireInterval=0.045000
		PreFireTime=0.100000
	    PreFireAnim="LoopOpenStart"
	    FireLoopAnim="LoopOpenFire"
	    FireEndAnim="LoopOpenEnd"
		FireEffectParams(0)=InstantEffectParams'ArenaOverChargeEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.150000,OutVal=0.020000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.11),(InVal=0.400000,OutVal=0.130000),(InVal=0.600000,OutVal=0.20000),(InVal=0.800000,OutVal=0.25000),(InVal=1.000000,OutVal=0.30000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.500000,OutVal=0.600000),(InVal=0.600000,OutVal=0.670000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.8
		DeclineDelay=0.2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=192)
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.5
		ChaosDeclineDelay=0.3
		ChaosSpeedThreshold=2500
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.40000
		DisplaceDurationMult=1
		MagAmmo=50
        ZoomType=ZT_Smooth
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaQuickChargeFireParams'
		AltFireParams(1)=FireParams'ArenaOverChargeFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}