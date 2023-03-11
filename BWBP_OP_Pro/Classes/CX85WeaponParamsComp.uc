class CX85WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=9000)
		RangeAtten=0.350000
		Damage=21
		DamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
		DamageTypeHead=Class'BWBP_OP_Pro.DTCX85BulletHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTCX85Bullet'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=120
		Chaos=0.08
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,Pitch=1.500000,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.0900000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="Fire"
		FireAnimRate=1.200000
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=5
		DamageType=Class'DTCX85Dart'
		DamageTypeHead=Class'DTCX85Dart'
		DamageTypeArm=Class'DTCX85Dart'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
		Recoil=256.000000
		Chaos=0.500000
		BotRefireRate=0.300000
		WarnTargetPct=0.300000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.350000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="FireAlt"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.120000),(InVal=0.400000,OutVal=0.180000),(InVal=0.800000,OutVal=0.220000),(InVal=1.000000,OutVal=0.250000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.445000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=1.000000
		DeclineDelay=0.170000
	End Object

	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1024)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-1024,Yaw=-1024)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		ViewOffset=(X=25.000000,Y=18.000000,Z=-25.000000)
		SightOffset=(X=-20.000000,Z=35.000000)
		CockAnimRate=1.200000
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=7
		SightMoveSpeedFactor=0.8
		SightingTime=0.650000
		DisplaceDurationMult=1
		MagAmmo=50
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}