class SK410WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=2048.000000,Max=2048.000000)
        DecayRange=(Min=750,Max=2250)
        RangeAtten=0.350000
        TraceCount=7
        TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunHE'
        ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
        Damage=9
        DamageType=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_SK410ShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
        FlashScaleFactor=0.500000
        Recoil=378.000000
        Chaos=0.400000
        BotRefireRate=0.900000
        WarnTargetPct=0.500000
		Inaccuracy=(X=256,Y=256)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.300000)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.225000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireAnimRate=1.750000	
        FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.SK410HEProjectile'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        Speed=8000.000000
        MaxSpeed=15000.000000
        AccelSpeed=3000.000000
        Damage=50
        DamageRadius=256.000000
		PushbackForce=180.000000
        MomentumTransfer=100000.000000
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
        FlashScaleFactor=0.500000
        Recoil=650.000000
        Chaos=0.450000
        BotRefireRate=0.6
        WarnTargetPct=0.4	
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-FireFRAG',Volume=1.300000)
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.650000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireAnimRate=1.250000	
        FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.65
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=0.120000),(InVal=0.600000,OutVal=0.15000),(InVal=0.750000,OutVal=0.250000),(InVal=1.000000,OutVal=0.32)))
        YCurve=(Points=(,(InVal=0.500000,OutVal=0.400000),(InVal=1.000000,OutVal=1.000000)))
        YRandFactor=0.05
        XRandFactor=0.05
        DeclineTime=0.500000
        DeclineDelay=0.450000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        SprintOffset=(Pitch=-1000,Yaw=-2048)
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.250000
    	ReloadAnimRate=1.250000
		SightPivot=(Pitch=150)
		SightOffset=(X=20.000000,Y=-10.000000,Z=22.500000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=1
		SightingTime=0.250000
		DisplaceDurationMult=0.75
		MagAmmo=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}