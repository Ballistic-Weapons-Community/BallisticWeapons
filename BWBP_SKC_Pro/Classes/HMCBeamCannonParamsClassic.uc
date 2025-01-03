class HMCBeamCannonParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=50000.000000,Max=50000.000000)
		Damage=240
		HeadMult=1.2
		LimbMult=0.8
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
		Recoil=1024
		PushBackForce=320.000000
		Chaos=0.005000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.080000
		AmmoPerFire=25
		FireAnim="ChargeFireBig"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Gravitron
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Gravitron
		TraceRange=(Min=50000.000000,Max=50000.000000)
		Damage=150
		HeadMult=1.2
		LimbMult=0.8
		DamageType=Class'BWBP_SKC_Pro.DTHMCBlast'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBlastHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBlast'
		PenetrateForce=400
		bPenetrate=True
		HookStopFactor=2.500000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Fire',Volume=1.700000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=400
		PushBackForce=180.000000
		Chaos=0.005000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Gravitron
		FireInterval=0.080000
		AmmoPerFire=25
		FireAnim="ChargeFireBig"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Gravitron'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=10000.000000,Max=10000.000000)
		RangeAtten=0.750000
		Damage=15
		HeadMult=2.0
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
		PenetrateForce=200
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		Heat=0.01
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Tractor
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams_Tractor
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=8
		HeadMult=2.0
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
		PenetrateForce=200
		bPenetrate=True
		HookStopFactor=0.300000
		HookPullForce=240.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.800000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		Heat=0.02
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Tractor
		TargetState="RepulsorBeamMode"
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams_Tractor'
	End Object
	
	//Tractor
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams_Repulsor
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=8
		HeadMult=2.0
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
		PenetrateForce=200
		bPenetrate=True
		HookStopFactor=0.300000
		HookPullForce=-240.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.800000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
		Heat=0.02
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Repulsor
		TargetState="RepulsorBeamMode"
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams_Repulsor'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.600000)))
		ViewBindFactor=0.950000
		PitchFactor=0.8
		YawFactor=0.8
		XRandFactor=0.7
		YRandFactor=0.9
		DeclineTime=3.000000
		CrouchMultiplier=0.3
		MaxRecoil=1600
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1248)
		AimAdjustTime=1.000000
		OffsetAdjustTime=0.500000
		CrouchMultiplier=0.3
		ADSMultiplier=0.850000
		ViewBindFactor=0.65
		ChaosDeclineTime=2.500000
		SprintChaos=0.600000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.600000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.600000
		ChaosSpeedThreshold=800.00
		AimDamageThreshold=150
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		Weight=30
		LayoutName="Industrial Laser"
		LayoutDescription="High Power with searing laser"
		AllowedCamos(0)=0
		//ADS
		SightOffset=(X=10.00,Y=-15.0,Z=20)
		SightingTime=0.300000
		//Function
		InventorySize=11
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		MagAmmo=500
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Cryon
		//Layout core
		Weight=10
		LayoutName="Cryon Gravitron"
		LayoutTags="grav"
		LayoutDescription="Slowing Blast with tractor/repulsor beam"
		AllowedCamos(0)=1
		AllowedCamos(1)=2
		AllowedCamos(2)=3
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.HMCCryon_FPm'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.HMCCryon_TPm'
		PickupMesh=StaticMesh'BWBP_SKC_Static.HMC.HMCCryonPickup'
		ViewOffset=(X=10,Y=15,Z=-15)
		//ADS
		SightingTime=0.300000
		SightOffset=(X=0,Y=-20,Z=20)
		//Function
		InventorySize=11
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		MagAmmo=500
		WeaponModes(0)=(ModeName="Beam: Tractor",ModeID="WM_FullAuto",Value=0.250000)
		WeaponModes(1)=(ModeName="Beam: Repulsor",ModeID="WM_FullAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Healing Beam",Value=0.333333,bUnavailable=true)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Gravitron'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Tractor'
		AltFireParams(1)=FireParams'ClassicSecondaryFireParams_Repulsor'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Cryon'
	
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