class BulldogWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2363,Max=7000)
		RangeAtten=0.5
		Damage=120
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DTBulldog'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTBulldogHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTBulldog'
        PenetrationEnergy=64
		PenetrateForce=250
		bPenetrate=True
		PushbackForce=3000.000000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=1.100000
		Recoil=1280.000000
		Chaos=1.000000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Bulldog.Bulldog-Fire',Volume=7.500000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.85
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2.000000	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.BulldogRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=110
        ImpactDamage=110
		PushbackForce=100.000000
		DamageRadius=512.000000
		MomentumTransfer=60000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=2048.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.75	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-FireTest',Volume=2.500000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.8
		AmmoPerFire=0
		FireAnim="SGFire"	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=6144.000000
		DeclineTime=1.500000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=96,Max=1024)
		ADSMultiplier=0.50000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
        JumpOffset=(Pitch=-6000,Yaw=-1500)
        ChaosSpeedThreshold=300
		ChaosDeclineTime=1.600000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		WeaponBoneScales(0)=(BoneName="Scope",Slot=9,Scale=0f)
		SightPivot=(Pitch=256)
		ViewOffset=(X=20.000000,Y=0.000000,Z=-18.000000)
		SightOffset=(X=-40.000000,Y=13.500000,Z=20.100000)
		PlayerSpeedFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.5
		SightingTime=0.65
		DisplaceDurationMult=1.25
		MagAmmo=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}