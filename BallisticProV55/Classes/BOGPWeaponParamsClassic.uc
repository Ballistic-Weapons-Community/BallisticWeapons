class BOGPWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
			ProjectileClass=Class'BallisticProV55.BOGPGrenade'
			SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
			Speed=1750.000000
			Damage=120.000000
			DamageRadius=384.000000
			HeadMult=1.0
			LimbMult=1.0
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
			FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.BOGP.BOGP_Fire',Volume=1.750000)
			Recoil=0.0
			Chaos=-1.0
			SplashDamage=True
			RecommendSplashDamage=True
			BotRefireRate=0.300000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.100000
			BurstFireRateFactor=1.00
			bCockAfterFire=True
			PreFireAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			SpreadMode=FSM_Rectangle
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.200000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=1024)
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		SightOffset=(X=-8.000000,Y=-0.650000,Z=10.500000)
		SightPivot=(Pitch=1024,Roll=-1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}