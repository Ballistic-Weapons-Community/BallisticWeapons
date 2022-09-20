class SuperchargerWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=3
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireSingle',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=45
		Chaos=0.01
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.063150
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
        TraceRange=(Min=160.000000,Max=160.000000)
        Damage=20
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
        HookStopFactor=1.500000
        HookPullForce=150.000000
        WarnTargetPct=0.05
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-SawOpen',Volume=0.750000,Radius=256.000000)
    End Object
    
    Begin Object Class=FireParams Name=ClassicSecondaryFireParams
        FireInterval=0.100000
        AmmoPerFire=0
        PreFireAnim=
        FireAnim="EndReload"
        FireEndAnim="MeleeLoopEnd"
        FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=0.800000,OutVal=0.000000),(InVal=1.000000,OutVal=-0.400000)))
		ViewBindFactor=0.600000
		CrouchMultiplier=0.800000
		XRandFactor=0.25000
		YRandFactor=0.25000
		MaxRecoil=1600
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1048)
		ViewBindFactor=0.050000
		ChaosDeclineTime=0.800000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=29
		SightingTime=0.300000
		SightOffset=(X=-10.000000,Y=-0.050000,Z=16.500000)
		SightPivot=(Pitch=64)
        ZoomType=ZT_Fixed
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}