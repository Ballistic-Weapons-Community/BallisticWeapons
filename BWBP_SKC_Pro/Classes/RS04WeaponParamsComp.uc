class RS04WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Max=5500.000000)
		RangeAtten=0.900000
		Damage=25
		DamageType=Class'BWBP_SKC_Pro.DTRS04Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTRS04PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTRS04Pistol'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
		Recoil=300.000000
		Chaos=0.200000
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.070000
		FireEndAnim=
		FireAnimRate=1.75	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryBurstEffectParams
		TraceRange=(Max=5500.000000)
		RangeAtten=0.900000
		Damage=25
		DamageType=Class'BWBP_SKC_Pro.DTRS04Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTRS04PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTRS04Pistol'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire',Volume=1.200000)
		Recoil=300.000000
		Chaos=0.200000
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryBurstFireParams
		FireInterval=0.030000
		FireAnim="FireDual"
		AimedFireAnim="Fire"
		BurstFireRateFactor=0.02
		FireEndAnim=
		FireAnimRate=1.75	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryBurstEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Light
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
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
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		TargetState="Light"
		FireInterval=0.200000
		AmmoPerFire=0
	FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Flashbang Light
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Blind
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
		EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Blind
		TargetState="FlashbangLight"
		FireInterval=4.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="SecFire"
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Blind'
	End Object
	
	//Sensor
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams_Sensor
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

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Sensor
		TargetState="Projectile"
		FireInterval=1.000000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="FlashLightToggle"
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams_Sensor'
	End Object
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTRS04Stab'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTRS04Stab'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTRS04Stab'
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
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams_TacKnife'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.7
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.1),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.12),(InVal=0.7,OutVal=0.2),(InVal=1.0,OutVal=0.3)))
		XRandFactor=0.15000
		YRandFactor=0.15000
		ClimbTime=0.06
		DeclineDelay=0.250000
		DeclineTime=0.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Tac Light"
		LayoutTags="flash,light"
		//ADS
		SightOffset=(X=-3.50,Y=0.2,Z=1.07)
		SightPivot=(Roll=-256)
		SightingTime=0.200000
		//Function
		ViewOffset=(X=0.00,Y=6.00,Z=-6.00)
		PlayerSpeedFactor=1
		MagAmmo=10
        InventorySize=3
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Blind'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Sensor
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
		SightingTime=0.200000
		//Function
		ViewOffset=(X=0.00,Y=6.00,Z=-6.00)
		PlayerSpeedFactor=1
		MagAmmo=10
        InventorySize=3
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Sensor'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		LayoutName="RDS"
		LayoutTags="light"
		Weight=10
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="Slide",AugmentOffset=(x=1.4,y=-1,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-3.50,Y=0.2,Z=1.9)
		SightPivot=(Roll=-256)
		SightingTime=0.200000
		//Stats
		ViewOffset=(X=0.00,Y=6.00,Z=-6.00)
		PlayerSpeedFactor=1
		MagAmmo=10
        InventorySize=3
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_TacKnife
		//Layout core
		Weight=30
		LayoutName="Tac Knife"
		LayoutTags="tacknife,light"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_RS04Melee'
		//ADS
		SightOffset=(X=-3.50,Y=-0.03,Z=1.07)
		SightPivot=(Roll=0)
		SightingTime=0.200000
		//Function
		bDualBlocked=true
		ViewOffset=(X=0.00,Y=6.00,Z=-6.00)
		PlayerSpeedFactor=1
		MagAmmo=10
        InventorySize=3
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_TacKnife'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_TacKnife'
	Layouts(2)=WeaponParams'ArenaParams_RDS'
	Layouts(3)=WeaponParams'ArenaParams_Sensor'
	
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