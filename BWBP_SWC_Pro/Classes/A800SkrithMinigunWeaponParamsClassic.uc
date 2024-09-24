class A800SkrithMinigunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A73NewProjectile'
		SpawnOffset=(X=1.000000,Y=5.000000,Z=-5.000000)
		Speed=3000.000000
		MaxSpeed=9000.000000
		AccelSpeed=60000.000000
		Damage=27
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_SWC_Sounds.A800.A800-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=40.000000
		PushbackForce=15
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.075000
		FireLoopAnim="FireLoop"
		FireEndAnim="FireEnd"
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Elite - Red, fast, and bounces
	Begin Object Class=GrenadeEffectParams Name=ClassicPrimaryEffectParams_Elite
		ProjectileClass=Class'BWBP_SWC_Pro.A800Projectile_Red'
		SpawnOffset=(X=1.000000,Y=5.000000,Z=-5.000000)
		Speed=3000.000000
		MaxSpeed=9000.000000
		AccelSpeed=60000.000000
		Damage=45
		FlashScaleFactor=0.500000
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Fire',Volume=1.200000,Pitch=1.1,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=80.000000
		PushbackForce=45
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Elite
		AmmoPerFire=2
		FireInterval=0.15000
		FireLoopAnim="FireLoop"
		FireEndAnim="FireEnd"
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=GrenadeEffectParams'ClassicPrimaryEffectParams_Elite'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A800StickyBombProjectile'
		SpawnOffset=(X=400.000000,Y=7.000000,Z=-9.000000)
		Speed=1000.000000
		MaxSpeed=2000.000000
		AccelSpeed=8000.000000
		Damage=150
		DamageRadius=230.000000
		MomentumTransfer=50000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SWC_Sounds.A800.A800-AltFire2',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.550000
		AmmoPerFire=10
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(Inval=1.0,OutVal=0.1)))
		YCurve=(Points=(,(Inval=1.0,OutVal=0.1)))
		//XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		//YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.450000
		YRandFactor=0.450000
		DeclineTime=1.700000
		DeclineDelay=0.40000
		MaxRecoil=512
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		ViewBindFactor=0.5
		ADSMultiplier=1
		AimSpread=(Min=128,Max=2500)
		AimAdjustTime=1.000000
		OffsetAdjustTime=0.650000
		AimDamageThreshold=75.000000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		ChaosSpeedThreshold=300
		FallingChaos=0.500000
		ChaosDeclineTime=5.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Replacable Cells"
		Weight=30
		AllowedCamos(0)=0
		//ADS
		SightingTime=0.600000
        SightMoveSpeedFactor=0.75
		ZoomType=ZT_Logarithmic
		//Stats
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
        MagAmmo=80
        InventorySize=12
		SightOffset=(X=-30.000000,Y=-25.000000,Z=6.500000)
		SightPivot=(Roll=-1900)
		ViewOffset=(X=20.000000,Y=20.000000,Z=-15.000000)
		ViewPivot=(Roll=-256)
		ReloadAnimRate=1.300000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_BigBattery
		//Layout core
		LayoutName="Integrated Cells"
		LayoutTags="no_reload"
		Weight=5
		AllowedCamos(0)=0
		//ADS
		SightingTime=0.600000
        SightMoveSpeedFactor=0.75
		ZoomType=ZT_Logarithmic
		//Stats
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
        MagAmmo=200
        InventorySize=12
		SightOffset=(X=-30.000000,Y=-25.000000,Z=6.500000)
		SightPivot=(Roll=-1900)
		ViewOffset=(X=20.000000,Y=20.000000,Z=-15.000000)
		ViewPivot=(Roll=-256)
		ReloadAnimRate=1.300000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Elite
		//Layout core
		LayoutName="Elite"
		LayoutTags="no_reload"
		Weight=5
		AllowedCamos(0)=2
		//ADS
		SightingTime=0.600000
        SightMoveSpeedFactor=0.75
		ZoomType=ZT_Logarithmic
		//Stats
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
        MagAmmo=250
        InventorySize=12
		SightOffset=(X=-30.000000,Y=-25.000000,Z=6.500000)
		SightPivot=(Roll=-1900)
		ViewOffset=(X=20.000000,Y=20.000000,Z=-15.000000)
		ViewPivot=(Roll=-256)
		ReloadAnimRate=1.300000
		WeaponModes(0)=(ModeName="Reflect Fire",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Fire",bUnavailable=True,ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="2400 RPM",bUnavailable=True,ModeID="WM_FullAuto")
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Elite'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_BigBattery'
	Layouts(2)=WeaponParams'ClassicParams_Elite'
	
	//Camos =========================================
	Begin Object Class=WeaponCamo Name=A800_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=A800_Pink
		Index=1
		CamoName="Pink"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73AmmoSkin',Index=1,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.A73PurpleLayout.A73Skin_SD',Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.A73PurpleLayout.A73Skin_SD',Index=2,AIndex=-1,PIndex=4)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73SkinB',Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.A73.A73BladeShader',Index=4,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=A800_Orange
		Index=2
		CamoName="Orange"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HyperblasterCamos.Hyper-RedFront",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.HyperblasterCamos.Hyper-RedRear",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.HyperblasterCamos.Hyper-RedCore",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.A73RedLayout.A73BAmmoSkin',Index=4,AIndex=3,PIndex=3)
	End Object
	
	Camos(0)=WeaponCamo'A800_Blue'
	Camos(1)=WeaponCamo'A800_Pink'
	Camos(2)=WeaponCamo'A800_Orange'
}