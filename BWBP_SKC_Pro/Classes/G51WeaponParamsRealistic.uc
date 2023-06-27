class G51WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1400.000000,Max=5200.000000) //5.56mm Short Barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=43.0
		HeadMult=2.15
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_G51Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_G51AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_G51AssaultLimb'
		PenetrationEnergy=18.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ55A3Carbine-Fire',Pitch=1.150000,Volume=1.10000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.063000
		AimedFireAnim="SightFire"
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//HE
	Begin Object Class=GrenadeEffectParams Name=RealisticSecondaryEffectParams_HE
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3600.000000
		Damage=200.000000
		DamageRadius=400.000000
        ImpactDamage=240
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=1.250000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_HE
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'RealisticSecondaryEffectParams_HE'
	End Object
	
	//Chaff
	Begin Object Class=GrenadeEffectParams Name=RealisticSecondaryEffectParams_Chaff
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_Chaff'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3600.000000
		Damage=65.000000
		DamageRadius=192.000000
        ImpactDamage=100
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=1.250000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Chaff
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'RealisticSecondaryEffectParams_Chaff'
	End Object
	
	//Sensor
	Begin Object Class=GrenadeEffectParams Name=RealisticSecondaryEffectParams_Sensor
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_Sensor'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3600.000000
		Damage=25.000000
		DamageRadius=10.000000
        ImpactDamage=100
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=1.250000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Sensor
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'RealisticSecondaryEffectParams_Sensor'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.700000,OutVal=0.350000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.150000
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=2800
		DeclineTime=0.625000
		DeclineDelay=0.075000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=12,Max=1400)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.450000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Chaff
		//Layout core
		Weight=30
		LayoutName="Adv Holo + Chaff"
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="HoloSightLower",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=-0.500000,Y=-0.01000,Z=3.100000)
		
		//Function
		InventorySize=6
		WeaponPrice=1200
		SightMoveSpeedFactor=0.500000
		//SightOffset=(X=10.000000,Y=-6.450000,Z=20.900000)
		//ViewOffset=(X=-9.000000,Y=8.000000,Z=-15.000000)
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="G51 5.56mm Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Chaff'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Sensor
		//Layout core
		Weight=3
		LayoutName="Adv Holo + Sensor"
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=-1)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=1f)
		SightOffset=(X=-0.50,Y=0.00,Z=-0.12)
		
		//Function
		InventorySize=6
		WeaponPrice=1200
		SightMoveSpeedFactor=0.500000
		//SightOffset=(X=10.000000,Y=-6.450000,Z=20.900000)
		//ViewOffset=(X=-9.000000,Y=8.000000,Z=-15.000000)
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="G51 5.56mm Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Sensor'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_HE
		//Layout core
		Weight=10
		LayoutName="Iron Sights + HE"
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=-0.500000,Y=0.00000,Z=1.000000)
		
		//Function
		InventorySize=6
		WeaponPrice=1200
		SightMoveSpeedFactor=0.500000
		//SightOffset=(X=10.000000,Y=-6.450000,Z=20.900000)
		//ViewOffset=(X=-9.000000,Y=8.000000,Z=-15.000000)
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="G51 5.56mm Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_HE'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_Chaff'
	Layouts(1)=WeaponParams'RealisticParams_Sensor'
	Layouts(2)=WeaponParams'RealisticParams_HE'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=G51_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Green
		Index=1
		CamoName="Green"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainGreen",Index=1,AIndex=0,PIndex=1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_GreenHex
		Index=2
		CamoName="Hex Green"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainHexG",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_BlueHex
		Index=3
		CamoName="Hex Blue"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainHexB",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Desert
		Index=4
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainDesert",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_UTC
		Index=5
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.UTCG51Tex",Index=1,AIndex=0,PIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Inferno
		Index=6
		CamoName="Inferno"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainRed",Index=1,AIndex=0,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Gold
		Index=7
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainGold",Index=1,AIndex=0,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'G51_Black'
	Camos(1)=WeaponCamo'G51_Green'
	Camos(2)=WeaponCamo'G51_GreenHex'
	Camos(3)=WeaponCamo'G51_BlueHex'
	Camos(4)=WeaponCamo'G51_Desert'
	Camos(5)=WeaponCamo'G51_UTC'
	Camos(6)=WeaponCamo'G51_Inferno'
	Camos(7)=WeaponCamo'G51_Gold'
}