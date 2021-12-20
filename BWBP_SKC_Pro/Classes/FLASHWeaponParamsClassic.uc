class FLASHWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
			ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
			Speed=4500.000000
			Damage=100.000000
			DamageRadius=270.000000
			MomentumTransfer=10000.000000
			HeadMult=1.0
			LimbMult=1.0
			MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireInc',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=1024.000000
			Chaos=-1.0
			Inaccuracy=(X=400,Y=400)
			SplashDamage=True
			RecommendSplashDamage=True
			BotRefireRate=0.500000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.700000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
			ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
			Speed=4500.000000
			Damage=100.000000
			DamageRadius=270.000000
			MomentumTransfer=10000.000000
			HeadMult=1.0
			LimbMult=1.0
			MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireInc',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=1024.000000
			Chaos=-1.0
			Inaccuracy=(X=400,Y=400)
			SplashDamage=True
			RecommendSplashDamage=True
			BotRefireRate=0.500000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=3.500000
			BurstFireRateFactor=1.00
			FireAnim="FireAll"
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=1024.000000
		DeclineTime=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.400000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=480,Max=2000)
		CrouchMultiplier=0.400000
		ADSMultiplier=0.100000
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=380.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.800000
		InventorySize=51
		SightMoveSpeedFactor=0.500000
		MagAmmo=4
		SightOffset=(X=0.000000,Y=5.300000,Z=23.300000)
		ZoomType=ZT_Fixed
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}