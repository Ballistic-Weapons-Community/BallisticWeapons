class R78WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
		HeadMult=1.5f
		LimbMult=0.9f
		DamageType=Class'BallisticProV55.DTR78Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=378.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.R78NS.R78NS-Fire',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=1.1
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.2
		CrouchMultiplier=0.600000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.16),(InVal=0.40000,OutVal=0.250000),(InVal=0.50000,OutVal=0.30000),(InVal=0.600000,OutVal=0.370000),(InVal=0.700000,OutVal=0.4),(InVal=0.800000,OutVal=0.50000),(InVal=1.000000,OutVal=0.55)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=1.25
		DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.25
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimAdjustTime=0.700000
		AimSpread=(Min=64,Max=512)
		ChaosSpeedThreshold=500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		SightingTime=0.550000
		SightMoveSpeedFactor=0.8
		MagAmmo=7
        InventorySize=12
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}