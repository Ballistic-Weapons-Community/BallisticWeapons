class Fifty9WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=AutoFireEffect
        DecayRange=(Min=788,Max=2363) // 15-45m
        PenetrationEnergy=16
        TraceRange=(Min=3072,Max=3072)
        Damage=23.000000 // 9mm
        HeadMult=3.5
        LimbMult=0.75
        RangeAtten=0.5
		Inaccuracy=(X=128,Y=128)
        DamageType=Class'BallisticProV55.DTFifty9SMG'
        DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
        DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
        PenetrateForce=135
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
        FlashScaleFactor=0.600000
        Recoil=260.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-Fire',Volume=0.900000)
	    SplashDamage=False
	    RecommendSplashDamage=False
	    BotRefireRate=0.99
        WarnTargetPct=0.2
    End Object

    Begin Object Class=InstantEffectParams Name=SuppFireEffect
        DecayRange=(Min=788,Max=2363) // 15-45m
        PenetrationEnergy=16
        TraceRange=(Min=3072,Max=3072)
        Damage=23.000000
        HeadMult=3.5
        LimbMult=0.75
        RangeAtten=0.5
		Inaccuracy=(X=128,Y=128)
        DamageType=Class'BallisticProV55.DTFifty9SMG'
        DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
        DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
        PenetrateForce=135
        bPenetrate=True
        Recoil=210.000000 //
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.600000 //
		FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-FireSil',Volume=0.800000,Radius=48.000000,batten=false) //
	    SplashDamage=False
	    RecommendSplashDamage=False
	    BotRefireRate=0.99
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=BurstFireParams
        AimedFireAnim="SightFire"
        FireInterval=0.05
		BurstFireRateFactor=1.00	
        FireEffectParams(0)=InstantEffectParams'AutoFireEffect'
    End Object

    Begin Object Class=FireParams Name=AutoFireParams
        AimedFireAnim="SightFire"
        FireInterval=0.06 //.072
        FireEffectParams(0)=InstantEffectParams'AutoFireEffect'
    End Object

    Begin Object Class=FireParams Name=SuppFireParams
        AimedFireAnim="SightFire"
        FireInterval=0.072 //.072
        FireEffectParams(0)=InstantEffectParams'SuppFireEffect'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=MeleeEffectParams Name=MeleeSwipeEffect
        Fatigue=0.090000
        TraceRange=(Min=150.000000,Max=150.000000)
        Damage=45.000000
        DamageType=Class'BallisticProV55.DTFifty9Blade'
        DamageTypeHead=Class'BallisticProV55.DTFifty9BladeHead'
        DamageTypeArm=Class'BallisticProV55.DTFifty9Blade'
        //HookStopFactor=1.700000
        //HookPullForce=100.000000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=0.5,Radius=24.000000,batten=false)
        SplashDamage=False
        RecommendSplashDamage=False
        BotRefireRate=0.99
        WarnTargetPct=0.3
    End Object

    Begin Object Class=FireParams Name=MeleeFireParams
        FireAnim="Melee1"
        FireAnimRate=1
        FireInterval=0.5
        AmmoPerFire=0
        FireEffectParams(0)=MeleeEffectParams'MeleeSwipeEffect'
    End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Scope'
	End Object	

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalBurstRecoilParams // for no stock
		ViewBindFactor=0.2
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.2
		XCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		MaxRecoil=6144
		ClimbTime=0.04
		DeclineDelay=0.14
		DeclineTime=1.1
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=1.25
	End Object

	Begin Object Class=RecoilParams Name=TacticalAutoRecoilParams // for stock
		ViewBindFactor=0.2
		ADSViewBindFactor=0.7 //
		EscapeMultiplier=1.2
		XCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		MaxRecoil=6144
		ClimbTime=0.04
		DeclineDelay=0.14
		DeclineTime=1.1
		CrouchMultiplier=0.85 //
		HipMultiplier=1.25
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalBurstAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Bladed"
		//ADS
        SightingTime=0.19
        SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=128)
		//Stats
		DisplaceDurationMult=0.5
        MagAmmo=25        
		InventorySize=3
		bDualBlocked=True
		RecoilParams(0)=RecoilParams'TacticalBurstRecoilParams'
        FireParams(0)=FireParams'BurstFireParams'
        FireParams(1)=FireParams'AutoFireParams'
        AltFireParams(0)=FireParams'MeleeFireParams'
        AimParams(0)=AimParams'TacticalBurstAimParams'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_Burst
		//Layout core
		Weight=10
		LayoutName="Burst"
		LayoutTags="laser,lock,open"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.Fifty9Tac_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Laser',BoneName="tip",Scale=0.08,AugmentOffset=(x=-40,y=0,z=-10.0),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="tip",Scale=0.085,AugmentOffset=(x=-85,y=0,z=7.0),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
        WeaponBoneScales(0)=(BoneName="Suppressor",Slot=0,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Irons",Slot=1,Scale=0f)
		//ADS
        SightingTime=0.19
        SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=128)
		//Stats
		DisplaceDurationMult=0.5
        MagAmmo=25        
		InventorySize=3
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Burst",ModeID="WM_Burst",Value=5.000000)
		WeaponModes(1)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'TacticalBurstRecoilParams'
        FireParams(0)=FireParams'BurstFireParams'
        AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
        AimParams(0)=AimParams'TacticalBurstAimParams'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_Supp
		//Layout core
		Weight=10
		LayoutName="Suppressed"
		LayoutTags="lock"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.Fifty9Tac_FPm'
        WeaponBoneScales(0)=(BoneName="StockWire",Slot=2,Scale=0f)
		//ADS
        SightingTime=0.19
        SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=128)
		//Stats
		DisplaceDurationMult=0.5
        MagAmmo=25        
		InventorySize=3
		bDualBlocked=True
		RecoilParams(0)=RecoilParams'TacticalBurstRecoilParams'
        FireParams(0)=FireParams'SuppFireParams'
        AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
        AimParams(0)=AimParams'TacticalBurstAimParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Burst'
    Layouts(2)=WeaponParams'TacticalParams_Supp'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Fifty_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Fifty_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.Fifty9Camos.Fifty7Skin",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Fifty_Orange
		Index=2
		CamoName="Orange"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.Fifty9Camos.TigerUziSkin",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'Fifty_Blue'
	Camos(1)=WeaponCamo'Fifty_Red'
	Camos(2)=WeaponCamo'Fifty_Orange'
}