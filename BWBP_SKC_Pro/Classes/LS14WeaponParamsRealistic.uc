class LS14WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Long Barrel
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=40
		HeadMult=2.714285
		LimbMult=0.628571
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=1.000000)
		Recoil=25.000000
		Chaos=-1.00
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Carbine
	Begin Object Class=InstantEffectParams Name=RealisticCarbinePrimaryEffectParams
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=30
		HeadMult=2.714285
		LimbMult=0.628571
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
		Recoil=75.000000
		Chaos=0.1
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticCarbinePrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticCarbinePrimaryEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
		
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LS14Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7500.000000
		MaxSpeed=10000.000000
		AccelSpeed=2000.000000
		Damage=100.000000
		DamageRadius=350.000000
		MomentumTransfer=20000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=2.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
		Recoil=256.000000
		Chaos=5.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.020000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="RLFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=-0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.200000
		XRandFactor=0.185000
		YRandFactor=0.185000
		MaxRecoil=4000
		DeclineTime=0.900000
		DeclineDelay=0.180000;
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=32,Max=1936)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.700000
		ChaosSpeedThreshold=550.000000
	End Object
	
	Begin Object Class=AimParams Name=RealisticCarbineAimParams
		AimSpread=(Min=10,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.800000
		ViewBindFactor=0.250000
		SprintChaos=1.000000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.350000
		ChaosDeclineTime=1.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=21,Scale=1f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=22,Scale=0f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=23,Scale=1f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=24,Scale=0f)
		WeaponBoneScales(4)=(BoneName="Stock",Slot=25,Scale=1f)
		WeaponBoneScales(5)=(BoneName="ShortStock",Slot=26,Scale=0f)
		PlayerSpeedFactor=1.100000
		PlayerJumpFactor=1.100000
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		SightingTime=0.3
		MagAmmo=20
		//ViewOffset=(X=-4.000000,Y=10.000000,Z=-16.000000)
		//ViewOffset=(X=-8.000000,Y=9.000000,Z=-16.000000)
		//SightOffset=(X=18.000000,Y=-8.500000,Z=22.000000)
		SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Logarithmic
		WeaponModes(0)=(ModeName="Single Barrel",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponName="LS14 Directed Energy Weapon"
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
		Begin Object Class=WeaponParams Name=RealisticCarbineParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=21,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=22,Scale=1f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=23,Scale=0f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=24,Scale=1f)
		WeaponBoneScales(4)=(BoneName="Stock",Slot=25,Scale=0f)
		WeaponBoneScales(5)=(BoneName="ShortStock",Slot=26,Scale=1f)
		PlayerSpeedFactor=1.100000
		PlayerJumpFactor=1.100000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=20
		//SightOffset=(X=18.000000,Y=-8.500000,Z=22.000000)
		SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Logarithmic
		WeaponModes(0)=(ModeName="Single Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponName="LS10 Laser Carbine"
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticCarbineAimParams'
		FireParams(0)=FireParams'RealisticCarbinePrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticCarbineParams'


}