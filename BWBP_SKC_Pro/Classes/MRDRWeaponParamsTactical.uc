//=============================================================================
// MRDRWeaponParams
//=============================================================================
class MRDRWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		RangeAtten=0.5
        DecayRange=(Min=788,Max=1838)
		Damage=22
        HeadMult=2.5
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
        PenetrationEnergy=8
		FlashScaleFactor=0.600000
		Recoil=64.000000
		Chaos=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MRDR.MRDR-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.165000
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
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.200000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.550000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.800000
		DeclineDelay=0.350000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
		AimSpread=(Min=16,Max=256)
        ADSMultiplier=1
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
    Begin Object Class=WeaponParams Name=TacticalParams
        ViewOffset=(X=-8.000000,Y=8.000000,Z=-8.000000)
		SightPivot=(Pitch=900,Roll=-800)
		SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
		MagAmmo=24
        InventorySize=3
        SightingTime=0.200000
        DisplaceDurationMult=0.5
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}