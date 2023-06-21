class A800SkrithMinigunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A73NewProjectile'
		SpawnOffset=(X=1.000000,Y=5.000000,Z=-5.000000)
		Speed=5500.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=45
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=SoundGroup'BWBP_SWC_Sounds.A800.A800-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=100.000000
		Chaos=0.100000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.075000
		FireLoopAnim="FireLoop"
		FireEndAnim="FireEnd"
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A800StickyBombProjectile'
		SpawnOffset=(X=400.000000,Y=7.000000,Z=-9.000000)
		Speed=1000.000000
		MaxSpeed=2000.000000
		AccelSpeed=8000.000000
		Damage=75
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SWC_Sounds.A800.A800-AltFire2',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=650.000000
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.850000
		AmmoPerFire=15
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=1
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineTime=1
		DeclineDelay=0.130000
		MaxRecoil=10240
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=3
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ViewBindFactor=0.2
		ADSMultiplier=1
		AimAdjustTime=0.7
		SprintOffset=(Pitch=-5000,Yaw=-2000)
		AimSpread=(Min=768,Max=3072)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.600000
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		LayoutName="Default"
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		SightingTime=0.600000
        MagAmmo=90
        InventorySize=10
        SightMoveSpeedFactor=0.35
		DisplaceDurationMult=1.5
		ZoomType=ZT_Logarithmic
		SightOffset=(X=-15.000000,Y=-25.000000,Z=6.500000)
		SightPivot=(Roll=-1900)
		ViewOffset=(X=30.000000,Y=20.000000,Z=-16.000000)
		ViewPivot=(Roll=-256)
		ReloadAnimRate=1.300000
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
}