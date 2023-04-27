class LS14WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=20
        HeadMult=2.5
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=128.000000
		Chaos=0.300000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.250000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LS14Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=5500.000000
		MaxSpeed=7500.000000
		AccelSpeed=60000.000000
		Damage=105
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
		FlashScaleFactor=2.600000
		Recoil=512.000000
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.7500000
		AmmoPerFire=0
		PreFireAnim="GrenadePrepFire"
		FireAnim="RLFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=1,OutVal=0)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=1,OutVal=1)))
		XRandFactor=0.0
		YRandFactor=0.0
		ClimbTime=0.01
		DeclineDelay=0.18
		DeclineTime=1.000000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
		AimAdjustTime=0.700000
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.0
		ChaosDeclineDelay=0.5
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=21,Scale=1f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=22,Scale=0f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=23,Scale=1f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=24,Scale=0f)
		SightPivot=(Pitch=600,Roll=-1024)
		//SightOffset=(X=26.000000,Y=-8.500000,Z=22.500000)
		InventorySize=6
		SightMoveSpeedFactor=0.35
		SightingTime=0.5
		DisplaceDurationMult=1
		MagAmmo=20
		// fixed 3x - acog/carbine
		ZoomType=ZT_Fixed
		MaxZoom=3
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}