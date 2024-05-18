class FM13WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Dragons Breath
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_Flame
		TraceRange=(Min=2072.000000,Max=2072.000000)
		RangeAtten=0.150000
		TraceCount=7
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FM13ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		MuzzleFlashClass=Class'BWBP_OP_Pro.FM13FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
		Recoil=1024.000000
		Chaos=1.000000
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=900,Y=900)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Flame
		FireInterval=0.750000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.000000	
		TargetState="FireFromFireControl"
	FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_Flame'
	End Object	
	
	//8ga Shot
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.400000
		TraceCount=8
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_BigBullet'
		Damage=45.0
		LimbMult=0.35
		DamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FM13ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=120
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter_C'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-FireStrong',Volume=3.300000)
		Recoil=2048.000000
		Chaos=1.0
		Inaccuracy=(X=1300,Y=1300)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=1.250000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=0.650000	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object	
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.FM13Grenade'
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.750000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.2
		XRandFactor=0.200000
		YRandFactor=0.500000
		MaxRecoil=4096
		DeclineTime=1.400000
		DeclineDelay=0.4
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		ADSMultiplier=0.5
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimSpread=(Min=16,Max=1760)
        ChaosSpeedThreshold=550.000000
		ChaosDeclineTime=0.750000
		ViewBindFactor=0.25
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		ViewOffset=(X=0.000000,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=27.000000)
		SightPivot=(Pitch=128)
		bNeedCock=True
		MagAmmo=6
        SightingTime=0.350000
        InventorySize=6
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Flame'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Pitbull
		LayoutTags="8Gauge"
		Weight=30
		//LayoutMesh=SkeletalMesh'BWBP_OP_Anim.FPm_FM14'
		ViewOffset=(X=0.000000,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=29.000000)
		SightPivot=(Pitch=128)
		bNeedCock=True
		MagAmmo=4
        SightingTime=0.350000
        InventorySize=6
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Pitbull'

}