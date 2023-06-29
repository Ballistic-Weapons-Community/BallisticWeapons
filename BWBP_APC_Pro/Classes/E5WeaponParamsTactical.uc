class E5WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{   
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=TacticalSeriesEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_Std'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=5500.000000
        MaxSpeed=14000.000000
        AccelSpeed=100000.000000
        Damage=42.000000
        HeadMult=2.5
        LimbMult=0.75
        DamageRadius=16.000000
        MaxDamageGainFactor=0.6
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.MVPR.MVPR-FireAlt',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.06
        Recoil=140
        WarnTargetPct=0.1
        BotRefireRate=0.99	
    End Object

    Begin Object Class=ProjectileEffectParams Name=TacticalMultiEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_SG'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=5500.000000
        MaxSpeed=5500.000000
        AccelSpeed=60000.000000
        Damage=42.000000
        DamageRadius=64.000000
        MaxDamageGainFactor=0.25
        DamageGainEndTime=0.3
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.MVPR.MVPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.5
        Recoil=768
        WarnTargetPct=0.2
        BotRefireRate=0.99	
    End Object

    Begin Object Class=ProjectileEffectParams Name=TacticalSniperEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_Snpr'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=5500.000000
        MaxSpeed=50000.000000
        AccelSpeed=100000.000000
        Damage=50.000000
        DamageRadius=64.000000
        FlashScaleFactor=0.750000
        Chaos=0.350000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Recoil=768.000000
        WarnTargetPct=0.1
        BotRefireRate=0.99	
    End Object

    Begin Object Class=FireParams Name=TacticalSeriesFireParams
        FireInterval=0.20000
		BurstFireRateFactor=0.55
		AmmoPerFire=2
        FireAnim="Fire"
		AimedFireAnim="SightFire"
        FireEndAnim=
        FireEffectParams(0)=ProjectileEffectParams'TacticalSeriesEffectParams'
    End Object

    Begin Object Class=FireParams Name=TacticalMultiFireParams
        AmmoPerFire=4
        TargetState="Shotgun"
        FireAnim="Fire"
		AimedFireAnim="SightFire"
        FireEndAnim=
        FireInterval=0.50000
        FireEffectParams(0)=ProjectileEffectParams'TacticalMultiEffectParams'
    End Object

    Begin Object Class=FireParams Name=TacticalSniperFireParams
        AmmoPerFire=20
        FireAnim="Fire"
        FireEndAnim=
		AimedFireAnim="SightFire"
        FireInterval=0.650000
        FireEffectParams(0)=ProjectileEffectParams'TacticalSniperEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=TacticalLaserEffectParams
        TraceRange=(Min=10000.000000,Max=10000.000000)
        WaterTraceRange=5000
        Damage=14.000000
        HeadMult=2.5
        LimbMult=0.75
        DamageType=Class'BWBP_APC_Pro.DTE5Laser'
        DamageTypeHead=Class'BWBP_APC_Pro.DTE5LaserHead'
        DamageTypeArm=Class'BWBP_APC_Pro.DTE5Laser'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        FlashScaleFactor=0.750000
        Chaos=0.000000
	    Recoil=0
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=TacticalLaserFireParams
        FireAnim=
        FireLoopAnim="'"
        FireEndAnim=
        FireInterval=0.085000
        FireEffectParams(0)=InstantEffectParams'TacticalLaserEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.040000),(InVal=0.200000,OutVal=0.12000),(InVal=0.350000,OutVal=0.170000),(InVal=0.600000,OutVal=0.220000),(InVal=0.800000,OutVal=0.320000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.380000),(InVal=0.600000,OutVal=0.750000),(InVal=0.700000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		ClimbTime=0.04
		DeclineTime=0.500000
		DeclineDelay=0.240000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=1
		AimSpread=(Min=256,Max=1024)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.250000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
	    SightingTime=0.30000	 
        MagAmmo=60        
        InventorySize=4
        SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=256)
		SightOffset=(X=2.000000,Y=-0.850000,Z=10.850000)
		ViewOffset=(X=5.000000,Y=4.000000,Z=-10.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalSeriesFireParams'
        FireParams(1)=FireParams'TacticalMultiFireParams'
        FireParams(2)=FireParams'TacticalSniperFireParams'
        AltFireParams(0)=FireParams'TacticalLaserFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=E5_Gray
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=E5_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_BYWeapon_Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_BYWeapon2_Shine",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_BYPadding_Shine",Index=4,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5,AIndex=-1,PIndex=-1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=E5_SpecOps
		Index=2
		CamoName="Spec Ops"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.E5Camos.E5-MainBlack",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.E5Camos.E5-MiscBlack",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_BYPadding_Shine",Index=4,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=E5_Rust
		Index=3
		CamoName="Rust"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_RSWeapon_Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_RSWeapon2_Shine",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_RSPadding_Shine",Index=4,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=E5_UTC
		Index=4
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.E5Camos.E5UTC-Main-Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.E5Camos.E5UTC-Main2-Shine",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.E5Camos.E5UTC-Padding-Shine",Index=4,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5,AIndex=-1,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=E5_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_AUWeapon_Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_AUWeapon2_Shine",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_AUPadding_Shine",Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5,AIndex=-1,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'E5_Gray'
	Camos(1)=WeaponCamo'E5_Black'
	Camos(2)=WeaponCamo'E5_SpecOps'
	Camos(3)=WeaponCamo'E5_Rust'
	Camos(4)=WeaponCamo'E5_UTC'
	Camos(5)=WeaponCamo'E5_Gold'
}