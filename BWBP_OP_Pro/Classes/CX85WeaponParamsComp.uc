class CX85WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//556
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2363,Max=5000)
		PenetrationEnergy=32
		RangeAtten=0.67
		Damage=23
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
	
	//spike shot
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Seeker
		ProjectileClass=Class'BWBP_OP_Pro.CX85Flechette'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=15000.000000
		MaxSpeed=20000.000000
		AccelSpeed=1000.000000
		Damage=40
		DamageRadius=8.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.700000
		Recoil=256.000000
		Chaos=-1.00000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX61.CX61-FireHeavy',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Seeker
		FireInterval=0.25
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="Fire"
		FireAnimRate=1.000000	
		TargetState="SeekerFlechette"
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Seeker'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//HE tracker dart
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=15
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
	
	//Smart linked tracker dart
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Smart
		FireInterval=0.850000
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
		ClimbTime=0.04
		DeclineDelay=0.140000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1024)
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-1024,Yaw=-1024)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="5.56mm Mod"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.45	
		//Attachments
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerSpeedFactor=0.95
		InventorySize=6
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=50
		// fixed 4x
        ZoomType=ZT_Fixed
		MaxZoom=4
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_Seeker
		//Layout core
		LayoutName="Seeker Spikes"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.45	
		//Attachments
		ReloadAnimRate=1.00
		CockAnimRate=1.00
		PlayerSpeedFactor=0.95
		InventorySize=6
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=24
		// fixed 4x
        ZoomType=ZT_Fixed
		MaxZoom=4
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Seeker'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Smart'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Seeker'
}