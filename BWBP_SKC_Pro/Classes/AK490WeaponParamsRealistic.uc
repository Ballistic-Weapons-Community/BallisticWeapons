class AK490WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1400.000000,Max=7000.000000) //7.62mm short
		WaterTraceRange=4000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=50
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_AK47Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK47AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK47Assault'
		PenetrationEnergy=22.000000
		PenetrateForce=70
		bPenetrate=True
		PDamageFactor=0.600000
		WallPDamageFactor=0.600000
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.ak47.ak47-Fire',Pitch=1.100000,Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=465.000000 //700 hip
		Chaos=0.1
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE - Todo
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AK47Knife'
		SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
		Speed=8500.000000
		MaxSpeed=8500.000000
		Damage=90
		BotRefireRate=0.300000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="PreKnifeFire"
		FireAnim="KnifeFire"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
				
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=-0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.150000),(InVal=0.600000,OutVal=0.200000),(InVal=0.800000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.400000
		XRandFactor=0.300000
		YRandFactor=0.200000
		MaxRecoil=2800.000000
		DeclineTime=1.500000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.500000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================		
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=11
		WeaponPrice=1200
		SightMoveSpeedFactor=0.500000
		SightingTime=0.210000
		MagAmmo=20
		ViewOffset=(X=-9.000000,Y=10.000000,Z=-16.000000)
		SightOffset=(X=-5.000000,Y=-10.020000,Z=20.600000)
		SightPivot=(Pitch=64)
		WeaponName="AK-490 7.62mm Battle Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
    Layouts(0)=WeaponParams'RealisticParams'
}