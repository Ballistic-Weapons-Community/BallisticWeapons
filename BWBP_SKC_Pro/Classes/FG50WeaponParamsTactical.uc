class FG50WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Exp rounds
	Begin Object Class=InstantEffectParams Name=TacticalPriStandardEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=90 // .50 explosive
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=2048.000000
		Chaos=0.200000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPriStandardFireParams
		TargetState="HEAmmo"
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalPriStandardEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=90 // .50 explosive
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PushbackForce=125.000000
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=1536.000000
		Chaos=0.070000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPriControlledFireParams
		TargetState="HEAmmo"
		FireInterval=0.600000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalPriControlledEffectParams'
	End Object
	
	//AP rounds
	Begin Object Class=InstantEffectParams Name=TacticalPriStandardEffectParams_AP
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=95 // .50 AP
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=128 //
		PenetrateForce=450 //
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=2048.000000
		Chaos=0.200000
		WarnTargetPct=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.FG50-HeavyFire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPriStandardFireParams_AP
		TargetState="APAmmo"
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalPriStandardEffectParams_AP'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalPriControlledEffectParams_AP
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=95 // .50 AP
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=128 //
		PenetrateForce=450 //
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=1536.000000
		Chaos=0.070000
		WarnTargetPct=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.FG50-HeavyFire',Volume=6.750000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPriControlledFireParams_AP
		TargetState="APAmmo"
		FireInterval=1.000000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=1.800000	
		FireEffectParams(0)=InstantEffectParams'TacticalPriControlledEffectParams_AP'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecStandardEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=90 // .50 explosive
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=768.000000
		WarnTargetPct=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Heat=1.5
		PushbackForce=150.000000
	End Object

	Begin Object Class=FireParams Name=TacticalSecStandardFireParams
		TargetState="RapidFire"
		FireInterval=0.165000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalSecStandardEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalSecControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=90 // .50 explosive
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=512.000000
		Chaos=0.5
		WarnTargetPct=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		Heat=1.5
		PushbackForce=125.000000
	End Object

	Begin Object Class=FireParams Name=TacticalSecControlledFireParams
		TargetState="RapidFire"
		FireInterval=0.600000
		FireAnim="CFire"
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalSecControlledEffectParams'
	End Object
	
	//Mount
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Mount
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Mount
		TargetState="Mount"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Mount'
	End Object	
	
	//Scope
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XCurve=(Points=(,(InVal=0.15,OutVal=0.03),(InVal=0.400000,OutVal=-0.090000),(InVal=0.550000,OutVal=0.05000),(InVal=0.700000,OutVal=-0.07500),(InVal=1.000000,OutVal=0.1000)))
		YCurve=(Points=(,(InVal=0.20000,OutVal=0.250000),(InVal=0.400000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=8192
		ClimbTime=0.1
		DeclineDelay=0.3
		DeclineTime=2
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalStandardAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.7
		AimAdjustTime=0.6
		AimSpread=(Min=512,Max=2560)
		ChaosDeclineTime=1.750000
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 

	Begin Object Class=AimParams Name=TacticalControlledAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		AimSpread=(Min=384,Max=1280)
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Holosight",Slot=51,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Support",Slot=52,Scale=0f)
		WeaponBoneScales(3)=(BoneName="LegLeft",Slot=53,Scale=0f)
		WeaponBoneScales(4)=(BoneName="LegRight",Slot=54,Scale=0f)
		SightOffset=(X=3.00,Y=0.00,Z=3.25)
		SightMoveSpeedFactor=0.3
		SightingTime=0.65
		//Function
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		DisplaceDurationMult=1.4
		MagAmmo=40
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalStandardAimParams'
		AimParams(1)=AimParams'TacticalControlledAimParams'
		FireParams(0)=FireParams'TacticalPriControlledFireParams'
		FireParams(2)=FireParams'TacticalPriStandardFireParams'
		AltFireParams(0)=FireParams'TacticalSecControlledFireParams'
		AltFireParams(2)=FireParams'TacticalSecStandardFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Mount
		//Layout core
		Weight=20
		LayoutName="Bipod"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Holosight",Slot=51,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Support",Slot=52,Scale=1f)
		WeaponBoneScales(3)=(BoneName="LegLeft",Slot=53,Scale=1f)
		WeaponBoneScales(4)=(BoneName="LegRight",Slot=54,Scale=1f)
		SightOffset=(X=0.00,Y=0.05,Z=2.00)
		SightMoveSpeedFactor=0.3
		SightingTime=0.65
		//Function
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		DisplaceDurationMult=1.4
		MagAmmo=40
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalStandardAimParams'
		AimParams(1)=AimParams'TacticalControlledAimParams'
		FireParams(0)=FireParams'TacticalPriControlledFireParams'
		FireParams(2)=FireParams'TacticalPriStandardFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Mount'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_AP
		//Layout core
		Weight=10
		LayoutName="AP Rounds"
		LayoutTags="AP"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Holosight",Slot=51,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Support",Slot=52,Scale=0f)
		WeaponBoneScales(3)=(BoneName="LegLeft",Slot=53,Scale=0f)
		WeaponBoneScales(4)=(BoneName="LegRight",Slot=54,Scale=0f)
		SightOffset=(X=3.00,Y=0.00,Z=3.25)
		SightMoveSpeedFactor=0.3
		SightingTime=0.65
		//Function
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		DisplaceDurationMult=1.4
		MagAmmo=40
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalStandardAimParams'
		AimParams(1)=AimParams'TacticalControlledAimParams'
		FireParams(0)=FireParams'TacticalPriControlledFireParams_AP'
		FireParams(2)=FireParams'TacticalPriStandardFireParams_AP'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams_Scope'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Mount'
    Layouts(2)=WeaponParams'TacticalParams_AP'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=FG50_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=FG50_Wood
		Index=1
		CamoName="Wood"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainWood",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=2,PIndex=3)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=FG50_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainDesert",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=2,PIndex=3)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=FG50_Dazzle
		Index=3
		CamoName="Dazzle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainDazzle",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=2,PIndex=3)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=FG50_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainGold",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=2,PIndex=3)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'FG50_Black'
	Camos(1)=WeaponCamo'FG50_Wood'
	Camos(2)=WeaponCamo'FG50_Desert'
	Camos(3)=WeaponCamo'FG50_Dazzle'
	Camos(4)=WeaponCamo'FG50_Gold'
}