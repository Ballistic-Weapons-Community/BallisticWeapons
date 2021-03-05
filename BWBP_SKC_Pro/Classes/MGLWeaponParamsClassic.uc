class MGLWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
			ProjectileClass=Class'BWBP_SKC_Pro.MGLGrenadeTimed'
			SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
			Speed=2000.000000
			Damage=140.000000
			DamageRadius=356.000000
			HeadMult=1.0
			LimbMult=1.0
			MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.MGL.MGL-Fire',Volume=9.200000)
			Recoil=0.0
			Chaos=-1.0
			SplashDamage=True
			RecommendSplashDamage=True
			BotRefireRate=0.300000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.500000
			BurstFireRateFactor=1.00	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
			ProjectileClass=Class'BWBP_SKC_Pro.MGLGrenadeRemote'
			SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
			Speed=4000.000000
			Damage=130.000000
			DamageRadius=356.000000
			HeadMult=1.0
			LimbMult=1.0
			MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.MGL.MGL-Fire',Volume=9.200000)
			Recoil=0.0
			Chaos=-1.0
			SplashDamage=True
			RecommendSplashDamage=True
			BotRefireRate=0.300000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			BurstFireRateFactor=1.00	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		DeclineTime=0.900000
		ViewBindFactor=0.900000
		ADSViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.450000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=6
		SightOffset=(X=-30.000000,Y=12.45,Z=14.8500000)
		SightPivot=(Pitch=512)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}