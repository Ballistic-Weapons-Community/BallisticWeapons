class M99RifleWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=125
		HeadMult=1.75
		LimbMult=0.75
		DamageType=Class'BWBP_JCF_Pro.DTM99Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM99RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM99Rifle'
		PenetrationEnergy=128
		PenetrateForce=450
		PushbackForce=255.000000
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99FireNew',Volume=10.00000)
		Recoil=3072.000000
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=2.000000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.1
		XRandFactor=0.300000
		YRandFactor=0.300000
		MinRandFactor=0.45
		MaxRecoil=8192
		ClimbTime=0.15
		DeclineDelay=0.35
		DeclineTime=1.5
		CrouchMultiplier=0.750000
		HipMultiplier=2
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=2560)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.75
		AimAdjustTime=0.800000
		ChaosDeclineTime=1.200000
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=7
		SightMoveSpeedFactor=0.35
		ScopeScale=0.7
		SightingTime=0.65000		
		DisplaceDurationMult=1.4
		MagAmmo=1
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.800000
		SightOffset=(X=-10.000000,Y=20.000000,Z=36.000000)
		SightPivot=(Roll=-1024)
		ViewOffset=(X=10.000000,Y=-4.000000,Z=-30.000000)
		// sniper 5-10x
        ZoomType=ZT_Logarithmic
		MinZoom=4
		MaxZoom=8
		ZoomStages=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
}