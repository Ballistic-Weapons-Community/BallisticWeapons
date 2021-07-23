class CX85WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.350000
		Damage=21
		DamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
		DamageTypeHead=Class'BWBP_OP_Pro.DTCX85BulletHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTCX85Bullet'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=120.000000
		Chaos=0.080000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,Pitch=1.500000,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.090000
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX85Dart'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-2.000000)
		Speed=35000.000000
		MaxSpeed=100000.000000
		AccelSpeed=100000.000000
		Damage=8
		Recoil=256.000000
		Chaos=0.500000
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.350000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="FireAlt"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
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
		AimSpread=(Min=16,Max=768)
		ADSMultiplier=0.15
		SprintOffset=(Pitch=-3000,Yaw=-8000)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=12
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