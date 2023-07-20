class RSNovaWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Bigboom
	Begin Object Class=ProjectileEffectParams Name=RealisticSlowEffectParams
		ProjectileClass=Class'BallisticProV55.RSNovaProjectile'
		SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
        Speed=6000.000000
        AccelSpeed=10000.000000
        MaxSpeed=10000.000000
		Damage=80.0
		DamageRadius=192.000000
		MomentumTransfer=90000.00000
		HeadMult=1.375
		LimbMult=0.625
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=60.000000
		Chaos=0.2
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticSlowFireParams
		FireInterval=1.200000
		AmmoPerFire=3
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSlowEffectParams'
	End Object
	
	//Smallboom
	Begin Object Class=ProjectileEffectParams Name=RealisticFastEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
    	SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
        Speed=5500.000000
        AccelSpeed=10000.000000
        MaxSpeed=14000.000000
        Damage=25.000000
		DamageRadius=48.000000
		MomentumTransfer=10000.000000
    	Recoil=14.000000
	    Chaos=0.005000
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=32,Y=32)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSNovaFastProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=RealisticFastFireParams
		AmmoPerFire=1
		FireAnim="Fire2"
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.175000
        FireEffectParams(0)=ProjectileEffectParams'RealisticFastEffectParams'
    End Object	
	
	//Lightning
	Begin Object Class=ProjectileEffectParams Name=RealisticLightningEffectParams
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

    Begin Object Class=FireParams Name=RealisticLightningFireParams
		TargetState="NovaLightning"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'RealisticLightningEffectParams'
    End Object  

	//God Strike
	Begin Object Class=ProjectileEffectParams Name=RealisticGodStrikeEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
		SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=250.000000
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

    Begin Object Class=FireParams Name=RealisticGodStrikeFireParams
		TargetState="Zap"
		AmmoPerFire=2
		FireAnim="Fire"
	    FireInterval=0.400000
        FireEffectParams(0)=ProjectileEffectParams'RealisticGodStrikeEffectParams'
    End Object

	//Chain Lightning
	Begin Object Class=ProjectileEffectParams Name=RealisticChainLightningEffectParams
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

    Begin Object Class=FireParams Name=RealisticChainLightningFireParams
		TargetState="ChainLightning"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'RealisticChainLightningEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
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
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.300000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepSwipe"
		FireAnim="Swipe"
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
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=550.000000
		ChaosTurnThreshold=150000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=66
		//SightOffset=(X=-16.000000,Z=14.000000)
		SightPivot=(Pitch=1200)
		AimParams(0)=AimParams'RealisticAimParams'
		AimParams(1)=AimParams'RealisticAimParams'
		AimParams(2)=AimParams'RealisticAimParams'
		AimParams(3)=AimParams'RealisticAimParams'
		AimParams(4)=AimParams'RealisticAimParams'
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticRecoilParams'
		RecoilParams(2)=RecoilParams'RealisticRecoilParams'
		RecoilParams(3)=RecoilParams'RealisticRecoilParams'
		RecoilParams(4)=RecoilParams'RealisticRecoilParams'
		FireParams(0)=FireParams'RealisticSlowFireParams'
		FireParams(1)=FireParams'RealisticFastFireParams'
		FireParams(2)=FireParams'RealisticLightningFireParams'
		FireParams(3)=FireParams'RealisticGodStrikeFireParams'
		FireParams(4)=FireParams'RealisticChainLightningFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}