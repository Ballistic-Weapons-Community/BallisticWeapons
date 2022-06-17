class MACWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
			ProjectileClass=Class'BallisticProV55.MACShell'
			SpawnOffset=(X=28.000000,Y=10.000000)
			Speed=25000.000000
			MaxSpeed=25000.000000
			Damage=350.000000
			DamageRadius=192.000000
			MomentumTransfer=80000.000000
			HeadMult=1.0
			LimbMult=1.0
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
			FlashScaleFactor=2.500000
			FireSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Fire')
			Recoil=8000.000000
			Chaos=0.800000
			PushbackForce=1000.000000
			Inaccuracy=(X=4,Y=4)
			SplashDamage=True
			RecommendSplashDamage=True
			BotRefireRate=0.500000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=1.500000
			BurstFireRateFactor=1.00
			FireEndAnim=	
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
			FireInterval=1.000000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="Deploy"
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.200000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=8192.000000
		DeclineTime=3.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=2048)
		AimAdjustTime=1.000000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.400000
		SprintChaos=0.400000
		ChaosDeclineTime=5.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		SightPivot=(Pitch=450)
		SightOffset=(X=-5.000000,Y=-15.000000,Z=10.000000)
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		InventorySize=51
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		//SightingTime=0.000000
        //ZoomType=ZT_Smooth
        ZoomType=ZT_Logarithmic
		MagAmmo=5
		//SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}