class M99RifleWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
		HeadMult=2.25f
		LimbMult=0.75f
		DamageType=Class'BWBP_JCF_Pro.DTM99Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM99RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM99Rifle'
		PenetrateForce=50050
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99FireNew',Volume=10.00000)
		Recoil=7000
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=2.000000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.300000
		YRandFactor=0.300000
		DeclineTime=1.000000
		DeclineDelay=1.2
		HipMultiplier=3
		CrouchMultiplier=0.95
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=128,Max=1156)
		SprintOffset=(Pitch=-3000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=-8000)
		ADSMultiplier=0.15
		AimAdjustTime=0.500000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=7
		SightMoveSpeedFactor=0.8
		SightingTime=0.65000		
		DisplaceDurationMult=1.25
		MagAmmo=1
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.800000
		SightOffset=(X=-10.000000,Y=20.000000,Z=36.000000)
		SightPivot=(Roll=-1024)
		ViewOffset=(X=10.000000,Y=-4.000000,Z=-30.000000)
		ZoomType=ZT_Smooth
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}