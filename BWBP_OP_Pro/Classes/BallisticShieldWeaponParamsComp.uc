class BallisticShieldWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
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
	
	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.750000
		AmmoPerFire=0
		FireAnim="Bash1"
		FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=140.000000,Max=140.000000)
		Damage=80
		Fatigue=0.500000
		DamageType=Class'BWBP_OP_Pro.DTBallisticShield'
		DamageTypeHead=Class'BWBP_OP_Pro.DTBallisticShield'
		DamageTypeArm=Class'BWBP_OP_Pro.DTBallisticShield'
		HookStopFactor=1.700000
		HookPullForce=100.000000
		BotRefireRate=0.99
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=12.000000,bAtten=True)
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.200000
		AmmoPerFire=0
		PreFireAnim="PrepSmashAlt"
		FireAnim="SmashAlt"
		FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
        DeclineTime=1.500000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        ViewBindFactor=0.00
        SprintOffset=(Pitch=-2048,Yaw=-2048)
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Riot Shield"
		Weight=30
		//Stats
		PlayerSpeedFactor=0.95
        MagAmmo=1
        InventorySize=2
        DisplaceDurationMult=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    
	Begin Object Class=WeaponParams Name=ArenaParams-Civ
		//Layout core
		LayoutName="Police Shield"
		Weight=10
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_OP_Anim.CivShield_FPm'
		//Stats
		PlayerSpeedFactor=0.95
        MagAmmo=1
        InventorySize=2
        DisplaceDurationMult=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams-Junk
		//Layout core
		LayoutName="Junk Shield"
		Weight=10
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_OP_Anim.JunkShield_FPm'
		//Stats
		PlayerSpeedFactor=0.95
        MagAmmo=1
        InventorySize=2
        DisplaceDurationMult=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams-Civ'
	Layouts(2)=WeaponParams'ArenaParams-Junk'
}