class AM67WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaPriEffectParams
        DecayRange=(Min=1050,Max=2100)
        PenetrationEnergy=16
        Damage=60.000000
        HeadMult=2.00
        LimbMult=0.75
        RangeAtten=0.5
        DamageType=Class'BallisticProV55.DTAM67Pistol'
        DamageTypeHead=Class'BallisticProV55.DTAM67PistolHead'
        DamageTypeArm=Class'BallisticProV55.DTAM67Pistol'
        PenetrateForce=200
        bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
        FlashScaleFactor=0.900000
        Recoil=1536.000000
        Chaos=0.2
        Inaccuracy=(X=16,Y=16)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Fire',Volume=1.100000)
        WarnTargetPct=0.400000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaPriFireParams
        FireEndAnim=
        FireInterval=0.5
        FireEffectParams(0)=InstantEffectParams'ArenaPriEffectParams'
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	//Flash
    Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Flash
        MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
        WarnTargetPct=1.000000
        BotRefireRate=0.3
        EffectString="Blinding flash"
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Flash
		TargetState="Flash"
        MaxHoldTime=0.500000
        FireAnim="Idle"
        FireEndAnim=
        FireInterval=10.000000
        AmmoPerFire=0
        FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Flash'
    End Object
	
	//Combat Laser
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams_CombatLaser
		TraceRange=(Min=1500.000000,Max=6000.000000)
		WaterTraceRange=4200.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.10000
		Damage=8.0
		HeadMult=2.5
		LimbMult=0.375
		DamageType=Class'BallisticProV55.DTAM67Laser'
		DamageTypeHead=Class'BallisticProV55.DTAM67LaserHead'
		DamageTypeArm=Class'BallisticProV55.DTAM67Laser'
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.GRS9LaserFlashEmitter'
		FlashScaleFactor=0.700000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-LaserFire')
		Recoil=0.0
		Chaos=0.000000
		Inaccuracy=(X=2,Y=2)
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_CombatLaser
		TargetState="CombatLaser"
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams_CombatLaser'
	End Object
	
	//Laser
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

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.5
        XCurve=(Points=(,(InVal=0.1,OutVal=0.00),(InVal=0.2,OutVal=-0.06),(InVal=0.3,OutVal=-0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=-0.02000),(InVal=0.600000,OutVal=0.06),(InVal=0.700000,OutVal=0.01),(InVal=0.800000,OutVal=-0.04000),(InVal=1.000000,OutVal=0.0)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
        MaxRecoil=8192.000000
        XRandFactor=0.10000
        YRandFactor=0.10000
		ClimbTime=0.1
		DeclineDelay=0.45
        DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=16,Max=128)
        AimAdjustTime=0.450000
        ADSMultiplier=1
        JumpChaos=0.200000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=500.000000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Flash Bulb"
		Weight=7
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		//ADS
		SightingTime=0.250000
		SightMoveSpeedFactor=0.9
		SightOffset=(X=-24,Y=0.06,Z=2.5)
		//Function
        ReloadAnimRate=1.250000
		CockAnimRate=1.250000
        DisplaceDurationMult=0.75
        MagAmmo=9
        InventorySize=4
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Flash'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		LayoutName="RDS + Lasersight"
		Weight=2
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=1f)
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.25
		SightOffset=(X=-24,Y=0.06,Z=4.43)
		//Function
        ReloadAnimRate=1.250000
		CockAnimRate=1.250000
        DisplaceDurationMult=0.75
        MagAmmo=9
        InventorySize=4
		bDualBlocked=True
		bNoaltfire=true
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams_LaserSight'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_CombatLaser
		//Layout core
		LayoutName="Combat Laser"
		LayoutTags="combat_laser"
		Weight=2
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		// ADS handling
		SightMoveSpeedFactor=0.9
		SightingTime=0.25
		SightOffset=(X=-24,Y=0.06,Z=2.5)
		//Stats
        ReloadAnimRate=1.250000
		CockAnimRate=1.250000
        DisplaceDurationMult=0.75
        MagAmmo=9
        InventorySize=4
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams_CombatLaser'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_RDS'
    Layouts(2)=WeaponParams'ArenaParams_CombatLaser'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=AM67_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AM67_Gray
		Index=1
		CamoName="Pounder"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AM67Camos.AM67.AH104-MainMk2",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AM67_Silver
		Index=2
		CamoName="Special Edition"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AM67Camos.AH999-Main",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'AM67_Green'
	Camos(1)=WeaponCamo'AM67_Gray'
	Camos(2)=WeaponCamo'AM67_Silver'
}