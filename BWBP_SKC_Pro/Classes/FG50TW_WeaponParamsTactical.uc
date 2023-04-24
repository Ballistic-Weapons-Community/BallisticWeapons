class FG50TW_WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPriStandardEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=100
        HeadMult=2.75
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=252.000000
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
		Damage=100
		HeadMult=1.5f
		LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PushbackForce=125.000000
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=156.000000
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
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.070000,OutVal=-0.050000),(InVal=0.100000,OutVal=0.00000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.5,OutVal=0.000000),(InVal=0.650000,OutVal=-0.100000),(InVal=0.700000,OutVal=-0.1500000),(InVal=0.850000,OutVal=0.000000),(InVal=1.000000,OutVal=0.15)))
		YCurve=(Points=(,(InVal=0.20000,OutVal=0.250000),(InVal=0.400000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.050000
		XRandFactor=0.200000
		YRandFactor=0.20000
		MaxRecoil=7000.000000
		ViewBindFactor=0.6
		DeclineTime=1
	End Object

	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=TacticalStandardAimParams
		ADSMultiplier=0.7
		AimSpread=(Min=0,Max=2)
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=1.750000
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 

	Begin Object Class=AimParams Name=TacticalControlledAimParams
		AimAdjustTime=0.8
		ADSMultiplier=0.4
		AimSpread=(Min=0,Max=1)
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		TargetState="Mount"
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams //we should never see this
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.01		
		DisplaceDurationMult=1.25
		MagAmmo=40
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Bipod
		WeaponBoneScales(0)=(BoneName="Holosight",Slot=51,Scale=0f)
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.01		
		DisplaceDurationMult=1.25
		MagAmmo=40
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalStandardAimParams'
		AimParams(1)=AimParams'TacticalControlledAimParams'
		FireParams(0)=FireParams'TacticalPriControlledFireParams'
		FireParams(2)=FireParams'TacticalPriStandardFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Bipod'

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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainWood",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=1,PIndex=3)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=FG50_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=1,PIndex=3)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=FG50_Dazzle
		Index=3
		CamoName="Dazzle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainDazzle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=1,PIndex=3)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=FG50_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MainGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.FG50Camos.FG50-MiscDark",Index=2,AIndex=1,PIndex=3)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'FG50_Black'
	Camos(1)=WeaponCamo'FG50_Wood'
	Camos(2)=WeaponCamo'FG50_Desert'
	Camos(3)=WeaponCamo'FG50_Dazzle'
	Camos(4)=WeaponCamo'FG50_Gold'
}