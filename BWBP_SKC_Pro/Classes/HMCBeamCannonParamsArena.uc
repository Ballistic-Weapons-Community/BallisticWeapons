class HMCBeamCannonParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
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

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.080000
		AmmoPerFire=50
		FireAnim="ChargeFireBig"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Gravitron
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

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Gravitron
		FireInterval=0.080000
		AmmoPerFire=40
		FireAnim="ChargeFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Gravitron'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=10
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

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams_Tractor
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=6
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

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Tractor
		TargetState="RepulsorBeamMode"
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams_Tractor'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams_Repulsor
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=6
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

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Repulsor
		TargetState="RepulsorBeamMode"
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams_Repulsor'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.000000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
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
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Cryon
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
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Gravitron'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Tractor'
		AltFireParams(1)=FireParams'ArenaSecondaryFireParams_Repulsor'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_Cryon'
	
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