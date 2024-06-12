class AM67WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=5000.000000,Max=5000.000000) //.50
		WaterTraceRange=5000.0
		DecayRange=(Min=1000.0,Max=5000.0)
		Damage=70.0
		HeadMult=2.3f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTAM67Pistol'
		DamageTypeHead=Class'BallisticProV55.DTAM67PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTAM67Pistol'
		PenetrationEnergy=12.000000
		PenetrateForce=40
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.900000
		FireSound=(sound=sound'BW_Core_WeaponSound.AM67.AM67-Fire',Pitch=1.100000,Volume=1.400000)
		Recoil=1024.000000
		Chaos=0.090000
		Inaccuracy=(X=32,Y=32)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.270000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.750000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Flash
    Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Flash
        MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
        WarnTargetPct=1.000000
        BotRefireRate=0.3
        EffectString="Blinding flash"
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Flash
		TargetState="Flash"
        MaxHoldTime=0.500000
        FireAnim="Idle"
        FireEndAnim=
        FireInterval=10.000000
        AmmoPerFire=0
        FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Flash'
    End Object
	
	//Combat Laser
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams_CombatLaser
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

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_CombatLaser
		TargetState="CombatLaser"
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams_CombatLaser'
	End Object
	
	//Laser Sight
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_LaserSight
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_LaserSight
		TargetState="LaserSight"
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.500000
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_LaserSight'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.40000),(InVal=7.00000,OutVal=0.50000),(InVal=1.00000,OutVal=0.40000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=3072.000000
		DeclineTime=0.600000
		DeclineDelay=0.175000
		ViewBindFactor=0.400000
		ADSViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1152)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-5000)
		FallingChaos=0.400000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Flash Bulb"
		Weight=7
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.17
		SightOffset=(X=-24,Y=0.06,Z=2.5)
		//Function
		PlayerSpeedFactor=1.100000
        InventorySize=4
		MagAmmo=9
		bMagPlusOne=True
		//ViewOffset=(X=9.000000,Y=7.000000,Z=-7.000000)
		//SightOffset=(X=-12.000000,Y=-1.1750000,Z=14.150000)
		//SightPivot=(Pitch=-160,Roll=-465)
		//bAdjustHands=true
		//RootAdjust=(Yaw=-280,Pitch=2500)
		//WristAdjust=(Yaw=-2500,Pitch=-000)
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=true)
		WeaponModes(2)=(bUnavailable=true)
		InitialWeaponMode=0
		WeaponName="AM67 .50 Assault Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Flash'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_RDS
		//Layout core
		LayoutName="RDS + Lasersight"
		Weight=2
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=1f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.17
		SightOffset=(X=-24,Y=0.06,Z=4.43)
		//Function
		PlayerSpeedFactor=1.100000
        InventorySize=4
		MagAmmo=9
		bMagPlusOne=True
		bDualBlocked=True
		InitialWeaponMode=0
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=true)
		WeaponModes(2)=(bUnavailable=true)
		WeaponName="AM67 .50 Assault Pistol (RDS)"
		bNoaltfire=true
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_LaserSight'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_CombatLaser
		//Layout core
		LayoutName="Combat Laser"
		LayoutTags="combat_laser"
		Weight=2
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		// ADS handling
		SightMoveSpeedFactor=0.5
		SightingTime=0.17
		SightOffset=(X=-24,Y=0.06,Z=2.5)
		//Stats
		PlayerSpeedFactor=1.100000
        InventorySize=4
		MagAmmo=9
		bMagPlusOne=True
		bDualBlocked=True
		InitialWeaponMode=0
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=true)
		WeaponModes(2)=(bUnavailable=true)
		WeaponName="AM67 .50 Assault Pistol (RDS)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_CombatLaser'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_RDS'
	Layouts(2)=WeaponParams'RealisticParams_CombatLaser'
	
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