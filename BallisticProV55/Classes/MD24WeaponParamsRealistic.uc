class MD24WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//10mm
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_10mm
		TraceRange=(Min=800.000000,Max=4000.000000) //10mm Super
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=50.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrationEnergy=9.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_FireHeavy',Volume=4.000000)
		Recoil=1024.000000
		Chaos=-1.0
		Inaccuracy=(X=14,Y=14)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_10mm
		FireInterval=0.220000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.700000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_10mm'
	End Object
	
	//.40
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000,Max=3500.000000) //.40
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=37.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrationEnergy=9.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=14,Y=14)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=2.400000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//.40 supp
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Supp
		TraceRange=(Min=800.000000,Max=3500.000000) //.40
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=37.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrationEnergy=9.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=0.650000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MD24.MD24_FireSil',Volume=0.800000,Radius=48.000000,bAtten=True)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=14,Y=14)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Supp
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=2.400000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Supp'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=84.000000,Max=84.000000)
		WaterTraceRange=5000.0
		Damage=36.0
		HeadMult=2.083333
		LimbMult=0.472222
		DamageType=Class'BallisticProV55.DTMD24Melee'
		DamageTypeHead=Class'BallisticProV55.DTMD24Melee'
		DamageTypeArm=Class'BallisticProV55.DTMD24Melee'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Melee',Volume=1.500000,Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.400000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepMelee"
		FireAnim="Melee"
		PreFireAnimRate=1.500000
		FireAnimRate=1.250000
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.000000
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=1344.000000
		DeclineTime=0.450000
		DeclineDelay=0.100000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.820000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1216)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=700.000000
		ChaosTurnThreshold=196608.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams_10mm
		//Layout core
		LayoutName="10mm Super"
		Weight=30
		//Attachments
		//ADS
		SightOffset=(X=-7.00000,Y=0,Z=1.7)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=2
		WeaponPrice=650
		MagAmmo=15
		//ViewOffset=(X=11.000000,Y=6.000000,Z=-6.500000)
		//SightOffset=(X=-14.000000,Y=-0.010000,Z=7.450000)
		SightPivot=(Pitch=0,Roll=-0)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="MD24 10mm Commando Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_10mm'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName=".40 RDS"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronSights",Slot=50,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="Slide",AugmentOffset=(x=5,y=0,z=4),Scale=0.05,AugmentRot=(Pitch=0,Roll=0,Yaw=-32768))
		//ADS
		SightOffset=(X=-7.00000,Y=-0.01,Z=1.82)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=2
		WeaponPrice=650
		MagAmmo=15
		//ViewOffset=(X=11.000000,Y=6.000000,Z=-6.500000)
		//SightOffset=(X=-14.000000,Y=-0.010000,Z=7.450000)
		SightPivot=(Pitch=0,Roll=-0)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="MD24 .40 Commando Pistol (RDS)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Supp
		//Layout core
		LayoutName=".40 Suppressed"
		Weight=10
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorSOCOM',BoneName="Muzzle",Scale=0.04,AugmentRot=(Pitch=0,Roll=0,Yaw=-32768))
		//ADS
		SightOffset=(X=-7.00000,Y=-0.01,Z=1.82)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=2 //3 in future
		WeaponPrice=650
		MagAmmo=15
		//ViewOffset=(X=11.000000,Y=6.000000,Z=-6.500000)
		//SightOffset=(X=-14.000000,Y=-0.010000,Z=7.450000)
		SightPivot=(Pitch=0,Roll=-0)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="MD24 .40 Commando Pistol (Supp)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_10mm'
	Layouts(1)=WeaponParams'RealisticParams'
	Layouts(2)=WeaponParams'RealisticParams_Supp'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=MD24_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Black
		Index=1
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24BlackShine",Index=1,PIndex=0,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Desert
		Index=2
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24DesertShine",Index=1,PIndex=0,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Blue
		Index=3
		CamoName="Blue"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24BlueShine",Index=1,PIndex=0,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Red
		Index=4
		CamoName="Red"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24RedShine",Index=1,PIndex=0,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Gold
		Index=5
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24Gold-Main-Shine",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24Gold-Clip-Shine",Index=2,PIndex=0,AIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'MD24_Green'
    Camos(1)=WeaponCamo'MD24_Black'
    Camos(2)=WeaponCamo'MD24_Desert'
    Camos(3)=WeaponCamo'MD24_Blue'
    Camos(4)=WeaponCamo'MD24_Red'
    Camos(5)=WeaponCamo'MD24_Gold'
}