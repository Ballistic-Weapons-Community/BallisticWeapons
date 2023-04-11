class LAWWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LAWRocketHvy'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=1400.000000
		MaxSpeed=30000.000000
		AccelSpeed=60000.000000
		Damage=400.000000
		DamageRadius=1800.000000
		MomentumTransfer=300000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		RadiusFallOffType=RFO_Linear
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-FireLoud',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1500.000000
		Chaos=-1.0
		Inaccuracy=(X=256,Y=256)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.950000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LAWGrenadeHvy'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4500.000000
		HeadMult=2.000000
		LimbMult=0.500000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		RadiusFallOffType=RFO_Linear
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1500.000000
		Chaos=-1.0
		Inaccuracy=(X=256,Y=256)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.600000
		BurstFireRateFactor=1.00	
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
		MaxRecoil=1500.000000
		ADSViewBindFactor=1.000000
		DeclineTime=1.000000
		DeclineDelay=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.400000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=1300,Max=2960)
		AimAdjustTime=0.750000
		OffsetAdjustTime=0.650000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.500000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=380.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.700000
		InventorySize=30
		SightMoveSpeedFactor=0.500000
		SightingTime=0.750000
		MagAmmo=1
		//SightOffset=(Y=6.000000,Z=15.000000)
		ZoomType=ZT_Logarithmic
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="FGM-70 "Shockwave" 152mm Anti-Tank Weapon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=LAW_Green
		Index=0
		CamoName="OD Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_Tan
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainTan",Index=2,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainBlack",Index=2,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_RedTiger
		Index=3
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainRedTiger",Index=2,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainGold",Index=2,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'LAW_Green'
	Camos(1)=WeaponCamo'LAW_Tan'
	Camos(2)=WeaponCamo'LAW_Black'
	Camos(3)=WeaponCamo'LAW_RedTiger'
	Camos(4)=WeaponCamo'LAW_Gold'
}