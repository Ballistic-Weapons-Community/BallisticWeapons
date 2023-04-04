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
        DecayRange=(Min=1250,Max=3750)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.75f
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
        DecayRange=(Min=1250,Max=3750)
		PenetrationEnergy=16
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=128.000000
		Chaos=0.030000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalBurstFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalBurstEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		BotRefireRate=0.300000
        EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.5
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalStockOutRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.75
		ViewBindFactor=0.35
		ADSViewBindFactor=0.85
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
		DeclineDelay=0.13
	End Object

	Begin Object Class=RecoilParams Name=TacticalStockInRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.75
		ViewBindFactor=0.45
		ADSViewBindFactor=0.7
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2
		DeclineDelay=0.13
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalStockOutAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalStockInAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.45
		AimSpread=(Min=256,Max=768)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		SightPivot=(Pitch=450)
		SightOffset=(X=35.000000,Y=-0.010000,Z=13.600000)
		MagAmmo=32
        InventorySize=6
        SightingTime=0.35 // adjust the factor with stock mode
        SightMoveSpeedFactor=0.6
        RecoilParams(0)=RecoilParams'TacticalStockOutRecoilParams'
        RecoilParams(1)=RecoilParams'TacticalStockInRecoilParams'
        AimParams(0)=AimParams'TacticalStockOutAimParams'
        AimParams(1)=AimParams'TacticalStockInAimParams'
		FireParams(0)=FireParams'TacticalAutoFireParams'
		FireParams(1)=FireParams'TacticalBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
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