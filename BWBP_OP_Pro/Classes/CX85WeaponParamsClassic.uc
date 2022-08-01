class CX85WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.350000
		Damage=50
		DamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
		DamageTypeHead=Class'BWBP_OP_Pro.DTCX85BulletHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTCX85Bullet'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=1.700000
		Recoil=256.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX85.CX85-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.150000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97TrackerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		AccelSpeed=8000.000000
		Speed=2240.000000
		MaxSpeed=10000.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.PD97.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="Fire"
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.120000),(InVal=0.400000,OutVal=0.180000),(InVal=0.800000,OutVal=0.220000),(InVal=1.000000,OutVal=0.250000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.445000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=1.000000
		DeclineDelay=0.170000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=768)
		ADSMultiplier=0.15
		SprintOffset=(Pitch=-3000,Yaw=-8000)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.650000
		DisplaceDurationMult=1
		MagAmmo=32
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}