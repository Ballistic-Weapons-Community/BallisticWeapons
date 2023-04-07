class CX61WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1250,Max=3750)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.75f
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
        PenetrationEnergy=32
		PenetrateForce=180
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1
		Recoil=128
		Chaos=0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08000
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.200000
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.4
		ADSViewBindFactor=0.85
		XCurve=(Points=(,(InVal=0.2,OutVal=-0.03),(InVal=0.4,OutVal=0.11),(InVal=0.5,OutVal=0.13),(InVal=0.6,OutVal=0.15),(InVal=0.8,OutVal=0.16),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.190000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.620000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineDelay=0.135000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=0.85
		ReloadAnimRate=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=32
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireHealParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}