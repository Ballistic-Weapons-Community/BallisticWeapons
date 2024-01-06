class FM13WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2572.000000,Max=2572.000000)
		RangeAtten=0.150000
		TraceCount=7
		TracerClass=Class'BWBP_APC_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=Class'BWBP_APC_Pro.DTFM13Shotgun'
		DamageTypeHead=Class'BWBP_APC_Pro.DTFM13ShotgunHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTFM13Shotgun'
		MuzzleFlashClass=Class'BWBP_APC_Pro.FM13FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
		Recoil=1792.000000
		Chaos=1.000000
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=450,Y=450)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.750000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.000000	
		TargetState="FireFromFireControl"
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object	
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.FM13Grenade'
		Speed=3500.000000
		Damage=30
		DamageRadius=64.000000
		FlashScaleFactor=2.000000
		Recoil=1280.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.750000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.200000
		XRandFactor=0.400000
		YRandFactor=0.200000
		MaxRecoil=1792
		DeclineTime=0.350000
		DeclineDelay=0.250000
		ViewBindFactor=0.700000
		ADSViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.875000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=740,Max=1480)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.875000
		ADSMultiplier=0.875000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		ViewOffset=(X=0.000000,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=27.000000)
		SightPivot=(Pitch=128)
		MagAmmo=5
		bMagPlusOne=True
        SightingTime=0.350000
        InventorySize=6
		WeaponName="FM-13 Dragon's Breath Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}