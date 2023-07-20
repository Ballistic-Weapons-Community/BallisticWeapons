class BallisticShieldWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=140.000000,Max=140.000000)
		Damage=65
		Fatigue=0.150000
		DamageType=Class'BWBP_OP_Pro.DTBallisticShield'
		DamageTypeHead=Class'BWBP_OP_Pro.DTBallisticShield'
		DamageTypeArm=Class'BWBP_OP_Pro.DTBallisticShield'
		HookStopFactor=1.700000
		BotRefireRate=0.99
		WarnTargetPct=0.3
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=12.000000,bAtten=True)
	End Object
	
	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.750000
		AmmoPerFire=0
		FireAnim="Bash1"
		FireEffectParams(0)=MeleeEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=140.000000,Max=140.000000)
		Damage=80
		Fatigue=0.5
		DamageType=Class'BWBP_OP_Pro.DTBallisticShield'
		DamageTypeHead=Class'BWBP_OP_Pro.DTBallisticShield'
		DamageTypeArm=Class'BWBP_OP_Pro.DTBallisticShield'
		HookStopFactor=1.700000
		HookPullForce=100.000000
		BotRefireRate=0.99
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=12.000000,bAtten=True)
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.200000
		AmmoPerFire=0
		PreFireAnim="PrepSmashAlt"
		FireAnim="SmashAlt"
		FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=UniversalRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
        DeclineTime=1.500000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=UniversalAimParams
        ViewBindFactor=0.00
        SprintOffset=(Pitch=-2048,Yaw=-2048)
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
		//Layout core
		LayoutName="Riot Shield"
		Weight=30
		//Stats
        ViewOffset=(Y=75.000000,Z=-125.000000)
		PlayerSpeedFactor=0.95
        MagAmmo=1
        InventorySize=2
        DisplaceDurationMult=0
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Begin Object Class=WeaponParams Name=UniversalParams_P
		//Layout core
		LayoutName="Police Shield"
		Weight=10
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_OP_Anim.FPm_CivShield'
		//Stats
        ViewOffset=(Y=75.000000,Z=-125.000000)
		PlayerSpeedFactor=0.95
        MagAmmo=1
        InventorySize=2
        DisplaceDurationMult=0
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Begin Object Class=WeaponParams Name=UniversalParams_J
		//Layout core
		LayoutName="Junk Shield"
		Weight=10
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_OP_Anim.FPm_JunkShield'
		//Stats
        ViewOffset=(Y=75.000000,Z=-125.000000)
		PlayerSpeedFactor=0.95
        MagAmmo=1
        InventorySize=2
        DisplaceDurationMult=0
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
    Layouts(1)=WeaponParams'UniversalParams_P'
    Layouts(2)=WeaponParams'UniversalParams_J'
}