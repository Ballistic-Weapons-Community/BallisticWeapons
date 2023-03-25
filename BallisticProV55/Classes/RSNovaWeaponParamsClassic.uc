class RSNovaWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Bigboom
	Begin Object Class=ProjectileEffectParams Name=ClassicSlowEffectParams
		ProjectileClass=Class'BallisticProV55.RSNovaProjectile'
		SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
		Speed=50.000000
		MaxSpeed=4000.000000
		AccelSpeed=16000.000000
		Damage=80.0
		DamageRadius=192.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.375
		LimbMult=0.625
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=60.000000
		Chaos=0.2
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicSlowFireParams
		FireInterval=0.800000
		AmmoPerFire=3
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSlowEffectParams'
	End Object
	
	//Smallboom
	Begin Object Class=ProjectileEffectParams Name=ClassicFastEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
    	SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
        Speed=50.000000
        AccelSpeed=30000.000000
        MaxSpeed=7000.000000
        Damage=18.000000
		HeadMult=1.375
		LimbMult=0.625
		DamageRadius=48.000000
		MomentumTransfer=10000.000000
    	Recoil=14.000000
	    Chaos=0.005000
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		bLimitMomentumZ=False
		Inaccuracy=(X=8,Y=8)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSNovaFastProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ClassicFastFireParams
		AmmoPerFire=1
		FireAnim="Fire2"
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.150000
        FireEffectParams(0)=ProjectileEffectParams'ClassicFastEffectParams'
    End Object	
	
	//Lightning
	Begin Object Class=ProjectileEffectParams Name=ClassicLightningEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
    	SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=5.000000
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

    Begin Object Class=FireParams Name=ClassicLightningFireParams
		TargetState="NovaLightning"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'ClassicLightningEffectParams'
    End Object  

	//God Strike
	Begin Object Class=ProjectileEffectParams Name=ClassicGodStrikeEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
		SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=200.000000
		DamageRadius=
		MomentumTransfer=
		MaxDamageGainFactor=
		DamageGainStartTime=
		DamageGainEndTime=
    	Recoil=60.000000
	    Chaos=0.060000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-LightningBolt',Slot=SLOT_Interact,bNoOverride=False)
	    //ProjectileClass=
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ClassicGodStrikeFireParams
		TargetState="Zap"
		AmmoPerFire=2
		FireAnim="Fire"
	    FireInterval=0.750000
        FireEffectParams(0)=ProjectileEffectParams'ClassicGodStrikeEffectParams'
    End Object

	//Chain Lightning
	Begin Object Class=ProjectileEffectParams Name=ClassicChainLightningEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
    	SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=5.000000
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

    Begin Object Class=FireParams Name=ClassicChainLightningFireParams
		TargetState="ChainLightning"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'ClassicChainLightningEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=200.000000,Max=200.000000)
		WaterTraceRange=5000.0
		Damage=55.0
		HeadMult=1.818181
		LimbMult=0.454545
		DamageType=Class'BallisticProV55.DT_RSNovaStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSNovaStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSNovaStab'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=150.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.NovaStaff.Nova-Melee',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.300000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepSwipe"
		FireAnim="Swipe"
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
		SprintOffSet=(Pitch=-500,Yaw=-1024)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=2400.000000
		ChaosTurnThreshold=150000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Standard"
		
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		MagAmmo=66
		SightOffset=(X=-16.000000,Z=14.000000)
		SightPivot=(Pitch=1200)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicSlowFireParams'
		FireParams(1)=FireParams'ClassicFastFireParams'
		FireParams(2)=FireParams'ClassicLightningFireParams'
		FireParams(3)=FireParams'ClassicGodStrikeFireParams'
		FireParams(4)=FireParams'ClassicChainLightningFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}