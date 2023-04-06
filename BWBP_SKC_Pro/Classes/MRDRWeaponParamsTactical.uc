//=============================================================================
// MRDRWeaponParams
//=============================================================================
class MRDRWeaponParamsTactical extends BallisticWeaponParams;

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
		RangeAtten=0.5
        DecayRange=(Min=525,Max=1225)
		Inaccuracy=(X=128,Y=128)
		Damage=22
        HeadMult=3f
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
        PenetrationEnergy=16
		FlashScaleFactor=0.600000
		Recoil=64.000000
		Chaos=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MRDR.MRDR-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.135
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=130.000000,Max=130.000000)
		Damage=45
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88SpikeHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=32.000000,bAtten=True)
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.5
		AmmoPerFire=0
		FireAnim="Melee1"
		FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.5
		ADSViewBindFactor=0.85
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.200000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.550000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineTime=0.750000
		DeclineDelay=0.190000
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		AimSpread=(Min=256,Max=768)
        ADSMultiplier=0.75
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
    Begin Object Class=WeaponParams Name=TacticalParams
		SightPivot=(Pitch=900,Roll=-800)
		//SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
		MagAmmo=24
        InventorySize=3
        SightingTime=0.200000
        SightMoveSpeedFactor=0.6
        DisplaceDurationMult=0.5
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}