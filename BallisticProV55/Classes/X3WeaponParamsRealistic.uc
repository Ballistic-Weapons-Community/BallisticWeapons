class X3WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=78.000000,Max=78.000000)
		WaterTraceRange=5000.0
		Damage=38.0
		HeadMult=2.236842
		LimbMult=0.447368
		DamageType=Class'BallisticProV55.DTX3Knife'
		DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
		DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.000000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.333333
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Slice1"
		FireAnimRate=2.000000
	FireEffectParams(0)=MeleeEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Projectile
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryProjEffectParams
		Speed=1500
		Damage=50.0
		HeadMult=2.5
		LimbMult=0.6
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifeThrow',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=RealisticPrimaryFireProjParams
		FireInterval=0.250000
		AmmoPerFire=1
		BurstFireRateFactor=1.00
		FireAnimRate=2.500000
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryProjEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=104.000000,Max=104.000000)
		WaterTraceRange=5000.0
		Damage=74.0
		HeadMult=2.256756
		LimbMult=0.445945
		DamageType=Class'BallisticProV55.DTX3Knife'
		DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
		DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.500000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.450000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="BigBack1"
		FireAnim="BigStab1"
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
		PlayerSpeedFactor=1.150000
        InventorySize=2
		WeaponPrice=100
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		ViewOffset=(X=6.000000,Y=7.500000,Z=-8.000000)
		ViewPivot=(Yaw=32768)
		WeaponName="X3 Combat Knife"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireProjParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticPrimaryFireProjParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}