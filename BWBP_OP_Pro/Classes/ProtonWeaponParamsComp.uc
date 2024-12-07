class ProtonWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		Damage=6
		DamageType=Class'BWBP_OP_Pro.DTProtonStreamer'
		DamageTypeHead=Class'BWBP_OP_Pro.DTProtonStreamer'
		MuzzleFlashClass=Class'BWBP_OP_Pro.ProtonFlashEmitter'
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.070000
		FireAnim="FireLoop"
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		Damage=2
		DamageType=Class'BWBP_OP_Pro.DTProtonStreamer'
		DamageTypeHead=Class'BWBP_OP_Pro.DTProtonStreamer'
		MuzzleFlashClass=Class'BWBP_OP_Pro.ProtonFlashEmitterAlt'
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.100000
		FireAnim="FireLoop"
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object

	Begin Object Class=RecoilParams Name=ProtonRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=-0.045000),(InVal=0.300000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		DeclineTime=1.500000
		DeclineDelay=0.250000
		HipMultiplier=3.5
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=2560)
		ADSMultiplier=0.000000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=15000.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		
		PlayerJumpFactor=1
		InventorySize=4
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		DisplaceDurationMult=1
		MagAmmo=100
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}