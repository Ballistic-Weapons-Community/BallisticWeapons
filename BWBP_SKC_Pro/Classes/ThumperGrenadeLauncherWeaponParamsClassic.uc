class ThumperGrenadeLauncherWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.ThumperGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		Damage=65
		DamageRadius=384.000000
		MomentumTransfer=100000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Fire',Volume=3.500000)
		Chaos=0.700000
		SplashDamage=True
		Recoil=56
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.55
		PreFireAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.ThumperSmokeGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		Damage=20
		DamageRadius=128.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Fire',Volume=1.750000)
		Chaos=0.700000
		SplashDamage=True
		Recoil=56
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.45
		PreFireAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
        ViewBindFactor=0.65
        CrouchMultiplier=0.750000
        XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.270000),(InVal=0.600000,OutVal=0.350000),(InVal=0.700000,OutVal=0.40000),(InVal=1.000000,OutVal=0.4500000)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.170000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.100000),(InVal=1.000000,OutVal=0.500000)))
        XRandFactor=0.200000
        YRandFactor=0.200000
        DeclineTime=1.500000
    End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
        ADSMultiplier=0.150000
        SprintOffSet=(Pitch=-3000,Yaw=-4000)
        AimAdjustTime=0.600000
        AimSpread=(Min=0,Max=128)
        AimDamageThreshold=75.000000
        ChaosDeclineTime=0.320000
        ChaosSpeedThreshold=1000.000000
    End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		MagAmmo=5
		ViewOffset=(X=5,Y=9,Z=-2)
		//ViewOffset=(X=30.000000,Y=15.000000,Z=-20.000000)
		ViewPivot=(Pitch=600)
		//SightOffset=(X=-30.000000,Y=-0.030000,Z=34.000000)
		SightPivot=(Pitch=-550)
		SightingTime=0.300000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
