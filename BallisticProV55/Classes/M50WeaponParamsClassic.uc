class M50WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=25.0
		HeadMult=3.5
		LimbMult=0.45
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=72.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		AimedFireAnim="AimedFire"	
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	// Long Barreled
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Long
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=25.0
		HeadMult=3.5
		LimbMult=0.45
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M50.M50Fire3',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=52.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Long
		FireInterval=0.105000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Long'
	End Object
	
	//Suppressed
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Sil
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=25.0
		HeadMult=3.5
		LimbMult=0.45
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.F2000-SilFire',Volume=1.100000,Radius=192.000000,bAtten=True)
		Recoil=72.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Sil
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Sil'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M50Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4000.000000
		Damage=120.000000
		HeadMult=1.0
		LimbMult=1.0
		DamageRadius=240.000000
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50GrenFire')
		Recoil=0.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		bLimitMomentumZ=False
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.000000),(InVal=0.400000,OutVal=-0.300000),(InVal=0.600000,OutVal=0.400000),(InVal=0.800000,OutVal=-0.500000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.150000),(InVal=0.250000,OutVal=0.500000),(InVal=0.300000,OutVal=0.700000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.300000
		MaxRecoil=2048.000000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.500000
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
		LayoutName="Silver"
		Weight=30
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		ViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
		SightOffset=(Y=-1.000000,Z=14.800000)
		SightPivot=(Pitch=600,Roll=-1024)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		bNeedCock=True
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Stealth
		LayoutName="M50A1 Stealth"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50SkinA-D",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50SkinB-D",Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.M50.M50Laser',Index=4)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50Gren-D",Index=5)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50.M900Grenade',Index=6)
		AttachmentMaterialSwaps(0)=(Material=Texture'BWBP_SKC_TexExp.M30A2.M50SkinA-D',Index=0)
		AttachmentMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.M30A2.M50SkinB-D',Index=1)
		AttachmentMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50.M50Laser',Index=4)
		AttachmentMaterialSwaps(3)=(Material=Texture'BWBP_SKC_TexExp.M30A2.M50Gren-D',Index=3)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.1)
		ViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
		SightOffset=(Y=-1.000000,Z=14.800000)
		SightPivot=(Pitch=600,Roll=-1024)
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		bNeedCock=True
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Sil'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_AdvStealth
		LayoutName="M50A3 Adv Stealth"
		Weight=10
		
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_M50A3'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50SkinA-D",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50SkinB-D",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50A3-CoverBlack",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50A3-MainBlack",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50A3-Barrel",Index=5)
		WeaponMaterialSwaps(6)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50A3-Misc",Index=6)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.1)
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="Scope",Scale=0.05)
        WeaponBoneScales(0)=(BoneName="Sights",Slot=0,Scale=0f)
		ViewOffset=(X=-4.000000,Y=10.00000,Z=-15.000000)
		SightOffset=(X=0.000000,Y=-6.580000,Z=21.65000)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		bNeedCock=True
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Sil'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Desert
		LayoutName="M50A3 Desert Ops"
		Weight=10
		
		LayoutMesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_M50A3'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.M30A2.M50SkinA-D',Index=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_TexExp.M30A2.M50SkinB-D',Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_TexExp.M50A3.M50A3-CoverTan',Index=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_TexExp.M50A3.M50A3-MainTan',Index=4)
		WeaponMaterialSwaps(5)=(Material=Texture'BWBP_SKC_TexExp.M50A3.M50A3-Barrel',Index=5)
		WeaponMaterialSwaps(6)=(Material=Texture'BWBP_SKC_TexExp.M50A3.M50A3-Misc',Index=6)
		//GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="Scope",Scale=0.15)
		ViewOffset=(X=-4.000000,Y=10.00000,Z=-15.000000)
		SightOffset=(X=0.000000,Y=-6.580000,Z=21.65000)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		bNeedCock=True
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Long'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Jungle
		LayoutName="Jungle Burst"
		Weight=10
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SATiger",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SBTiger",Index=2)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Scope",Scale=0.15)
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		ZoomType=ZT_Fixed
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		ViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
		SightOffset=(Y=-1.000000,Z=14.800000)
		SightPivot=(Pitch=600,Roll=-1024)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		bNeedCock=True
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_GaussTiger
		LayoutName="Gauss Prototype"
		Weight=10
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SATiger",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SBTiger",Index=2)
		ScopeViewTex=Texture'BWBP_SKC_Tex.M30A2.M30A2-Scope'
		ZoomType=ZT_Logarithmic
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		ViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
		SightOffset=(Y=-1.000000,Z=14.800000)
		SightPivot=(Pitch=600,Roll=-1024)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		bNeedCock=True
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Gold
		LayoutName="Gold"
		Weight=1
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main1_S1",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main2_S1",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Laser_S1",Index=4)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main3_S1",Index=5)
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		ViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
		SightOffset=(Y=-1.000000,Z=14.800000)
		SightPivot=(Pitch=600,Roll=-1024)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		bNeedCock=True
		MagAmmo=80
		ReloadAnimRate=1.500000
		CockAnimRate=1.500000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams' //M50 (Silver, GL)
	Layouts(1)=WeaponParams'ClassicParams_Stealth' //M50 (Black, Suppressed, Smoke GL, Burst)
	Layouts(2)=WeaponParams'ClassicParams_AdvStealth'//M50A3 Stealth (Black, Suppressed, EO Tech)
	Layouts(3)=WeaponParams'ClassicParams_Desert' //M50A3 Desert (Tan, Irons)
	Layouts(4)=WeaponParams'ClassicParams_Jungle' //M50A1 Jungle (Jungle, Scope, GL, Burst)
	Layouts(5)=WeaponParams'ClassicParams_GaussTiger' //M50A1 Gauss Prototype (M30A2, Screen Scope, Gauss, Burst)
	Layouts(6)=WeaponParams'ClassicParams_Gold' //M50 (Gold, GL)


}