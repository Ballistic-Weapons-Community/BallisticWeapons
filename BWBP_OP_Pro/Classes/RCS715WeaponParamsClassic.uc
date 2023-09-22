class RCS715WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//12ga Shot
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=10
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_RCSShotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.000000
		HeadMult=1.0
		LimbMult=1.0
		DamageType=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_RCS715ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_OP_Pro.RCS715FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.RCS.RCS-Fire')
		Recoil=256.000000
		Chaos=0.500000
		Inaccuracy=(X=1200,Y=1200)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.500000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2.50000	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//12ga Explosive Slug
	Begin Object Class=GrenadeEffectParams Name=ClassicPrimaryEffectParams_Frag
		ProjectileClass=Class'BWBP_OP_Pro.RCS715Slug_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=18000.000000
		MaxSpeed=37000.000000
		AccelSpeed=37000.000000
		bCombinedSplashImpact=true
		ImpactDamage=30.000000
		Damage=60.000000
		DamageRadius=150.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_OP_Pro.RCS715FlashEmitter'
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.RCS.RCS-FireFrag')
		Recoil=512.000000
		Chaos=1
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
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2.50000	
	FireEffectParams(0)=GrenadeEffectParams'ClassicPrimaryEffectParams_Frag'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.RCS715Projectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=4000.000000
		MaxSpeed=15000.000000
		AccelSpeed=3000.000000
		Damage=50
		DamageRadius=128.000000
		MomentumTransfer=0.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=650.000000
		Chaos=0.450000
		BotRefireRate=0.600000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.GL-Fire',Volume=1.300000)	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.650000
		AmmoPerFire=0
		FireAnim="GLFire"
		FireAnimRate=1.250000	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		DeclineTime=1.0
		DeclineDelay=0.4
		ViewBindFactor=0.4
		ADSViewBindFactor=1.0
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		ChaosDeclineTime=2.000000
		SprintChaos=0.500000
		SprintOffset=(Pitch=-4096,Yaw=-4096)
		JumpChaos=1.000000
		JumpOffset=(Pitch=-1024,Yaw=-1024)
		FallingChaos=0.500000
		ChaosSpeedThreshold=565.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="12ga Shot"
		Weight=10
		//Attachments
        WeaponBoneScales(1)=(BoneName="LadderSightHinge",Slot=8,Scale=0f)
        WeaponBoneScales(2)=(BoneName="LadderSight",Slot=9,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.500000
		SightOffset=(X=0,Y=0,Z=1.4)
		//Function
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		InventorySize=8
		bNeedCock=True
		MagAmmo=20
		WeaponName="RCS-715 Assault Shotgun"
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ClassicParams_Frag
		//Layout core
		LayoutName="12ga Frag"
		Weight=10
		//Attachments
        WeaponBoneScales(1)=(BoneName="RedDotSight",Slot=8,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.500000
		SightOffset=(X=0,Y=0,Z=3.4)
		//Function
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		InventorySize=8
		bNeedCock=True
		MagAmmo=20
		WeaponName="RCS-715 Assault Shotgun (FRAG)"
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
    Layouts(1)=WeaponParams'ClassicParams_Frag'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=RCS_Red
		Index=0
		CamoName="Red"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Yellow
		Index=1
		CamoName="Yellow"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainYellowShine",Index=1,AIndex=0,PIndex=39)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainJungleShine",Index=1,AIndex=0,PIndex=39)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Arctic
		Index=3
		CamoName="Arctic"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainArcticShine",Index=1,AIndex=0,PIndex=39)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Clown
		Index=4
		CamoName="Clown"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainClownShine",Index=1,AIndex=0,PIndex=39)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'RCS_Red'
	Camos(1)=WeaponCamo'RCS_Yellow'
	Camos(2)=WeaponCamo'RCS_Jungle'
	Camos(3)=WeaponCamo'RCS_Arctic'
	Camos(4)=WeaponCamo'RCS_Clown'
	//Camos(5)=WeaponCamo'RCS_Gold'
}