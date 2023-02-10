class AkeronWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//High-Speed Rocket
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=800.000000
		MaxSpeed=8500.000000
		AccelSpeed=6000.000000
		Damage=150
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=256.000000
		Chaos=0.500000
		Inaccuracy=(X=25,Y=25)
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumb2')
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.50000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Barrage Rocket
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryBarrageEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=450.000000
		MaxSpeed=1500.000000
		AccelSpeed=6000.000000
		Damage=150
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		Inaccuracy=(X=100,Y=100)
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumb')
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryBarrageFireParams
		FireInterval=0.20000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryBarrageEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryBarrageEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=155
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.500000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumbTriple')
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryBarrageFireParams
		AmmoPerFire=3
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryBarrageEffectParams'
	End Object

	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=155
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.500000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		AmmoPerFire=1
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.75
		DeclineTime=1.000000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=512)
		ADSMultiplier=0.650000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		ChaosSpeedThreshold=500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		SightOffset=(X=-30.000000,Y=-17.000000,Z=15.000000)
		//ViewOffset=(X=30.000000,Y=20.000000,Z=-18.000000)
		ViewOffset=(X=25.000000,Y=15.000000,Z=-15.000000)
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
        DisplaceDurationMult=1.25
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.500000
		WeaponModes(0)=(ModeName="Mode: Barrage",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="Mode: High Velocity",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Mode: Barrage",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		MagAmmo=6
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryBarrageFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams'
		FireParams(2)=FireParams'ClassicPrimaryBarrageFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryBarrageFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(2)=FireParams'ClassicSecondaryBarrageFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}