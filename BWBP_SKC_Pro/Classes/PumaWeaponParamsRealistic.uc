class PumaWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Impact Det
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryImpactEffectParams
		ProjectileClass=Class'PUMAProjectileImpact'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=12500.000000
		Damage=70.000000
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryImpactFireParams
		FireInterval=0.450000
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryImpactEffectParams'
	End Object
	
	//Proximity Det
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryProxyEffectParams
		ProjectileClass=Class'PumaProjectile'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=12500.000000
		Damage=55.000000
		DamageRadius=270.000000
		MomentumTransfer=10000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryProxyFireParams
		FireInterval=0.450000
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryProxyEffectParams'
	End Object

	//Range Det
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryRangeEffectParams
		ProjectileClass=Class'PumaProjectileRanged'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6000.000000
		Damage=55.000000
		DamageRadius=270.000000
		MomentumTransfer=10000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryRangeFireParams
		FireInterval=0.450000
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryRangeEffectParams'
	End Object

	//Shield Shot
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryShieldEffectParams
		ProjectileClass=Class'PUMAProjectileClose'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6000.000000
		Damage=55.000000
		DamageRadius=270.000000
		MomentumTransfer=10000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryShieldFireParams
		FireInterval=0.450000
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryShieldEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		PitchFactor=0.400000
		XRandFactor=0.400000
		YRandFactor=0.400000
		DeclineTime=1.500000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1960)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=6
		//ViewOffset=(X=7.000000,Y=6.000000,Z=-13.000000)
		//SightOffset=(X=-10.000000,Y=-0.035000,Z=19.500000)
		SightPivot=(Pitch=0)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="PUMA-77 Target Engagement System"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryImpactFireParams'
		FireParams(1)=FireParams'RealisticPrimaryProxyFireParams'
		FireParams(2)=FireParams'RealisticPrimaryRangeFireParams'
		FireParams(3)=FireParams'RealisticPrimaryShieldFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
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