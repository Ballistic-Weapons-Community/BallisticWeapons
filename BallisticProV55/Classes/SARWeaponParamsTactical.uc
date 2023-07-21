class SARWeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalAutoEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1575,Max=4725) // 30-90m
		RangeAtten=0.5
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=180.000000
		Chaos=0.022000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalAutoFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalAutoEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalBurstEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1575,Max=4725) // 30-90m
		PenetrationEnergy=16
		RangeAtten=0.5
		Damage=34
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=180.000000
		Chaos=0.030000 //
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalBurstFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalBurstEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalFireEffectParams_Supp
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1575,Max=4725) // 30-90m
		RangeAtten=0.5
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		Recoil=175.000000 //
		Chaos=0.03000 //
		WarnTargetPct=0.200000
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.400000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50FireSil',Volume=1.200000,Pitch=1.1,Radius=192.000000,bAtten=True) //
	End Object

	Begin Object Class=FireParams Name=TacticalFireParams_Supp
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalFireEffectParams_Supp'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Flash
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		BotRefireRate=0.300000
        EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		TargetState="Flash"
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.5
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
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
	
	//Combat Laser
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams_CombatLaser
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

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_CombatLaser
		TargetState="CombatLaser"
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams_CombatLaser'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalStockOutRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.30000,OutVal=-0.030000),(InVal=0.4500000,OutVal=-0.050000),(InVal=0.600000,OutVal=0.060000),(InVal=0.800000,OutVal=0.04000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.13
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalStockOutRecoilParams_Scope
		ViewBindFactor=0.15
		ADSViewBindFactor=1.0 //
		EscapeMultiplier=1.0 //
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.30000,OutVal=-0.030000),(InVal=0.4500000,OutVal=-0.050000),(InVal=0.600000,OutVal=0.060000),(InVal=0.800000,OutVal=0.04000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.13
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalStockInRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.30000,OutVal=-0.030000),(InVal=0.4500000,OutVal=-0.050000),(InVal=0.600000,OutVal=0.060000),(InVal=0.800000,OutVal=0.04000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05 //
		YRandFactor=0.05 //
		ClimbTime=0.04
		DeclineDelay=0.13
		DeclineTime=0.75
		CrouchMultiplier=1 //
		HipMultiplier=1.25
		MaxMoveMultiplier=2.0 //
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalStockOutAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=256,Max=1024)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalStockInAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.7
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.5
		AimSpread=(Min=256,Max=768)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Flash Bulb"
		Weight=30
		// ADS handling
        SightingTime=0.35
		SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=450)
		//Stats
		MagAmmo=30
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalStockOutRecoilParams'
        RecoilParams(1)=RecoilParams'TacticalStockInRecoilParams'
        AimParams(0)=AimParams'TacticalStockOutAimParams'
        AimParams(1)=AimParams'TacticalStockInAimParams'
		FireParams(0)=FireParams'TacticalAutoFireParams'
		FireParams(1)=FireParams'TacticalBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_CombatLaser
		//Layout core
		LayoutName="Combat Laser"
		LayoutTags="combat_laser"
		Weight=10
		// ADS handling
        SightingTime=0.35
		SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=450)
		//Stats
		MagAmmo=30
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalStockOutRecoilParams'
        RecoilParams(1)=RecoilParams'TacticalStockInRecoilParams'
        AimParams(0)=AimParams'TacticalStockOutAimParams'
        AimParams(1)=AimParams'TacticalStockInAimParams'
		FireParams(0)=FireParams'TacticalAutoFireParams'
		FireParams(1)=FireParams'TacticalBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_CombatLaser'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_Scope
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
		SightingTime=0.4 //+0.5
		SightMoveSpeedFactor=0.350000
		SightPivot=(Pitch=0)
		//Stats
		MagAmmo=30
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalStockOutRecoilParams_Scope'
        RecoilParams(1)=RecoilParams'TacticalStockOutRecoilParams_Scope'
        AimParams(0)=AimParams'TacticalStockOutAimParams'
        AimParams(1)=AimParams'TacticalStockInAimParams'
		FireParams(0)=FireParams'TacticalAutoFireParams'
		FireParams(1)=FireParams'TacticalBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_LaserSight'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_Supp
		//Layout
		LayoutName="Suppressor"
		LayoutTags="target_laser"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.3,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		// ADS handling
        SightingTime=0.35
		SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=450)
		//Stats
		MagAmmo=30
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalStockOutRecoilParams_Scope'
        RecoilParams(1)=RecoilParams'TacticalStockOutRecoilParams_Scope'
        AimParams(0)=AimParams'TacticalStockOutAimParams'
        AimParams(1)=AimParams'TacticalStockInAimParams'
		FireParams(0)=FireParams'TacticalFireParams_Supp'
		FireParams(1)=FireParams'TacticalFireParams_Supp'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_LaserSight'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
	Layouts(1)=WeaponParams'TacticalParams_CombatLaser'
	Layouts(2)=WeaponParams'TacticalParams_Scope'
	Layouts(3)=WeaponParams'TacticalParams_Supp'
	
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