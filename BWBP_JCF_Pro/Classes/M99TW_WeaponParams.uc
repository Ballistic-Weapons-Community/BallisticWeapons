class M99TW_WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=135
		DamageType=Class'BWBP_JCF_Pro.DTM99Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM99RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM99Rifle'
		PenetrateForce=50050
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99FireNew',Volume=10.00000)
		Recoil=100
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
		Inaccuracy=(X=0,Y=0)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=2.000000
		FireAnim="Fire"	
		FireAnimRate=1.20000
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.000000
		DeclineDelay=1.2
		HipMultiplier=3
		CrouchMultiplier=0.95
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=0,Max=0)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
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
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.010000		
		DisplaceDurationMult=1.25
		MagAmmo=1
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.880000
		SightOffset=(X=-10.000000,Y=-2.000000,Z=12.000000)
		SightPivot=(Roll=-1024)
		ZoomType=ZT_Smooth
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}