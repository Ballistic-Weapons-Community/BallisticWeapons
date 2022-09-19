class RSDarkWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
    // PRIMARY FIRE
    //=================================================================	

	//Big Boom
    Begin Object Class=ProjectileEffectParams Name=ClassicBoltEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=500
        AccelSpeed=16000
        MaxSpeed=4000
        Damage=80
		DamageRadius=192
		HeadMult=1.375
		LimbMult=0.625
		MomentumTransfer=80000
    	Recoil=60.000000
	    Chaos=0.020000
		RadiusFallOffType=RFO_Linear
		bLimitMomentumZ=False
		SpreadMode=FSM_Rectangle
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkProjectile'
        WarnTargetPct=0.200000
		Inaccuracy=(X=8,Y=8)
    End Object

    Begin Object Class=FireParams Name=ClassicBoltFireParams
		AmmoPerFire=3
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'ClassicBoltEffectParams'
    End Object	
	
	//Small Boom
	Begin Object Class=ProjectileEffectParams Name=ClassicFastEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=50
        AccelSpeed=30000
        MaxSpeed=7000
        Damage=18
		DamageRadius=48
		bLimitMomentumZ=False
		HeadMult=1.375
		LimbMult=0.625
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MomentumTransfer=100
    	Recoil=14.000000
	    Chaos=0.005000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire2',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFastProjectile'
        WarnTargetPct=0.200000
		Inaccuracy=(X=8,Y=8)
    End Object

    Begin Object Class=FireParams Name=ClassicFastFireParams
		AmmoPerFire=1
		FireAnim="Fire2"
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.150000
        FireEffectParams(0)=ProjectileEffectParams'ClassicFastEffectParams'
    End Object	
	
	//Plasmathrower
	Begin Object Class=ProjectileEffectParams Name=ClassicFlameEffectParams
    	MuzzleFlashClass=None
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=1300.000000
        AccelSpeed=0.000000
        MaxSpeed=1300.000000
        Damage=12.000000
		DamageRadius=192.000000
		MomentumTransfer=0.000000
    	Recoil=7.000000
	    Chaos=0.015000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFlameProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ClassicFlameFireParams
		TargetState="DarkFlamer"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'ClassicFlameEffectParams'
    End Object  

	//Immolate
	Begin Object Class=ProjectileEffectParams Name=ClassicConeEffectParams
    	MuzzleFlashClass=None
		SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=50.000000
		DamageRadius=
		MomentumTransfer=
		MaxDamageGainFactor=
		DamageGainStartTime=
		DamageGainEndTime=
    	Recoil=7.000000
	    Chaos=0.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ClassicConeFireParams
		TargetState="Immolate"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'ClassicConeEffectParams'
    End Object     

	//Firebomb
	Begin Object Class=ProjectileEffectParams Name=ClassicBombEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=50.000000
        AccelSpeed=0.000000
        MaxSpeed=1500.000000
        Damage=120.000000
		DamageRadius=384.000000
		MomentumTransfer=80000.000000
		bLimitMomentumZ=False
		HeadMult=1.375
		LimbMult=0.625
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
    	Recoil=60.000000
	    Chaos=0.020000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-FireBall',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFireBomb'
        WarnTargetPct=0.200000
		Inaccuracy=(X=8,Y=8)
    End Object

    Begin Object Class=FireParams Name=ClassicBombFireParams
		TargetState="Fireball"
		AmmoPerFire=3
		FireAnim="Fire"
        AimedFireAnim=
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'ClassicBombEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=180.000000,Max=180.000000)
		WaterTraceRange=5000.0
		Damage=50.0
		HeadMult=1f
		LimbMult=1f
		DamageType=Class'BallisticProV55.DT_RSDarkStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSDarkStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSDarkStab'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.000000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-SawOpen',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.100000
		AmmoPerFire=0
		FireAnim="SawStart"
		FireEndAnim="SawEnd"
		FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=-0.150000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=-1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.300000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		DeclineTime=1.000000
		ViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
 
	Begin Object Class=RecoilParams Name=ClassicFastRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
	    XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.5
		ViewBindFactor=0.5
		DeclineDelay=0.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=2048)
		AimAdjustTime=0.700000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=1600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=66
		SightOffset=(X=-12.000000,Z=10.100000)
		SightPivot=(Pitch=1400)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParams'
		RecoilParams(2)=RecoilParams'ClassicRecoilParams'
		RecoilParams(3)=RecoilParams'ClassicRecoilParams'
		RecoilParams(4)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ClassicAimParams'
		AimParams(2)=AimParams'ClassicAimParams'
		AimParams(3)=AimParams'ClassicAimParams'
		AimParams(4)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicBoltFireParams'
		FireParams(1)=FireParams'ClassicFastFireParams'
		FireParams(2)=FireParams'ClassicFlameFireParams'
		FireParams(3)=FireParams'ClassicConeFireParams'
		FireParams(4)=FireParams'ClassicBombFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}