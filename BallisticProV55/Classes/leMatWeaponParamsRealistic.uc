class leMatWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1000.000000,Max=5000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=51.0
		HeadMult=2.254901
		LimbMult=0.647058
		DamageType=Class'BallisticProV55.DTleMatRevolver'
		DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
		PenetrationEnergy=11.000000
		PenetrateForce=40
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Fire',Volume=1.200000)
		Recoil=800.000000
		Chaos=0.080000
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.240000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.900000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Shot
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=600.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		TraceCount=9
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		HeadMult=2.05
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrationEnergy=5.000000
		PenetrateForce=8
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFire',Volume=1.300000)
		Recoil=1536.000000
		Chaos=0.240000
		Inaccuracy=(X=1100,Y=1100)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		BurstFireRateFactor=1.00
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Slug
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams_Slug
		TraceRange=(Min=3150.000000,Max=3150.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		RangeAtten=0.5
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=75
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=2036.000000
		Chaos=0.300000
		Inaccuracy=(X=64,Y=64)
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFireSlug',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Slug
		FireInterval=None
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams_Slug'
	End Object
	
	//Decoy
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams_Decoy
		TraceRange=(Min=2500.000000,Max=2500.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		RangeAtten=0.5
		TraceCount=1
		TracerClass=None //
		ImpactManager=Class'BallisticProV55.IM_Decoy' //
		Damage=35
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=256.000000
		Chaos=0.300000
		Inaccuracy=(X=64,Y=64)
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=0.700000,Radius=48.000000,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Decoy
		FireInterval=None
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams_Decoy'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.40000),(InVal=7.00000,OutVal=0.50000),(InVal=1.00000,OutVal=0.50000)))
		PitchFactor=0.600000
		YawFactor=0.200000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=1840.000000
		DeclineTime=0.500000
		DeclineDelay=0.145000
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
		AimSpread=(Min=512,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=675.000000
		ChaosTurnThreshold=200000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		LayoutName="20ga Shot"
		Weight=30
		PlayerSpeedFactor=1.100000
		InventorySize=3
		WeaponPrice=9000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.14
		MagAmmo=9
		ViewPivot=(Pitch=512)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Slug
		LayoutName="20ga Slug"
		LayoutTags="slug"
		Weight=10
		
		PlayerSpeedFactor=1.100000
		InventorySize=3
		WeaponPrice=9000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.14
		MagAmmo=9
		ViewPivot=(Pitch=512)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Slug'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Decoy
		LayoutName="Noisemaker"
		LayoutTags="decoy"
		Weight=5
		
		PlayerSpeedFactor=1.100000
		InventorySize=3
		WeaponPrice=9000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.14
		MagAmmo=9
		ViewPivot=(Pitch=512)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Decoy'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Slug'
	Layouts(2)=WeaponParams'RealisticParams_Decoy'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=LeMat_Engraved
		Index=0
		CamoName="Engraved"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Rusted
		Index=1
		CamoName="Rusted"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMattBR-Main1-Shine",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMattBR-Main2-Shine",Index=2,PIndex=1,AIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Black
		Index=2
		CamoName="Blued"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMat-MainBlue",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1,AIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Chrome
		Index=3
		CamoName="Chrome"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMat-MainChromeShine",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1,AIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMat-MainGoldShine",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1,AIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'LeMat_Engraved'
	Camos(1)=WeaponCamo'LeMat_Rusted'
	Camos(2)=WeaponCamo'LeMat_Black'
	Camos(3)=WeaponCamo'LeMat_Chrome'
	Camos(4)=WeaponCamo'LeMat_Gold'
}