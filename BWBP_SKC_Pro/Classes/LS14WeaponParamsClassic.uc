class LS14WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Long Barrel
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
		Recoil=100.000000
		Chaos=-1.0
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Long Barrel - Double
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Dbl
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=70
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FireDouble',Volume=0.900000)
		Recoil=2000.000000
		Chaos=1.5
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Dbl
		AmmoPerFire=2
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Dbl'
	End Object

	//Auto
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Auto
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=30
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=None)
		Recoil=75.000000
		Chaos=-0.1
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Auto
		TargetState="GatlingLaser"
		FireInterval=0.110000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Auto'
	End Object

	//Gatling
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Gatling
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=30
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=None)
		Inaccuracy=(X=256,Y=256)
		Recoil=25.000000
		Chaos=-0.1
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Gatling
		TargetState="GatlingLaser"
		FireInterval=0.030000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Gatling'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LS14Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2500.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		Damage=50.000000
		DamageRadius=192.000000
		MomentumTransfer=20000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=2.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
		Recoil=256.000000
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.020000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="RLFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.700000
		YRandFactor=0.700000
		MaxRecoil=2048.000000
		DeclineTime=1.000000
		ViewBindFactor=0.550000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=20,Max=1400)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.450000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.500000
	End Object
	
	Begin Object Class=AimParams Name=ClassicCarbineAimParams
		AimSpread=(Min=10,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.800000
		ViewBindFactor=0.250000
		SprintChaos=0.450000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Laser Rifle"
		Weight=30
		
		//Visual
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=1f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=92,Scale=0f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=93,Scale=1f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=94,Scale=0f)
		WeaponBoneScales(4)=(BoneName="Stock",Slot=95,Scale=1f)
		WeaponBoneScales(5)=(BoneName="ShortStock",Slot=96,Scale=0f)
		ZoomType=ZT_Logarithmic
		
		//Function
		PlayerSpeedFactor=1.100000
		PlayerJumpFactor=1.100000
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		//SightOffset=(X=18.000000,Y=-8.500000,Z=22.000000)
		ViewOffset=(X=0.000000,Y=6.000000,Z=-5.000000)
		SightPivot=(Pitch=600,Roll=-1024)
		WeaponModes(0)=(ModeName="Single Barrel",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponName="LS14 Laser Rifle"
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams_Dbl'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Auto
		//Layout core
		LayoutName="Laser Repeater"
		LayoutTags="gatling"
		Weight=10
		
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_LS440'
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=92,Scale=1f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=93,Scale=0f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=94,Scale=1f)
		WeaponBoneScales(4)=(BoneName="Stock",Slot=95,Scale=0f)
		WeaponBoneScales(5)=(BoneName="ShortStock",Slot=96,Scale=1f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.LS440.LS440-Red',Index=1,AIndex=-1,PIndex=-1)
		//WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.XM20Prototype.XM20-MainProtoShine',Index=2,AIndex=1,PIndex=3)
		SightOffset=(X=11.000000,Y=-0.00000,Z=4.700000)
		//SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Irons
		
		//Function
		PlayerSpeedFactor=1.100000
		PlayerJumpFactor=1.100000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		WeaponModes(0)=(ModeName="Rotary Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		WeaponName="LS10 Laser Repeater"
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicCarbineAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Auto'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Gatling
		//Layout core
		LayoutName="Laser Gatling"
		LayoutTags="gatling,rapid,backpack"
		Weight=10
		
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_LS440'
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=92,Scale=1f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=93,Scale=0f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=94,Scale=1f)
		WeaponBoneScales(4)=(BoneName="Stock",Slot=95,Scale=0f)
		WeaponBoneScales(5)=(BoneName="ShortStock",Slot=96,Scale=1f)
		SightOffset=(X=11.000000,Y=-0.00000,Z=4.700000)
		//SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Irons
		
		//Function
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=500
		WeaponModes(0)=(ModeName="Rotary Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		WeaponName="LS440 Laser Gatling"
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicCarbineAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Gatling'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Carbine
		//Layout core
		LayoutName="Carbine"
		Weight=10
		
		//Visual
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=92,Scale=1f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=93,Scale=0f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=94,Scale=1f)
		WeaponBoneScales(4)=(BoneName="Stock",Slot=95,Scale=0f)
		WeaponBoneScales(5)=(BoneName="ShortStock",Slot=96,Scale=1f)
		SightOffset=(X=11.000000,Y=-0.00000,Z=4.700000)
		//SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Irons
		
		//Function
		PlayerSpeedFactor=1.100000
		PlayerJumpFactor=1.100000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		WeaponModes(0)=(ModeName="Rotary Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		WeaponName="LS10 Laser Carbine"
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicCarbineAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Auto'
	Layouts(2)=WeaponParams'ClassicParams_Gatling'
	//Layouts(2)=WeaponParams'ClassicCarbineParams'


}