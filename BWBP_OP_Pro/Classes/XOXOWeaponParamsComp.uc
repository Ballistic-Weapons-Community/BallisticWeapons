class XOXOWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE - Rapid Fire
	//=================================================================	
	
	// FAST FIRE
	Begin Object Class=ProjectileEffectParams Name=ArenaFastPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=5500.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=38
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

	Begin Object Class=FireParams Name=ArenaFastPrimaryFireParams
		FireInterval=0.170000
		AmmoPerFire=3
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaFastPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Bomb
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaBombPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOBomb'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=2500.000000
		MaxSpeed=0000.000000
		AccelSpeed=100000.000000
		Damage=100
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

	Begin Object Class=FireParams Name=ArenaBombPrimaryFireParams
		FireInterval=1.350000
		AmmoPerFire=16
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaBombPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Shockwave
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaLustPrimaryEffectParams
		Damage=80
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

	Begin Object Class=FireParams Name=ArenaLustPrimaryFireParams
		FireInterval=0.900000
		AmmoPerFire=10
		FireAnim="LustWave"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaLustPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Nuke
	//=================================================================	

	Begin Object Class=ProjectileEffectParams Name=ArenaNukePrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXONukeProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=2500.000000
		MaxSpeed=4500.000000
		AccelSpeed=100000.000000
		Damage=250
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

	Begin Object Class=FireParams Name=ArenaNukePrimaryFireParams
		FireInterval=0.500000
		AmmoPerFire=1
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaNukePrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		Damage=7
		DamageType=Class'BWBP_OP_Pro.DTXOXOStream'
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		Recoil=0.000000
		Chaos=0.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.070000
		FireAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ArenaFastRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.250000
	End Object

	Begin Object Class=RecoilParams Name=ArenaBombRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=1.5
		DeclineDelay=0.8
		DeclineTime=1.500000
	End Object

	Begin Object Class=RecoilParams Name=ArenaLustRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.250000
	End Object

	Begin Object Class=RecoilParams Name=ArenaNukeRecoilParams
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

	Begin Object Class=AimParams Name=ArenaFastAimParams
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object

	Begin Object Class=AimParams Name=ArenaBombAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object
	
	Begin Object Class=AimParams Name=ArenaLustAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object
	
	Begin Object Class=AimParams Name=ArenaNukeAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.250000
		ViewOffset=(X=5.000000,Y=6.000000,Z=-9.000000)
		SightOffset=(X=5.000000,Y=0.650000,Z=12.500000)
		SightPivot=(Pitch=768)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.30000
		DisplaceDurationMult=1
		MagAmmo=70
		WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Bomb",ModeID="WM_FullAuto",RecoilParamsIndex=1,AimParamsIndex=1)
		WeaponModes(2)=(ModeName="Lust Shockwave",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Sexplosion",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		FireParams(0)=FireParams'ArenaFastPrimaryFireParams'
		FireParams(1)=FireParams'ArenaBombPrimaryFireParams'
		FireParams(2)=FireParams'ArenaLustPrimaryFireParams'
		FireParams(3)=FireParams'ArenaNukePrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		RecoilParams(0)=RecoilParams'ArenaFastRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaBombRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaLustRecoilParams'
		RecoilParams(3)=RecoilParams'ArenaNukeRecoilParams'
		AimParams(0)=AimParams'ArenaFastAimParams'
		AimParams(1)=AimParams'ArenaBombAimParams'
		AimParams(2)=AimParams'ArenaLustAimParams'
		AimParams(3)=AimParams'ArenaNukeAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}