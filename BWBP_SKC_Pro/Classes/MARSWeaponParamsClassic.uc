class MARSWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Marksman Barrel
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_HeavyBarrel
		TraceRange=(Min=11000.000000,Max=14000.000000)
		WaterTraceRange=11200.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.950000
		Damage=24
		HeadMult=3.125
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=-1.0
		Inaccuracy=(X=16,Y=16)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_HeavyBarrel
		FireInterval=0.085700
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_HeavyBarrel'
	End Object
	
	// Regular Barrel
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10500.000000,Max=12500.000000)
		WaterTraceRange=10000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.850000
		Damage=22
		HeadMult=3.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-RapidFire',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=220.000000
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.077000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"	
		FireEndAnim=
		FireAnimRate=2.000000	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Smoke Grenade
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_Smoke
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Chaff'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=50
		DamageRadius=256.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Smoke
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_Smoke'
	End Object
	
	//Sensor Grenade
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_Sensor
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Sensor'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=10
		DamageRadius=10.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Sensor
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_Sensor'
	End Object
	
	//HE Grenade
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_HE
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_HETimed'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=150
		DamageRadius=256.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_HE
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_HE'
	End Object	
	
	//Shockwave Grenade
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_Shockwave
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Shockwave'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=50
		DamageRadius=256.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Shockwave
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_Shockwave'
	End Object	
	
	//Scope
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Scope
		FireInterval=0.200000
		AmmoPerFire=0
		TargetState=Scope
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_Scope'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams_HeavyBarrel
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=1.000000 
		YawFactor=0.400000
		XRandFactor=0.300000
		YRandFactor=0.400000
		MaxRecoil=3200
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object
	
	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		//XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		//YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.150000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.000000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.150000),(InVal=0.600000,OutVal=0.200000),(InVal=0.800000,OutVal=0.300000),(InVal=1.000000,OutVal=0.400000)))
		PitchFactor=1.500000 //
		YawFactor=0.100000
		XRandFactor=0.350000 //
		YRandFactor=0.500000 //
		MinRandFactor=0.05
		MaxRecoil=4800 //
		DeclineTime=1.5
		ViewBindFactor=0.500000 //
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000 //
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams_HeavyBarrel
		AimSpread=(Min=16,Max=2048)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
	End Object
	
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560) //
		ADSMultiplier=0.700000
		ViewBindFactor=0.300000 //
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams_Marksman //IRNV, Tracker, Heavy Barrel
		//Layout core
		Weight=30
		LayoutName="Marksman"
		LayoutTags="IRNV,tracker"
		
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MARS2'
		ZoomType=ZT_Logarithmic
		SightOffset=(X=6.50,Y=0.01,Z=3.8)
		
		//Function
		InventorySize=6
		bNeedCock=True
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ViewOffset=(X=3.000000,Y=7.000000,Z=-4.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams_HeavyBarrel'
		AimParams(0)=AimParams'ClassicAimParams_HeavyBarrel'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_HeavyBarrel'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Smoker //IRNV, Smoke GL
		//Layout core
		Weight=10
		LayoutName="Smoker"
		LayoutTags="IRNV"
		
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_F2000'
		ZoomType=ZT_Logarithmic
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.MARS.F2000-LensShineAltGreen',Index=3,PIndex=2,AIndex=3)
		SightOffset=(X=6.50,Y=0.01,Z=0.8)
		
		//Function
		InventorySize=6
		bNeedCock=True
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="MARS-3 Adv Assault Rifle"
		ViewOffset=(X=3.000000,Y=7.000000,Z=-2.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_HeavyBarrel'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Smoke'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Tracker //Target scope, sensor mine
		//Layout core
		Weight=10
		LayoutName="Tracker"
		LayoutTags="tracker"
		
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_F2000'
		ZoomType=ZT_Logarithmic
		SightOffset=(X=6.50,Y=0.01,Z=0.8)
		
		//Function
		InventorySize=6
		bNeedCock=True
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="MARS-3 Adv Assault Rifle"
		ViewOffset=(X=3.000000,Y=7.000000,Z=-2.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_HeavyBarrel'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Sensor'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_CQC //Holo, Suppressor, HE GL
		//Layout core
		Weight=30
		LayoutName="CQC Bomber"
		LayoutTags="suppressor"
		
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MARS3'
		SightOffset=(X=6.50,Y=0.01,Z=3.65)
		ZoomType=ZT_Irons
		ScopeViewTex=None
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=4,PIndex=-1,AIndex=-1)
		
		//Function
		InventorySize=6
		bNeedCock=True
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="MARS-3 CQB Assault Rifle"
		ViewOffset=(X=3.000000,Y=7.000000,Z=-3.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_HE'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Shockwave //Holo, Suppressor, Shockwave GL
		//Layout core
		Weight=10
		LayoutName="CQC Shockwave"
		LayoutTags="suppressor"
		
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MARS3'
		SightOffset=(X=6.50,Y=0.01,Z=3.65)
		ZoomType=ZT_Irons
		ScopeViewTex=None
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=4,PIndex=-1,AIndex=-1)
		
		//Function
		InventorySize=4
		bNeedCock=True
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="MARS-3 CQB Assault Rifle"
		ViewOffset=(X=3.000000,Y=7.000000,Z=-3.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Shockwave'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams_Marksman'
	Layouts(1)=WeaponParams'ClassicParams_Smoker'
	Layouts(2)=WeaponParams'ClassicParams_Tracker'
	Layouts(3)=WeaponParams'ClassicParams_CQC'
	Layouts(4)=WeaponParams'ClassicParams_Shockwave'
	
	
	//Camos =========================================
	Begin Object Class=WeaponCamo Name=MARS_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Tan
		Index=1
		CamoName="Tan"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronsTan",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Green
		Index=2
		CamoName="Olive Drab"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-MainGreen",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Urban
		Index=3
		CamoName="Urban"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-MainSplitter",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Arctic
		Index=4
		CamoName="Arctic"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronArctic",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Proto
		Index=5
		CamoName="Prototype"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronBlack",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_LE
		Index=6
		CamoName="Limited Edition"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronWhite",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'MARS_Black' //Black
	Camos(1)=WeaponCamo'MARS_Tan'
	Camos(2)=WeaponCamo'MARS_Green'
	Camos(3)=WeaponCamo'MARS_Urban'
	Camos(4)=WeaponCamo'MARS_Arctic'
	Camos(5)=WeaponCamo'MARS_Proto'
	Camos(6)=WeaponCamo'MARS_LE'
	//Camos(7)=WeaponCamos'MARS_Gold'
}