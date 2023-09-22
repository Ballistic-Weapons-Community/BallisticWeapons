class MD24WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//10mm Super
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Max=6000.000000)
		WaterTraceRange=3600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.850000
		Damage=42.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrationEnergy=24.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.750000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_FireHeavy',Volume=4.000000)
		Recoil=3600.000000
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//9mm
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_9mm
		TraceRange=(Max=6000.000000)
		WaterTraceRange=3600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=25.0 //
		HeadMult=2.4
		LimbMult=0.3
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.650000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
		Recoil=1400.000000 //
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_9mm
		FireInterval=0.150000 //
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_9mm'
	End Object
	
	//Supp
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Supp
		TraceRange=(Max=6000.000000)
		WaterTraceRange=3600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.700000 //
		Damage=25.0
		HeadMult=2.4
		LimbMult=0.3
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.650000 //
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MD24.MD24_FireSil',Volume=0.800000,Radius=48.000000,bAtten=True) ///
		Recoil=1300.000000 //
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Supp
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Supp'
	End Object
	
	//9mm Tac Knife
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_TacKnife
		TraceRange=(Max=6000.000000)
		WaterTraceRange=3600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=25.0
		HeadMult=2.4
		LimbMult=0.3
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.650000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
		Recoil=2800.000000 //x2
		Chaos=1.0
		Inaccuracy=(X=256,Y=256) //
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_TacKnife
		FireInterval=0.150000 //
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_TacKnife'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================		
	
	//Scope
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object	
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMD24Melee'
		DamageTypeHead=Class'BallisticProV55.DTMD24Melee'
		DamageTypeArm=Class'BallisticProV55.DTMD24Melee'
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
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	//2 hand
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=1024)
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1400.000000
		ChaosTurnThreshold=196608.000000
	End Object

	//1 hand
	Begin Object Class=AimParams Name=ClassicAimParams_TacKnife
		AimSpread=(Min=256,Max=1024) //
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1400.000000
		ChaosTurnThreshold=196608.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="10mm Super"
		Weight=30
		//Attachments
		//ADS
		SightOffset=(X=-7.00000,Y=0,Z=1.7)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=3
		bNeedCock=True
		MagAmmo=14
		//SightOffset=(X=-10.000000,Y=-0.725000,Z=10.300000)
		//SightPivot=(Pitch=1024,Roll=-1024)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		ViewOffset=(X=2,Y=5.00,Z=-2.5)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_RDS
		//Layout core
		LayoutName="9mm RDS"
		Weight=5
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronSights",Slot=50,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="Slide",AugmentOffset=(x=5,y=0,z=4),Scale=0.05,AugmentRot=(Pitch=0,Roll=0,Yaw=-32768))
		//ADS
		SightOffset=(X=-7.00000,Y=-0.01,Z=1.82)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		bNeedCock=True
		MagAmmo=16
		ViewOffset=(X=2,Y=5.00,Z=-2.5)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_9mm'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Supp
		//Layout core
		LayoutName="9mm Suppressed"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorSOCOM',BoneName="Muzzle",Scale=0.04,AugmentRot=(Pitch=0,Roll=0,Yaw=-32768))
		//ADS
		SightOffset=(X=-7.00000,Y=0,Z=1.7)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		bNeedCock=True
		MagAmmo=16
		ViewOffset=(X=2,Y=5.00,Z=-2.5)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_TacKnife
		//Layout core
		LayoutName="9mm Tac Knife"
		LayoutTags="tacknife"
		Weight=5
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_MD24Melee'
		//ADS
		SightOffset=(X=-7.00000,Y=-0.01,Z=2.5)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		//Stats
		bDualBlocked=true
		bDualMixing=false
		PlayerSpeedFactor=1.100000
		InventorySize=3
		//bNeedCock=True //netcode issue, needs pulloutfancy in main anim set
		MagAmmo=16
		ViewOffset=(X=2,Y=5.00,Z=-2.5)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams_TacKnife'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_9mm'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_TacKnife'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_RDS'
	Layouts(2)=WeaponParams'ClassicParams_Supp'
	Layouts(3)=WeaponParams'ClassicParams_TacKnife'
	
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