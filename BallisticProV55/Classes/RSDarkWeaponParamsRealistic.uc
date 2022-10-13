class RSDarkWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
    // PRIMARY FIRE
    //=================================================================	

	//Big Boom
    Begin Object Class=ProjectileEffectParams Name=RealisticBoltEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=5000
        AccelSpeed=10000
        MaxSpeed=14000
        Damage=80
		DamageRadius=192
		HeadMult=1.375
		LimbMult=0.625
		MomentumTransfer=80000
    	Recoil=60.000000
	    Chaos=0.020000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkProjectile'
        WarnTargetPct=0.200000
		Inaccuracy=(X=32,Y=32)
    End Object

    Begin Object Class=FireParams Name=RealisticBoltFireParams
		AmmoPerFire=3
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.990000
        FireEffectParams(0)=ProjectileEffectParams'RealisticBoltEffectParams'
    End Object	
	
	//Small Boom
	Begin Object Class=ProjectileEffectParams Name=RealisticFastEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=4000
        AccelSpeed=80000
        MaxSpeed=10000
        Damage=40
		DamageRadius=48
		HeadMult=1.375
		LimbMult=0.625
		MomentumTransfer=100
    	Recoil=14.000000
	    Chaos=0.005000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire2',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFastProjectile'
        WarnTargetPct=0.200000
		Inaccuracy=(X=32,Y=32)
    End Object

    Begin Object Class=FireParams Name=RealisticFastFireParams
		AmmoPerFire=1
		FireAnim="Fire2"
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.155000
        FireEffectParams(0)=ProjectileEffectParams'RealisticFastEffectParams'
    End Object	
	
	//Plasmathrower
	Begin Object Class=ProjectileEffectParams Name=RealisticFlameEffectParams
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

    Begin Object Class=FireParams Name=RealisticFlameFireParams
		TargetState="DarkFlamer"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'RealisticFlameEffectParams'
    End Object  

	//Immolate
	Begin Object Class=ProjectileEffectParams Name=RealisticConeEffectParams
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

    Begin Object Class=FireParams Name=RealisticConeFireParams
		TargetState="Immolate"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'RealisticConeEffectParams'
    End Object     

	//Firebomb
	Begin Object Class=ProjectileEffectParams Name=RealisticBombEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=4000.000000
        AccelSpeed=0.000000
        MaxSpeed=4000.000000
        Damage=140.000000
		DamageRadius=384.000000
		HeadMult=1.375
		LimbMult=0.625
		MomentumTransfer=80000.000000
    	Recoil=60.000000
	    Chaos=0.020000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-FireBall',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFireBomb'
        WarnTargetPct=0.200000
		Inaccuracy=(X=32,Y=32)
    End Object

    Begin Object Class=FireParams Name=RealisticBombFireParams
		TargetState="Fireball"
		AmmoPerFire=3
		FireAnim="Fire"
        AimedFireAnim=
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'RealisticBombEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
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
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.100000
		AmmoPerFire=0
		FireAnim="SawStart"
		FireEndAnim="SawEnd"
		FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
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
 
	Begin Object Class=RecoilParams Name=RealisticFastRecoilParams
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

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=768,Max=2048)
		AimAdjustTime=0.700000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=16
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=66
		SightOffset=(X=-12.000000,Z=10.100000)
		SightPivot=(Pitch=1400)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticRecoilParams'
		RecoilParams(2)=RecoilParams'RealisticRecoilParams'
		RecoilParams(3)=RecoilParams'RealisticRecoilParams'
		RecoilParams(4)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		AimParams(1)=AimParams'RealisticAimParams'
		AimParams(2)=AimParams'RealisticAimParams'
		AimParams(3)=AimParams'RealisticAimParams'
		AimParams(4)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticBoltFireParams'
		FireParams(1)=FireParams'RealisticFastFireParams'
		FireParams(2)=FireParams'RealisticFlameFireParams'
		FireParams(3)=FireParams'RealisticConeFireParams'
		FireParams(4)=FireParams'RealisticBombFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}