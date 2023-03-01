class XM20WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{ 
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=11000.000000,Max=12000.000000)
        DecayRange=(Min=0,Max=4500)
		Damage=20
        HeadMult=2.5
        LimbMult=0.67f
		DamageType=Class'BWBP_OP_Pro.DTXM20Body'
		DamageTypeHead=Class'BWBP_OP_Pro.DTXM20Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DTXM20Body'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_OP_Pro.XM20FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=128.000000
		Chaos=0.07000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.135000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams

	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="Cock"
		FireAnimRate=1.00
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.150000,OutVal=0.020000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.11),(InVal=0.400000,OutVal=0.130000),(InVal=0.600000,OutVal=0.20000),(InVal=0.800000,OutVal=0.25000),(InVal=1.000000,OutVal=0.30000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.5,OutVal=0.600000),(InVal=0.600000,OutVal=0.67),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		DeclineDelay=0.15
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.5
		ChaosDeclineDelay=0.3
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(1)=(BoneName="Prototype",Slot=59,Scale=1f)
		ReloadAnimRate=1.000000
		SightOffset=(X=20.000000,Y=16.8500000,Z=29.000000)
		ViewOffset=(X=4.000000,Y=0.000000,Z=-22.000000)
		InventorySize=20
		SightMoveSpeedFactor=0.9
		SightingTime=0.3
		DisplaceDurationMult=1
		MagAmmo=20
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}