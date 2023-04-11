class FG50WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.FG50-HeavyFire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=2500.000000
		Chaos=1.000000
		PushbackForce=100.000000
		Inaccuracy=(X=12,Y=12)
		Heat=0.25
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		TargetState="IncAmmo"
		FireInterval=0.160000
		BurstFireRateFactor=1.00
		FireAnimRate=1.550000
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=RealisticPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=768.000000
		Chaos=0.070000
		PushbackForce=64.000000
		WarnTargetPct=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=6.750000,Slot=SLOT_Interact,bNoOverride=False)
		Heat=0.25
	End Object

	Begin Object Class=FireParams Name=RealisticPriControlledFireParams
		TargetState="IncAmmo"
		FireInterval=0.500000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'RealisticPriControlledEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Mount
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Mount
		TargetState="Mount"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Mount'
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
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		//YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		YawFactor=0.200000
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=4000.000000
		DeclineTime=2.000000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=32,Max=5072)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.800000
		ViewBindFactor=0.100000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
		SprintChaos=0.500000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
		AimAdjustTime=1.000000
	End Object

	Begin Object Class=AimParams Name=RealisticControlledAimParams
		AimSpread=(Min=16,Max=3048)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=350
		SprintChaos=0.500000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
		AimAdjustTime=1.1
	End Object 
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
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
		//SightPivot=(Pitch=32)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.35
		//Function
		PlayerSpeedFactor=0.825000
		InventorySize=8
		MagAmmo=40
		//ViewOffset=(X=4.000000,Y=-10.000000,Z=-15.000000)
		//ReloadAnimRate=0.900000
		//CockAnimRate=1.000000
		WeaponName="FG-50 .50 Heavy Machinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		AimParams(1)=AimParams'RealisticControlledAimParams'
		FireParams(0)=FireParams'RealisticPriControlledFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Bipod
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
		SightMoveSpeedFactor=0.500000
		SightingTime=0.35
		//Function
		PlayerSpeedFactor=0.825000
		InventorySize=8
		MagAmmo=40
		//ViewOffset=(X=4.000000,Y=-10.000000,Z=-15.000000)
		//ReloadAnimRate=0.900000
		//CockAnimRate=1.000000
		WeaponName="FG-50 .50 Heavy Machinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		AimParams(1)=AimParams'RealisticControlledAimParams'
		FireParams(0)=FireParams'RealisticPriControlledFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Mount'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Bipod'

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