class Mk781WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=3000.000000,Max=5000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.600000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
		HeadMult=2.0
		LimbMult=0.333333
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MK781.Mk781-Fire',Volume=1.300000)
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=400,Y=350)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object

	//Suppressed
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimarySilEffectParams
		TraceRange=(Min=3000.000000,Max=5000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.600000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
		HeadMult=2.0
		LimbMult=0.333333
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Mk781.Mk781-FireSil',Volume=2.300000,Radius=256.000000)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=200,Y=150)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimarySilFireParams
		FireInterval=0.750000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimarySilEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Zaps
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=1.000000
		TraceCount=30
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=10
		HeadMult=1.5
		LimbMult=0.9
		DamageType=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.HyperBeamCannon.343Primary-Hit',Volume=1.600000)
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=1300,Y=1200)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEndAnim=	
        TargetState="ElektroShot"
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Electrobolt
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryBoltEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MK781PulseProjectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=3600.000000
		MaxSpeed=1000000.000000
		AccelSpeed=1200.000000
		Damage=100.000000
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire')
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryBoltFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
        TargetState="ElektroSlug"
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryBoltEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.600000
		YRandFactor=0.700000
		DeclineDelay=0.200000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.700000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		SightOffset=(X=-5.00,Y=0.08,Z=2.65)
		SightPivot=(Pitch=-64,Yaw=10)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		bNeedCock=True
		MagAmmo=6
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		FireParams(3)=FireParams'ClassicPrimarySilFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(2)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(3)=FireParams'ClassicSecondaryBoltFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicRDSParams
		//Layout core
		Weight=10
		LayoutName="Red Dot Sight"
		//Attachments
		SightOffset=(X=4.20,Y=0.01,Z=6.97)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		bNeedCock=True
		MagAmmo=6
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		FireParams(3)=FireParams'ClassicPrimarySilFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(2)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(3)=FireParams'ClassicSecondaryBoltFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicRDSParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M781_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Digital
		Index=1
		CamoName="Digital"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoDigital",Index=1,AIndex=1,PIndex=2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoDesert",Index=1,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Patriot
		Index=3
		CamoName="Patriot"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoAmerica",Index=1,AIndex=1,PIndex=2)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_RedTiger
		Index=4
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoTiger",Index=1,AIndex=1,PIndex=2)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'M781_Gray'
	Camos(1)=WeaponCamo'M781_Digital'
	Camos(2)=WeaponCamo'M781_Desert'
	Camos(3)=WeaponCamo'M781_Patriot'
	Camos(4)=WeaponCamo'M781_RedTiger'
}