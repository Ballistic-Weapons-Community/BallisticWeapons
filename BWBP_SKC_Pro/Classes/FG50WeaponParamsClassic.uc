class FG50WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=6000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=65
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=72.000000
		PenetrateForce=350
		bPenetrate=True
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter_C'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
		PushBackForce=125.000000
		Heat=0.25
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		TargetState="IncAmmo"
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=65
		HeadMult=1.5f
		LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=72.000000
		PenetrateForce=350
		bPenetrate=True
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter_C'
		FlashScaleFactor=1.000000
		Recoil=384.000000
		Chaos=0.070000
		PushbackForce=64.000000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		Heat=0.25
	End Object

	Begin Object Class=FireParams Name=ClassicPriControlledFireParams
		TargetState="IncAmmo"
		FireInterval=0.600000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'ClassicPriControlledEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=6000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=65
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=72.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter_C'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
		PushbackForce=125.000000
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.165000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicSecControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=384.000000
		Chaos=0.5
		WarnTargetPct=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		PushbackForce=64.000000
	End Object

	Begin Object Class=FireParams Name=ClassicSecControlledFireParams
		FireInterval=0.600000
		FireAnim="CFire"
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'ClassicSecControlledEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_Scope'
	End Object	
	
	//Mount
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_Mount
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Mount
		TargetState="Mount"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_Mount'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.250000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.300000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2800
		DeclineTime=2.2
		DeclineDelay=0.3
		ViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.100000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Super Heavy
		AimAdjustTime=1.000000
		AimSpread=(Min=32,Max=2560)
		CrouchMultiplier=0.100000
		ADSMultiplier=0.700000
		ViewBindFactor=0.300000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
		ChaosDeclineTime=1.500000
	End Object

	Begin Object Class=AimParams Name=ClassicControlledAimParams
		AimAdjustTime=1.1
		ADSMultiplier=0.4
		AimSpread=(Min=64,Max=768)
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=350
		SprintChaos=0.500000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
	End Object 
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams_Holo
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
		//SightOffset=(X=-5.000000,Y=25.000000,Z=10.300000)
		//Function
		PlayerSpeedFactor=0.890000
		PlayerJumpFactor=0.750000
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=40
		//ViewOffset=(X=5.000000,Y=-7.000000,Z=-8.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ClassicControlledAimParams'
		FireParams(0)=FireParams'ClassicPriControlledFireParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Bipod
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
		//SightOffset=(X=0.000000,Y=25.000000,Z=8.200000)
		//Function
		PlayerSpeedFactor=0.890000
		PlayerJumpFactor=0.750000
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=40
		//ViewOffset=(X=5.000000,Y=-7.000000,Z=-8.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ClassicControlledAimParams'
		FireParams(0)=FireParams'ClassicPriControlledFireParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Mount'
	End Object
	Layouts(0)=WeaponParams'ClassicParams_Holo'
	Layouts(1)=WeaponParams'ClassicParams_Bipod'

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