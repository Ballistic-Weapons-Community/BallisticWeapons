class PKMMachinegunWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
			TraceRange=(Min=15000.000000,Max=15000.000000)
			RangeAtten=0.35
			Damage=26
			HeadMult=2.0f
			LimbMult=0.75f
			DamageType=Class'BWBP_APC_Pro.DTPKM'
			DamageTypeHead=Class'BWBP_APC_Pro.DTPKMHead'
			DamageTypeArm=Class'BWBP_APC_Pro.DTPKM'
			PenetrateForce=150
			bPenetrate=True
			MuzzleFlashClass=Class'BWBP_APC_Pro.PKMFlashEmitter'
			FlashScaleFactor=1.000000
			Recoil=192.000000
			WarnTargetPct=0.200000
			FireSound=(Sound=Sound'BWBP_CC_Sounds.RPK940.RPK-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryFireParams
			FireInterval=0.110000
			FireEndAnim=
			AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
			ProjectileClass=Class'BWBP_APC_Pro.PKMKnife'
			SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
			Speed=8500.000000
			MaxSpeed=8500.000000
			Damage=90
			BotRefireRate=0.300000
			WarnTargetPct=0.300000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=1.350000)
		End Object

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=0.650000
			PreFireTime=0.450000
			PreFireAnim="KnifeFirePrep"
			FireAnim="KnifeFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.500000,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.300000,OutVal=0.40000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.12000
		YRandFactor=0.12000
		MaxRecoil=12288
		DeclineDelay=0.15
		DeclineTime=0.9
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=768)
		SprintOffset=(Pitch=-4000,Yaw=-8000)
		ChaosDeclineTime=1.600000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.250000
		PlayerSpeedFactor=0.900000
		PlayerJumpFactor=0.900000
		InventorySize=6
		SightMoveSpeedFactor=0.9
		SightingTime=0.55000
		DisplaceDurationMult=1
		MagAmmo=75
		ViewOffset=(X=5.000000,Y=6.000000,Z=-12.000000)
		SightOffset=(X=5.000000,Y=-1.1150000,Z=14.10000)
		SightPivot=(Pitch=-64)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}