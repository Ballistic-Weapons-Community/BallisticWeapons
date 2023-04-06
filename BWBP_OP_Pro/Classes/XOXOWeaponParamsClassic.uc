class XOXOWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	// FAST FIRE
	Begin Object Class=ProjectileEffectParams Name=ClassicFastPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=5000.000000
		MaxSpeed=10000.000000
		AccelSpeed=30000.000000
		Damage=15
		DamageRadius=48.000000
		MomentumTransfer=-1000.000000
		RadiusFallOffType=RFO_Linear
		bLimitMomentumZ=False
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=160.000000
		Chaos=0.060000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicFastPrimaryFireParams
		FireInterval=0.150000
		AmmoPerFire=2
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicFastPrimaryEffectParams'
	End Object
	
	// BOMB FIRE
	Begin Object Class=ProjectileEffectParams Name=ClassicBombPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.XOXOBomb'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=2500.000000
		MaxSpeed=2500.000000
		AccelSpeed=20000.000000
		Damage=60
		DamageRadius=1028.000000
		MomentumTransfer=-30000.000000
		RadiusFallOffType=RFO_Linear
		bLimitMomentumZ=False
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-FireBig',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.750000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicBombPrimaryFireParams
		FireInterval=0.350000
		AmmoPerFire=10
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicBombPrimaryEffectParams'
	End Object
	
	// SHOCKWAVE FIRE
	Begin Object Class=InstantEffectParams Name=ClassicLustPrimaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicLustPrimaryFireParams
		FireInterval=0.900000
		AmmoPerFire=10
		FireAnim="LustWave"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicLustPrimaryEffectParams'
	End Object
	
	// NUKE FIRE
	Begin Object Class=ProjectileEffectParams Name=ClassicNukePrimaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicNukePrimaryFireParams
		FireInterval=0.500000
		AmmoPerFire=1
		FireAnim="Fire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicNukePrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		Damage=7
		DamageType=Class'BWBP_OP_Pro.DTXOXOStream'
		MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
		Recoil=0.000000
		Chaos=0.000000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.070000
		FireAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ClassicFastRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.250000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicBombRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=1.5
		DeclineDelay=0.8
		DeclineTime=1.500000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicLustRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.250000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicNukeRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=1.5
		DeclineDelay=0.8
		DeclineTime=1.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicFastAimParams
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object

	Begin Object Class=AimParams Name=ClassicBombAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object
	
	Begin Object Class=AimParams Name=ClassicLustAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object
	
	Begin Object Class=AimParams Name=ClassicNukeAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		//SightOffset=(X=5.000000,Y=0.650000,Z=10.600000)
		SightPivot=(Pitch=768)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=7
		SightMoveSpeedFactor=0.9
		SightingTime=0.30000
		DisplaceDurationMult=1
		MagAmmo=70
		WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Bomb",ModeID="WM_FullAuto",RecoilParamsIndex=1,AimParamsIndex=1)
		WeaponModes(2)=(ModeName="Lust Shockwave",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Sexplosion",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		FireParams(0)=FireParams'ClassicFastPrimaryFireParams'
		FireParams(1)=FireParams'ClassicBombPrimaryFireParams'
		FireParams(2)=FireParams'ClassicLustPrimaryFireParams'
		FireParams(3)=FireParams'ClassicNukePrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		RecoilParams(0)=RecoilParams'ClassicFastRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicBombRecoilParams'
		RecoilParams(2)=RecoilParams'ClassicLustRecoilParams'
		RecoilParams(3)=RecoilParams'ClassicNukeRecoilParams'
		AimParams(0)=AimParams'ClassicFastAimParams'
		AimParams(1)=AimParams'ClassicBombAimParams'
		AimParams(2)=AimParams'ClassicLustAimParams'
		AimParams(3)=AimParams'ClassicNukeAimParams'
    End Object 
	
	Layouts(0)=WeaponParams'ClassicParams'
	
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