class M75WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=200000.000000,Max=200000.000000)
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Radius=350.000000)
		Damage=325.0
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTM75Railgun'
		DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
		PenetrationEnergy=2560.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.95
		WallPDamageFactor=0.7
		Recoil=3072.000000
		Chaos=-1.0
		PushbackForce=920.000000
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=1.000000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
        TargetState="FullChargedRail"
		FireInterval=0.900000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnimRate=0.300000
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=3072.000000
		DeclineTime=1.000000
		DeclineDelay=0.350000
		ViewBindFactor=0.750000
		ADSViewBindFactor=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=900,Max=2308)
		AimAdjustTime=0.450000
		OffsetAdjustTime=0.500000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-5120)
		ChaosDeclineTime=1.200000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		InventorySize=25
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		MagAmmo=3
		ViewOffset=(X=8.000000,Y=8.000000,Z=-14.000000)
		SightOffset=(X=15.7500000,Y=0.000000,Z=24.700000)
		ReloadAnimRate=1.100000
		CockAnimRate=1.325000
		ZoomType=ZT_Logarithmic
		ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
		WeaponName="M75-TIC 20mm Infantry Railgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}