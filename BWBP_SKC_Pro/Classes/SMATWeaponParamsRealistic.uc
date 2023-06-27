class SMATWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//HEDP
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.SMATRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=20000.000000
		MaxSpeed=20000.000000
		AccelSpeed=1.000000
		Damage=600.000000
		DamageRadius=160.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-FireNewLoud2',Volume=9.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1524.000000
		Chaos=-1.0
		Inaccuracy=(X=5,Y=5)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=False
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//CRYO
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams_Ice
		ProjectileClass=Class'BWBP_SKC_Pro.SMATRocketIce'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=20000.000000
		MaxSpeed=20000.000000
		AccelSpeed=1.000000
		Damage=100.000000
		DamageRadius=1024.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-FireIce',Volume=9.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=-1.0
		Inaccuracy=(X=5,Y=5)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Ice
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=False
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams_Ice'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.SMATGrenade'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=100.000000
		MaxSpeed=100.000000
		AccelSpeed=100.000000
		Damage=600.000000
		DamageRadius=768.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-Jump',Volume=9.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=5,Y=5)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=768.000000
		DeclineTime=0.650000
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
		AimSpread=(Min=900,Max=2560)
		AimAdjustTime=0.550000
		OffsetAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.500000
		ChaosDeclineTime=1.300000
		ChaosSpeedThreshold=475.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.805000
		PlayerJumpFactor=0.850000
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.400000
		ZoomType=ZT_Logarithmic
		MagAmmo=1
		//ViewOffset=(X=9.000000,Y=9.500000,Z=-3.000000)
		//SightOffset=(X=20.000000,Y=15.000000,Z=-10.000000)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="S.M.A.T. 105mm Recoilless Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=SMAT_Green
		Index=0
		CamoName="Olive Drab"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SMAT_Urban
		Index=1
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MainUrban",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MiscUrban",Index=2,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SMAT_Ocean
		Index=2
		CamoName="Ocean"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MainWater",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MiscWater",Index=2,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SMAT_Orange
		Index=3
		CamoName="Orange"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MainOrange",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MiscOrange",Index=2,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'SMAT_Green'
	Camos(1)=WeaponCamo'SMAT_Urban'
	Camos(2)=WeaponCamo'SMAT_Ocean'
	Camos(3)=WeaponCamo'SMAT_Orange'
}