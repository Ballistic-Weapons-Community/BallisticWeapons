class CX61WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.350000
		Damage=22
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=128.000000
		Chaos=0.030000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
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
    // SECONDARY FIRE - FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaFireSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX61FlameProjectile'
		Chaos=0.050000
		WarnTargetPct=0.200000
		Damage=8
		DamageRadius=192
		Speed=3000
		MaxSpeed=3000
		FireSound=(Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=ArenaFireSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		FireEffectParams(0)=ProjectileEffectParams'ArenaFireSecondaryEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE - HEAL
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaHealSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX61HealProjectile'
		Chaos=0.050000
		WarnTargetPct=0.200000
		Damage=2
		DamageRadius=32
		Speed=3000
		FireSound=(Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=ArenaHealSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		FireEffectParams(0)=ProjectileEffectParams'ArenaHealSecondaryEffectParams'
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
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=15000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.300000
		DisplaceDurationMult=1
		MagAmmo=32
		WeaponModes(0)=(ModeName="Flamethrower",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Healing Gas",ModeID="WM_FullAuto")
		WeaponModes(2)=(bUnavailable=True)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaFireSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaHealSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}