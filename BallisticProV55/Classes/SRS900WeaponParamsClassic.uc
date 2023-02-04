class SRS900WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35.0
		HeadMult=3.0
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrationEnergy=48.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=130.000000
		Chaos=0.015000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.125000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.300000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=3072)
		AimAdjustTime=0.650000
		CrouchMultiplier=0.300000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Silver Scoped"
		Weight=30
		
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Desert
		LayoutName="Desert Scoped"
		Weight=20
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_KBP_Tex.SRS900-K.SRS900-KMain',Index=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_KBP_Tex.SRS900-K.SRS900-KScopeShine',Index=1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_KBP_Tex.SRS900-K.SRS900-KAmmo',Index=2)
		
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_BlackNoScope
		LayoutName="Black"
		Weight=10
		
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.SRS.SRSNSGrey',Index=0)
		
		ZoomType=ZT_Irons
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_UrbanNoScope
		LayoutName="Urban"
		Weight=10
		
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.SKS650.SRSNSUrban',Index=0)
		
		ZoomType=ZT_Irons
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_DesertNoScope
		LayoutName="Desert"
		Weight=10
		
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.SKS650.SRSNSDesert',Index=0)
		
		ZoomType=ZT_Irons
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_GermanNoScope
		LayoutName="Flecktarn"
		Weight=10
		
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.SKS650.SRSM2German',Index=0)
		
		ZoomType=ZT_Irons
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_BlueNoScope
		LayoutName="Blue Amplified"
		Weight=3
		
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.SKS650.SRSNSJungle',Index=0)
		
		ZoomType=ZT_Irons
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_RedNoScope
		LayoutName="Red Amplified"
		Weight=3
		
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.SKS650.SRSNSTiger',Index=0)
		
		ZoomType=ZT_Irons
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_RedTigerNoScope
		LayoutName="Red Tiger"
		Weight=1
		
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.SKS650.SRSNSFlame',Index=0)
		
		ZoomType=ZT_Irons
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=20.000000,Z=11.750000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Desert'
	Layouts(2)=WeaponParams'ClassicParams_BlackNoScope'
	Layouts(3)=WeaponParams'ClassicParams_UrbanNoScope'
	Layouts(4)=WeaponParams'ClassicParams_DesertNoScope'
	Layouts(5)=WeaponParams'ClassicParams_GermanNoScope'
	Layouts(6)=WeaponParams'ClassicParams_RedNoScope'
	Layouts(7)=WeaponParams'ClassicParams_BlueNoScope'
	Layouts(8)=WeaponParams'ClassicParams_RedTigerNoScope'


}