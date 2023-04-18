class AK91WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=30
		HeadMult=2.85
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.rpk940.rpk-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=128
		Chaos=-1
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.140000
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		//TracerChance=1.000000
		TraceRange=(Min=600.000000,Max=600.000000)
		RangeAtten=0.200000
		TraceCount=3
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_GRSXXLaser'
		Damage=5
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.700000
		AmmoPerFire=0
		FireAnim="FireAlt"	
	FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		XRandFactor=0.300000
		YRandFactor=0.200000
		MaxRecoil=1524.000000
		DeclineTime=1.500000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=128,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams_Irons
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=61,Scale=0f)
		//SightOffset=(X=-10.000000,Y=-0.050000,Z=16.500000)
		ZoomType=ZT_Irons
		//Function
		InventorySize=7
		SightingTime=0.300000
		bNeedCock=True
		SightPivot=(Pitch=64)
		//ViewOffset=(X=5.000000,Y=7.000000,Z=-13.000000)
		ViewOffset=(X=9,Y=7.00,Z=-4)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_ACOG
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
		SightingTime=0.400000
		bNeedCock=True
		SightPivot=(Pitch=64)
		//ViewOffset=(X=5.000000,Y=7.000000,Z=-13.000000)
		ViewOffset=(X=9,Y=7.00,Z=-4)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Layouts(0)=WeaponParams'ClassicParams_Irons'
	Layouts(1)=WeaponParams'ClassicParams_ACOG'

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
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AK91Camos.AK91-TopQuantum",Index=2,AIndex=1,PIndex=1)
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
	
	Camos(0)=WeaponCamo'VK_Red'
	Camos(1)=WeaponCamo'VK_Green'
	Camos(2)=WeaponCamo'VK_Black'
	Camos(3)=WeaponCamo'VK_Desert'
	Camos(4)=WeaponCamo'VK_Quantum'
	Camos(5)=WeaponCamo'VK_Gold'

}