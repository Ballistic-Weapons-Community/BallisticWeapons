class MGLWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Impact
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MGLGrenadeImpact'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10000.000000
		Damage=200.000000
		DamageRadius=356.000000
		MomentumTransfer=75000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MGL.MGL-Fire',Volume=8.200000)
		Recoil=256.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		bLimitMomentumZ=False
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MGLGrenadeRemote'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10000.000000
		Damage=200.000000
		DamageRadius=356.000000
		MomentumTransfer=75000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MGL.MGL-FireAlt',Volume=9.200000)
		Recoil=256.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		bLimitMomentumZ=False
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=0.600000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		DeclineTime=0.900000
		ViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=2360)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=24
		SightMoveSpeedFactor=0.500000
		SightingTime=0.35
		MagAmmo=6
		SightOffset=(X=-30.000000,Y=12.45,Z=14.8500000)
		SightPivot=(Pitch=512)
		WeaponModes(0)=(ModeName="Impact",ModeID="WM_SemiAuto",Value=1)
		WeaponModes(1)=(ModeName="4-Round Burst",bUnavailable=True)
		WeaponModes(2)=(ModeName="4-Round Burst",bUnavailable=True)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		WeaponName="MGL-140 40mm Grenade Launcher"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}