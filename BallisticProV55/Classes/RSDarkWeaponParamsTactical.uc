class RSDarkWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=TacticalBoltEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=5000
        AccelSpeed=10000
        MaxSpeed=14000
        Damage=105
        HeadMult=2.25
        LimbMult=0.67f
		DamageRadius=128
		MomentumTransfer=10000
    	Recoil=1024.000000
	    Chaos=0.250000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalBoltFireParams
		AmmoPerFire=5
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=1.350000
        FireEffectParams(0)=ProjectileEffectParams'TacticalBoltEffectParams'
    End Object	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalFastEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=4000
        AccelSpeed=80000
        MaxSpeed=10000
        Damage=60
        HeadMult=2.25
        LimbMult=0.67f
		DamageRadius=0
		MomentumTransfer=100
    	Recoil=220.000000
	    Chaos=0.090000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire2',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFastProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalFastFireParams
		AmmoPerFire=1
		FireAnim="Fire2"
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.145000
        FireEffectParams(0)=ProjectileEffectParams'TacticalFastEffectParams'
    End Object	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalFlameEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=3000.000000
        AccelSpeed=0.000000
        MaxSpeed=3000.000000
        Damage=12.000000
		DamageRadius=192.000000
		MomentumTransfer=0.000000
    	Recoil=7.000000
	    Chaos=0.060000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFlameProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalFlameFireParams
		TargetState="DarkFlamer"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'TacticalFlameEffectParams'
    End Object  

	Begin Object Class=ProjectileEffectParams Name=TacticalConeEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
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

    Begin Object Class=FireParams Name=TacticalConeFireParams
		TargetState="Immolate"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'TacticalConeEffectParams'
    End Object     

	Begin Object Class=ProjectileEffectParams Name=TacticalBombEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=4000.000000
        AccelSpeed=0.000000
        MaxSpeed=4000.000000
        Damage=130.000000
		DamageRadius=256.000000
		MomentumTransfer=80000.000000
    	Recoil=1024.000000
	    Chaos=0.150000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-FireBall',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFireBomb'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalBombFireParams
		TargetState="Fireball"
		AmmoPerFire=4
		FireAnim="Fire"
        AimedFireAnim=
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'TacticalBombEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=180.000000,Max=180.000000)
		WaterTraceRange=5000.0
		Damage=50.0
		HeadMult=1f
		LimbMult=1f
		DamageType=Class'BallisticProV55.DT_RSNovaStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSNovaStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSNovaStab'
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
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.100000
		AmmoPerFire=1
		FireAnim="SawStart"
		FireEndAnim="SawEnd"
		FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalBoltRecoilParams
     	XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
     	YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=0.8
		DeclineTime=1.5
		ViewBindFactor=0.3
		DeclineDelay=0.8
	End Object
 
	Begin Object Class=RecoilParams Name=TacticalFastRecoilParams
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

	Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=64,Max=384)
        ADSMultiplier=0.35
		SprintOffSet=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================

	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=1.250000
		SightingTime=0.2
        DisplaceDurationMult=0.75
		MagAmmo=24
        InventorySize=20
		WeaponModes(0)=(ModeName="Bolt",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Flame",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		WeaponModes(3)=(ModeName="Cone Immolation",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		WeaponModes(4)=(ModeName="Fire Bomb",ModeID="WM_FullAuto")
		RecoilParams(0)=RecoilParams'TacticalBoltRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalFastRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalBoltFireParams'
		FireParams(1)=FireParams'TacticalFastFireParams'
		FireParams(2)=FireParams'TacticalFlameFireParams'
		FireParams(3)=FireParams'TacticalConeFireParams'
		FireParams(4)=FireParams'TacticalBombFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}