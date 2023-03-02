class PugWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=2560.000000,Max=2560.000000)
        RangeAtten=0.250000
        TraceCount=7
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=11
        DamageType=Class'BWBP_SKCExp_Pro.DTPugCannon'
        DamageTypeHead=Class'BWBP_SKCExp_Pro.DTPugCannonHead'
        DamageTypeArm=Class'BWBP_SKCExp_Pro.DTPugCannon'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        Recoil=450.000000
        Chaos=0.300000
        BotRefireRate=0.800000
        WarnTargetPct=0.400000	
		Inaccuracy=(X=175,Y=175)
        FireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.Pug.Pug-Fire',Volume=2.500000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		FireInterval=0.200000
	FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.PugRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=110
		DamageRadius=512.000000
		MomentumTransfer=60000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=2048.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.75	
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.PUG.PUG-FireSlug',Volume=2.500000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.5
		PreFireTime=0.6
		PreFireAnim="GrenadePrep"
		AmmoPerFire=0
		FireAnim="GrenadeFire"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
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

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=32,Max=1024)
		ADSMultiplier=0.30000
		SprintOffset=(Pitch=-1000,Yaw=-2048)
        JumpOffset=(Pitch=-6000,Yaw=-1500)
        ChaosSpeedThreshold=550.000000
		ChaosDeclineTime=1.600000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightOffset=(X=0.000000,Y=-1.250000,Z=35.000000)
		ViewOffset=(X=10.000000,Y=11.000000,Z=-21.000000)
		SightPivot=(Pitch=512)
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.850000
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.450000		
		DisplaceDurationMult=1.25
		MagAmmo=10
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}