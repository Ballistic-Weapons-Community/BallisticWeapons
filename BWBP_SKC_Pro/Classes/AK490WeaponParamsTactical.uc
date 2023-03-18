class AK490WeaponParamsTactical extends BallisticWeaponParams;

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
		TraceRange=(Min=12000.000000,Max=13000.000000)
        DecayRange=(Min=2363,Max=6000)
		RangeAtten=0.75
		Damage=46
        HeadMult=2.75f
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_AK47Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK47AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK47Assault'
        PenetrationEnergy=32
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'AK47FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=220.000000
		Chaos=0.04000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.11000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AK47Knife'
		SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
		Speed=8500.000000
		MaxSpeed=8500.000000
		Damage=75
        HeadMult=2.75
        LimbMult=0.67f
		BotRefireRate=0.300000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=0.50000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="PreKnifeFire"
		FireAnim="KnifeFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.5,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.300000,OutVal=0.35000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=0.15
		DeclineTime=0.65	
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=1.250000
		InventorySize=6
        SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=25
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}