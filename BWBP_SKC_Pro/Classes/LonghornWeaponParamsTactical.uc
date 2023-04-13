class LonghornWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		SpawnOffset=(X=20,Y=4,Z=-6)
		Recoil=2048.000000
		PushbackForce=300.000000
		Chaos=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-Fire',Volume=1.500000)
		BotRefireRate=0.5
     	WarnTargetPct=0.300000
		ProjectileClass=Class'BWBP_SKC_Pro.LonghornGrenade'
     	Speed=4200.000000
     	MaxSpeed=4200.000000
		Damage=150
        ImpactDamage=150
     	DamageRadius=450.000000
		MomentumTransfer=100000.000000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.600000
		bCockAfterFire=True
		FireAnimRate=1
		AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams
		Recoil=2048.000000
     	PushbackForce=800.000000
     	Chaos=1.000000
		SpawnOffset=(X=20,Y=4,Z=-6)
		Inaccuracy=(X=256,Y=256)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.7
     	WarnTargetPct=0.3
		ProjectileClass=Class'BWBP_SKC_Pro.LonghornMicroClusterAlt'
     	Speed=5500.000000
    	MaxSpeed=5500.000000
    	Damage=45.000000
        ImpactDamage=45
    	DamageRadius=256.000000
   	  	MomentumTransfer=25000.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-FireAlt',Volume=1.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.200000
		bCockAfterFire=True
		FireAnimRate=1.5
		AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XRandFactor=0.35
		YRandFactor=0.200000
		MinRandFactor=0.2
		ClimbTime=0.08
		DeclineDelay=0.25
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpChaos=0.200000
		FallingChaos=0.200000
		SprintChaos=0.200000
		AimAdjustTime=0.600000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=4
		SightMoveSpeedFactor=0.6
		SightingTime=0.3
		SightPivot=(Pitch=150)
		DisplaceDurationMult=1
		MagAmmo=4
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}