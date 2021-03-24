//=============================================================================
// MRDRWeaponParams
//=============================================================================
class MRDRWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		RangeAtten=0.200000
		Damage=20
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=64.000000
		Chaos=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MRDR.MRDR-Fire')
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.120000	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=130.000000,Max=130.000000)
		Damage=45
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88SpikeHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		HookStopFactor=1.700000
		HookPullForce=100.000000
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=32.000000,bAtten=True)
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

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
		AimSpread=(Min=16,Max=256)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
    Begin Object Class=WeaponParams Name=ArenaParams
        MagAmmo=24
        InventorySize=6
        SightingTime=0.200000
        PlayerSpeedFactor=1.05
        DisplaceDurationMult=0.5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}