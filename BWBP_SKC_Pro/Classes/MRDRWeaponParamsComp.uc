//=============================================================================
// MRDRWeaponParams
//=============================================================================
class MRDRWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
        DecayRange=(Min=525,Max=1225)
		PenetrationEnergy=16
        RangeAtten=0.5
		Damage=20
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=240.000000
		Chaos=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MRDR.MRDR-Fire')
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.135
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=130.000000,Max=130.000000)
		Damage=55
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88SpikeHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=12.000000,bAtten=True)
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		FireAnim="Melee1"
		FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.75
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.200000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.550000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		ClimbTime=0.04
		DeclineDelay=0.190000
		DeclineTime=0.750000
		CrouchMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
		AimSpread=(Min=16,Max=256)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
    Begin Object Class=WeaponParams Name=ArenaParams
		SightPivot=(Pitch=900,Roll=-800)
		//SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
		MagAmmo=24
        InventorySize=3
        SightingTime=0.200000
        SightMoveSpeedFactor=0.9
        DisplaceDurationMult=0.5
		ReloadAnimRate=1.25
		CockAnimRate=1.25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}