class SARWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaAutoEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1250,Max=3750)
		PenetrationEnergy=16
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=180.000000
		Chaos=0.022000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaAutoFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaAutoEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaBurstEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1250,Max=3750)
		PenetrationEnergy=16
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=180.000000
		Chaos=0.030000 //
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaBurstFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaBurstEffectParams'
	End Object

	//Supp
	Begin Object Class=InstantEffectParams Name=ArenaFireEffectParams_Supp
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1250,Max=3750)
		PenetrationEnergy=16
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		Recoil=170.000000
		Chaos=0.03000 //
		WarnTargetPct=0.200000
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.400000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50FireSil',Volume=1.200000,Pitch=1.1,Radius=192.000000,bAtten=True) //
	End Object

	Begin Object Class=FireParams Name=ArenaFireParams_Supp
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaFireEffectParams_Supp'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Flash
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		BotRefireRate=0.300000
        EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		TargetState="Flash"
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.500000
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
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
	
	//Combat Laser
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams_CombatLaser
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

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_CombatLaser
		TargetState="CombatLaser"
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams_CombatLaser'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaAutoRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.30000,OutVal=-0.030000),(InVal=0.4500000,OutVal=-0.050000),(InVal=0.600000,OutVal=0.060000),(InVal=0.800000,OutVal=0.04000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		ClimbTime=0.04
		DeclineDelay=0.13
		DeclineTime=0.75
		CrouchMultiplier=0.85
		ViewBindFactor=0.35
		HipMultiplier=1.25
	End Object

	Begin Object Class=RecoilParams Name=ArenaBurstRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.30000,OutVal=-0.030000),(InVal=0.4500000,OutVal=-0.050000),(InVal=0.600000,OutVal=0.060000),(InVal=0.800000,OutVal=0.04000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		ClimbTime=0.04
		DeclineDelay=0.13
		DeclineTime=0.75
		CrouchMultiplier=1
		ViewBindFactor=0.45
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=AutoAimParams
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.6
		AimSpread=(Min=64,Max=512)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=BurstAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.45
		AimSpread=(Min=48,Max=378)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Flash Bulb"
		Weight=30
		// ADS handling
        SightingTime=0.250000
		SightMoveSpeedFactor=0.8
		//Stats
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightPivot=(Pitch=450)
		MagAmmo=30
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaAutoRecoilParams'
        RecoilParams(1)=RecoilParams'ArenaBurstRecoilParams'
        AimParams(0)=AimParams'AutoAimParams'
        AimParams(1)=AimParams'BurstAimParams'
		FireParams(0)=FireParams'ArenaAutoFireParams'
		FireParams(1)=FireParams'ArenaBurstFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_CombatLaser
		//Layout core
		LayoutName="Combat Laser"
		LayoutTags="combat_laser"
		Weight=5
		// ADS handling
        SightingTime=0.250000
		SightMoveSpeedFactor=0.8
		//Stats
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightPivot=(Pitch=450)
		MagAmmo=30
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaAutoRecoilParams'
        RecoilParams(1)=RecoilParams'ArenaBurstRecoilParams'
        AimParams(0)=AimParams'AutoAimParams'
        AimParams(1)=AimParams'BurstAimParams'
		FireParams(0)=FireParams'ArenaAutoFireParams'
		FireParams(1)=FireParams'ArenaBurstFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_CombatLaser'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Scope
		//Layout
		LayoutName="3X Scope"
		LayoutTags="target_laser, lock_stock"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Muzzle",Scale=0.12,AugmentOffset=(x=-220,y=-0,z=26))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
		// Zoom
		ZoomType=ZT_Fixed
		MaxZoom=3
		// ADS handling
		SightingTime=0.3 //+0.5
		SightMoveSpeedFactor=0.350000
		//Stats
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightPivot=(Pitch=450)
		MagAmmo=30
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaAutoRecoilParams'
        RecoilParams(1)=RecoilParams'ArenaBurstRecoilParams'
        AimParams(0)=AimParams'AutoAimParams'
        AimParams(1)=AimParams'BurstAimParams'
		FireParams(0)=FireParams'ArenaAutoFireParams'
		FireParams(1)=FireParams'ArenaBurstFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_LaserSight'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Supp
		//Layout
		LayoutName="Suppressor"
		LayoutTags="target_laser"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.3,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		// ADS handling
        SightingTime=0.250000
		SightMoveSpeedFactor=0.8
		//Stats
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightPivot=(Pitch=450)
		MagAmmo=30
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaAutoRecoilParams'
        RecoilParams(1)=RecoilParams'ArenaBurstRecoilParams'
        AimParams(0)=AimParams'AutoAimParams'
        AimParams(1)=AimParams'BurstAimParams'
		FireParams(0)=FireParams'ArenaFireParams_Supp'
		FireParams(1)=FireParams'ArenaFireParams_Supp'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_LaserSight'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_CombatLaser'
	Layouts(2)=WeaponParams'ArenaParams_Scope'
	Layouts(3)=WeaponParams'ArenaParams_Supp'
	
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