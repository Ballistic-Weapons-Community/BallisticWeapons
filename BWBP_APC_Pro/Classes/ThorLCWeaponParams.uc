class ThorLCWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		Damage=8
		HeadMult=1f
		LimbMult=1f
		DamageType=Class'BallisticProV55.DT_HVCLightning'
		DamageTypeHead=Class'BallisticProV55.DT_HVCLightning'
		DamageTypeArm=Class'BallisticProV55.DT_HVCLightning'
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9MuzzleFlash'
		FlashScaleFactor=1.200000
		Recoil=4.000000
		BotRefireRate=0.150000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="FireLoop"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		Damage=0.0
		HeadMult=1.0
		LimbMult=1.0
		DamageType=Class'BWBP_OP_Pro.DTProtonStreamer'
		DamageTypeHead=Class'BWBP_OP_Pro.DTProtonStreamer'
		DamageTypeArm=Class'BWBP_OP_Pro.DTProtonStreamer'
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9MuzzleFlash'
		FlashScaleFactor=1.200000
		Recoil=2.000000
		BotRefireRate=0.150000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="FireLoop"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ProtonRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=-0.045000),(InVal=0.300000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		DeclineTime=1.500000
		DeclineDelay=0.250000
		HipMultiplier=3.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=2560)
		ADSMultiplier=0.000000
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=15000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=7
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