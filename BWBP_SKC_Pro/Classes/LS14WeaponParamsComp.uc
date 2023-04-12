class LS14WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=12
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

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.250000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LS14Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=750.000000
		MaxSpeed=9000.000000
		AccelSpeed=6750.000000
		Damage=70
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
		FlashScaleFactor=2.600000
		Recoil=512.000000
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
		PreFireAnim="GrenadePrepFire"
		FireAnim="RLFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
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
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.0
		ChaosDeclineDelay=0.5
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		WeaponBoneScales(0)=(BoneName="Scope",Slot=21,Scale=1f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=22,Scale=0f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=23,Scale=1f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=24,Scale=0f)
		SightPivot=(Pitch=600,Roll=-1024)
		//SightOffset=(X=26.000000,Y=-8.500000,Z=22.500000)
		
		PlayerJumpFactor=1
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.40000		
		DisplaceDurationMult=1
		MagAmmo=20
		// fixed 3x - acog/carbine
		ZoomType=ZT_Fixed
		MaxZoom=3
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}