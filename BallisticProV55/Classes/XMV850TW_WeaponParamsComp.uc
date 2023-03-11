class XMV850TW_WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=12000.000000)
		RangeAtten=0.35
		Damage=22
		DamageType=Class'BallisticProV55.DTXMV850MG'
		DamageTypeHead=Class'BallisticProV55.DTXMV850MGHead'
		DamageTypeArm=Class'BallisticProV55.DTXMV850MG'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=48.000000
		Chaos=0.080000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Fire-1',Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.050000	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.1,OutVal=0.03),(InVal=0.2,OutVal=-0.05),(InVal=0.3,OutVal=-0.07),(InVal=0.4,OutVal=0.0),(InVal=0.5,OutVal=0.1),(InVal=0.6,OutVal=0.18),(InVal=0.7,OutVal=0.05),(InVal=0.8,OutVal=0),(InVal=1,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.350000,OutVal=0.400000),(InVal=0.500000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.03000
		YRandFactor=0.03000
		ViewBindFactor=1.000000
		CrouchMultiplier=1.000000
		HipMultiplier=1.000000
		DeclineTime=1.100000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=1
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpOffSet=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=1
		AimSpread=(Min=0,Max=0)
		ChaosSpeedThreshold=350.000000
		AimDamageThreshold=2000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.300000
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.800000
		MagAmmo=300
		SightingTime=0.80000
		SightMoveSpeedFactor=0.9
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}