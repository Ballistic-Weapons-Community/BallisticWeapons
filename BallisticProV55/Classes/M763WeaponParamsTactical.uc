class M763WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
        DecayRange=(Min=1312,Max=3938)
		RangeAtten=0.15
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=13
        HeadMult=1.75f
        LimbMult=0.85f
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=2048.000000
		Chaos=0.30000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		Inaccuracy=(X=200,Y=200)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.85
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		bCockAfterFire=True
		FireAnimRate=0.9	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=768.000000,Max=768.000000)
		RangeAtten=0.25
		Damage=35
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrateForce=100
		bPenetrate=True
		FlashScaleFactor=2.000000
		Recoil=1280.000000
		Chaos=0.5
		BotRefireRate=0.3
		WarnTargetPct=0.75
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		TargetState="GasSpray"
		FireInterval=0.750000
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.100000	
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.2
		YRandFactor=0.2
		MaxRecoil=8192
		DeclineTime=0.75
		DeclineDelay=0.55
		ClimbTime=0.075
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.25
		AimAdjustTime=0.6
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=128,Max=1024)
        ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		MagAmmo=6
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=128)
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M763_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M763_OD
		Index=1
		CamoName="Olive Drab"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M763Camos.M763-KShotgunShiney",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M763Camos.M763-KSmallShiney",Index=2,AIndex=0,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M763_Wood
		Index=2
		CamoName="Wood"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781_LargeShine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781_SmallShine",Index=2,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M763_Trusty
		Index=3
		CamoName="Ol' Trusty"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781-OldTrusty",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781Small",Index=2,AIndex=0,PIndex=1)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'M763_Gray'
	Camos(1)=WeaponCamo'M763_OD'
	Camos(2)=WeaponCamo'M763_Wood'
	Camos(3)=WeaponCamo'M763_Trusty'
}