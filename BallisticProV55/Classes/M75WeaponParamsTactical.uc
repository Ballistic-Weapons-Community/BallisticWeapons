class M75WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=768.000000
		Chaos=0.750000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		Damage=200
        HeadMult=2
        LimbMult=0.67f
		PushbackForce=350.000000
	    DamageType=Class'BallisticProV55.DTM75Railgun'
        DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM75Railgun'		
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Volume=0.750000,Radius=384.000000)
	End Object
	
	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        TargetState="ChargedRail"
		FireInterval=1.500000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		Recoil=1024.000000
		Chaos=0.750000
		Damage=200
        HeadMult=2
        LimbMult=0.67f
		BotRefireRate=0.3
		WarnTargetPct=0.75
		PushbackForce=1300.000000
		DamageType=Class'BallisticProV55.DTM75Railgun'
		DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Radius=768.000000)
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.50000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		CrouchMultiplier=0.600000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.18),(InVal=0.40000,OutVal=0.350000),(InVal=0.50000,OutVal=0.420000),(InVal=0.600000,OutVal=0.450000),(InVal=0.700000,OutVal=0.55),(InVal=0.800000,OutVal=0.60000),(InVal=1.000000,OutVal=0.7)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.400000
		DeclineTime=1.500000
		DeclineDelay=0.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		SprintOffset=(Pitch=-8000,Yaw=-10000)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		JumpChaos=0.800000
		AimSpread=(Min=768,Max=4096)
		ChaosDeclineTime=0.800000
		ADSMultiplier=0.75
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=-24.000000,Z=24.700000)
		ViewOffset=(X=15.000000,Y=11.000000,Z=-12.000000)
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.4
        SightingTime=0.8
        MagAmmo=5
        InventorySize=7
        ZoomType=ZT_Logarithmic
		ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}