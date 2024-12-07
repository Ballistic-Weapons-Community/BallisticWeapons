class MG36WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_LMG
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34  // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=230.000000
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_LMG
		FireInterval=0.085000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_LMG'
	End Object
	
	//AR
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_AR
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34  // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.JSOC.JSOC-FireAR',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=190.000000
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_AR
		FireInterval=0.086000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_AR'
	End Object
	
	//Gauss
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Gauss
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=5250,Max=10250) // 100-200m
		RangeAtten=0.97
		Damage=60  // 5.56mm Accel
        HeadMult=3.25
        LimbMult=0.75
        PenetrationEnergy=150 //
		PenetrateForce=600 //
		bPenetrate=True
		DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
		PDamageFactor=0.8
		WallPDamageFactor=0.6
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.JSOC.JSOC-FireGauss',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		PushbackForce=250 //
		Recoil=1200.000000 //
		Chaos=0.05
		Inaccuracy=(X=1,Y=1) //
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Gauss
		FireInterval=0.28000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Gauss'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.30000),(InVal=0.500000,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		//YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		PitchFactor=0.250000
		YawFactor=0.300000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3200.000000
		DeclineTime=0.750000
		DeclineDelay=0.145000
		ViewBindFactor=0.350000
		ADSViewBindFactor=1.00000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_Gauss
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		PitchFactor=0.350000
		YawFactor=0.300000
		XRandFactor=0.450000
		YRandFactor=0.450000
		ClimbTime=0.06
		MaxRecoil=3200.000000
		DeclineTime=0.750000
		DeclineDelay=0.215000
		ViewBindFactor=0.550000
		ADSViewBindFactor=1.00000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_AR
		ViewBindFactor=0.2
		ADSViewBindFactor=0.6
		EscapeMultiplier=1.45
		XCurve=(Points=(,(InVal=0.10000,OutVal=0.000000),(InVal=0.150000,OutVal=0.080000),(InVal=0.25000,OutVal=0.04000),(InVal=0.300000,OutVal=-0.0500000),(InVal=0.450000,OutVal=0.0000000),(InVal=0.600000,OutVal=-0.40000),(InVal=0.800000,OutVal=-0.12),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.30000),(InVal=0.500000,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15
		YRandFactor=0.45
		ClimbTime=0.04
		DeclineDelay=0.120000     
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object


	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams_LMG
		ADSViewBindFactor=1
		ADSMultiplier=0.7
		AimAdjustTime=0.8
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		AimSpread=(Min=256,Max=2872)
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_AR
		ADSViewBindFactor=1
		ADSMultiplier=0.7
		AimAdjustTime=0.7 //
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=256,Max=1024) //
		ChaosDeclineTime=1.25 //
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_LMG
		//Layout
		Weight=30
		LayoutName="LMG"
		LayoutTags="lmg"
		//Visual
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=0f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=0f)
		//Stats
		PlayerSpeedFactor=0.900000
		InventorySize=6
        DisplaceDurationMult=1.25
		SightMoveSpeedFactor=0.35
		SightingTime=0.45
		MagAmmo=100
		//ViewOffset=(X=5.000000,Y=4.000000,Z=-12.000000)
		//SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
		ZoomType=ZT_Logarithmic
		WeaponName="Mk 88 Squad Automatic Weapon"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams_LMG'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_LMG'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_AR
		//Layout
		Weight=10
		LayoutName="Assault Rifle"
		LayoutTags="ar"
		//Visual
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=1f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=33,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="tip",Scale=0.06,AugmentOffset=(x=-48,y=-2,z=-0.125),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//Stats
		PlayerSpeedFactor=1.000000
		InventorySize=6
		SightMoveSpeedFactor=0.35
		SightingTime=0.40
		MagAmmo=30
		//ViewOffset=(X=5.000000,Y=4.000000,Z=-12.000000)
		SightOffset=(X=-5.000000,Y=0.0000,Z=1.950000)
		ZoomType=ZT_Irons
		WeaponName="Mk 88 Assault Rifle"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_AR'
		AimParams(0)=AimParams'TacticalAimParams_AR'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_AR'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Gauss
		//Layout
		Weight=10
		LayoutName="Gauss Rifle"
		LayoutTags="gauss"
		//Visual
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=1f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=1f)
		//Stats
		PlayerSpeedFactor=1.000000
		InventorySize=6
		SightMoveSpeedFactor=0.35
		SightingTime=0.40
		MagAmmo=20
		InitialWeaponMode=0
		//ViewOffset=(X=5.000000,Y=4.000000,Z=-12.000000)
		//SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
		ZoomType=ZT_Logarithmic
		WeaponName="Mk 88 Gauss Rifle"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_Gauss'
		AimParams(0)=AimParams'TacticalAimParams_LMG'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Gauss'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_LMG'
	Layouts(1)=WeaponParams'TacticalParams_AR'
	Layouts(2)=WeaponParams'TacticalParams_Gauss'

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