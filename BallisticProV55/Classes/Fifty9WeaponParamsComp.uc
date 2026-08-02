class Fifty9WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=AutoFireEffect
        DecayRange=(Min=525,Max=1225)
        PenetrationEnergy=16
        TraceRange=(Min=3072,Max=3072)
        Damage=19.000000
        HeadMult=2.00
        LimbMult=0.75
        RangeAtten=0.5
        DamageType=Class'BallisticProV55.DTFifty9SMG'
        DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
        DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
        PenetrateForce=135
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
        FlashScaleFactor=0.500000
        Recoil=260.000000
        Inaccuracy=(X=72,Y=72)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-Fire',Volume=0.900000)
	    SplashDamage=False
	    RecommendSplashDamage=False
	    BotRefireRate=0.99
        WarnTargetPct=0.2
    End Object

    Begin Object Class=InstantEffectParams Name=BurstFireEffect
        DecayRange=(Min=525,Max=1225)
        PenetrationEnergy=16
        TraceRange=(Min=3072,Max=3072)
        Damage=19.000000
        HeadMult=2.00
        LimbMult=0.75
        RangeAtten=0.5
        DamageType=Class'BallisticProV55.DTFifty9SMG'
        DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
        DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
        PenetrateForce=135
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
        FlashScaleFactor=0.500000
        Recoil=210.000000 //
        Inaccuracy=(X=72,Y=72)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-Fire',Volume=0.900000)
	    SplashDamage=False
	    RecommendSplashDamage=False
	    BotRefireRate=0.99
        WarnTargetPct=0.2
    End Object

    Begin Object Class=InstantEffectParams Name=SuppFireEffect
        DecayRange=(Min=525,Max=1225)
        PenetrationEnergy=16
        TraceRange=(Min=3072,Max=3072)
        Damage=19.000000
        HeadMult=2.00
        LimbMult=0.75
        RangeAtten=0.5
        DamageType=Class'BallisticProV55.DTFifty9SMG'
        DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
        DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
        PenetrateForce=135
        bPenetrate=True
        Recoil=210.000000 //
        Inaccuracy=(X=72,Y=72)
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-FireSil',Volume=0.800000,Radius=48.000000,batten=false) //
	    SplashDamage=False
	    RecommendSplashDamage=False
	    BotRefireRate=0.99
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=BurstFireParams
        AimedFireAnim="SightFire"
        FireInterval=0.06
        BurstFireRateFactor=1
        FireEffectParams(0)=InstantEffectParams'BurstFireEffect'
    End Object

    Begin Object Class=FireParams Name=AutoFireParams
        AimedFireAnim="SightFire"
        FireInterval=0.072
        FireEffectParams(0)=InstantEffectParams'AutoFireEffect'
    End Object

    Begin Object Class=FireParams Name=SuppFireParams
        AimedFireAnim="SightFire"
        FireInterval=0.08
        FireEffectParams(0)=InstantEffectParams'SuppFireEffect'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=MeleeEffectParams Name=MeleeSwipeEffect
        Fatigue=0.090000
        TraceRange=(Min=150.000000,Max=150.000000)
        Damage=55.000000
        DamageType=Class'BallisticProV55.DTFifty9Blade'
        DamageTypeHead=Class'BallisticProV55.DTFifty9BladeHead'
        DamageTypeArm=Class'BallisticProV55.DTFifty9Blade'
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=0.5,Radius=12.000000,batten=false)
        SplashDamage=False
        RecommendSplashDamage=False
        BotRefireRate=0.99
        WarnTargetPct=0.3
    End Object

    Begin Object Class=FireParams Name=MeleeFireParams
        FireAnim="Melee1"
        FireAnimRate=1
        FireInterval=0.500000
        AmmoPerFire=0
        FireEffectParams(0)=MeleeEffectParams'MeleeSwipeEffect'
    End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Scope'
	End Object	

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaBurstRecoilParams
		XCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		MaxRecoil=6144
		ClimbTime=0.04
		DeclineDelay=0.14
		DeclineTime=1.1
		CrouchMultiplier=1
		HipMultiplier=1.5
		ViewBindFactor=0.2
	End Object

	Begin Object Class=RecoilParams Name=ArenaAutoRecoilParams
		XCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		MaxRecoil=6144
		ClimbTime=0.03 //
		DeclineDelay=0.14
		DeclineTime=1.1
		CrouchMultiplier=0.85 //
		HipMultiplier=1.5
		ViewBindFactor=0.2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=64,Max=256)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Bladed"
		//ADS
		SightingTime=0.2
		SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=128)
		//Stats
		DisplaceDurationMult=0.5
        MagAmmo=25        
		bDualBlocked=True
		InventorySize=3
		ReloadAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ArenaAutoRecoilParams'
        FireParams(0)=FireParams'AutoFireParams'
        AltFireParams(0)=FireParams'MeleeFireParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Burst
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
		SightingTime=0.2
		SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=128)
		//Stats
		DisplaceDurationMult=0.5
        MagAmmo=25        
		bDualBlocked=True
		InventorySize=3
		ReloadAnimRate=1.250000
		WeaponModes(0)=(ModeName="Burst",ModeID="WM_Burst",Value=5.000000)
		WeaponModes(1)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ArenaBurstRecoilParams'
        FireParams(0)=FireParams'BurstFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Supp
		//Layout core
		Weight=10
		LayoutName="Suppressed"
		LayoutTags="lock"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.Fifty9Tac_FPm'
        WeaponBoneScales(0)=(BoneName="StockWire",Slot=2,Scale=0f)
		//ADS
		SightingTime=0.2
		SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=128)
		//Stats
		DisplaceDurationMult=0.5
        MagAmmo=25        
		bDualBlocked=True
		InventorySize=3
		ReloadAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ArenaBurstRecoilParams'
        FireParams(0)=FireParams'SuppFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Burst'
    Layouts(2)=WeaponParams'ArenaParams_Supp'
	
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