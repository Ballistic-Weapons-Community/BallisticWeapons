class ARWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=600.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		TraceCount=8
		TracerClass=Class'BallisticV25.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticV25.IM_Shell'
		Damage=20.0
		HeadMult=2.05
		LimbMult=0.6
		DamageType=Class'BWBPKabPack.DTAAS20ShotgunBal'
		DamageTypeHead=Class'BWBPKabPack.DTAAS20ShotgunBal'
		DamageTypeArm=Class'BWBPKabPack.DTAAS20ShotgunBal'
		PenetrationEnergy=5.000000
		PenetrateForce=8
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBPKabPack.M763FlashEmitterBal'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BallisticSounds3.M763.M763Fire1',Pitch=1.100000,Volume=1.100000)
		Recoil=900.000000
		Chaos=0.15000
		Inaccuracy=(X=700,Y=700)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.270000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.2000000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		MuzzleFlashClass=Class'BWBPKabPack.AM67FlashEmitterBal'
		FireSound=(Sound=Sound'BallisticSounds3.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=7.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim=
		FireEndAnim=
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.50000,OutVal=0.350000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.200000
		XRandFactor=0.280000
		YRandFactor=0.280000
		MaxRecoil=3600.000000
		DeclineTime=0.900000
		DeclineDelay=0.200000
		ViewBindFactor=0.060000
		ADSViewBindFactor=0.060000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.060000
		SprintChaos=0.400000
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=565.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=30
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		ViewOffset=(X=-8.000000,Y=7.000000,Z=-11.000000)
		SightOffset=(X=8.000000,Y=-0.045000,Z=8.140000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}