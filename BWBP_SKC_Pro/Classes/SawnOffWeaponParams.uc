class SawnOffWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryShotEffectParams
		TraceRange=(Min=2560.000000,Max=3072.000000)
		RangeAtten=0.200000
		TraceCount=18
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=14
		Damage=6
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1152.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=220,Y=220)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-SFire',Volume=1.200000)	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireShotParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryShotEffectParams'
	End Object

	Begin Object Class=ShotgunEffectParams Name=ArenaPrimarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		MaxHits=14 
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
        HeadMult=1.5f
        LimbMult=0.8f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=1152.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=16,Y=0)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireSlugParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimarySlugEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.350000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.300000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		DeclineTime=0.900000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		WeaponBoneScales(0)=(BoneName="RDS",Slot=13,Scale=0f)
		//SightOffset=(X=-40.000000,Y=11.150000,Z=29.000000)
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=11
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireShotParams'
		FireParams(1)=FireParams'ArenaPrimaryFireSlugParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}