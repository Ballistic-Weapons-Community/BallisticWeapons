class AK91WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.75
		Damage=40
        HeadMult=2.75f
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK91Zapped'
		PenetrateForce=0
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.200000
		Recoil=128.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.rpk940.rpk-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.130000
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=600.000000,Max=600.000000)
		RangeAtten=0.2
		TraceCount=3
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_GRSXXLaser'
		Damage=5
		DamageType=Class'BWBP_SKC_Pro.DT_AK91ZappedAlt'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK91ZappedAlt'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK91ZappedAlt'
		PenetrateForce=50
		MuzzleFlashClass=Class'A49FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-SecFire',Volume=1.000000)
		Chaos=0.5
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.700000
		AmmoPerFire=0
		FireAnim="FireAlt"	
	FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.5,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.300000,OutVal=0.35000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=0.15
		DeclineTime=0.65
		HipMultiplier=1.25
		MaxMoveMultiplier=2	
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1536)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ViewBindFactor=0.200000
		ChaosDeclineTime=1.500000
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		SightingTime=0.350000
        SightMoveSpeedFactor=0.6
		SightOffset=(X=-10.000000,Y=-0.050000,Z=16.500000)
		SightPivot=(Pitch=64)
		ViewOffset=(X=5.000000,Y=7.000000,Z=-13.000000)
		MagAmmo=25
		InventorySize=6
		WeaponBoneScales(0)=(BoneName="Scope",Slot=61,Scale=0f)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}