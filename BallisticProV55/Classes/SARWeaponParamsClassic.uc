class SARWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Auto
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=25.0
		HeadMult=3.3
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=96.000000
		Chaos=0.040000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Burst
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryBurstEffectParams
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=25
		HeadMult=3.3
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=128.000000
		Chaos=0.030000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryBurstFireParams
		FireInterval=0.1
		BurstFireRateFactor=1.00
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryBurstEffectParams'
	End Object
	
	//Auto
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Supp
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=25.0
		HeadMult=3.3
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.400000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50FireSil',Volume=1.200000,Pitch=1.1,Radius=192.000000,bAtten=True) //
		Recoil=96.000000
		Chaos=0.040000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Supp
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Supp'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Flash
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		TargetState="Flash"
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.500000
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Laser
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_LaserSight
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_LaserSight
		TargetState="LaserSight"
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.500000
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_LaserSight'
	End Object
	
	//Combat Laser
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams_CombatLaser
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_CombatLaser
		TargetState="CombatLaser"
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams_CombatLaser'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		YawFactor=1.000000
		MaxRecoil=3840.000000
		DeclineTime=0.800000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicBurstRecoilParams
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.15 //
		YRandFactor=0.15 //
		YawFactor=0.700000 //

		MaxRecoil=3840.000000
		DeclineTime=0.7 //
		ViewBindFactor=0.45
		HipMultiplier=1.000000
		CrouchMultiplier=0.7 //
		//DeclineDelay=0.14 //
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2560)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.900000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1200.000000
		ChaosTurnThreshold=170000.000000
	End Object
	
	Begin Object Class=AimParams Name=ClassicBurstAimParams
		AimSpread=(Min=32,Max=2560)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.700000 //
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.200000 //
		ChaosSpeedThreshold=960.000000 //
		ChaosTurnThreshold=131072.000000 //
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Flash Bulb"
		Weight=30
		// ADS handling
		SightMoveSpeedFactor=0.500000
		SightingTime=0.320000
		SightPivot=(Pitch=450)
		//Stats
		InventorySize=6
		bNeedCock=True
		MagAmmo=40
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1,AimParamsIndex=1)
		ViewOffset=(X=12.000000,Y=12.000000,Z=-7.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        RecoilParams(1)=RecoilParams'ClassicBurstRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ClassicBurstAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_CombatLaser
		//Layout core
		LayoutName="Combat Laser"
		LayoutTags="combat_laser"
		Weight=5
		// ADS handling
		SightMoveSpeedFactor=0.500000
		SightingTime=0.320000
		SightPivot=(Pitch=450)
		//Stats
		InventorySize=6
		bNeedCock=True
		MagAmmo=40
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1,AimParamsIndex=1)
		ViewOffset=(X=12.000000,Y=12.000000,Z=-7.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        RecoilParams(1)=RecoilParams'ClassicBurstRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ClassicBurstAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_CombatLaser'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Scope
		//Layout
		LayoutName="3X Scope"
		LayoutTags="target_laser, lock_stock"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Muzzle",Scale=0.12,AugmentOffset=(x=-220,y=-0,z=26))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
		// Zoom
		ZoomType=ZT_Fixed
		MaxZoom=4
		// ADS handling
		SightingTime=0.40 //+0.5
		SightMoveSpeedFactor=0.500000
		SightPivot=(Pitch=450)
		//Stats
		InventorySize=6
		bNeedCock=True
		MagAmmo=40
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1,AimParamsIndex=1)
		ViewOffset=(X=12.000000,Y=12.000000,Z=-7.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        RecoilParams(1)=RecoilParams'ClassicBurstRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ClassicBurstAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_LaserSight'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Supp
		//Layout
		LayoutName="Suppressor"
		LayoutTags="target_laser"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.3,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		// ADS handling
		SightingTime=0.32
		SightMoveSpeedFactor=0.500000
		SightPivot=(Pitch=450)
		//Stats
		InventorySize=6
		bNeedCock=True
		MagAmmo=40
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1,AimParamsIndex=1)
		ViewOffset=(X=12.000000,Y=12.000000,Z=-7.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        RecoilParams(1)=RecoilParams'ClassicBurstRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ClassicBurstAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Supp'
		FireParams(1)=FireParams'ClassicPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_LaserSight'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_CombatLaser'
	Layouts(2)=WeaponParams'ClassicParams_Scope'
	Layouts(3)=WeaponParams'ClassicParams_Supp'
	
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