class XOXOWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	// FAST FIRE
	Begin Object Class=ProjectileEffectParams Name=RealisticFastPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=9000.000000
		MaxSpeed=10000.000000
		AccelSpeed=30000.000000
		Damage=40
		DamageRadius=48.000000
		MomentumTransfer=-1000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=160.000000
		Chaos=0.010000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticFastPrimaryFireParams
		FireInterval=0.130000
		AmmoPerFire=1
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticFastPrimaryEffectParams'
	End Object
	
	// BOMB FIRE
	Begin Object Class=ProjectileEffectParams Name=RealisticBombPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOBomb'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=2500.000000
		MaxSpeed=2500.000000
		AccelSpeed=20000.000000
		Damage=80
		DamageRadius=1028.000000
		MomentumTransfer=-30000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-FireBig',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.050000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticBombPrimaryFireParams
		FireInterval=0.450000
		AmmoPerFire=10
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticBombPrimaryEffectParams'
	End Object
	
	// SHOCKWAVE FIRE
	Begin Object Class=ProjectileEffectParams Name=RealisticLustPrimaryEffectParams
		Damage=120
		//DamageRadius=1024.000000
		MomentumTransfer=4000.000000
		HeadMult=1.5f
		LimbMult=0.8f
		//DamageType=Class'BWBP_OP_Pro.DTXOXOShockwave'
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=0.000000
		Chaos=0.060000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticLustPrimaryFireParams
		FireInterval=0.900000
		AmmoPerFire=10
		FireAnim="LustWave"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticLustPrimaryEffectParams'
	End Object
	
	// NUKE FIRE
	Begin Object Class=ProjectileEffectParams Name=RealisticNukePrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXONukeProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=500.000000
		MaxSpeed=4500.000000
		AccelSpeed=100000.000000
		Damage=500
		DamageRadius=4096.000000
		MomentumTransfer=100.000000
		RadiusFallOffType=RFO_Linear
		bLimitMomentumZ=False
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Sexplosion-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=1.000000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticNukePrimaryFireParams
		FireInterval=0.500000
		AmmoPerFire=1
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticNukePrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		Damage=7
		DamageType=Class'BWBP_OP_Pro.DTXOXOStream'
		DamageTypeHead=Class'BWBP_OP_Pro.DTXOXOStream'
		DamageTypeArm=Class'BWBP_OP_Pro.DTXOXOStream'
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		Recoil=0.000000
		Chaos=0.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.070000
		FireAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticFastRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=-0.150000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=-1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.300000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		DeclineTime=1.000000
		ViewBindFactor=0.150000
		ADSViewBindFactor=0.150000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticFastAimParams
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		AimSpread=(Min=768,Max=2048)
		AimAdjustTime=0.700000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=550.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		//SightOffset=(X=5.000000,Y=0.650000,Z=10.600000)
		SightPivot=(Pitch=768)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.30000
		DisplaceDurationMult=1
		MagAmmo=66
		WeaponName="Lustwave Staff"
		WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Bomb",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Lust Shockwave",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Sexplosion",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		FireParams(0)=FireParams'RealisticFastPrimaryFireParams'
		FireParams(1)=FireParams'RealisticBombPrimaryFireParams'
		FireParams(2)=FireParams'RealisticLustPrimaryFireParams'
		FireParams(3)=FireParams'RealisticNukePrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		RecoilParams(0)=RecoilParams'RealisticFastRecoilParams'
		AimParams(0)=AimParams'RealisticFastAimParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XOXO_Pink
		Index=0
		CamoName="Love"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XOXO_Purple
		Index=1
		CamoName="Lust"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XOXOCamos.XOXOPurpleCamo-Shine",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Camos(0)=WeaponCamo'XOXO_Pink'
	Camos(1)=WeaponCamo'XOXO_Purple'
}