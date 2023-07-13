class AK490WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		WaterTraceRange=10400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=35
		HeadMult=2.85
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		PenetrationEnergy=70.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.600000
		WallPDamageFactor=0.600000
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=286.000000
		Chaos=-1.0
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.110000
		BurstFireRateFactor=0.23
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Long Barrel
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_HeavyBarrel
		TraceRange=(Min=12000.000000,Max=13000.000000)
		WaterTraceRange=10400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=35
		HeadMult=2.85
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		PenetrationEnergy=70.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.600000
		WallPDamageFactor=0.600000
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C' //
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK490-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False) //
		Recoil=256.000000 //
		Chaos=0.05
		Inaccuracy=(X=6,Y=6)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_HeavyBarrel
		FireInterval=0.140000 //
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_HeavyBarrel'
	End Object
	
	//Suppressed
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Suppressed
		TraceRange=(Min=12000.000000,Max=13000.000000)
		WaterTraceRange=10400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=35
		HeadMult=2.85
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		PenetrationEnergy=70.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.600000
		WallPDamageFactor=0.600000
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK490-SilFire',Volume=1.500000,Radius=768.000000,bAtten=True) //
		Recoil=226.000000 //
		Chaos=0.05
		Inaccuracy=(X=4,Y=4)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Suppressed
		FireInterval=0.140000 //
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Suppressed'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AK490Knife'
		SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
		Speed=8500.000000
		MaxSpeed=8500.000000
		Damage=90
		BotRefireRate=0.300000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="PreKnifeFire"
		FireAnim="KnifeFire"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_Scope'
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
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================		
	
	Begin Object Class=WeaponParams Name=ClassicParams //Standard
		//Layout core
		Weight=30
		LayoutName="Carbine"
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000 // -.5
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=-6.500000,Y=0.02,Z=2.55)
		SightPivot=(Pitch=64)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ViewOffset=(X=6.000000,Y=5.000000,Z=-4.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsBurst'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Suppressed
		//Layout core
		Weight=10
		LayoutName="Suppressed"
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AKM490'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="Muzzle",Scale=0.05,AugmentOffset=(x=-26,y=-3.6,z=-0.2),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorAK',BoneName="Muzzle",AugmentOffset=(x=0,y=-0.5,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		SightOffset=(X=0.000000,Y=-0.250000,Z=6.505000)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.350000
		bNeedCock=True
		MagAmmo=20
		SightPivot=(Pitch=64)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ViewOffset=(X=6.000000,Y=5.000000,Z=-4.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsBurst'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Suppressed'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Scope
		//Layout core
		Weight=10
		LayoutName="4X Scope"
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AKM490'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Muzzle",Scale=0.07,AugmentOffset=(x=-26,y=-3.6,z=-0.1),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		SightOffset=(X=3.000000,Y=-0.100000,Z=5.000000)
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BWBP_SKC_Tex.VSK.VSKScopeView'
		MaxZoom=4
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.40000 //+.1
		bNeedCock=True
		MagAmmo=20
		SightPivot=(Pitch=64)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ViewOffset=(X=6.000000,Y=5.000000,Z=-4.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsBurst'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_HeavyBarrel'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Scope'
	End Object
	
    Layouts(0)=WeaponParams'ClassicParams'
    Layouts(1)=WeaponParams'ClassicParams_Suppressed'
    Layouts(2)=WeaponParams'ClassicParams_Scope'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=AK_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-C-CamoDesert",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Flecktarn
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-UC-CamoGerman",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Blood
		Index=3
		CamoName="Bloodied"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-UC-CamoBlood",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Blue
		Index=4
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-R-CamoBlue",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Red
		Index=5
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-R-CamoRed",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_AU
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.GoldAK-Shine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AK_Black' //Black
	Camos(1)=WeaponCamo'AK_Desert'
	Camos(2)=WeaponCamo'AK_Flecktarn'
	Camos(3)=WeaponCamo'AK_Blood'
	Camos(4)=WeaponCamo'AK_Blue'
	Camos(5)=WeaponCamo'AK_Red'
	Camos(6)=WeaponCamo'AK_AU'
}