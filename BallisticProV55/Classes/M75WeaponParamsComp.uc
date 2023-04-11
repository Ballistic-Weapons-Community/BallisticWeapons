class M75WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=768.000000
		Chaos=0.750000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		Damage=170
		PushbackForce=350.000000
	    DamageType=Class'BallisticProV55.DTM75Railgun'
        DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM75Railgun'		
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Volume=0.750000,Radius=384.000000)
	End Object
	
	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        TargetState="ChargedRail"
		FireInterval=1.500000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		Recoil=1024.000000
		Chaos=0.750000
		Damage=170
		BotRefireRate=0.3
		WarnTargetPct=0.75
		PushbackForce=1300.000000
		DamageType=Class'BallisticProV55.DTM75Railgun'
		DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Radius=768.000000)
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.50000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.18),(InVal=0.40000,OutVal=0.350000),(InVal=0.50000,OutVal=0.420000),(InVal=0.600000,OutVal=0.450000),(InVal=0.700000,OutVal=0.55),(InVal=0.800000,OutVal=0.60000),(InVal=1.000000,OutVal=0.7)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.400000
		ClimbTime=0.1
		DeclineDelay=0.4
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-8000,Yaw=-10000)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		JumpChaos=0.800000
		AimSpread=(Min=64,Max=1536)
		ChaosDeclineTime=0.800000
		ADSMultiplier=0.25
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		//SightOffset=(X=20.000000,Z=24.700000)
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.6
		SightingTime=0.45	
		ScopeScale=0.6
        MagAmmo=5
        InventorySize=8
        ZoomType=ZT_Logarithmic
		ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}