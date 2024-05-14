class MRS138WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//10ga Shot
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.400000
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=30.0
		LimbMult=0.35
		DamageType=Class'BallisticProV55.DTMRS138Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=120
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter_C'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=900,Y=800)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=1.000000
		FireAnim="Fire"
		AimedFireAnim="AimedFire"
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=0.750000	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object	
	
	//10ga Explosive Slug
	Begin Object Class=GrenadeEffectParams Name=ClassicPrimaryEffectParams_Frag
		ProjectileClass=Class'BallisticProV55.MRS138Slug_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=20000.000000 //for now, needs accel tweaks
		MaxSpeed=350000.000000
		AccelSpeed=350000.000000
		bCombinedSplashImpact=true
		ImpactDamage=40.000000
		Damage=70.000000
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter_C'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)
		Recoil=1048.000000
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		bOverrideArming=true
		ArmingDelay=0.03
		DetonateDelay=0.03
		UnarmedDetonateOn=DT_Impact
		UnarmedPlayerImpactType=PIT_Detonate
		ArmedDetonateOn=DT_Impact
		ArmedPlayerImpactType=PIT_Detonate
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Frag
		TargetState="Projectile"
		FireInterval=1.000000
		FireAnim="Fire"
		AimedFireAnim="AimedFire"
		BurstFireRateFactor=1.00
		bCockAfterFire=True
	FireEffectParams(0)=GrenadeEffectParams'ClassicPrimaryEffectParams_Frag'
	End Object
	
	//10ga Teargas
	Begin Object Class=GrenadeEffectParams Name=ClassicPrimaryEffectParams_Gas
		ProjectileClass=Class'BallisticProV55.MRS138Slug_Gas'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2000.000000
		MaxSpeed=350000.000000
		AccelSpeed=350000.000000
		bCombinedSplashImpact=true
		ImpactDamage=40.000000
		Damage=40
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter_C'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-FireSlug',Volume=1.250000)	
		Recoil=1048.000000
		Chaos=-1.000000
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.5
		WarnTargetPct=0.75	
		bOverrideArming=true
		ArmingDelay=0.03
		DetonateDelay=0.03
		UnarmedDetonateOn=DT_Impact
		UnarmedPlayerImpactType=PIT_Detonate
		ArmedDetonateOn=DT_Impact
		ArmedPlayerImpactType=PIT_Detonate
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Gas
		TargetState="Projectile"
		FireInterval=1.000000
		FireAnim="Fire"
		AimedFireAnim="AimedFire"
		BurstFireRateFactor=1.00
		bCockAfterFire=True
	FireEffectParams(0)=GrenadeEffectParams'ClassicPrimaryEffectParams_Gas'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRS138TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=12800.000000
		MaxSpeed=12800.000000
		Damage=5
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="TazerStart"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=0.900000
		ViewBindFactor=0.900000
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
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.700000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=550.000000
		ChaosTurnThreshold=160000.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		Weight=30
		LayoutName="10ga Shot"
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		bNeedCock=True
		MagAmmo=7
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Frag
		//Layout core
		LayoutName="10ga HE Slug"
		Weight=10
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		bNeedCock=True
		MagAmmo=7
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Frag'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Gas
		//Layout core
		LayoutName="10ga Teargas Slug"
		Weight=10
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		bNeedCock=True
		MagAmmo=7
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Gas'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Frag'
	Layouts(2)=WeaponParams'ClassicParams_Gas'
	
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