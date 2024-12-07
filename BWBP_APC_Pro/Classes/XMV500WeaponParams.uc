class XMV500WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	 
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=12000.000000)
		RangeAtten=0.35
		Damage=20
		DamageType=Class'BWBP_APC_Pro.DTXMV500MG'
		DamageTypeHead=Class'BWBP_APC_Pro.DTXMV500MGHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTXMV500MG'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=24.000000
		Chaos=0.120000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.550.Mini-Fire',Slot=SLOT_Interact,bNoOverride=False)
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
		ViewBindFactor=0.1
		CrouchMultiplier=0.75
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.22),(InVal=0.3,OutVal=0.28),(InVal=0.4,OutVal=0.4),(InVal=0.5,OutVal=0.3),(InVal=0.6,OutVal=0.1),(InVal=0.7,OutVal=0.25),(InVal=0.8,OutVal=0.4),(InVal=1,OutVal=0.600000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=-0.170000),(InVal=0.350000,OutVal=-0.400000),(InVal=0.500000,OutVal=-0.700000),(InVal=1.000000,OutVal=-1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=32768.000000
		DeclineTime=2.500000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=0.500000
		AimSpread=(Min=256,Max=1024)
		ChaosSpeedThreshold=350.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//SightOffset=(X=15.000000,Y=-17.000000,Z=75.000000)
		//ViewOffset=(X=20.000000,Y=17.000000,Z=-50.000000)
		DisplaceDurationMult=1.9
		PlayerSpeedFactor=0.700000
		PlayerJumpFactor=0.700000
		MagAmmo=200
		SightingTime=0.4
		SightMoveSpeedFactor=0.8
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}