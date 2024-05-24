class SKASWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//10Ga Auto
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=30
		LimbMult=0.35
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Single',Volume=1.300000)
		Recoil=450.000000
		PushBackForce=180.000000
		Chaos=-1.0
		Inaccuracy=(X=900,Y=900)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireRot"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object

	//10Ga High Power
    Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryManualEffectParams
        TraceRange=(Min=2048.000000,Max=4096.000000)
        RangeAtten=0.400000
        TraceCount=7
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=45
        DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
        FlashScaleFactor=2.0
        Recoil=1024.000000
        Chaos=0.250000
        BotRefireRate=0.800000
        WarnTargetPct=0.400000
		Inaccuracy=(X=450,Y=450)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Power',Volume=1.300000)	
    End Object

    Begin Object Class=FireParams Name=ClassicPrimaryManualFireParams
        FireInterval=1.750000
        FireAnim="SemiFire"
        FireEndAnim=
        FireAnimRate=1.000000	
        FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryManualEffectParams'
    End Object
	
	//12Ga Gatling
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_Gatling
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=5 //200dmg (12ga auto)
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=40
		LimbMult=0.35
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Rapid',Volume=1.300000)
		Recoil=50.000000
		PushBackForce=120.000000
		Chaos=1.0
		Inaccuracy=(X=900,Y=900)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object
	
	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Gatling
		TargetState="SpinUpFire"
		FireInterval=0.130000
		BurstFireRateFactor=1.00
        FireAnimRate=2.000000	
		FireAnim="Fire"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_Gatling'
	End Object
	
	//FRAG-10 Auto
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams_Frag
		ProjectileClass=Class'BWBP_SKC_Pro.SKASRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=150.000000
		MaxSpeed=50000.000000
		AccelSpeed=25000.000000
		Damage=105
		DamageRadius=130.000000
		MomentumTransfer=30000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.SRAC-Fire2',Volume=1.450000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Frag
		TargetState="Projectile"
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireRot"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams_Frag'
	End Object
	
	//FRAG-10 Manual
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams_FragManual
		ProjectileClass=Class'BWBP_SKC_Pro.SKASRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=100000.000000
		AccelSpeed=50000.000000
		Damage=110
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.SRAC-Fire',Volume=1.450000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_FragManual
		TargetState="Projectile"
        FireInterval=1.750000
        FireAnim="SemiFire"
        FireEndAnim=
        FireAnimRate=1.000000	
        FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams_FragManual'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=3000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.850000
		TraceCount=30
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=42
		HeadMult=1.4
		LimbMult=0.357142
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgunAlt'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgunAlt'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter_C'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Triple',Volume=2.200000)
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=1600,Y=1600)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Gatling
		TargetState="SpinUpFire"
		FireInterval=1.000000
		AmmoPerFire=3
		BurstFireRateFactor=1.00
		PreFireAnim="ChargeUp"
		FireAnim="FireBig"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.700000
		AmmoPerFire=3
		BurstFireRateFactor=1.00
		PreFireAnim="ChargeUp"
		FireAnim="FireBig"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object

	//Scope
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_Scope'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.000000
		YawFactor=0.00000
		XRandFactor=1.000000
		YRandFactor=1.000000
		MaxRecoil=2048.000000
		DeclineTime=1.000000
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
		AimSpread=(Min=32,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.350000
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
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="10ga Rotary"
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.5
		SightPivot=(Pitch=1024)
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=36
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="1110011",bUnavailable=True,ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="XR4 System",bUnavailable=True,ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SKAS-21 Super Shotgun"
		//SightPivot=(Pitch=512,Roll=-1024,Yaw=-512)
		ViewOffset=(X=5,Y=6,Z=-2)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
        FireParams(1)=FireParams'ClassicPrimaryManualFireParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Gatling
		//Layout core
		LayoutName="12ga Gatling"
		LayoutTags="spinup"
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.5
		SightPivot=(Pitch=1024)
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=40
		WeaponModes(0)=(ModeName="Gatling Mode",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Semi-Automatic",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="1110011",bUnavailable=True,ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="XR4 System",bUnavailable=True,ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SKAS-21 Super Shotgun"
		//SightPivot=(Pitch=512,Roll=-1024,Yaw=-512)
		ViewOffset=(X=5,Y=6,Z=-2)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Gatling'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Gatling'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Frag
		//Layout core
		LayoutName="SRAC HE"
		Weight=10
		AllowedCamos(0)=7
		AllowedCamos(1)=8
		AllowedCamos(2)=9
		AllowedCamos(3)=10
		AllowedCamos(4)=11
		AllowedCamos(5)=12
		AllowedCamos(6)=13
		AllowedCamos(7)=14
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.5
		SightPivot=(Pitch=1024)
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=36
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="1110011",bUnavailable=True,ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="XR4 System",bUnavailable=True,ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SRAC-21/G Autocannon"
		//SightPivot=(Pitch=512,Roll=-1024,Yaw=-512)
		ViewOffset=(X=5,Y=6,Z=-2)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Frag'
        FireParams(1)=FireParams'ClassicPrimaryFireParams_FragManual'
		FireParams(2)=FireParams'ClassicPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Gatling'
	Layouts(2)=WeaponParams'ClassicParams_Frag'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=SKAS_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Urban
		Index=1
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoU",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Digital
		Index=2
		CamoName="Digital"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoT",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Desert
		Index=3
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoD",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Jungle
		Index=4
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoG",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Glitch
		Index=5
		CamoName="XR4"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-Charged",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Glitch2
		Index=6
		CamoName="11011"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-BlueGlow",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Gray
		Index=7
		CamoName="Gray"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-MainShine",Index=1,AIndex=0,PIndex=0)
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Tactical
		Index=8
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-TacticalShine",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Steel
		Index=9
		CamoName="Steel"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-SteelShine",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Blood
		Index=10
		CamoName="Blood"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-BloodShine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Tiger
		Index=11
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-RedTiger",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_DarkTiger
		Index=12
		CamoName="Dark Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-TigerShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Pink
		Index=13
		CamoName="Fabulous"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-PinkShine",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Gold
		Index=14
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-GoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	//SKAS
	Camos(0)=WeaponCamo'SKAS_Gray'
	Camos(1)=WeaponCamo'SKAS_Urban'
	Camos(2)=WeaponCamo'SKAS_Digital'
	Camos(3)=WeaponCamo'SKAS_Desert'
	Camos(4)=WeaponCamo'SKAS_Jungle'
	Camos(5)=WeaponCamo'SKAS_Glitch'
	Camos(6)=WeaponCamo'SKAS_Glitch2'
	//SRAC
	Camos(7)=WeaponCamo'SRAC_Gray'
	Camos(8)=WeaponCamo'SRAC_Tactical'
	Camos(9)=WeaponCamo'SRAC_Steel'
	Camos(10)=WeaponCamo'SRAC_Blood'
	Camos(11)=WeaponCamo'SRAC_Tiger'
	Camos(12)=WeaponCamo'SRAC_DarkTiger'
	Camos(13)=WeaponCamo'SRAC_Pink'
	Camos(14)=WeaponCamo'SRAC_Gold'
}