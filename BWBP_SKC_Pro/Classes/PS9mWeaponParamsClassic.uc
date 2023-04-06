class PS9mWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=3000.000000,Max=5000.000000)
			WaterTraceRange=5000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=15
			HeadMult=4.0
			LimbMult=0.8
			DamageType=Class'BWBP_SKC_Pro.DT_PS9MDart'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_PS9MDartHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_PS9MDart'
			PenetrationEnergy=1.000000
			PenetrateForce=150
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
			FlashScaleFactor=0.800000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-Fire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=172.000000
			Chaos=-1.0
			Inaccuracy=(X=24,Y=24)
			WarnTargetPct=0.200000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.100000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
			ProjectileClass=Class'BWBP_SKC_Pro.PS9mMedDart'
			SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
			Speed=6500.000000
			Damage=30.000000
			HeadMult=1.0
			LimbMult=1.0
			MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-DartFire',Volume=1.350000)
			Recoil=0.0
			Chaos=-1.0
			SplashDamage=True
			RecommendSplashDamage=True
			BotRefireRate=0.300000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.600000
			BurstFireRateFactor=1.00
			AmmoPerFire=0
			FireAnim="Dart_Fire"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		XRandFactor=0.300000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Ultra light handling
		AimSpread=(Min=16,Max=1748)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.050000
		JumpChaos=0.050000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.050000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=2
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		MagAmmo=10
		//SightOffset=(X=-10.000000,Y=11.40000,Z=11.50000)
		//ViewOffset=(X=3.000000,Y=-2.000000,Z=-8.500000)
		SightPivot=(Pitch=1024)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=PS_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=PS_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.StealthCamos.Stealth-Black",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=PS_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.StealthCamos.Stealth-TigerGreen",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=PS_RedTiger
		Index=3
		CamoName="Ember"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.StealthCamos.Stealth-Tiger",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'PS_Gray' //Black
	Camos(1)=WeaponCamo'PS_Black'
	Camos(2)=WeaponCamo'PS_Jungle'
	Camos(3)=WeaponCamo'PS_RedTiger'
}