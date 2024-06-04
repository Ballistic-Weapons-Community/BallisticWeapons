class A49WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

	//Rapid Fire
	Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.A49Projectile'
        SpawnOffset=(X=25.000000,Y=6.000000,Z=-8.000000)
        Speed=5500.000000
        AccelSpeed=100000.000000
        MaxSpeed=8500.000000
        Damage=40.000000
        DamageRadius=48.000000
     	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.150000
     	Recoil=108.000000
     	Chaos=0.070000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-Fire',Volume=0.700000,Pitch=1.200000)
		WarnTargetPct=0.2
		BotRefireRate=0.99
	End Object
		
	Begin Object Class=FireParams Name=ArenaProjFireParams
		FireEndAnim=
		FireInterval=0.120000
		FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams'
	End Object
	
	//Lob Shot
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Bomb
		ProjectileClass=Class'BWBP_SKC_Pro.A49LobProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=3000.000000
		MaxSpeed=15000.000000
		AccelSpeed=4000.000000
		Damage=80
		DamageRadius=100.000000
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire',Volume=1.300000)
		Recoil=880.000000
     	Chaos=0.370000
		Heat=5
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Bomb
		FireInterval=0.850000
		AmmoPerFire=8
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Bomb'
	End Object
	
	//Charge Lob Shot
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_ChargeBomb
		ProjectileClass=Class'BWBP_SKC_Pro.A49LobProjectileRed'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=3000.000000
		MaxSpeed=15000.000000
		AccelSpeed=4000.000000
		Damage=100
		DamageSpecial=60
		DamageRadius=200.000000
		HeadMult=2.0
		LimbMult=0.5
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire',Volume=1.300000)
		Recoil=1280.000000
     	Chaos=0.370000
		Heat=6
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_ChargeBomb
		TargetState="ChargeFire"
		FireInterval=1.450000
		AmmoPerFire=8
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_ChargeBomb'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

	Begin Object Class=FireEffectParams Name=ArenaAltEffectParams
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A49FlashEmitter'
		FlashScaleFactor=1.200000
     	Recoil=512.000000
     	Chaos=0.500000
		PushbackForce=1500.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-ShockWave',Volume=2.000000)
     	WarnTargetPct=0.100000
		BotRefireRate=0.900000
	End Object

	Begin Object Class=FireParams Name=ArenaAltFireParams
		FireAnim="AltFire"
		FireInterval=1.25
     	AmmoPerFire=8
		FireEffectParams(0)=FireEffectParams'ArenaAltEffectParams'
	End Object

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=-0.050000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.070000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.400000),(InVal=0.540000,OutVal=0.650000),(InVal=0.700000,OutVal=0.720000),(InVal=1.000000,OutVal=0.300000)))
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.170000
		CrouchMultiplier=1
	End Object

	//=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.350000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=7500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout Core
		LayoutName="Standard"
        Weight=30
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		//Layout Core
		PlayerJumpFactor=1.050000
		InventorySize=4
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.5
		MagAmmo=32
		WeaponModes(0)=(ModeName="Concussive Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Bomb'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams_Red
		//Layout Core
		LayoutName="Elite"
		LayoutTags="charge"
        Weight=10
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.A6Red.A49-RedFull',Index=1,AIndex=0,PIndex=0)
		//Layout Core
		PlayerJumpFactor=1.050000
		InventorySize=4
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.5
		MagAmmo=32
		WeaponModes(0)=(ModeName="Charge Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_ChargeBomb'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams_Pink
		//Layout Core
		LayoutName="CQC"
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		//Layout Core
		PlayerJumpFactor=1.050000
		InventorySize=4
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.5
		MagAmmo=32
		WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaProjFireParams'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Red'
    Layouts(2)=WeaponParams'ArenaParams_Pink'
}