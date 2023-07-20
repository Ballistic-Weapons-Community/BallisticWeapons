class EKS43WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=120.000000,Max=120.000000)
		WaterTraceRange=5000.0
		Damage=87.0
		HeadMult=2.183908
		LimbMult=0.482758
		DamageType=Class'BallisticProV55.DTEKS43Katana'
		DamageTypeHead=Class'BallisticProV55.DTEKS43KatanaHead'
		DamageTypeArm=Class'BallisticProV55.DTEKS43KatanaLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.300000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.EKS43.EKS-Slash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.450000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Slash1"
	FireEffectParams(0)=MeleeEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=120.000000,Max=120.000000)
		WaterTraceRange=5000.0
		Damage=175.0
		HeadMult=2.497142
		LimbMult=0.468571
		DamageType=Class'BallisticProV55.DTEKS43Katana'
		DamageTypeHead=Class'BallisticProV55.DTEKS43KatanaHead'
		DamageTypeArm=Class'BallisticProV55.DTEKS43KatanaLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.EKS43.EKS-Slash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.750000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepHack1"
		FireAnim="Hack1"
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		LayoutName="Perfect Steel"
		Weight=30
		PlayerSpeedFactor=1.050000
		InventorySize=2
		WeaponPrice=1000
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		//ViewOffset=(X=15.000000,Y=-1.500000,Z=-18.000000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Hot
		LayoutName="Superheated"
		Weight=10
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EKS43Camos.Katana-KGlow",Index=1)
		PlayerSpeedFactor=1.050000
		InventorySize=2
		WeaponPrice=1000
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		//ViewOffset=(X=15.000000,Y=-1.500000,Z=-18.000000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Hot'


}