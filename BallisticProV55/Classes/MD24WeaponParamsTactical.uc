class MD24WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//9mm
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=23 // 9mm
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=256.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.1000 //.13
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//9mm Supp
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Supp
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=23 // 9mm
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=0.650000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MD24.MD24_FireSil',Volume=0.800000,Radius=48.000000,bAtten=True)
		Recoil=230.000000 //
		Chaos=0.350000 //
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Supp
		FireInterval=0.1000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Supp'
	End Object
	
	//9mm Tac Knife
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_TacKnife
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=256,Y=256) //x2
		RangeAtten=0.5
		Damage=23 // 9mm
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=512.000000 //x2
		Chaos=1.200000 //x5
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_TacKnife
		FireInterval=0.1000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_TacKnife'
	End Object
	
	//10mm
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_10mm
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=40 // 10mm
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=762.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_FireHeavy',Volume=4.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_10mm
		FireInterval=0.14000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_10mm'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Scope
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object	
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=80.0
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
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.06
		DeclineDelay=0.250000
		DeclineTime=0.35
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.25
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_TacKnife
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.1
		XRandFactor=0.2 //x2
		YRandFactor=0.2 //x2
		ClimbTime=0.06
		DeclineDelay=0.250000
		DeclineTime=0.35
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_TacKnife
		ADSViewBindFactor=0
		ADSMultiplier=0.7 //x2
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=512) //x2
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="9mm RDS"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronSights",Slot=50,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="Slide",AugmentOffset=(x=5,y=0,z=4),Scale=0.05,AugmentRot=(Pitch=0,Roll=0,Yaw=-32768))
		//ADS
		SightOffset=(X=-7.00000,Y=-0.01,Z=1.82)
        SightMoveSpeedFactor=0.6
		SightingTime=0.20
		//Function
		bDualBlocked=True
        DisplaceDurationMult=0.33
		MagAmmo=15
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Supp
		//Layout core
		LayoutName="9mm Suppressed"
		Weight=10
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorSOCOM',BoneName="Muzzle",Scale=0.04,AugmentRot=(Pitch=0,Roll=0,Yaw=-32768))
		//ADS
		SightOffset=(X=-7.00000,Y=-0.01,Z=1.82)
        SightMoveSpeedFactor=0.6
		SightingTime=0.20
		//Function
		bDualBlocked=True
        DisplaceDurationMult=0.33
		MagAmmo=15
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_TacKnife
		//Layout core
		LayoutName="9mm Tac Knife"
		LayoutTags="tacknife"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_MD24Melee'
		//ADS
		SightOffset=(X=-7.00000,Y=-0.01,Z=2.5)
        SightMoveSpeedFactor=0.6
		SightingTime=0.20
		//Function
		bDualBlocked=True
        DisplaceDurationMult=0.33
		MagAmmo=15
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams_TacKnife'
        AimParams(0)=AimParams'TacticalAimParams_TacKnife'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_TacKnife'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_10mm
		//Layout core
		LayoutName="10mm Super"
		Weight=30
		//Attachments
		//ADS
		SightOffset=(X=-7.00000,Y=0,Z=1.7)
		SightingTime=0.20
        SightMoveSpeedFactor=0.6
		//Function
		bDualBlocked=True
        DisplaceDurationMult=0.33
		MagAmmo=12
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_10mm'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Supp'
    Layouts(2)=WeaponParams'TacticalParams_TacKnife'
    Layouts(3)=WeaponParams'TacticalParams_10mm'
	
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