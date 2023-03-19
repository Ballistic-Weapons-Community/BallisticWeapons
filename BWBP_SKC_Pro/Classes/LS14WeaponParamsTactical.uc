class LS14WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=30
        HeadMult=2.25
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=150.000000
		Chaos=0.300000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.150000
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
		Recoil=256.000000
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
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.1),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.20000),(InVal=0.400000,OutVal=0.420000),(InVal=0.600000,OutVal=0.560000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.000000
		DeclineDelay=0.2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
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
		ViewOffset=(X=-5.000000,Y=12.000000,Z=-15.000000)
		SightPivot=(Pitch=600,Roll=-1024)
		SightOffset=(X=18.000000,Y=-8.500000,Z=22.000000)
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.5
		DisplaceDurationMult=1
		MagAmmo=20
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}