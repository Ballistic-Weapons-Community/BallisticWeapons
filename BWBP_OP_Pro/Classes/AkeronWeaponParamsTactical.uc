class AkeronWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=5500.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=150
		DamageRadius=400.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=128.000000
		Chaos=0.5
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.70000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryBarrageEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=3000.000000
		MaxSpeed=20000.000000
		AccelSpeed=100000.000000
		Damage=150
		DamageRadius=400.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=256.000000
		Chaos=0.800000
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumb')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryBarrageFireParams
		FireInterval=0.250000
		BurstFireRateFactor=0.3
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryBarrageEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
		SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=150
		DamageRadius=400.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.5
		BotRefireRate=0.5
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		AmmoPerFire=1
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.75
		DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=768)
		ADSMultiplier=0.50000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=1.250000
		ReloadAnimRate=0.900000
		SightOffset=(X=-30.000000,Y=-17.000000,Z=15.000000)
		ViewOffset=(X=30.000000,Y=20.000000,Z=-18.000000)
		WeaponModes(0)=(ModeName="Barrage",ModeID="WM_BigBurst",Value=3)
		WeaponModes(1)=(ModeName="High Velocity",ModeID="WM_FullAuto",Value=1)
		WeaponModes(2)=(ModeName="N/A",ModeID="WM_BigBurst",Value=3,bUnavailable=True)
		InitialWeaponMode=1
		PlayerSpeedFactor=0.95000
        DisplaceDurationMult=1.25
		InventorySize=20
		SightMoveSpeedFactor=0.8
		SightingTime=0.35
		MagAmmo=9
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryBarrageFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}