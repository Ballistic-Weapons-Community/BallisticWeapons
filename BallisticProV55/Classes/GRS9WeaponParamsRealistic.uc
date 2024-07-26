class GRS9WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000Max=4000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTGRS9Pistol'
		DamageTypeHead=Class'BallisticProV55.DTGRS9PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTGRS9Pistol'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Fire',Volume=1.200000)
		Recoil=512.000000
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Burst
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryBurstEffectParams
		TraceRange=(Min=800.000000Max=4000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTGRS9Pistol'
		DamageTypeHead=Class'BallisticProV55.DTGRS9PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTGRS9Pistol'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Fire',Volume=1.200000)
		Recoil=512.000000
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryBurstFireParams
		FireInterval=0.050000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryBurstEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
        RangeAtten=0.5
        Damage=8
        HeadMult=2
        LimbMult=0.75
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

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		TargetState="CombatLaser"
        FireInterval=0.080000
        AmmoPerFire=0
        FireAnim="Idle"	
        FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
    End Object
	
	//Flash
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Flash
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
		EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Flash
		TargetState="Flash"
		FireInterval=4.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Flash'
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
	
	//Stab
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams_TacKnife
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
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams_TacKnife'
	End Object	
	
	//Scope
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.000000
		XRandFactor=0.4000000
		YRandFactor=0.400000
		MaxRecoil=2048.000000
		DeclineTime=0.400000
		DeclineDelay=0.120000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//Burst
	Begin Object Class=RecoilParams Name=RealisticBurstRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.4000000
		YRandFactor=0.400000
		MaxRecoil=2048.000000
		DeclineTime=0.600000
		DeclineDelay=0.180000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=800.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Combat Laser"
		Weight=30
		WeaponPrice=1400
		//ADS
		SightOffset=(X=-20,Y=-1.85,Z=26.7)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=19
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",RecoilParamsIndex=1,bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="GRS9-L2 9mm Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(2)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Flash
		//Layout core
		LayoutName="Flash Bulb"
		LayoutTags="no_combat_laser,flash"
		Weight=10
		//ADS
		SightOffset=(X=-20,Y=-1.85,Z=26.7)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=19
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",RecoilParamsIndex=1,bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="GRS9-L2 9mm Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(2)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Flash'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Auto
		//Layout core
		Weight=10
		LayoutName="Automatic"
		LayoutTags="no_combat_laser"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Laser",Slot=4,Scale=0f)
		//ADS
		SightOffset=(X=-20,Y=-1.85,Z=26.7)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.11
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=19
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1,bUnavailable=True)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		InitialWeaponMode=2
		WeaponName="GRS9-L3 9mm Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(2)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
		bNoaltfire=True
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_RDS
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
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		bAdjustHands=true
		RootAdjust=(Yaw=-300,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=19
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",RecoilParamsIndex=1,bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="GRS9-L2 9mm Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(2)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_LaserSight'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Tazer
		//Layout core
		Weight=10
		LayoutName="Tazer"
		LayoutTags="no_combat_laser,target_laser,tacknife"
		//Attachments
		WeaponBoneScales(0)=(BoneName="LAM",Slot=4,Scale=0)
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_GRS9Melee'
		//GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Laser',BoneName="Muzzle",AugmentOffset=(x=-20,y=-3,z=-20),Scale=0.25,AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		//ADS
		SightOffset=(X=0,Y=-0.3,Z=3.5)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=19
		bMagPlusOne=True
		bDualBlocked=true
		bDualMixing=false
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",RecoilParamsIndex=1,bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="GRS9-L2 9mm Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(2)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_TacKnife'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Flash'
	Layouts(2)=WeaponParams'RealisticParams_Auto'
	Layouts(3)=WeaponParams'RealisticParams_RDS'
	Layouts(4)=WeaponParams'RealisticParams_Tazer'
	
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