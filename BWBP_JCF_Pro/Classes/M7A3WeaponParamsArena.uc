class M7A3WeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//7.62mm
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=12000.000000)
		RangeAtten=0.800000
		Damage=30
		HeadMult=2.5f
		LimbMult=0.75f
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrateForce=450
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_JCF_Pro.M7A3FlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3-HFire4',Volume=1.4,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.10000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.150000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//5.7mm
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_57mm
		TraceRange=(Min=10000.000000,Max=12000.000000)
		RangeAtten=0.800000
		Damage=20
		HeadMult=2.5f
		LimbMult=0.75f
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrateForce=450
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_JCF_Pro.M7A3FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.M7A3.M7A3-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=80.000000
		Chaos=0.10000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_57mm
		FireInterval=0.080000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_57mm'
	End Object
	
	//5.7mm Suppressed
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_57mmSupp
		TraceRange=(Min=10000.000000,Max=12000.000000)
		RangeAtten=0.800000
		Damage=20
		HeadMult=2.5f
		LimbMult=0.75f
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrateForce=450
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.300000 //
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.P90.P90SilFire',Radius=64.000000,bAtten=True,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=70.000000
		Chaos=0.12000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_57mmSupp
		FireInterval=0.090000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_57mmSupp'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.M7A3TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="DartFireSingle"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15000
		YRandFactor=0.15000
		DeclineTime=0.65
		DeclineDelay=0.36
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.350000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout Core
		LayoutName="Holosight"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-3.000000,Y=-0.440000,Z=10.70000)
		SightMoveSpeedFactor=0.8
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.050000
		MagAmmo=20
        InventorySize=5
		ViewOffset=(X=6.000000,Y=3.000000,Z=-8.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Scope
		//Layout Core
		LayoutName="3X Scope"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=1f)
		ScopeViewTex=Texture'BWBP_SKC_Tex.MG36.G36ScopeViewDot'
		//ADS
		SightOffset=(X=0.000000,Y=-0.45000,Z=11.300000)
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		MaxZoom=3
		ZoomType=ZT_Fixed
		//Function
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.050000
		MagAmmo=20
        InventorySize=5
		ViewOffset=(X=6.000000,Y=3.000000,Z=-8.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_57mm
		//Layout Core
		LayoutName="5.7mm M7B2"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-3.000000,Y=-0.440000,Z=10.70000)
		SightMoveSpeedFactor=0.8
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.050000
		MagAmmo=50
        InventorySize=5
		ViewOffset=(X=6.000000,Y=3.000000,Z=-8.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_57mm'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_57mmSupp
		//Layout Core
		LayoutName="5.7mm M7B2 Supp"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",AugmentOffset=(x=-5,y=0,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-3.000000,Y=-0.440000,Z=10.70000)
		SightMoveSpeedFactor=0.8
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.050000
		MagAmmo=50
        InventorySize=5
		ViewOffset=(X=6.000000,Y=3.000000,Z=-8.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_57mmSupp'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_Scope'
	Layouts(2)=WeaponParams'ArenaParams_57mm'
	Layouts(3)=WeaponParams'ArenaParams_57mmSupp'
}