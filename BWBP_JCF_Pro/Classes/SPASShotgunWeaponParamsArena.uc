class SPASShotgunWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=7500.000000,Max=7500.000000)
		RangeAtten=0.30000
		TraceCount=8
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=9
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.35
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.Fire_SPAS',Volume=1.500000)
		Recoil=650.000000
		Chaos=0.3
		Inaccuracy=(X=190,Y=270)
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.450000
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=4000.000000,Max=6000.000000)
		RangeAtten=0.300000
		TraceCount=14
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=9
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.1
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.Fire_SPAS_Cock',Volume=1.500000)
		Inaccuracy=(X=190,Y=540)
		Recoil=900.000000
		Chaos=0.500000
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.80000
		AmmoPerFire=2
		FireAnim="FireCock"
		FireEndAnim=
		AimedFireAnim="SightFireCock"	
	FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		CrouchMultiplier=0.800000
		ViewBindFactor=0.4
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.500000
        DeclineDelay=0.750000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
	ViewBindFactor=0.15
        ADSMultiplier=0.350000
        SprintOffSet=(Pitch=-1000,Yaw=-2048)
        JumpChaos=1.000000
        ChaosDeclineTime=0.750000	
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.500000
		MagAmmo=5
		SightingTime=0.35
        InventorySize=4
		ViewOffset=(X=5.000000,Y=3.000000,Z=-6.500000)
		SightOffset=(X=-4.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}