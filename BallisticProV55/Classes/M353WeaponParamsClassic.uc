class M353WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=17.0
		HeadMult=3.3
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM353MG'
		DamageTypeHead=Class'BallisticProV55.DTM353MGHead'
		DamageTypeArm=Class'BallisticProV55.DTM353MG'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter_C'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Fire1',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=64.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=3000.000000
		ViewBindFactor=0.450000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=1500)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=2000,Yaw=-5000)
		FallingChaos=0.500000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Default"
		Weight=30
		//Attachments
		//Function
		PlayerSpeedFactor=0.900000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=150
		SightOffset=(X=-8.000000,Y=-0.200000,Z=7.500000)
		SightPivot=(Pitch=512,Roll=-512)
		WeaponModes(0)=(bUnavailable=True)
		WeaponModes(1)=(ModeName="Burst of Three",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=3
		CockAnimRate=1.000000
		ReloadAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M353_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Jungle
		Index=1
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S2",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S2",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S2",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Arctic
		Index=2
		CamoName="Arctic"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S1",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S1",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S1",Index=1,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Ocean
		Index=3
		CamoName="Ocean"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S3",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S3",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S3",Index=1,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Gold
		Index=4
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S4",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S4",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S4",Index=1,AIndex=2,PIndex=2)
	End Object
	
	Camos(0)=WeaponCamo'M353_Gray'
    Camos(1)=WeaponCamo'M353_Jungle'
    Camos(2)=WeaponCamo'M353_Arctic'
    Camos(3)=WeaponCamo'M353_Ocean'
    Camos(4)=WeaponCamo'M353_Gold'
}