class M353TW_WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 1;
	BWA.ModeInfos[0].TracerMix = 4;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTM353MGDeploy'
		DamageTypeHead=Class'BallisticProV55.DTM353MGDeployHead'
		DamageTypeArm=Class'BallisticProV55.DTM353MGDeploy'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=64.000000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Fire1',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08000
		FireEndAnim=
		BurstFireRateFactor=0.66
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
	 	HipMultiplier=1.000000
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.5,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.03000
		YRandFactor=0.03000
        ViewBindFactor=1.000000
		MaxRecoil=12288.000000
		DeclineTime=0.5
		DeclineDelay=0.150000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.350000
		AimAdjustTime=0.800000
		AimSpread=(Min=0,Max=0)
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		ViewBindFactor=1.000000
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=300
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		WeaponModes(0)=(bUnavailable=True)
		WeaponModes(1)=(ModeName="Burst of Three",ModeID="WM_Burst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_Burst",Value=5.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
        SightMoveSpeedFactor=0.5
		MagAmmo=100
		SightingTime=0.45
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}