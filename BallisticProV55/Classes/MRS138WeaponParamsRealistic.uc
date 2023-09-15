class MRS138WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//10ga shot
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=600.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		TraceCount=13
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		//Damage=20.0
		Damage=15.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMRS138Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)
		Recoil=1792.000000
		Chaos=-1.0
		Inaccuracy=(X=900,Y=900)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=0.8500000	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//10ga FRAG
	Begin Object Class=GrenadeEffectParams Name=RealisticPrimaryEffectParams_Frag
		ProjectileClass=Class'BallisticProV55.MRS138Slug_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=20000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		ImpactDamage=110.000000
		Damage=150.000000
		DamageRadius=200.000000 //4 meter dmg radius, approx 2 meter kill radius
		MomentumTransfer=30000.000000
		HeadMult=2.0
		LimbMult=0.5
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)
		Recoil=1792.000000
		Chaos=0.15
		SplashDamage=True
		RecommendSplashDamage=True
		Inaccuracy=(X=64,Y=64)
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Frag
		TargetState="Projectile"
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=0.8500000	
	FireEffectParams(0)=GrenadeEffectParams'RealisticPrimaryEffectParams_Frag'
	End Object
	
	//10ga Teargas
	Begin Object Class=GrenadeEffectParams Name=RealisticPrimaryEffectParams_Gas
		ProjectileClass=Class'BallisticProV55.MRS138Slug_Gas'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=20000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		ImpactDamage=60.000000
		Damage=50.000000
		DamageRadius=200.000000 //4 meter dmg radius
		bCombinedSplashImpact=true
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-FireSlug',Volume=1.500000)	
		Recoil=1792.000000
		Chaos=0.15
		SplashDamage=True
		RecommendSplashDamage=True
		Inaccuracy=(X=64,Y=64)
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Gas
		TargetState="Projectile"
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=0.8500000	
	FireEffectParams(0)=GrenadeEffectParams'RealisticPrimaryEffectParams_Gas'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRS138TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=12800.000000
		MaxSpeed=12800.000000
		Damage=5
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="TazerStart"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1792
		DeclineTime=0.550000
		DeclineDelay=0.250000
		ViewBindFactor=0.700000
		ADSViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.875000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=640,Max=1280)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.875000
		ADSMultiplier=0.875000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-2048)
		JumpChaos=0.700000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="10ga Shot"
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=5
		bMagPlusOne=True
		SightPivot=(Pitch=0,Yaw=0,Roll=0)
		WeaponName="MRS138 10ga Riot Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Frag
		//Layout core
		Weight=10
		LayoutName="10ga HE Slug"
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=5
		bMagPlusOne=True
		SightPivot=(Pitch=0,Yaw=0,Roll=0)
		WeaponName="MRS138 10ga Riot Shotgun (Frag)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Gas
		//Layout core
		Weight=10
		LayoutName="10ga Teargas Slug"
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=5
		bMagPlusOne=True
		SightPivot=(Pitch=0,Yaw=0,Roll=0)
		WeaponName="MRS138 10ga Riot Shotgun (Gas)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Gas'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Frag'
	Layouts(2)=WeaponParams'RealisticParams_Gas'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=MRS_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MRS_Arctic
		Index=1
		CamoName="Arctic"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MRS138Camos.MRSArctic-Main-Shine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=MRS_Gold
		Index=2
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MRS138Camos.MRSGold-Main-Shine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'MRS_Silver'
	Camos(1)=WeaponCamo'MRS_Arctic'
	Camos(2)=WeaponCamo'MRS_Gold'
}