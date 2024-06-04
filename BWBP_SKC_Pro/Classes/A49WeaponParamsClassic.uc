class A49WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.A49Projectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=40.000000
		MaxSpeed=8000.000000
		AccelSpeed=60000.000000
		Damage=15
		DamageRadius=48.000000
		MomentumTransfer=100.000000
		HeadMult=2.0
		LimbMult=0.5
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-Fire',Pitch=1.200000,Volume=0.700000)
		Recoil=24.000000
		Chaos=-1.0
		Heat=0.5
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Lob Shot
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams_Bomb
		ProjectileClass=Class'BWBP_SKC_Pro.A49LobProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=3000.000000
		MaxSpeed=15000.000000
		AccelSpeed=4000.000000
		Damage=80
		DamageRadius=340.000000
		RadiusFallOffType=RFO_Linear
		MomentumTransfer=80000.000000
		bLimitMomentumZ=False
		HeadMult=2.0
		LimbMult=0.5
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire',Volume=1.300000)
		Recoil=880.000000
		Chaos=-1.0
		Heat=5
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Bomb
		FireInterval=0.850000
		BurstFireRateFactor=1.00
		AmmoPerFire=10
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams_Bomb'
	End Object
	
	//Charge Lob Shot
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams_ChargeBomb
		ProjectileClass=Class'BWBP_SKC_Pro.A49LobProjectileRed'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=3000.000000
		MaxSpeed=15000.000000
		AccelSpeed=4000.000000
		Damage=80
		DamageSpecial=40
		DamageRadius=340.000000
		RadiusFallOffType=RFO_Linear
		MomentumTransfer=80000.000000
		bLimitMomentumZ=False
		HeadMult=2.0
		LimbMult=0.5
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire',Volume=1.300000)
		Recoil=1280.000000
		Chaos=-1.0
		Heat=6
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_ChargeBomb
		TargetState="ChargeFire"
		FireInterval=1.850000
		BurstFireRateFactor=1.00
		AmmoPerFire=10
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams_ChargeBomb'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================
	
	Begin Object Class=FireEffectParams Name=ClassicAltEffectParams
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A49FlashEmitter'
		FlashScaleFactor=1.200000
     	Recoil=2048.000000
     	Chaos=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-ShockWave',Volume=2.000000)
     	WarnTargetPct=0.100000
		PushbackForce=2000.000000
	End Object
	
	Begin Object Class=FireParams Name=ClassicAltFireParams
		FireAnim="AltFire"
		FireInterval=1.7
     	AmmoPerFire=10
		FireEffectParams(0)=FireEffectParams'ClassicAltEffectParams'
	End Object
    
	//=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.450000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Heavy SMG handling
		AimSpread=(Min=16,Max=2048)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		AimDamageThreshold=75.000000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.750000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=900.000000
		ChaosTurnThreshold=185000.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout Core
		LayoutName="Standard"
        Weight=30
		//ADS
		SightPivot=(Pitch=768)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30000
		//Layout Core
        InventorySize=3
		MagAmmo=40
		WeaponModes(0)=(ModeName="Concussive Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		ViewOffset=(X=8.000000,Y=8.000000,Z=-5.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Bomb'
        AltFireParams(0)=FireParams'ClassicAltFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Red
		//Layout Core
		LayoutName="Elite"
		LayoutTags="charge"
        Weight=10
		//ADS
		SightPivot=(Pitch=768)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30000
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.A6Red.A49-RedFull',Index=1,AIndex=0,PIndex=0)
		//Layout Core
        InventorySize=3
		MagAmmo=40
		WeaponModes(0)=(ModeName="Charge Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		ViewOffset=(X=8.000000,Y=8.000000,Z=-5.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_ChargeBomb'
        AltFireParams(0)=FireParams'ClassicAltFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Pink
		//Layout Core
		LayoutName="CQC"
		LayoutTags="mod_rof"
		Weight=10
		//ADS
		SightPivot=(Pitch=768)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30000
		//Layout Core
        InventorySize=3
		MagAmmo=40
		WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		ViewOffset=(X=8.000000,Y=8.000000,Z=-5.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
        AltFireParams(0)=FireParams'ClassicAltFireParams'
	End Object
	
    Layouts(0)=WeaponParams'ClassicParams'
    Layouts(1)=WeaponParams'ClassicParams_Red'
    Layouts(2)=WeaponParams'ClassicParams_Pink'
}

