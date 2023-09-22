class RS04WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Max=5000.000000)
		WaterTraceRange=3300.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=32
		HeadMult=2.65
		LimbMult=0.375
		DamageType=Class'BWBP_SKC_Pro.DTM1911Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM1911PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM1911Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
		Recoil=840.000000
		Chaos=0.050000
		Inaccuracy=(X=16,Y=16)
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Light
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
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
		
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		TargetState="Light"
		FireInterval=0.200000
		AmmoPerFire=0
	FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Flashbang Light
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_Blind
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
		EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Blind
		TargetState="FlashbangLight"
		FireInterval=4.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="SecFire"
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_Blind'
	End Object
	
	//Sensor
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_Sensor
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Sensor
		TargetState="Projectile"
		FireInterval=0.300000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="FlashLightToggle"
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_Sensor'
	End Object
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35.0
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
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams_TacKnife'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=2048.000000
		DeclineTime=0.600000
		DeclineDelay=0.100000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.500000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Light Pistol
		AimSpread=(Min=36,Max=2048)
		AimAdjustTime=0.550000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.050000
		JumpChaos=0.050000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.050000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		Weight=30
		LayoutName="Tac Light"
		LayoutTags="flash,light"
		//ADS
		SightOffset=(X=-3.50,Y=0.2,Z=1.07)
		SightPivot=(Roll=-256)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Function
		InventorySize=2
		bNeedCock=True
		MagAmmo=8
		ReloadAnimRate=1.2
		ViewOffset=(X=0.000000,Y=6.000000,Z=-3.000000)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Blind'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_RDS
		//Layout core
		LayoutName="RDS"
		LayoutTags="flash,light"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="LightModule",Slot=4,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="Slide",AugmentOffset=(x=1.4,y=-1,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-3.50,Y=0.2,Z=1.9)
		SightPivot=(Roll=-256)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Stats
		InventorySize=2
		bNeedCock=True
		MagAmmo=8
		ReloadAnimRate=1.2
		ViewOffset=(X=0.000000,Y=6.000000,Z=-3.000000)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_TacKnife
		//Layout core
		LayoutName="Tac Knife"
		LayoutTags="tacknife,light"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_RS04Melee'
		//ADS
		SightOffset=(X=-3.50,Y=-0.03,Z=1.07)
		SightPivot=(Roll=0)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Stats
		//Function
		bDualBlocked=true
		InventorySize=2
		bNeedCock=True
		MagAmmo=8
		ReloadAnimRate=1.2
		ViewOffset=(X=0.000000,Y=6.000000,Z=-3.000000)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_TacKnife'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Sensor
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
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Function
		InventorySize=2
		bNeedCock=True
		MagAmmo=8
		ReloadAnimRate=1.2
		ViewOffset=(X=0.000000,Y=6.000000,Z=-3.000000)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Sensor'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_TacKnife'
	Layouts(2)=WeaponParams'ClassicParams_RDS'
	Layouts(3)=WeaponParams'ClassicParams_Sensor'
	
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