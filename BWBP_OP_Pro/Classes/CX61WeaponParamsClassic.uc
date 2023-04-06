class CX61WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
	
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX61Flechette'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=15000.000000
		MaxSpeed=20000.000000
		AccelSpeed=1000.000000
		Damage=45
		DamageRadius=8.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.700000
		Recoil=256.000000
		Chaos=-1.00000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX61.CX61-FireHeavy',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.150000
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		TargetState="Flechette"
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.060000),(InVal=0.400000,OutVal=0.110000),(InVal=0.500000,OutVal=-0.120000),(InVal=0.600000,OutVal=0.130000),(InVal=0.800000,OutVal=0.160000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.1000),(InVal=0.200000,OutVal=0.19000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.35000
		YRandFactor=0.35000
		DeclineTime=1.5
		DeclineDelay=0.150000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1024)
		ADSMultiplier=0.200000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.00000
		ChaosSpeedThreshold=1200.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=7
		SightMoveSpeedFactor=0.9
		SightingTime=0.300000
		DisplaceDurationMult=1
		//ViewOffset=(X=-3.000000,Y=7.000000,Z=-13.500000)
		//SightOffset=(X=6.000000,Y=-0.350000,Z=22.799999)
		SightPivot=(Pitch=600)
		WeaponModes(0)=(ModeName="Flamethrower",Value=2,ModeID="WM_BigBurst")
		WeaponModes(1)=(ModeName="Healing Gas",Value=2,ModeID="WM_BigBurst")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		bNeedCock=True
		MagAmmo=16
		WeaponName="CX61 Flechette Rifle"
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireHealParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}