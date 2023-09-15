class MRS138WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//10ga shot
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=2048.000000,Max=2048.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		RangeAtten=0.2
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BallisticProV55.DTMRS138Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		Recoil=1536.000000
		Chaos=0.400000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		Inaccuracy=(X=256,Y=256)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.550000
		FireAnim="FireCombined"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//10ga HE
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryEffectParams_Frag
		ProjectileClass=Class'BallisticProV55.MRS138Slug_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		//Speed=9000.000000
		Speed=20000.000000 //for now, needs accel tweaks, phys_fall override
		AccelSpeed=27000.000000
		MaxSpeed=27000.000000
		bCombinedSplashImpact=true
		Damage=75
        ImpactDamage=70
		PushbackForce=100.000000
		DamageRadius=256.000000
		MomentumTransfer=60000.000000
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		Recoil=3072.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.75	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Frag
		TargetState="Projectile"
		FireInterval=0.550000
		FireAnim="FireCombined"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams_Frag'
	End Object
	
	//10ga Teargas
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryEffectParams_Gas
		ProjectileClass=Class'BallisticProV55.MRS138Slug_Gas'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2700.000000
		AccelSpeed=23000.000000
		MaxSpeed=23000.000000
		bCombinedSplashImpact=true
		Damage=35
        ImpactDamage=25
		PushbackForce=100.000000
		DamageRadius=256.000000
		MomentumTransfer=60000.000000
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		Recoil=3072.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.75	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-FireSlug',Volume=1.250000)	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Gas
		TargetState="Projectile"
		FireInterval=0.550000
		FireAnim="FireCombined"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams_Gas'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRS138TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=12800.000000
		MaxSpeed=12800.000000
		Damage=20
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.750000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="TazerStart"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.05)))
		YCurve=(Points=(,(InVal=0.2,OutVal=0.2),(InVal=0.4,OutVal=0.45),(InVal=0.75,OutVal=0.7),(InVal=1.000000,OutVal=1)))
		XRandFactor=0.2
		YRandFactor=0.2
		MaxRecoil=8192
		ClimbTime=0.075
		DeclineDelay=0.50000
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2
    End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
		AimSpread=(Min=128,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="10ga Shot"
		//Function
		SightingTime=0.30
        SightMoveSpeedFactor=0.6
		MagAmmo=6
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Frag
		//Layout core
		Weight=10
		LayoutName="10ga HE Slug"
		//Function
		SightingTime=0.30
        SightMoveSpeedFactor=0.6
		MagAmmo=6
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Gas
		//Layout core
		Weight=10
		LayoutName="10ga Teargas Slug"
		//Function
		SightingTime=0.30
        SightMoveSpeedFactor=0.6
		MagAmmo=6
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Gas'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Frag'
    Layouts(2)=WeaponParams'TacticalParams_Gas'
	
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