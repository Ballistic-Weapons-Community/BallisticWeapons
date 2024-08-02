class HMCBeamCannonParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=50000.000000,Max=50000.000000)
		Damage=245
		DamageType=Class'BWBP_SKC_Pro.DTHMCBlast'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBlastHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBlast'
		PenetrationEnergy=200.000000
		PenetrateForce=600
		PDamageFactor=0.80000
		WallPDamageFactor=0.80000
		bPenetrate=True
		HookStopFactor=2.500000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.BeamCannon.HMC-Blast',Volume=2.300000,Radius=512.000000,Slot=SLOT_Interact,bNoOverride=False)
		Chaos=0.005000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.080000
		AmmoPerFire=50
		FireAnim="ChargeFireBig"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Gravitron
		TraceRange=(Min=50000.000000,Max=50000.000000)
		Damage=145
		DamageType=Class'BWBP_SKC_Pro.DTHMCBlast'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBlastHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBlast'
		PenetrateForce=400
		bPenetrate=True
		HookStopFactor=2.500000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Fire',Volume=1.700000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Chaos=0.005000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Gravitron
		FireInterval=0.080000
		AmmoPerFire=25
		FireAnim="ChargeFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Gravitron'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=15
		DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
		PenetrateForce=200
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		Heat=0.03
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams_Tractor
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=10
		DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
		PenetrateForce=200
		bPenetrate=True
		HookStopFactor=0.300000
		HookPullForce=240.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		Heat=0.02
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Tractor
		TargetState="RepulsorBeamMode"
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams_Tractor'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams_Repulsor
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=10
		DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
		PenetrateForce=200
		bPenetrate=True
		HookStopFactor=0.300000
		HookPullForce=-240.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		Heat=0.02
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Repulsor
		TargetState="RepulsorBeamMode"
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams_Repulsor'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.000000
		ClimbTime=0.03
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1280)
        ADSMultiplier=0.7
		ViewBindFactor=0.200000
		ChaosDeclineTime=1.500000
		SprintChaos=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpChaos=0.5
		JumpOffset=(Pitch=-6000,Yaw=2000)
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Industrial Laser"
		LayoutDescription="High Power with searing laser"
		AllowedCamos(0)=0
		//ADS
		SightOffset=(X=-10,Y=0,Z=30.5)
		SightPivot=(Pitch=748)
		//Function
		InventorySize=8
		SightingTime=0.300000
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		MagAmmo=500
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Cryon
		//Layout core
		Weight=10
		LayoutName="Cryon Gravitron"
		LayoutTags="grav"
		LayoutDescription="Slowing Blast with tractor/repulsor beam"
		AllowedCamos(0)=1
		AllowedCamos(1)=2
		AllowedCamos(2)=3
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_HMCCryon'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.TPm_HMCCryon'
		PickupMesh=StaticMesh'BWBP_SKC_Static.HMC.HMCCryonPickup'
		ViewOffset=(X=10,Y=15,Z=-15)
		SightOffset=(X=-20,Y=0,Z=40)
		SightPivot=(Pitch=4096)
		//Function
		InventorySize=8
		SightingTime=0.300000
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		MagAmmo=500
		WeaponModes(0)=(ModeName="Beam: Tractor",ModeID="WM_FullAuto",Value=0.250000)
		WeaponModes(1)=(ModeName="Beam: Repulsor",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Healing Beam",Value=0.333333,bUnavailable=true)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Gravitron'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Tractor'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams_Repulsor'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams'
	Layouts(1)=WeaponParams'TacticalParams_Cryon'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=HMC_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=HMC_CryonWhite
		Index=1
		CamoName="White"
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=HMC_CryonBlack
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HMCCamos.HMC-CryonRed",Index=1,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=HMC_CryonStripes
		Index=3
		CamoName="MLN Labs"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HMCCamos.HMC-CryonStripes",Index=1,AIndex=-1,PIndex=-1)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'HMC_Black'
	Camos(1)=WeaponCamo'HMC_CryonWhite'
	Camos(2)=WeaponCamo'HMC_CryonBlack'
	Camos(3)=WeaponCamo'HMC_CryonStripes'
}