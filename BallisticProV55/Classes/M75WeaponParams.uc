class M75WeaponParams extends BallisticWeaponParams;

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
		Damage=80
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
		Damage=80
		BotRefireRate=0.3
		WarnTargetPct=0.75
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
		CrouchMultiplier=0.600000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.18),(InVal=0.40000,OutVal=0.350000),(InVal=0.50000,OutVal=0.420000),(InVal=0.600000,OutVal=0.450000),(InVal=0.700000,OutVal=0.55),(InVal=0.800000,OutVal=0.60000),(InVal=1.000000,OutVal=0.7)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.400000
		DeclineTime=1.500000
		DeclineDelay=0.500000
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
		ADSMultiplier=0.5
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightOffset=(X=-24.000000,Z=24.700000)
		ViewOffset=(X=15.000000,Y=11.000000,Z=-12.000000)
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.850000
		SightMoveSpeedFactor=0.8
        SightingTime=0.6
        MagAmmo=5
        InventorySize=12
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}