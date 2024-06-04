class A49WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

	//Rapid
	Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.A49Projectile'
        SpawnOffset=(X=25.000000,Y=6.000000,Z=-8.000000)
        Speed=4000.000000
        MaxSpeed=10000.000000
        AccelSpeed=60000.000000
        Damage=45.000000
        HeadMult=2.5
        LimbMult=0.67
        DamageRadius=48.000000
        MaxDamageGainFactor=0.35
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
     	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.150000
     	Recoil=108.000000
     	Chaos=0.070000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-Fire',Volume=0.700000,Pitch=1.200000)
		WarnTargetPct=0.2
		BotRefireRate=0.99
	End Object
		
	Begin Object Class=FireParams Name=TacticalProjFireParams
		FireEndAnim=
		FireInterval=0.115000
		FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams'
	End Object
	
	//Lob Shot
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams_Bomb
		ProjectileClass=Class'BWBP_SKC_Pro.A49LobProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=3000.000000
		MaxSpeed=15000.000000
		AccelSpeed=4000.000000
		Damage=100
		DamageRadius=160.000000
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire',Volume=1.300000)
		Recoil=880.000000
     	Chaos=0.370000
		Heat=5
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Bomb
		FireInterval=0.850000
		AmmoPerFire=8
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams_Bomb'
	End Object
	
	//Charge Lob Shot
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams_ChargeBomb
		ProjectileClass=Class'BWBP_SKC_Pro.A49LobProjectileRed'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=3000.000000
		MaxSpeed=15000.000000
		AccelSpeed=4000.000000
		Damage=100
		DamageSpecial=60
		DamageRadius=200.000000
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire',Volume=1.300000)
		Recoil=1280.000000
     	Chaos=0.570000
		Heat=6
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_ChargeBomb
		TargetState="ChargeFire"
		FireInterval=1.850000
		AmmoPerFire=8
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams_ChargeBomb'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

	Begin Object Class=FireEffectParams Name=TacticalAltEffectParams
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A49FlashEmitter'
		FlashScaleFactor=1.200000
     	Recoil=512.000000
     	Chaos=0.5
		PushbackForce=1500.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-ShockWave',Volume=2.000000)
     	WarnTargetPct=0.100000
		BotRefireRate=0.900000
	End Object

	Begin Object Class=FireParams Name=TacticalAltFireParams
		FireAnim="AltFire"
		FireInterval=1.25
     	AmmoPerFire=8
		FireEffectParams(0)=FireEffectParams'TacticalAltEffectParams'
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.4
		ADSViewBindFactor=0.7
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=-0.050000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.070000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.400000),(InVal=0.540000,OutVal=0.650000),(InVal=0.700000,OutVal=0.720000),(InVal=1.000000,OutVal=0.300000)))
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.170000
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=2
	End Object

	//=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout Core
		LayoutName="Standard"
        Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.20
		//Layout Core
		InventorySize=4
		DisplaceDurationMult=0.5
		MagAmmo=32
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Concussive Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Bomb'
        AltFireParams(0)=FireParams'TacticalAltFireParams'
    End Object

	Begin Object Class=WeaponParams Name=TacticalParams_Red
		//Layout Core
		LayoutName="Elite"
		LayoutTags="charge"
        Weight=10
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.2
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.A6Red.A49-RedFull',Index=1,AIndex=0,PIndex=0)
		//Layout Core
		InventorySize=4
		DisplaceDurationMult=0.5
		MagAmmo=32
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Concussive Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_ChargeBomb'
        AltFireParams(0)=FireParams'TacticalAltFireParams'
    End Object

	Begin Object Class=WeaponParams Name=TacticalParams_Pink
		//Layout Core
		LayoutName="CQC"
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.2
		//Layout Core
		InventorySize=4
		DisplaceDurationMult=0.5
		MagAmmo=32
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalProjFireParams'
        AltFireParams(0)=FireParams'TacticalAltFireParams'
    End Object
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Red'
    Layouts(2)=WeaponParams'TacticalParams_Pink'
}