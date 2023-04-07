class Fifty9WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		WaterTraceRange=2000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.600000
		Damage=17.0
		HeadMult=3.352941
		LimbMult=0.411764
		DamageType=Class'BallisticProV55.DTFifty9SMG'
		DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
		PenetrationEnergy=16.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter_C'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-Fire',Volume=0.900000)
		Recoil=64.000000
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35.0
		HeadMult=2.428571
		LimbMult=0.571428
		DamageType=Class'BallisticProV55.DTFifty9Blade'
		DamageTypeHead=Class'BallisticProV55.DTFifty9BladeHead'
		DamageTypeArm=Class'BallisticProV55.DTFifty9Blade'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Radius=24.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Melee1"
		FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.200000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.200000),(InVal=0.200000,OutVal=0.500000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=8192.000000
		DeclineTime=0.800000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=192,Max=1536)
		AimAdjustTime=0.450000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Blue Bling"
		Weight=80
		
		PlayerSpeedFactor=1.100000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=45
		//SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
		//SightPivot=(Pitch=900,Roll=-800)
		SightPivot=(Pitch=128)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Red
		LayoutName="Red Bling"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.Fifty9Camos.Fifty7Skin",Index=1)
		Weight=10
		
		PlayerSpeedFactor=1.100000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=45
		//SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
		//SightPivot=(Pitch=900,Roll=-800)
		SightPivot=(Pitch=128)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Orange
		LayoutName="Orange Bling"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.Fifty9Camos.TigerUziSkin",Index=1)
		Weight=10
		
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=45
		//SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
		//SightPivot=(Pitch=900,Roll=-800)
		SightPivot=(Pitch=128)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Red'
	Layouts(2)=WeaponParams'ClassicParams-Orange'

}