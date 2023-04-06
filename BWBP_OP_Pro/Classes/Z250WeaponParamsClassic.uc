class Z250WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

//=================================================================
// PRIMARY FIRE
//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=32.000000
		HeadMult=1.5
		LimbMult=1.0
		DamageType=Class'BWBP_OP_Pro.DTZ250Bullet'
		DamageTypeHead=Class'BWBP_OP_Pro.DTZ250Bullet'
		DamageTypeArm=Class'BWBP_OP_Pro.DTZ250Bullet'
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Z250.Z250-Fire2',Slot=SLOT_Interact,bNoOverride=False,Volume=4.750000)
		Recoil=256.000000
		Chaos=0.120000
		PushbackForce=48.000000
		Inaccuracy=(X=16,Y=16)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.200000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
//=================================================================
// SECONDARY FIRE
//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.Z250Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		Damage=30.000000
		DamageRadius=64.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_OP_Pro.Z250GrenadeFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Z250.Z250-GrenadeFire',Slot=SLOT_Interact,bNoOverride=False,Volume=4.750000)
		Recoil=0.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireAnim="GLFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
//=================================================================
// RECOIL
//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.350000,OutVal=0.400000),(InVal=0.500000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.070000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		DeclineTime=2.500000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.950000
		HipMultiplier=1.000000
		CrouchMultiplier=0.8
		bViewDecline=True
	End Object

//=================================================================
// AIM
//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=2500)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.8
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=400.000000
	End Object
    
//=================================================================
// BASIC PARAMS
//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.850000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		SightingTime=0.550000
		MagAmmo=50
		ViewOffset=(X=-40,Y=18.000000,Z=-32.000000)
		//SightOffset=(X=50.000000,Y=-10.690000,Z=45.400002)
		WeaponModes(0)=(ModeName="400 RPM",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="600 RPM",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="800 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(3)=(ModeName="900 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(4)=(ModeName="1200 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Z250_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Z250_Gold
		Index=1
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.Z250Camos.Z250_body_SH2",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.Z250Camos.Z250_Sight_SH2",Index=2,AIndex=1,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'Z250_Green'
	Camos(1)=WeaponCamo'Z250_Gold'
}