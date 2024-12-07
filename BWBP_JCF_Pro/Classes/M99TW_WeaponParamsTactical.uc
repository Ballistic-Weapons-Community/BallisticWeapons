class M99TW_WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=200 //.55 cal
		HeadMult=1.75
		LimbMult=0.75
		DamageType=Class'BWBP_JCF_Pro.DTM99Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM99RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM99Rifle'
		PenetrationEnergy=128
		PenetrateForce=450
		PushbackForce=255.000000
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99FireNew',Volume=10.00000)
		Recoil=3072.000000
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=2.000000
		FireAnim="Fire"	
		FireAnimRate=1.20000
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.000000
		DeclineDelay=1.2
		HipMultiplier=3
		CrouchMultiplier=0.95
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=0,Max=0)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=-8000)
		ADSMultiplier=0.15
		AimAdjustTime=0.500000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.010000		
		DisplaceDurationMult=1.25
		MagAmmo=1
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.880000
		SightOffset=(X=-10.000000,Y=-2.000000,Z=12.000000)
		SightPivot=(Roll=-1024)
		ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M99_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Digital
		Index=1
		CamoName="Digital"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99BShine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99AShine",Index=2,AIndex=0,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'M99_Gray'
	Camos(1)=WeaponCamo'M99_Digital'
}