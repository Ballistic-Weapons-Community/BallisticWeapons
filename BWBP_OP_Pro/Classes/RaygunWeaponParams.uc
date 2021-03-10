class RaygunWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.RaygunProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=4500.000000
		MaxSpeed=10000.000000
		AccelSpeed=80000.000000
		Damage=38
		MaxDamageGainFactor=0.5
		DamageGainStartTime=0.05
		DamageGainEndTime=0.2
		MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlashAlt'
		FlashScaleFactor=2.500000
		Recoil=108.000000
		Chaos=0.070000
		BotRefireRate=0.70000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.150000
		FireAnim="FireSmall"
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		Damage=10
		DamageType=Class'BWBP_OP_Pro.DTRaygunCharged'
		DamageTypeHead=Class'BWBP_OP_Pro.DTRaygunCharged'
		DamageTypeArm=Class'BWBP_OP_Pro.DTRaygunCharged'
		MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlash'
		FlashScaleFactor=4.000000
		Recoil=960.000000
		Chaos=0.320000
		BotRefireRate=0.250000
		WarnTargetPct=0.500000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.200000
		AmmoPerFire=8
		MaxHoldTime=2.50000
		FireAnim="ChargedFire"
		FireEndAnim=
		AimedFireAnim="Fire"	
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.140000),(InVal=0.600000,OutVal=0.120000),(InVal=0.700000,OutVal=0.120000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.150000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=0.320000),(InVal=0.450000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.230000
 	End Object
	 
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.250000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}