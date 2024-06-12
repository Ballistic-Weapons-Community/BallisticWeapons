class RS04WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4000,Max=4000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=30 // .45, compact
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTM1911Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM1911PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM1911Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
		Recoil=640.000000
		Chaos=0.2
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.070000
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryBurstEffectParams
		TraceRange=(Min=4000,Max=4000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=30
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTM1911Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM1911PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM1911Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
		Recoil=300.000000
		Chaos=0.2
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryBurstFireParams
		FireInterval=0.030000
		FireAnim="FireDual"
		AimedFireAnim="Fire"
		BurstFireRateFactor=0.02
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryBurstEffectParams'
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
		TargetState="Light"
		FireInterval=0.200000
		AmmoPerFire=0
	FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//Flashbang Light
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Blind
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
		EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Blind
		TargetState="FlashbangLight"
		FireInterval=4.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="SecFire"
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Blind'
	End Object
	
	//Sensor
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams_Sensor
		ProjectileClass=Class'BWBP_SKC_Pro.RS04Projectile_Sensor'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		AccelSpeed=8000.000000
		Speed=2240.000000
		MaxSpeed=10000.000000
		Damage=35
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Sensor
		TargetState="Projectile"
		FireInterval=1.000000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="FlashLightToggle"
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams_Sensor'
	End Object
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=80.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTRS8Stab'
		DamageTypeHead=Class'BallisticProV55.DTRS8Stab'
		DamageTypeArm=Class'BallisticProV55.DTRS8Stab'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.X4.X4_Melee',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams_TacKnife'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.1
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.1),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.12),(InVal=0.7,OutVal=0.2),(InVal=1.0,OutVal=0.3)))
		XRandFactor=0.15000
		YRandFactor=0.15000
		ClimbTime=0.06
		DeclineDelay=0.250000
		DeclineTime=0.5
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
		AimSpread=(Min=256,Max=768)
		ChaosDeclineTime=0.320000
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Tac Light"
		LayoutTags="flash,light"
		//ADS
		SightOffset=(X=-3.50,Y=0.2,Z=1.07)
		SightPivot=(Roll=-256)
		SightingTime=0.20
        SightMoveSpeedFactor=0.6
		//Stats
		InventorySize=2
		WeaponPrice=700
		DisplaceDurationMult=0.5
		MagAmmo=10
		bDualBlocked=True
		WeaponName="RS4 Compact Handgun (Light)"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Blind'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Sensor
		//Layout core
		Weight=10
		LayoutName="Sensor"
		LayoutTags="sensor"
		//Attachments
		WeaponBoneScales(0)=(BoneName="LightModule",Slot=4,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Tazer',BoneName="Muzzle",Scale=0.03,AugmentOffset=(x=-2.5,y=1.5,z=0),AugmentRot=(Pitch=0,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-3.50,Y=0.2,Z=1.07)
		SightPivot=(Roll=-256)
		SightingTime=0.20
        SightMoveSpeedFactor=0.6
		//Stats
		InventorySize=2
		WeaponPrice=700
		DisplaceDurationMult=0.5
		MagAmmo=10
		bDualBlocked=True
		WeaponName="RS4 Compact Handgun"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Sensor'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		LayoutName="RDS"
		LayoutTags="light"
		Weight=10
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="Slide",AugmentOffset=(x=1.4,y=-1,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-3.50,Y=0.2,Z=1.9)
		SightPivot=(Roll=-256)
		SightingTime=0.20
        SightMoveSpeedFactor=0.6
		//Stats
		InventorySize=2
		WeaponPrice=700
		DisplaceDurationMult=0.5
		MagAmmo=10
		bDualBlocked=True
		WeaponName="RS4 Compact Handgun (RDS)"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_TacKnife
		//Layout core
		LayoutName="Tac Knife"
		LayoutTags="tacknife,light"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_RS04Melee'
		//ADS
		SightOffset=(X=-3.50,Y=-0.03,Z=1.07)
		SightPivot=(Roll=0)
		SightingTime=0.20
        SightMoveSpeedFactor=0.6
		//Function
		InventorySize=2
		WeaponPrice=700
		DisplaceDurationMult=0.5
		MagAmmo=10
		bDualBlocked=True
		WeaponName="RS4 Compact Handgun (Tac Knife)"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_TacKnife'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Sensor'
	Layouts(1)=WeaponParams'TacticalParams_RDS'
	Layouts(2)=WeaponParams'TacticalParams'
	Layouts(3)=WeaponParams'TacticalParams_TacKnife'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=RS04_Tan
		Index=0
		CamoName="Tan"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-MainShineX1",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_TwoTone
		Index=2
		CamoName="Two-Tone"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-MainShineX2",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Jungle
		Index=3
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-UC-CamoJungle",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Hunter
		Index=4
		CamoName="Hunter"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-R-CamoHunter",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Autumn
		Index=5
		CamoName="Autumn"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-R-CamoAutumn",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_RedTiger
		Index=6
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-X-CamoTiger",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'RS04_Tan'
	Camos(1)=WeaponCamo'RS04_Black'
	Camos(2)=WeaponCamo'RS04_TwoTone'
	Camos(3)=WeaponCamo'RS04_Jungle'
	Camos(4)=WeaponCamo'RS04_Hunter'
	Camos(5)=WeaponCamo'RS04_Autumn'
	Camos(6)=WeaponCamo'RS04_RedTiger'
	//Camos(7)=WeaponCamo'RS04_Gold'
}