class RCS715WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//12ga Buckshot
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=600.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		//TraceCount=8
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		//Damage=20.0
		TraceCount=8
		Damage=16.5
		DamageType=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_RCS715ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		HeadMult=2.05
		LimbMult=0.6
		PenetrationEnergy=5.000000
		PenetrateForce=8
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Single',Pitch=1.100000,Volume=1.100000)
		Recoil=900.000000
		Chaos=0.15000
		Inaccuracy=(X=700,Y=700)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.220000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.2000000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//10ga FRAG
	Begin Object Class=GrenadeEffectParams Name=RealisticPrimaryEffectParams_Frag
		ProjectileClass=Class'BWBP_OP_Pro.RCS715Slug_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=20000.000000
		MaxSpeed=55000.000000
		AccelSpeed=55000.000000
		ImpactDamage=90.000000
		Damage=125.000000
		DamageRadius=200.000000 //4 meter dmg radius, approx 1.5 meter kill radius
		MomentumTransfer=30000.000000
		HeadMult=2.0
		LimbMult=0.5
		MuzzleFlashClass=Class'BWBP_OP_Pro.RCS715FlashEmitter'
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.RCS.RCS-FireFrag')
		Recoil=1400.000000
		Chaos=0.25
		SplashDamage=True
		RecommendSplashDamage=True
		Inaccuracy=(X=64,Y=64)
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Frag
		TargetState="Projectile"
		FireInterval=0.220000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.2000000	
	FireEffectParams(0)=GrenadeEffectParams'RealisticPrimaryEffectParams_Frag'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
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

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.650000
		AmmoPerFire=0
		FireAnim="GLFire"
		FireAnimRate=1.250000	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.50000,OutVal=0.350000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.200000
		XRandFactor=0.280000
		YRandFactor=0.280000
		MaxRecoil=3600.000000
		DeclineTime=0.900000
		DeclineDelay=0.200000
		ViewBindFactor=0.060000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		SprintChaos=0.500000
		SprintOffset=(Pitch=-4096,Yaw=-4096)
		JumpChaos=1.000000
		JumpOffset=(Pitch=-1024,Yaw=-1024)
		FallingChaos=0.500000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.060000
		ChaosDeclineTime=1.400000
		ChaosSpeedThreshold=565.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
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
		InventorySize=8
		MagAmmo=20
		WeaponName="RCS-715 12ga Auto-Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Frag
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
		InventorySize=8
		MagAmmo=8
		WeaponName="RCS-715 12ga Auto-Shotgun (FRAG)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Frag'
	
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