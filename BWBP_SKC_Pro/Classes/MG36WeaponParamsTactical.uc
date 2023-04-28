class MG36WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34 // 5.56
		HeadMult=3.25
		LimbMult=0.75
		PenetrationEnergy=18.000000
		PenetrateForce=55
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
		Recoil=140.000000
		Chaos=0.09
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		PitchFactor=0.250000
		YawFactor=0.300000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3200.000000
		DeclineTime=0.750000
		DeclineDelay=0.145000
		ViewBindFactor=0.350000
		ADSViewBindFactor=0.70000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		AimSpread=(Min=256,Max=2872)
		AimAdjustTime=0.8
		CrouchMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=0f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=0f)
		PlayerSpeedFactor=0.900000
		InventorySize=15
		SightMoveSpeedFactor=0.45
		SightingTime=0.3
		MagAmmo=100
		bMagPlusOne=True
		//ViewOffset=(X=5.000000,Y=4.000000,Z=-12.000000)
		//SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
		ZoomType=ZT_Logarithmic
		WeaponName="Mk 88 5.56mm Squad Automatic Weapon"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'

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