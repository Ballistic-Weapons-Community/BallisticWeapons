class GRS9WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		PenetrationEnergy=16
        RangeAtten=0.5
        Damage=19
        HeadMult=2.00
        LimbMult=0.75
        DamageType=Class'BallisticProV55.DTGRS9Pistol'
        DamageTypeHead=Class'BallisticProV55.DTGRS9PistolHead'
        DamageTypeArm=Class'BallisticProV55.DTGRS9Pistol'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
        FlashScaleFactor=2.500000
        Recoil=270.000000
        Chaos=0.120000
        BotRefireRate=0.99
        WarnTargetPct=0.2
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Fire',Volume=1.200000)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.055
        FireEndAnim=
		BurstFireRateFactor=1
        //AimedFireAnim='SightFire'
        FireAnimRate=1.700000	
        FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
        RangeAtten=0.5
        Damage=18
        DamageType=Class'BallisticProV55.DTGRS9Laser'
        DamageTypeHead=Class'BallisticProV55.DTGRS9LaserHead'
        DamageTypeArm=Class'BallisticProV55.DTGRS9Laser'
        PenetrateForce=200
        bPenetrate=True
        Chaos=0.000000
        BotRefireRate=0.999000
        WarnTargetPct=0.010000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-LaserFire')
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		TargetState="CombatLaser"
        FireInterval=0.080000
        AmmoPerFire=0
        FireAnim="Idle"	
        FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
    End Object
	
	//Flash
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Flash
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
		EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Flash
		TargetState="Flash"
		FireInterval=4.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Flash'
	End Object
	
	//Laser Sight
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_LaserSight
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_LaserSight
		TargetState="LaserSight"
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.500000
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_LaserSight'
	End Object	
	
	//Stab
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=50.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTGRS9Tazer'
		DamageTypeHead=Class'BallisticProV55.DTGRS9Tazer'
		DamageTypeArm=Class'BallisticProV55.DTGRS9Tazer'
		//ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=64.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams_TacKnife'
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

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.35
        XCurve=(Points=(,(InVal=0.150000,OutVal=0.09),(InVal=0.300000,OutVal=-0.080000),(InVal=0.4,OutVal=0.04),(InVal=0.550000,OutVal=-0.090000),(InVal=0.700000,OutVal=0.050000),(InVal=1.000000,OutVal=0.00000)))
        YCurve=(Points=(,(InVal=0.200000,OutVal=0.25000),(InVal=0.450000,OutVal=0.450000),(InVal=0.650000,OutVal=0.75000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.10000
        YRandFactor=0.10000
        MaxRecoil=8192
		ClimbTime=0.04
		DeclineDelay=0.150000
        DeclineTime=0.75
		CrouchMultiplier=1
        HipMultiplier=1.5
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=2
        SprintChaos=0.050000
        AimAdjustTime=0.350000
        ChaosDeclineTime=0.450000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Combat Laser"
		Weight=30
		//ADS
		SightOffset=(X=-20,Y=-1.85,Z=26.7)
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		bDualBlocked=True
        DisplaceDurationMult=0.5
        MagAmmo=19
        InventorySize=3
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Flash
		//Layout core
		LayoutName="Flash Bulb"
		LayoutTags="no_combat_laser,flash"
		Weight=10
		//ADS
		SightOffset=(X=-20,Y=-1.85,Z=26.7)
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		bDualBlocked=True
        DisplaceDurationMult=0.5
        MagAmmo=19
        InventorySize=3
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Flash'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Auto
		//Layout core
		Weight=10
		LayoutName="Automatic"
		LayoutTags="no_combat_laser"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Laser",Slot=4,Scale=0f)
		//ADS
		SightOffset=(X=-20,Y=-1.85,Z=26.7)
		SightMoveSpeedFactor=0.9
		SightingTime=0.2000
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		bDualBlocked=True
        DisplaceDurationMult=0.5
        MagAmmo=19
        InventorySize=3
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
		bNoaltfire=True
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		Weight=10
		LayoutName="RDS + Laser"
		LayoutTags="no_combat_laser,target_laser"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Laser",Slot=4,Scale=0.1f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="Slide",AugmentOffset=(x=-15,y=-0.6,z=8),Scale=0.18,AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Laser',BoneName="Muzzle",AugmentOffset=(x=-20,y=-3,z=-20),Scale=0.25,AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		//ADS
		SightOffset=(X=-20,Y=-1.85,Z=28.65)
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		bDualBlocked=True
        DisplaceDurationMult=0.5
        MagAmmo=19
        InventorySize=3
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_LaserSight'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Tazer
		//Layout core
		Weight=10
		LayoutName="Tazer"
		LayoutTags="no_combat_laser,target_laser,tacknife"
		//Attachments
		WeaponBoneScales(0)=(BoneName="LAM",Slot=4,Scale=0)
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.GRS9Melee_FPm'
		//GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Laser',BoneName="Muzzle",AugmentOffset=(x=-20,y=-3,z=-20),Scale=0.25,AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		//ADS
		SightOffset=(X=0,Y=-0.3,Z=3.5)
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		bDualBlocked=True
        DisplaceDurationMult=0.5
        MagAmmo=19
        InventorySize=3
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_TacKnife'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_Flash'
	Layouts(2)=WeaponParams'ArenaParams_Auto'
	Layouts(3)=WeaponParams'ArenaParams_RDS'
	Layouts(4)=WeaponParams'ArenaParams_Tazer'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Glock_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Brown
		Index=1
		CamoName="Brown"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRSCamos.GlockFullBrown_Shine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Green
		Index=2
		CamoName="Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRSCamos.GlockGreen_Shine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Silver
		Index=3
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.GlockSilver_Shine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_UTC
		Index=4
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.UTCGlockShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.Glock_GoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'Glock_Black'
	Camos(1)=WeaponCamo'Glock_Brown'
	Camos(2)=WeaponCamo'Glock_Green'
	Camos(3)=WeaponCamo'Glock_Silver'
	Camos(4)=WeaponCamo'Glock_UTC'
	Camos(5)=WeaponCamo'Glock_Gold'
}