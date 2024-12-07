class FG50TW_WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPriStandardEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=80
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=300.000000
		Chaos=0.200000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPriStandardFireParams
		TargetState="HEAmmo"
		FireInterval=0.230000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'ArenaPriStandardEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=80
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=100.000000
		Chaos=0.070000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPriControlledFireParams
		TargetState="HEAmmo"
		FireInterval=0.600000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'ArenaPriControlledEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.100000
		XCurve=(Points=(,(InVal=0.15,OutVal=0.075),(InVal=0.400000,OutVal=0.130000),(InVal=0.550000,OutVal=0.15000),(InVal=0.700000,OutVal=0.21000),(InVal=1.000000,OutVal=0.225000)))
		YCurve=(Points=(,(InVal=0.20000,OutVal=0.250000),(InVal=0.400000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.050000
		XRandFactor=0.200000
		YRandFactor=0.050000
		MaxRecoil=1200.000000
		DeclineTime=1
	End Object


	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.7
		AimSpread=(Min=0,Max=0)
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=1.750000
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 
	
	Begin Object Class=AimParams Name=ArenaAimParams_Controlled
		ADSMultiplier=0.7
		AimSpread=(Min=0,Max=0)
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=1.750000
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		TargetState="Mount"
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams //We should never see this
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.01		
		DisplaceDurationMult=1.25
		MagAmmo=40
		ReloadAnimRate=1.25
		CockAnimRate=1.25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		FireParams(0)=FireParams'ArenaPriControlledFireParams'
		FireParams(2)=FireParams'ArenaPriStandardFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(2)=FireParams'ArenaSecondaryFireParams'
		AimParams(0)=AimParams'ArenaAimParams'
		AimParams(1)=AimParams'ArenaAimParams_Controlled'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Bipod
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.01		
		DisplaceDurationMult=1.25
		MagAmmo=40
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		WeaponBoneScales(0)=(BoneName="Holosight",Slot=51,Scale=0f)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		AimParams(1)=AimParams'ArenaAimParams_Controlled'
		FireParams(0)=FireParams'ArenaPriControlledFireParams'
		FireParams(2)=FireParams'ArenaPriStandardFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(2)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Bipod'

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