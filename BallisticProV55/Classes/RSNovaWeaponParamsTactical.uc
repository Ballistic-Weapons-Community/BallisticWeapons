class RSNovaWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=TacticalSlowEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
    	SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
        Speed=5500
        AccelSpeed=100000
        MaxSpeed=14000
        Damage=90.000000
        HeadMult=2.5
        LimbMult=0.75
		DamageRadius=128.000000
		MomentumTransfer=70000.000000
    	Recoil=512.000000
	    Chaos=0.250000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSNovaProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalSlowFireParams
		AmmoPerFire=3
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=1.550000
        FireEffectParams(0)=ProjectileEffectParams'TacticalSlowEffectParams'
    End Object	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalFastEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
    	SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
        Speed=5500
        AccelSpeed=100000
        MaxSpeed=14000
        Damage=37.000000
        HeadMult=2.5
        LimbMult=0.75
		DamageRadius=48.000000
		MomentumTransfer=10000.000000
		MaxDamageGainFactor=0.6
		DamageGainStartTime=0.05
		DamageGainEndTime=0.25
    	Recoil=96.000000
	    Chaos=0.060000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSNovaFastProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalFastFireParams
		AmmoPerFire=1
		FireAnim="Fire2"
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.135000
        FireEffectParams(0)=ProjectileEffectParams'TacticalFastEffectParams'
    End Object	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalLightningEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
    	SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=2.000000
		DamageRadius=
		MomentumTransfer=
		MaxDamageGainFactor=
		DamageGainStartTime=
		DamageGainEndTime=
    	Recoil=7.000000
	    Chaos=0.060000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
	    //ProjectileClass=
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalLightningFireParams
		TargetState="NovaLightning"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'TacticalLightningEffectParams'
    End Object  

	Begin Object Class=ProjectileEffectParams Name=TacticalGodStrikeEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
		SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=145.000000
		DamageRadius=
		MomentumTransfer=
		MaxDamageGainFactor=
		DamageGainStartTime=
		DamageGainEndTime=
    	Recoil=256.000000
	    Chaos=0.060000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-LightningBolt',Slot=SLOT_Interact,bNoOverride=False)
	    //ProjectileClass=
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalGodStrikeFireParams
		TargetState="Zap"
		AmmoPerFire=2
		FireAnim="Fire"
	    FireInterval=0.750000
        FireEffectParams(0)=ProjectileEffectParams'TacticalGodStrikeEffectParams'
    End Object

	Begin Object Class=ProjectileEffectParams Name=TacticalChainLightningEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
    	SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=3.000000
		DamageRadius=
		MomentumTransfer=
		MaxDamageGainFactor=
		DamageGainStartTime=
		DamageGainEndTime=
    	Recoil=256.000000
	    Chaos=0.060000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
	    //ProjectileClass=
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalChainLightningFireParams
		TargetState="ChainLightning"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'TacticalChainLightningEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=200.000000,Max=200.000000)
		WaterTraceRange=5000.0
		Damage=50.0
		HeadMult=1
		LimbMult=1
		DamageType=Class'BallisticProV55.DT_RSNovaStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSNovaStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSNovaStab'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=150.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.NovaStaff.Nova-Melee',Volume=0.5,Radius=12.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepSwipe"
		FireAnim="Swipe"
		FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalBoltRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=0.8
		ClimbTime=0.06
		DeclineDelay=0.8
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalFastRecoilParams
		ViewBindFactor=0.65
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		ClimbTime=0.04
		DeclineDelay=0.25
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
        AimSpread=(Min=256,Max=768)
		AimAdjustTime=0.600000
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightingTime=0.35
        SightMoveSpeedFactor=0.6
        DisplaceDurationMult=0.5
		MagAmmo=32
        InventorySize=5
		WeaponModes(0)=(ModeName="Slow Bolt",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Lightning",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		WeaponModes(3)=(ModeName="Thunder Strike",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Chain Lightning",ModeID="WM_FullAuto",bUnavailable=True)
		RecoilParams(0)=RecoilParams'TacticalBoltRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalFastRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalSlowFireParams'
		FireParams(1)=FireParams'TacticalFastFireParams'
		FireParams(2)=FireParams'TacticalLightningFireParams'
		FireParams(3)=FireParams'TacticalGodStrikeFireParams'
		FireParams(4)=FireParams'TacticalChainLightningFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}