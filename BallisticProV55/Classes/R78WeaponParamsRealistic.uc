class R78WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=3000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.1
		Damage=146.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTR78Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
		PenetrationEnergy=30.000000
		PenetrateForce=350
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-Fire',Pitch=1.000000,Volume=1.200000)
		Recoil=1792.000000
		Chaos=0.800000
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.250000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=0.7500000	
		AimedFireAnim="SightFireCock"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1792.000000
		DeclineTime=0.500000
		DeclineDelay=0.500000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1792)
		AimAdjustTime=0.350000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=0.750000
		ChaosSpeedThreshold=575.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Variable Scope"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=1f)
        ZoomType=ZT_Smooth
     	SightOffset=(X=-1.500000,Y=-0.5,Z=5.30000)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		MagAmmo=5
		bMagPlusOne=True
		//ViewOffset=(X=1.000000,Y=6.500000,Z=-12.000000)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.250000
		WeaponName="R87A1 .416 Sniper Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_NoScope
		//Layout core
		LayoutName="Iron Sights"
		LayoutTags="quickpull"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=0f)
		ZoomType=ZT_Irons
		SightPivot=(Pitch=-64)
		SightOffset=(X=5.00,Y=0.00,Z=1.9)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		//Function
		InventorySize=7
		MagAmmo=5
		bMagPlusOne=True
		//ViewOffset=(X=1.000000,Y=6.500000,Z=-12.000000)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.250000
		WeaponName="R87A1 .416 Sniper Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_NoScope'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=R78_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Wood
		Index=1
		CamoName="Black n' Wood"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainWood",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Desert
		Index=2
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Jungle
		Index=3
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainTiger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Urban
		Index=4
		CamoName="Urban"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainUrban",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Patriot
		Index=5
		CamoName="Patriot"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainPatriot",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Tiger
		Index=6
		CamoName="Red Tiger"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainRedTiger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Gold
		Index=7
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'R78_Gray'
	Camos(1)=WeaponCamo'R78_Wood'
	Camos(2)=WeaponCamo'R78_Desert'
	Camos(3)=WeaponCamo'R78_Jungle'
	Camos(4)=WeaponCamo'R78_Urban'
	Camos(5)=WeaponCamo'R78_Patriot'
	Camos(6)=WeaponCamo'R78_Tiger'
	Camos(7)=WeaponCamo'R78_Gold'
}