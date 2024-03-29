class VSKWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - Heavy
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectHeavyParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35
		HeadMult=2.5
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_VSKTranq'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_VSKTranqHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_VSKTranq'
		PenetrationEnergy=1.000000
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.VSK.VSK-SuperShot',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=172.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireHeavyParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectHeavyParams'
	End Object
		
	//=================================================================
	// PRIMARY FIRE - Standard
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectStandardParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		Damage=15
		HeadMult=4.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_VSKTranq'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_VSKTranqHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_VSKTranq'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.VSK.VSK-Shot',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=88.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireStandardParams
		FireInterval=0.150000
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectStandardParams'
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
		MaxRecoil=2048.000000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		InventorySize=7
		bNeedCock=True
		MagAmmo=10
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_8XScope',BoneName="tip",Scale=0.1,AugmentOffset=(x=-20,y=-2,z=0),AugmentRot=(Pitch=32768,Yaw=0,Roll=-16384))
		SightOffset=(X=25.00,Y=0.40,Z=11.2)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		//Function
		SightPivot=(Pitch=0,Roll=0)
		ZoomType=ZT_Smooth
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireHeavyParams'
		FireParams(1)=FireParams'ClassicPrimaryFireStandardParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Irons
		Weight=30
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=10
		SightOffset=(X=20,Y=0.5,Z=3.2)
		SightPivot=(Pitch=0,Roll=0)
		ZoomType=ZT_Irons
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireHeavyParams'
		FireParams(1)=FireParams'ClassicPrimaryFireStandardParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Irons'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=VSK_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=VSK_UTC
		Index=1
		CamoName="UTC"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.VSKCamos.UTCVskShine",Index=1,PIndex=0,AIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'VSK_Gray'
    Camos(1)=WeaponCamo'VSK_UTC'
}