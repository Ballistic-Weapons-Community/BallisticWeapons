class X82WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=120
        HeadMult=1.75f
        LimbMult=0.85f
		PenetrationEnergy=128
		DamageType=Class'BWBP_SKC_Pro.DT_X82Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_X82Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_X82Torso'
		PenetrateForce=450
		PushbackForce=255.000000
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=768.000000
		Chaos=0.700000
		BotRefireRate=0.300000
		WarnTargetPct=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire',Volume=10.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.750000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams

	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.000000
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.1
		XRandFactor=0.600000
		YRandFactor=0.300000
		MaxRecoil=8192
		ClimbTime=0.08
		DeclineDelay=0.75
		DeclineTime=1.5
		CrouchMultiplier=0.750000
		HipMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=256,Max=2048)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.35
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.200000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.700000
		ReloadAnimRate=0.70000
		SightPivot=(Roll=-1024)
		//SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
		//ViewOffset=(X=4.000000,Y=6.000000,Z=-7.500000)
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
        DisplaceDurationMult=1.4
		InventorySize=7
		SightMoveSpeedFactor=0.6
		SightingTime=0.6	
		ScopeScale=0.8	
		MagAmmo=5
        ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}