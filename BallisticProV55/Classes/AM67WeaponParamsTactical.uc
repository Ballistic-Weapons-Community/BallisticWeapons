class AM67WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=TacticalPriEffectParams
        DecayRange=(Min=1050,Max=3150) // 20-60m
        PenetrationEnergy=16
        Damage=60.000000 // .50
        HeadMult=3
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
        Inaccuracy=(X=128,Y=128)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Fire',Volume=1.100000)
        WarnTargetPct=0.400000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=TacticalPriFireParams
        FireEndAnim=
        FireInterval=0.5
        FireEffectParams(0)=InstantEffectParams'TacticalPriEffectParams'
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	//Flash
    Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Flash
        MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
        WarnTargetPct=1.000000
        BotRefireRate=0.3
        EffectString="Blinding flash"
    End Object

    Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Flash
        MaxHoldTime=0.5
        FireAnim="Idle"
        FireEndAnim=
        FireInterval=10.000000
        AmmoPerFire=0
        FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Flash'
    End Object
	
	//Combat Laser
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams_CombatLaser
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

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_CombatLaser
		TargetState="CombatLaser"
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams_CombatLaser'
	End Object
	
	//Laser
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_LaserSight
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_LaserSight
		TargetState="LaserSight"
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.500000
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_LaserSight'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.35
        XCurve=(Points=(,(InVal=0.1,OutVal=0.00),(InVal=0.2,OutVal=-0.06),(InVal=0.3,OutVal=-0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=-0.02000),(InVal=0.600000,OutVal=0.06),(InVal=0.700000,OutVal=0.01),(InVal=0.800000,OutVal=-0.04000),(InVal=1.000000,OutVal=0.0)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.1
		YRandFactor=0.1
		MaxRecoil=8192
		ClimbTime=0.08
		DeclineDelay=0.45
        DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0.0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        JumpChaos=0.200000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Flash Bulb"
		Weight=7
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		//ADS
        SightingTime=0.2
        SightMoveSpeedFactor=0.6
		SightOffset=(X=-24,Y=0.06,Z=2.5)
		//Function
        DisplaceDurationMult=0.75
        MagAmmo=9
        InventorySize=4
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalPriFireParams'
        AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Flash'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		LayoutName="RDS + Lasersight"
		Weight=2
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=1f)
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.2
		SightOffset=(X=-24,Y=0.06,Z=4.43)
		//Function
        DisplaceDurationMult=0.75
        MagAmmo=9
        InventorySize=4
		bDualBlocked=True
		bNoaltfire=true
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalPriFireParams'
        AltFireParams(0)=FireParams'TacticalSecondaryFireParams_LaserSight'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_CombatLaser
		//Layout core
		LayoutName="Combat Laser"
		LayoutTags="combat_laser"
		Weight=2
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		// ADS handling
		SightMoveSpeedFactor=0.6
		SightingTime=0.2
		SightOffset=(X=-24,Y=0.06,Z=2.5)
		//Stats
        DisplaceDurationMult=0.75
        MagAmmo=9
        InventorySize=4
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalPriFireParams'
        AltFireParams(0)=FireParams'TacticalSecondaryFireParams_CombatLaser'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_RDS'
    Layouts(2)=WeaponParams'TacticalParams_CombatLaser'
	
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