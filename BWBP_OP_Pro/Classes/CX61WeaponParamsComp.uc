class CX61WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1250,Max=3750)
		RangeAtten=0.350000
		Damage=22
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=128
		Chaos=0.03
		WarnTargetPct=0.200000
		Inaccuracy=(X=48,Y=48)
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.115000
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.200000
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.2,OutVal=-0.03),(InVal=0.4,OutVal=0.11),(InVal=0.5,OutVal=0.13),(InVal=0.6,OutVal=0.15),(InVal=0.8,OutVal=0.16),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.190000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.620000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		DeclineDelay=0.135000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=768)
		ADSMultiplier=0.600000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=15000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.000000
		ReloadAnimRate=1.100000
		ViewOffset=(X=-3.000000,Y=7.000000,Z=-13.500000)
		SightOffset=(X=6.000000,Y=-0.350000,Z=22.799999)
		SightPivot=(Pitch=600)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.300000
		DisplaceDurationMult=1
		MagAmmo=32
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireHealParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}