class X82WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=120
        HeadMult=2
        LimbMult=0.67f
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

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.750000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams

	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.000000
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.1
		XRandFactor=0.600000
		YRandFactor=0.300000
		DeclineTime=1.500000
		MaxRecoil=8192
		HipMultiplier=2.5
		CrouchMultiplier=0.7
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=2048)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.75
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.200000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=1.700000
		ReloadAnimRate=0.70000
		SightPivot=(Roll=-1024)
		SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
		ViewOffset=(X=4.000000,Y=6.000000,Z=-7.500000)
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
        DisplaceDurationMult=1.4
		InventorySize=7
		SightMoveSpeedFactor=0.5
		SightingTime=0.8
		MagAmmo=5
        ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}