class A42WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.A42Projectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
		Speed=50.000000
		MaxSpeed=8000.000000
		AccelSpeed=60000.000000
		Damage=22.0
		DamageRadius=48.000000
		MomentumTransfer=100.000000
		HeadMult=2.0
		LimbMult=0.55
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Fire',Volume=0.700000)
		Recoil=24.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.250000
		BurstFireRateFactor=0.3
		FireEndAnim=	
		AimedFireAnim="Fire1"
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//spread shot
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams-Red
		ProjectileClass=Class'BallisticProV55.A42ProjectileBal'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
		Speed=50.000000
		MaxSpeed=8000.000000
		AccelSpeed=60000.000000
		Damage=15.0
		DamageRadius=48.000000
		MomentumTransfer=100.000000
		HeadMult=2.0
		LimbMult=0.55
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitterBal'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Fire',Volume=0.700000)
		Recoil=64.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams-Red
		TargetState="SpreadShot"
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="Fire1"
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams-Red'
	End Object
	
	//acid
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams-Acid
		ProjectileClass=Class'BallisticProV55.A42AcidProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
		Speed=1000.000000
		MaxSpeed=6000.000000
		AccelSpeed=60000.000000
		Damage=5.000000
		DamageRadius=56.000000
		MomentumTransfer=100.000000
		HeadMult=2.0
		LimbMult=0.55
		SpreadMode=FSM_Rectangle
		FlashScaleFactor=0.6
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_AltImpact')
		Recoil=64.000000
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams-Acid
		FireInterval=0.100000
		AmmoPerFire=1
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="Fire1"
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams-Acid'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=8000.000000,Max=8000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=65.0
		HeadMult=1.6
		LimbMult=0.4
		DamageType=Class'BallisticProV55.DTA42SkrithBeam'
		DamageTypeHead=Class'BallisticProV55.DTA42SkrithBeam'
		DamageTypeArm=Class'BallisticProV55.DTA42SkrithBeam'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-SecFire',Volume=0.800000)
		Recoil=96.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.100000
		AmmoPerFire=8
		BurstFireRateFactor=1.00
		FireAnim="SecFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.200000,OutVal=-0.100000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=-0.500000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=512.000000
		DeclineTime=1.000000
		DeclineDelay=0.100000
		ViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=2048)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-5000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout
		LayoutName="Standard"
		Weight=30
		//Visual
		AllowedCamos(0)=0
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25000
		MagAmmo=60
		//SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
		SightOffset=(X=-40,Y=-6.7,Z=17.5)
		SightPivot=(Pitch=1024,Roll=-768)
		//ViewOffset=(X=8.000000,Y=10.000000,Z=-10.000000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ViewOffset=(X=20,Y=25.00,Z=-15)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_R //The Red One
		//Layout core
		LayoutName="Elite"
		LayoutTags="elite"
		Weight=10
		//Visual
		AllowedCamos(0)=1
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25000
		MagAmmo=72
		//SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
		SightOffset=(X=-40,Y=-6.7,Z=17.5)
		SightPivot=(Pitch=1024,Roll=-768)
		//ViewOffset=(X=8.000000,Y=10.000000,Z=-10.000000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ViewOffset=(X=20,Y=25.00,Z=-15)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams-Red'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_G //The Green One
		LayoutName="Prototype Green"
		Weight=2
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		MagAmmo=60
		//SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
		SightOffset=(X=-40,Y=-6.7,Z=17.5)
		SightPivot=(Pitch=1024,Roll=-768)
		//ViewOffset=(X=8.000000,Y=10.000000,Z=-10.000000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ViewOffset=(X=20,Y=25.00,Z=-15)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams-Acid'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_R'
	//Layouts(2)=WeaponParams'ClassicParams_G'
	
	//Camos =========================================
	Begin Object Class=WeaponCamo Name=A42_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=A42_Red
		Index=1
		CamoName="Red"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.A42Camos.A48Skin_SD',Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=A42_Green
		Index=2
		CamoName="Green"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.A42Camos.A512_ExpShine',Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'A42_Blue'
	Camos(1)=WeaponCamo'A42_Red'
	Camos(2)=WeaponCamo'A42_Green'
}