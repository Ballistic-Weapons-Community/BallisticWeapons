class XOXOWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE - Rapid Fire
	//=================================================================	
	
	// FAST FIRE
	Begin Object Class=ProjectileEffectParams Name=TacticalFastPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=5500.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=62
        HeadMult=2.25
        LimbMult=0.67f
		DamageRadius=48.000000
		MomentumTransfer=-1000.000000
		MaxDamageGainFactor=0.6
		DamageGainStartTime=0.05
		DamageGainEndTime=0.25
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=160.000000
		Chaos=0.060000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalFastPrimaryFireParams
		FireInterval=0.170000
		AmmoPerFire=3
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalFastPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Bomb
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalBombPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOBomb'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=2500.000000
		MaxSpeed=0000.000000
		AccelSpeed=100000.000000
		Damage=150
		DamageRadius=768.000000
		MomentumTransfer=-30000.000000
		MaxDamageGainFactor=0.6
		DamageGainStartTime=0.05
		DamageGainEndTime=0.25
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-FireBig',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.250000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalBombPrimaryFireParams
		FireInterval=1.350000
		AmmoPerFire=16
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalBombPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Shockwave
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalLustPrimaryEffectParams
		Damage=120
		//DamageRadius=1024.000000
		MomentumTransfer=4000.000000
		HeadMult=1.5f
		LimbMult=0.8f
		DamageType=Class'BWBP_OP_Pro.DTXOXOShockwave'
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=0.000000
		Chaos=0.060000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalLustPrimaryFireParams
		FireInterval=0.900000
		AmmoPerFire=10
		FireAnim="LustWave"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalLustPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Nuke
	//=================================================================	

	Begin Object Class=ProjectileEffectParams Name=TacticalNukePrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXONukeProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=2500.000000
		MaxSpeed=4500.000000
		AccelSpeed=100000.000000
		Damage=350
		DamageRadius=2048.000000
		MomentumTransfer=100.000000
		//MaxDamageGainFactor=0.6
		//DamageGainStartTime=0.05
		//DamageGainEndTime=0.25
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Sexplosion-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=1.000000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalNukePrimaryFireParams
		FireInterval=0.5
		AmmoPerFire=1
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalNukePrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		Damage=15
        HeadMult=2.25
        LimbMult=0.67
		DamageType=Class'BWBP_OP_Pro.DTXOXOStream'
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		Recoil=0.000000
		Chaos=0.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.070000
		FireAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=TacticalFastRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.250000
	End Object

	Begin Object Class=RecoilParams Name=TacticalBombRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=1.5
		DeclineDelay=0.8
		DeclineTime=1.500000
	End Object

	Begin Object Class=RecoilParams Name=TacticalLustRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.250000
	End Object

	Begin Object Class=RecoilParams Name=TacticalNukeRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=1.5
		DeclineDelay=0.8
		DeclineTime=1.500000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalFastAimParams
    	AimSpread=(Min=64,Max=378)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalBombAimParams
		AimSpread=(Min=128,Max=1024)
        ADSMultiplier=0.2
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object
	
	Begin Object Class=AimParams Name=TacticalLustAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object
	
	Begin Object Class=AimParams Name=TacticalNukeAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=1.250000
		ViewOffset=(X=5.000000,Y=6.000000,Z=-9.000000)
		SightOffset=(X=5.000000,Y=0.650000,Z=12.500000)
		SightPivot=(Pitch=768)
		InventorySize=20
		SightMoveSpeedFactor=0.9
		SightingTime=0.2
		DisplaceDurationMult=1
		MagAmmo=70
		WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Bomb",ModeID="WM_FullAuto",RecoilParamsIndex=1,AimParamsIndex=1)
		WeaponModes(2)=(ModeName="Lust Shockwave",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Sexplosion",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		FireParams(0)=FireParams'TacticalFastPrimaryFireParams'
		FireParams(1)=FireParams'TacticalBombPrimaryFireParams'
		FireParams(2)=FireParams'TacticalLustPrimaryFireParams'
		FireParams(3)=FireParams'TacticalNukePrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		RecoilParams(0)=RecoilParams'TacticalFastRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalBombRecoilParams'
		RecoilParams(2)=RecoilParams'TacticalLustRecoilParams'
		RecoilParams(3)=RecoilParams'TacticalNukeRecoilParams'
		AimParams(0)=AimParams'TacticalFastAimParams'
		AimParams(1)=AimParams'TacticalBombAimParams'
		AimParams(2)=AimParams'TacticalLustAimParams'
		AimParams(3)=AimParams'TacticalNukeAimParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}