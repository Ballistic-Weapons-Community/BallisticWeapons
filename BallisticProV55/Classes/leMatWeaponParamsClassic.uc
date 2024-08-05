class leMatWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=8000.000000)
		WaterTraceRange=6400.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=60.0
		HeadMult=1.7
		LimbMult=0.4
		DamageType=Class'BallisticProV55.DTleMatRevolver'
		DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
		PenetrationEnergy=24.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Fire',Volume=1.200000)
		Recoil=1600.000000
		Chaos=-1.0
		Inaccuracy=(X=16,Y=16)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//20ga Shot
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=1500.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=9
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=22.0
		HeadMult=1.4
		LimbMult=0.3
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Circle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFire',Volume=1.300000)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=500,Y=500)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		BurstFireRateFactor=1.00
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object	
	
	//20ga Slug
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams_Slug
		TraceRange=(Min=4500.000000,Max=4500)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=1 //
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=85.0 //
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Circle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFireSlug',Volume=1.500000)
		Recoil=768.000000 //
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Slug
		BurstFireRateFactor=1.00
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams_Slug'
	End Object	
	
	//Noisemaker
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams_Decoy
		TraceRange=(Min=4500.000000,Max=4500)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=1 //
		TracerClass=None //
		ImpactManager=Class'BallisticProV55.IM_Decoy' //
		Damage=45.0 //
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Circle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=0.700000,Radius=48.000000,bAtten=True)
		Recoil=256.000000 //
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Decoy
		BurstFireRateFactor=1.00
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams_Decoy'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.800000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=1200.000000
		ChaosTurnThreshold=200000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="20ga Shot"
		Weight=30
		
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.2500
		MagAmmo=9
		SightOffset=(X=-18,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
		ViewOffset=(X=-2,Y=10.00,Z=-8.5)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Slug
		LayoutName="20ga Slug"
		LayoutTags="slug"
		Weight=10
		
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.2500
		MagAmmo=9
		SightOffset=(X=-18,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
		ViewOffset=(X=-2,Y=10.00,Z=-8.5)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Slug'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Decoy
		LayoutName="Noisemaker"
		LayoutTags="decoy"
		Weight=5
		
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.2500
		MagAmmo=9
		SightOffset=(X=-18,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
		ViewOffset=(X=-2,Y=10.00,Z=-8.5)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Decoy'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Slug'
	Layouts(2)=WeaponParams'ClassicParams_Decoy'
	
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