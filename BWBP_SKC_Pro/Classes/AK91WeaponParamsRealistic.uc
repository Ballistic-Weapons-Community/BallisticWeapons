class AK91WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1400.000000,Max=7000.000000) //7.62mm short
		WaterTraceRange=4000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		PenetrationEnergy=22.000000
		PenetrateForce=70
		bPenetrate=True
		PDamageFactor=0.600000
		WallPDamageFactor=0.600000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.300000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.rpk940.rpk-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=550.000000
		Chaos=0.1
		Heat=0.45
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.110000
		FireAnimRate=2.0
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		//TracerChance=1.000000
		TraceRange=(Min=600.000000,Max=600.000000)
		RangeAtten=0.200000
		TraceCount=3
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_GRSXXLaser'
		Damage=7
		DamageType=Class'BWBP_SKC_Pro.DT_AK91ZappedAlt'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK91ZappedAlt'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK91ZappedAlt'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'A49FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-SecFire',Volume=1.000000)
		Chaos=0.500000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.700000
		AmmoPerFire=0
		FireAnim="FireAlt"	
	FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.150000),(InVal=0.800000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.400000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2700.000000
		DeclineTime=1.500000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.150000),(InVal=0.800000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.400000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2700.000000
		DeclineTime=1.500000
		ViewBindFactor=0.100000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=700,Max=1324)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================		
	
	Begin Object Class=WeaponParams Name=RealisticParams_Irons
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=61,Scale=0f)
		//SightOffset=(X=-10.000000,Y=-0.050000,Z=16.500000)
		ZoomType=ZT_Irons
		//Function
		InventorySize=7
		WeaponPrice=2900
		SightMoveSpeedFactor=0.500000
		SightingTime=0.210000
		MagAmmo=25
		bMagPlusOne=True
		SightPivot=(Pitch=64)
		//ViewOffset=(X=0.000000,Y=5.000000,Z=-14.000000)
		WeaponName="AK-91 7.62mm Charge Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_ACOG
		//Layout core
		Weight=10
		LayoutName="ACOG"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=61,Scale=1f)
		//SightOffset=(X=-10.000000,Y=-0.050000,Z=16.500000)
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
		//Function
		InventorySize=7
		WeaponPrice=2900
		SightMoveSpeedFactor=0.500000
		SightingTime=0.310000
		MagAmmo=25
		bMagPlusOne=True
		SightPivot=(Pitch=64)
		//ViewOffset=(X=0.000000,Y=5.000000,Z=-14.000000)
		WeaponName="AK-91 7.62mm Charge Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object	

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=VK_Red
		Index=0
		CamoName="Red"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=VK_Green
		Index=1
		CamoName="Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-TopGreen",Index=2,AIndex=1,PIndex=1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=VK_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-MiscRed",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-TopBlack",Index=2,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=VK_Desert
		Index=3
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-MiscRed",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-TopDesert",Index=2,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=VK_Quantum
		Index=4
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-MiscRed",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-TopQuantumShine",Index=2,AIndex=1,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=VK_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-MiscRed",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-TopGold",Index=2,AIndex=1,PIndex=1)
		Weight=1
	End Object

    Layouts(0)=WeaponParams'RealisticParams_Irons'
	Layouts(1)=WeaponParams'RealisticParams_ACOG'
	
	Camos(0)=WeaponCamo'VK_Red'
	Camos(1)=WeaponCamo'VK_Green'
	Camos(2)=WeaponCamo'VK_Black'
	Camos(3)=WeaponCamo'VK_Desert'
	Camos(4)=WeaponCamo'VK_Quantum'
	Camos(5)=WeaponCamo'VK_Gold'
}