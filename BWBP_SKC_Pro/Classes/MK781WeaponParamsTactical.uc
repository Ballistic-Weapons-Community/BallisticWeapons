class MK781WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=1050,Max=2100)
		WaterTraceRange=5000.0
		RangeAtten=0.45
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=12
        HeadMult=1.75f
        LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MK781.Mk781-Fire',Volume=1.300000)
		Recoil=300.000000
		Inaccuracy=(X=256,Y=256)
		BotRefireRate=0.800000
		WarnTargetPct=0.400000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.325000
		FireAnimRate=1.150000
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object

	//Suppressed
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimarySilEffectParams
		TraceRange=(Min=3000.000000,Max=5000.000000)
		DecayRange=(Min=1050,Max=2100)
		WaterTraceRange=5000.0
		RangeAtten=0.45
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=8
        HeadMult=1.75f
        LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=16.000000
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Mk781.Mk781-FireSil',Volume=2.300000,Radius=256.000000)
		Recoil=240.000000
		Inaccuracy=(X=128,Y=128)
		BotRefireRate=0.800000
		WarnTargetPct=0.400000		
	End Object

	Begin Object Class=FireParams Name=TacticalPrimarySilFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.32500
		FireAnimRate=1.150000
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimarySilEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Zaps
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=1.000000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=5
        HeadMult=1.0f
        LimbMult=1.0f
		DamageType=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.HyperBeamCannon.343Primary-Hit',Volume=1.600000)
		Recoil=768.000000
		Inaccuracy=(X=150,Y=150)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.010000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		FireEndAnim=
        AimedFireAnim="SightFire"
		TargetState="ElektroShot"
		FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//Electrobolt
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryBoltEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MK781PulseProjectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=5500.000000
		MaxSpeed=5500.000000
		Damage=80
		DamageRadius=378.000000
		MomentumTransfer=70000.000000
		HeadMult=1.0f
		LimbMult=1.0f
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire')
		Recoil=768.000000
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryBoltFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		FireEndAnim=
        AimedFireAnim="SightFire"
        TargetState="ElektroSlug"
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryBoltEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.120000),(InVal=0.400000,OutVal=0.180000),(InVal=0.800000,OutVal=0.220000),(InVal=1.000000,OutVal=0.250000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineDelay=0.600000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=TacticalAimParams		
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		Weight=10
		LayoutName="Red Dot Sight"
		//Attachments
		SightOffset=(X=30.000000,Y=-7.660000,Z=13.940000)
		//Function
		ReloadAnimRate=1.2
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.3
		DisplaceDurationMult=1
		MagAmmo=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams'
		FireParams(2)=FireParams'TacticalPrimaryFireParams'
		FireParams(3)=FireParams'TacticalPrimarySilFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(3)=FireParams'TacticalSecondaryBoltFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		SightOffset=(X=20.000000,Y=-7.645,Z=11.90000)
		SightPivot=(Pitch=-64,Yaw=10)
		//Function
		ReloadAnimRate=1.2
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.3
		DisplaceDurationMult=1
		MagAmmo=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams'
		FireParams(2)=FireParams'TacticalPrimaryFireParams'
		FireParams(3)=FireParams'TacticalPrimarySilFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(3)=FireParams'TacticalSecondaryBoltFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams_RDS'
    Layouts(1)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M781_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Digital
		Index=1
		CamoName="Digital"
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoDigital",Index=1,AIndex=1,PIndex=2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoDesert",Index=1,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Patriot
		Index=3
		CamoName="Patriot"
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoAmerica",Index=1,AIndex=1,PIndex=2)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_RedTiger
		Index=4
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoTiger",Index=1,AIndex=1,PIndex=2)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'M781_Gray'
	Camos(1)=WeaponCamo'M781_Digital'
	Camos(2)=WeaponCamo'M781_Desert'
	Camos(3)=WeaponCamo'M781_Patriot'
	Camos(4)=WeaponCamo'M781_RedTiger'
}