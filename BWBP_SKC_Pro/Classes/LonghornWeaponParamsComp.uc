class LonghornWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		SpawnOffset=(X=20,Y=4,Z=-6)
		FlashScaleFactor=1.500000
		Recoil=2048.000000
		PushbackForce=300.000000
		Chaos=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-Fire',Volume=1.500000)
		BotRefireRate=0.500000
     	WarnTargetPct=0.300000
		ProjectileClass=Class'BWBP_SKC_Pro.LonghornGrenade'
     	Speed=6000.000000
     	MaxSpeed=6000.000000
		Damage=100.000000
     	DamageRadius=450.000000
		MomentumTransfer=100000.000000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.400000
		bCockAfterFire=True
		FireAnimRate=1.5
		AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		Recoil=2048.000000
		SpawnOffset=(X=20,Y=4,Z=-6)
     	PushbackForce=800.000000
     	Chaos=1.000000
		Inaccuracy=(X=256,Y=256)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.7
     	WarnTargetPct=0.3
		ProjectileClass=Class'BWBP_SKC_Pro.LonghornMicroClusterAlt'
     	Speed=7500.000000
    	MaxSpeed=7500.000000
    	Damage=25.000000
    	DamageRadius=256.000000
   	  	MomentumTransfer=25000.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-FireAlt',Volume=1.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.800000
		bCockAfterFire=True
		FireAnimRate=2.00000
		AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=0.35
		YRandFactor=0.200000
		MinRandFactor=0.2
		ClimbTime=0.08
		DeclineDelay=0.25
		CrouchMultiplier=0.85
		HipMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpChaos=0.200000
		FallingChaos=0.200000
		SprintChaos=0.200000
		AimAdjustTime=0.900000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.25
		PlayerJumpFactor=1
		InventorySize=5
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000		
		SightPivot=(Pitch=150)
		DisplaceDurationMult=1
		MagAmmo=4
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}