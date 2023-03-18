class LK05WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=11000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=40
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
        PenetrationEnergy=16
		PenetrateForce=150
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1
		Recoil=160.000000
		Chaos=0.028000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-RapidFire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.095000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.18),(InVal=0.35,OutVal=0.22),(InVal=0.5,OutVal=0.3),(InVal=0.7,OutVal=0.45),(InVal=0.85,OutVal=0.6),(InVal=1.000000,OutVal=0.66)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.4
		DeclineDelay=0.200000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=10.000000,Y=-8.550000,Z=24.660000)
		ViewOffset=(X=-6.000000,Y=12.000000,Z=-17.000000)
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}