class PumaWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================
	
	//Impact Det
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryImpactEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectileFast'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6500.000000
		Damage=120
        ImpactDamage=120
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryImpactFireParams
		FireInterval=0.900000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryImpactEffectParams'
	End Object

	//Proximity Det
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryProxyEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectile'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4000.000000
		Damage=105
        ImpactDamage=105
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryProxyFireParams
		FireInterval=1.1250000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryProxyEffectParams'
	End Object
	
	//Range Det
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryRangeEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectileRShort'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=8500.000000
		Damage=105
        ImpactDamage=120
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryRangeFireParams
		FireInterval=0.900000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryRangeEffectParams'
	End Object
	
	//Shield Explosion
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryShieldEffectParams
		ProjectileClass=Class'PumaProjectileClose'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6000.000000
		Damage=160.000000
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryShieldFireParams
		FireInterval=1.125000
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryShieldEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		SpreadMode=None
		MuzzleFlashClass=None
		FlashScaleFactor=None
		Recoil=None
		Chaos=None
		PushbackForce=None
		SplashDamage=None
		RecommendSplashDamage=None
		BotRefireRate=0.300000
		WarnTargetPct=None
	End Object
		
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
	FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=4096
		DeclineDelay=0.350000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1280)
        ADSMultiplier=0.5
		SprintOffSet=(Pitch=-2048,Yaw=-2048)
		OffsetAdjustTime=0.600000
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		JumpChaos=0.700000
		FallingChaos=0.200000
		SprintChaos=0.200000
		ChaosDeclineTime=2.000000
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=2,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=3,Scale=0f)
		PlayerSpeedFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.50000		
		DisplaceDurationMult=1
		MagAmmo=8
		//SightOffset=(X=0.000000,Y=-0.035000,Z=19.500000)
		SightPivot=(Pitch=0)
		WeaponModes(0)=(ModeName="Airburst: Impact Detonation",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Airburst: Proximity Detonation",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Airburst: Variable Range Detonation",ModeID="WM_FullAuto")
		//WeaponModes(3)=(ModeName="Shield (UNUSED)",bUnavailable=true)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryImpactFireParams'
		FireParams(1)=FireParams'TacticalPrimaryProxyFireParams'
		FireParams(2)=FireParams'TacticalPrimaryRangeFireParams'
		FireParams(3)=FireParams'TacticalPrimaryShieldFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=PUMA_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=PUMA_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA2-MainDark",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA2-BackDark",Index=2,AIndex=1,PIndex=2)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=PUMA_HexGreen
		Index=2
		CamoName="Hex Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-MainHexGreen",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-BackHexGreen",Index=2,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=PUMA_HexBlue
		Index=3
		CamoName="Hex Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-MainHexBlue",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-BackHexBlue",Index=2,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=PUMA_Wood
		Index=4
		CamoName="Classic"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-MainWood",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-BackWood",Index=2,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=PUMA_Pants
		Index=5
		CamoName="Fabulous"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-MainKitty",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-BackKitty",Index=2,AIndex=1,PIndex=2)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=PUMA_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-MainGold",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PUMACamos.PUMA-BackGold",Index=2,AIndex=1,PIndex=2)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'PUMA_Gray'
	Camos(1)=WeaponCamo'PUMA_Black'
	Camos(2)=WeaponCamo'PUMA_HexGreen'
	Camos(3)=WeaponCamo'PUMA_HexBlue'
	Camos(4)=WeaponCamo'PUMA_Wood'
	Camos(5)=WeaponCamo'PUMA_Pants'
	Camos(6)=WeaponCamo'PUMA_Gold'
}