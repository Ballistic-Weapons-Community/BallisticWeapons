class GASCPistolWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=5000.000000)
		RangeAtten=0.200000
		Damage=35
		HeadMult=2.3
		LimbMult=0.6
		DamageType=Class'BWBP_APC_Pro.DTGASCPistol'
		DamageTypeHead=Class'BWBP_APC_Pro.DTGASCPistolHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTGASCPistol'
		PenetrationEnergy=24.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_APC_Pro.GASCFlashEmitter'
		FlashScaleFactor=0.10000
		Recoil=32.000000
		Chaos=0.100000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.GASC.Gaucho-Fire',Volume=1.200000)
		Inaccuracy=(X=256,Y=256)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.095000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.05),(InVal=0.400000,OutVal=0.10000),(InVal=0.5500000,OutVal=0.120000),(InVal=0.800000,OutVal=0.15000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.400000,OutVal=0.420000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15000
		YRandFactor=0.3000
		MaxRecoil=1024
		DeclineTime=0.5
		DeclineDelay=0.35000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		ViewBindFactor=None
		AimSpread=(Min=512,Max=1024)
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.150000
		DisplaceDurationMult=1
		MagAmmo=16
		WeaponModes(0)=(ModeName="Burst of Four",ModeID="WM_Burst",Value=4.000000,bUnavailable=True)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=3
		ViewOffset=(X=10.00000,Y=10.000000,Z=-8.00000)
		SightOffset=(X=-5.000000,Y=-6.350000,Z=9.700000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}