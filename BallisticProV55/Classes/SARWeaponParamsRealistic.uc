class SARWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000) //5.56mm Short Barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.0500000
		Damage=43.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrationEnergy=16.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Pitch=1.250000,Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=775.000000
		Chaos=0.05000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.2000000	
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryBurstEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000) //5.56mm Short Barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.0500000
		Damage=43.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrationEnergy=16.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Pitch=1.250000,Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=825.000000
		Chaos=0.05000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryBurstFireParams
		FireInterval=0.060000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.2000000	
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryBurstEffectParams'
	End Object
	
	//Supp
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Supp
		TraceRange=(Min=1200.000000,Max=4800.000000) //5.56mm Short Barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.0500000
		Damage=43.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrationEnergy=16.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.400000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50FireSil',Volume=1.200000,Pitch=1.1,Radius=192.000000,bAtten=True) //
		Recoil=775.000000 //
		Chaos=0.07000 //
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Supp
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.2000000	
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Supp'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Flash
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		TargetState="Flash"
		FireInterval=7.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim=
		FireEndAnim=
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Laser
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
	
	//Combat Laser
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams_CombatLaser
		TraceRange=(Min=1500.000000,Max=6000.000000)
		WaterTraceRange=4200.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.10000
		Damage=8.0
		HeadMult=2.5
		LimbMult=0.375
		DamageType=Class'BallisticProV55.DTSARLaser'
		DamageTypeHead=Class'BallisticProV55.DTSARLaserHead'
		DamageTypeArm=Class'BallisticProV55.DTSARLaser'
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
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.50000,OutVal=0.350000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.15000
		XRandFactor=0.165000
		YRandFactor=0.165000
		MaxRecoil=3000.000000
		DeclineTime=0.750000
		DeclineDelay=0.175000
		ViewBindFactor=0.060000
		ADSViewBindFactor=0.060000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	Begin Object Class=RecoilParams Name=RealisticBurstRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.50000,OutVal=0.350000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		XCurveAlt=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurveAlt=(Points=(,(InVal=0.50000,OutVal=0.150000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.10000
		XRandFactor=0.125000 //
		YRandFactor=0.125000 //
		MaxRecoil=3000.000000
		DeclineTime=0.600000 //
		DeclineDelay=0.125000 //
		ViewBindFactor=0.060000
		ADSViewBindFactor=0.060000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
		bUseAltSightCurve=True
	End Object
	
	Begin Object Class=RecoilParams Name=RealisticBurstRecoilParams_Scope
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.50000,OutVal=0.350000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		XCurveAlt=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurveAlt=(Points=(,(InVal=0.50000,OutVal=0.150000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.10000
		XRandFactor=0.125000 //
		YRandFactor=0.125000 //
		MaxRecoil=3000.000000
		DeclineTime=0.600000 //
		DeclineDelay=0.125000 //
		ViewBindFactor=0.060000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
		bUseAltSightCurve=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.060000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-2048);
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=565.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Flash Bulb"
		Weight=30
		// ADS handling
        SightingTime=0.220000
		SightMoveSpeedFactor=0.5
		SightOffset=(X=0.000000,Y=-0.010000,Z=-1.000000)
		//Stats
		InventorySize=6
		WeaponPrice=1500
		MagAmmo=35
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponName="AC-12F 5.56mm Assault Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
        AimParams(1)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_CombatLaser
		//Layout core
		LayoutName="Combat Laser"
		LayoutTags="combat_laser"
		Weight=10
		// ADS handling
		SightMoveSpeedFactor=0.500000
		SightingTime=0.22
		SightOffset=(X=0.000000,Y=-0.010000,Z=-1.000000)
		//Stats
		InventorySize=6
		WeaponPrice=1500
		MagAmmo=35
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponName="AC-12L 5.56mm Assault Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
        AimParams(1)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_CombatLaser'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Scope
		//Layout
		LayoutName="3X Scope"
		LayoutTags="target_laser, lock_stock"
		Weight=10
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Muzzle",Scale=0.12,AugmentOffset=(x=-220,y=-0,z=26))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
		// Zoom
		ZoomType=ZT_Fixed
		MaxZoom=3
		// ADS handling
		SightingTime=0.3 //+0.8
		SightMoveSpeedFactor=0.500000
		SightOffset=(X=11.000000,Y=-0.010000,Z=3.600000)
		//Stats
		InventorySize=6
		WeaponPrice=1500
		MagAmmo=35
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		InitialWeaponMode=1
		WeaponName="AC-12 5.56mm Assault Carbine (3X)"
		RecoilParams(0)=RecoilParams'RealisticBurstRecoilParams_Scope'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
        AimParams(1)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_LaserSight'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Supp
		//Layout
		LayoutName="Suppressor"
		LayoutTags="target_laser"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.3,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		// ADS handling
		SightMoveSpeedFactor=0.500000
		SightingTime=0.22
		SightOffset=(X=0.000000,Y=-0.010000,Z=-1.000000)
		//Stats
		InventorySize=6
		WeaponPrice=1500
		MagAmmo=35
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		InitialWeaponMode=1
		WeaponName="AC-12 5.56mm Assault Carbine (3X)"
		RecoilParams(0)=RecoilParams'RealisticBurstRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
        AimParams(1)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Supp'
		FireParams(1)=FireParams'RealisticPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_LaserSight'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_CombatLaser'
	Layouts(2)=WeaponParams'RealisticParams_Scope'
	Layouts(3)=WeaponParams'RealisticParams_Supp'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=SAR_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SAR_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SARCamos.AAS-Shiny",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=SAR_Gray
		Index=2
		CamoName="Gray"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SARCamos.SAR15-Shiny",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=SAR_Black
		Index=3
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SARCamos.DSARSkin-Shiny",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SAR_Ocean
		Index=4
		CamoName="Ocean"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SARCamos.CSARSkin-Shiny",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'SAR_Green'
	Camos(1)=WeaponCamo'SAR_Desert'
	Camos(2)=WeaponCamo'SAR_Gray'
	Camos(3)=WeaponCamo'SAR_Black'
	Camos(4)=WeaponCamo'SAR_Ocean'
}