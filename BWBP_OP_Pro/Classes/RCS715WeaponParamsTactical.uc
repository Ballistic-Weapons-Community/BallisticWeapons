class RCS715WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//12ga Buckshot
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=6000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		RangeAtten=0.3
		TraceCount=10
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_RCSShotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_RCS715ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		PenetrateForce=100
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=384.000000
		Chaos=0.5
		BotRefireRate=0.900000
		WarnTargetPct=0.5	
		Inaccuracy=(X=256,Y=256)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Single',Pitch=1.100000,Volume=1.100000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2.50000	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//12ga Frag
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryEffectParams_Frag
		ProjectileClass=Class'BWBP_OP_Pro.RCS715Slug_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=500.000000
		AccelSpeed=800000.000000
		MaxSpeed=2000000.000000
		bCombinedSplashImpact=true
		Damage=75
        ImpactDamage=25
		PushbackForce=100.000000
		DamageRadius=200.000000
		MomentumTransfer=60000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		Recoil=768.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.75	
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.RCS.RCS-FireFrag')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Frag
		TargetState="Projectile"
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2.50000	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams_Frag'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.RCS715Projectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=2700.000000
		MaxSpeed=15000.000000
		AccelSpeed=3000.000000
		Damage=50
		DamageRadius=128.000000
		MomentumTransfer=0.000000
		PushbackForce=180.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		FlashScaleFactor=0.5
		Recoil=650.000000
		Chaos=0.450000
		BotRefireRate=0.600000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.GL-Fire',Volume=1.300000)	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.650000
		AmmoPerFire=0
		FireAnim="GLFire"
		FireAnimRate=1.250000	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.150000),(InVal=0.5,OutVal=0.250000),(InVal=0.750000,OutVal=0.30000),(InVal=1.000000,OutVal=0.350000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		ClimbTime=0.05
		DeclineDelay=0.25
		DeclineTime=1.0	
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.7
		AimAdjustTime=0.7
		AimSpread=(Min=384,Max=1280)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-1024,Yaw=-1024)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="12ga Shot"
		Weight=10
		//Attachments
        WeaponBoneScales(1)=(BoneName="LadderSightHinge",Slot=8,Scale=0f)
        WeaponBoneScales(2)=(BoneName="LadderSight",Slot=9,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.45
		SightOffset=(X=0,Y=0,Z=1.4)
		//Function
		PlayerSpeedFactor=0.95
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=15
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Frag
		//Layout core
		LayoutName="12ga Frag"
		Weight=10
		//Attachments
        WeaponBoneScales(1)=(BoneName="RedDotSight",Slot=8,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.45
		SightOffset=(X=0,Y=0,Z=3.4)
		//Function
		PlayerSpeedFactor=0.95
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=20 //set to 8 once model changes
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Frag'
	
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