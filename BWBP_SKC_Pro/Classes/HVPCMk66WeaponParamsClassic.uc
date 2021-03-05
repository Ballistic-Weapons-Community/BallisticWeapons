class HVPCMk66WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
			ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66Projectile'
			SpawnOffset=(X=100.000000,Y=10.000000,Z=-9.000000)
			Speed=1500.000000
			MaxSpeed=1000000.000000
			AccelSpeed=100.000000
			Damage=500.000000
			DamageRadius=832.000000
			MomentumTransfer=280000.000000
			HeadMult=1.0
			LimbMult=1.0
			MuzzleFlashClass=Class'BWBP_SKC_Pro.BFGFlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.BFG.BFG-Fire',Volume=4.500000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=820.000000
			Chaos=0.600000
			Inaccuracy=(X=8,Y=4)
			WarnTargetPct=0.200000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=2.500000
			AmmoPerFire=50
			BurstFireRateFactor=1.00
			FireAnim="Fire2"
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
			ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66ProjectileSmall'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=250.000000
			MaxSpeed=2000000.000000
			AccelSpeed=190000.000000
			Damage=60
			DamageRadius=122.000000
			MomentumTransfer=12500.000000
			HeadMult=2.083333
			LimbMult=0.666666
			MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.BFG.BFG-SmallFire',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=100.000000
			Chaos=0.050000
			Inaccuracy=(X=2,Y=2)
			WarnTargetPct=0.200000	
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.110000
			AmmoPerFire=2
			BurstFireRateFactor=1.00
			FireAnim="Fire2"
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=256.000000
		DeclineTime=0.750000
		ViewBindFactor=0.450000
		ADSViewBindFactor=0.450000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=50,Max=1100)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.350000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=380.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.650000
		PlayerJumpFactor=0.600000
		InventorySize=70
		SightMoveSpeedFactor=0.500000
		SightOffset=(X=-18.000000,Z=23.299999)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}