class R78WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=115.0
		HeadMult=1.6
		LimbMult=0.4
		DamageType=Class'BallisticProV55.DTR78Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
		PenetrationEnergy=48.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-Fire')
		Recoil=3072.000000
		Chaos=-1.0
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
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
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=3072.000000
		DeclineTime=1.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.300000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=8,Max=3072)
		AimAdjustTime=0.700000
		CrouchMultiplier=0.300000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
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
		LayoutName="Black Scoped"
		Weight=30
		
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=7
		SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
		SightPivot=(Roll=-1024)
		ViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
        ZoomType=ZT_Logarithmic
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Tan
		LayoutName="Tan Scoped"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R87_Main-SD",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R87_Scope-SD",Index=2)
		InventorySize=15
		
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
		SightPivot=(Roll=-1024)
		ViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
        ZoomType=ZT_Logarithmic
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-DesertNS
		LayoutName="Desert RDS"
		Weight=10
		
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_R98'
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.RifleSkinDesertCamo",Index=0)
		InventorySize=15
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		ViewOffset=(X=8.000000,Y=4.000000,Z=-10.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-UrbanNS
		LayoutName="Urban" //Todo: Wood, quick pull
		Weight=10
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_R98'
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R98_UTiger-SD",Index=0)
		
		InventorySize=15
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		ViewOffset=(X=8.000000,Y=4.000000,Z=-10.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-JungleNS
		LayoutName="Jungle CQC Scope"
		Weight=10
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_R98'
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R98_JTiger-SD",Index=0)
		
		InventorySize=15
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		ViewOffset=(X=8.000000,Y=4.000000,Z=-10.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-TigerNS
		LayoutName="Red-Tiger Amplified"
		Weight=3
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_R98'
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R98_RTiger-SD",Index=0)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Amplifier',BoneName="Muzzle",Scale=0.2)
		
		InventorySize=15
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		ViewOffset=(X=8.000000,Y=4.000000,Z=-10.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-WinterNS
		LayoutName="Arctic Warfare"
		Weight=3
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_R98'
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R98_Winter-SD",Index=0)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="Muzzle",Scale=0.2)
		
		InventorySize=15
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		ViewOffset=(X=8.000000,Y=4.000000,Z=-10.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-AUNS
		LayoutName="ANUS"
		Weight=1
		
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_R98'
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.GoldRifle-Shine",Index=0)
		InventorySize=15
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		ViewOffset=(X=8.000000,Y=4.000000,Z=-10.000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-AU
		LayoutName="Gold"
		Weight=1
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.GoldRifle-Shine",Index=1)
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
		SightPivot=(Roll=-1024)
        ZoomType=ZT_Logarithmic
		ReloadAnimRate=1.250000
		CockAnimRate=1.250000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Tan'
	Layouts(2)=WeaponParams'ClassicParams-DesertNS'
	Layouts(3)=WeaponParams'ClassicParams-UrbanNS'
	Layouts(4)=WeaponParams'ClassicParams-JungleNS'
	Layouts(5)=WeaponParams'ClassicParams-TigerNS'
	Layouts(6)=WeaponParams'ClassicParams-WinterNS'
	Layouts(7)=WeaponParams'ClassicParams-AUNS'
	Layouts(8)=WeaponParams'ClassicParams-AU'
	
}