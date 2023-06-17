class MG36WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=11000.000000)
		RangeAtten=0.400000
		Damage=28
		DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
		PenetrateForce=150
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-Fire',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=100.000000
		Chaos=0.030000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.085000
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//AR
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_AR
		TraceRange=(Min=9000.000000,Max=11000.000000)
		RangeAtten=0.400000
		Damage=28
		DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
		PenetrateForce=150
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.JSOC.JSOC-FireAR',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=128.000000
		Chaos=-1.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_AR
		FireInterval=0.085000
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_AR'
	End Object
	
	//Gauss
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Gauss
		TraceRange=(Min=9000.000000,Max=11000.000000)
		RangeAtten=0.400000
		Damage=68
		DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
		PenetrateForce=150
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.300000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.JSOC.JSOC-FireGauss',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		PushbackForce=150 //
		Recoil=428.000000
		Chaos=-1.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Gauss
		FireInterval=0.285000
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Gauss'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		SpreadMode=None
		MuzzleFlashClass=None
		FlashScaleFactor=None
		Recoil=None
		Chaos=None
		PushbackForce=None
		SplashDamage=None
		RecommendSplashDamage=None
		BotRefireRate=0.300000
		WarnTargetPct=None
	End Object
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
	FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.40000),(InVal=0.500000,OutVal=0.550000),(InVal=0.700000,OutVal=0.70000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.300000),(InVal=0.500000,OutVal=0.550000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.2000
		MaxRecoil=12288
		DeclineTime=1.3
		DeclineDelay=0.350000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		AimSpread=(Min=200,Max=1024)
		ADSMultiplier=0.200000
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=15000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams_LMG
		//Layout
		Weight=30
		LayoutName="LMG"
		LayoutTags="lmg"
		//Visual
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=0f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=0f)
		//Stats
		ReloadAnimRate=0.700000
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.6
		DisplaceDurationMult=1.5
		MagAmmo=100
		//SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
		//ViewOffset=(X=5.000000,Y=5.000000,Z=-9.000000)
		ZoomType=ZT_Logarithmic
		MinZoom=4.000000
		MaxZoom=8.000000
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_AR
		//Layout
		Weight=10
		LayoutName="Assault Rifle"
		LayoutTags="ar"
		//Visual
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=1f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=0f)
		//Stats
		ReloadAnimRate=0.800000
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.6
		DisplaceDurationMult=1.5
		MagAmmo=30
		//SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
		//ViewOffset=(X=5.000000,Y=5.000000,Z=-9.000000)
		ZoomType=ZT_Logarithmic
		MinZoom=4.000000
		MaxZoom=8.000000
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_AR'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Gauss
		//Layout
		Weight=10
		LayoutName="Gauss Rifle"
		LayoutTags="gauss"
		//Visual
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=1f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=1f)
		//Stats
		ReloadAnimRate=0.800000
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.6
		DisplaceDurationMult=1.5
		MagAmmo=20
		//SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
		//ViewOffset=(X=5.000000,Y=5.000000,Z=-9.000000)
		ZoomType=ZT_Logarithmic
		MinZoom=4.000000
		MaxZoom=8.000000
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Gauss'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams_LMG'
	Layouts(1)=WeaponParams'ArenaParams_AR'
	Layouts(2)=WeaponParams'ArenaParams_Gauss'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=MG36_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MG36_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MainDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MiscDesert",Index=2,AIndex=1,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=MG36_HexGreen
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MainJungle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MiscJungle",Index=2,AIndex=1,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=MG36_Hunter
		Index=3
		CamoName="Jaeger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MainJaeger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MiscJaeger",Index=2,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=MG36_Winter
		Index=4
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MainWinter",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MiscWinter",Index=2,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=MG36_Pink
		Index=5
		CamoName="Pink"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MainPink",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MiscPink",Index=2,AIndex=1,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=MG36_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MG36Camos.MG36-MainGold",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'MG36_Gray'
	Camos(1)=WeaponCamo'MG36_Desert'
	Camos(2)=WeaponCamo'MG36_HexGreen'
	Camos(3)=WeaponCamo'MG36_Hunter'
	Camos(4)=WeaponCamo'MG36_Winter'
	Camos(5)=WeaponCamo'MG36_Pink'
	Camos(6)=WeaponCamo'MG36_Gold'
}