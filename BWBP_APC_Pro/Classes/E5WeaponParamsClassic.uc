class E5WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{   
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	//Series
    Begin Object Class=ProjectileEffectParams Name=ClassicSeriesEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_Std'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=4500.000000
        MaxSpeed=12000.000000
        AccelSpeed=60000.000000
        Damage=30.000000
        DamageRadius=64.000000
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.MVPR.MVPR-FireAlt',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.06
        Recoil=96
        WarnTargetPct=0.1
        BotRefireRate=0.99	
    End Object

    Begin Object Class=FireParams Name=ClassicSeriesFireParams
        FireInterval=0.10000
		BurstFireRateFactor=1.00
		AmmoPerFire=1
        FireAnim="Fire"
		AimedFireAnim="SightFire"
        FireEndAnim=
        FireEffectParams(0)=ProjectileEffectParams'ClassicSeriesEffectParams'
    End Object
	
	//Shotgun
    Begin Object Class=ProjectileEffectParams Name=ClassicMultiEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_SG'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=4500.000000
        MaxSpeed=4500.000000
        AccelSpeed=60000.000000
        Damage=20.000000
        DamageRadius=24.000000
        MaxDamageGainFactor=0.00
        DamageGainEndTime=0.0
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.MVPR.MVPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.5
        Recoil=768
        WarnTargetPct=0.2
        BotRefireRate=0.99	
    End Object

    Begin Object Class=FireParams Name=ClassicMultiFireParams
        AmmoPerFire=3
        TargetState="Shotgun"
        FireAnim="Fire"
		AimedFireAnim="SightFire"
        FireEndAnim=
        FireInterval=0.50000
        FireEffectParams(0)=ProjectileEffectParams'ClassicMultiEffectParams'
    End Object
	
	//Sniper
    Begin Object Class=ProjectileEffectParams Name=ClassicSniperEffectParams
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

    Begin Object Class=FireParams Name=ClassicSniperFireParams
        AmmoPerFire=20
        FireAnim="Fire"
        FireEndAnim=
		AimedFireAnim="SightFire"
        FireInterval=0.650000
        FireEffectParams(0)=ProjectileEffectParams'ClassicSniperEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ClassicLaserEffectParams
        TraceRange=(Min=10000.000000,Max=10000.000000)
        WaterTraceRange=5000
        Damage=11.000000
        HeadMult=1.5f
        LimbMult=0.5f
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

    Begin Object Class=FireParams Name=ClassicLaserFireParams
        FireAnim=
        FireLoopAnim="'"
        FireEndAnim=
        FireInterval=0.085000
        FireEffectParams(0)=InstantEffectParams'ClassicLaserEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.000000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.300000),(InVal=0.700000,OutVal=0.500000),(InVal=1.000000,OutVal=0.800000)))
		PitchFactor=0.200000
		YawFactor=0.200000
		XRandFactor=0.800000
		YRandFactor=0.800000
		MaxRecoil=1024.000000
		DeclineTime=0.500000
		DeclineDelay=0.0500000
		ViewBindFactor=0.150000
		ADSViewBindFactor=0.150000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.0500000
		SprintChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=1.150000
		ChaosSpeedThreshold=575.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Military Issue"
	    Weight=30
		
		SightingTime=0.30000	 
        MagAmmo=45        
        InventorySize=3
        SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=256)
		SightOffset=(X=-15.000000,Y=-0.850000,Z=10.850000)
		ViewOffset=(X=4.000000,Y=6.000000,Z=-8.500000)
		WeaponModes(0)=(ModeName="Series Pulse",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(1)=(ModeName="Multi Pulse",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Sniper Pulse",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicSeriesFireParams'
        FireParams(1)=FireParams'ClassicMultiFireParams'
        FireParams(2)=FireParams'ClassicSniperFireParams'
        AltFireParams(0)=FireParams'ClassicLaserFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ClassicParams-BY
		LayoutName="Spec Ops Issue"
	    Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_BYWeapon_Shine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_BYWeapon2_Shine",Index=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_BYPadding_Shine",Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5)
		
		SightingTime=0.30000	 
        MagAmmo=45        
        InventorySize=12
        SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=256)
		SightOffset=(X=-15.000000,Y=-0.850000,Z=10.850000)
		ViewOffset=(X=4.000000,Y=6.000000,Z=-8.500000)
		WeaponModes(0)=(ModeName="Series Pulse",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(1)=(ModeName="Multi Pulse",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Sniper Pulse",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicSeriesFireParams'
        FireParams(1)=FireParams'ClassicMultiFireParams'
        FireParams(2)=FireParams'ClassicSniperFireParams'
        AltFireParams(0)=FireParams'ClassicLaserFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-RS
		LayoutName="Neglected Issue"
	    Weight=25
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_RSWeapon_Shine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_RSWeapon2_Shine",Index=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_RSPadding_Shine",Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5)
		
		SightingTime=0.30000	 
        MagAmmo=45        
        InventorySize=12
        SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=256)
		SightOffset=(X=-15.000000,Y=-0.850000,Z=10.850000)
		ViewOffset=(X=4.000000,Y=6.000000,Z=-8.500000)
		WeaponModes(0)=(ModeName="Series Pulse",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(1)=(ModeName="Multi Pulse",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Sniper Pulse",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicSeriesFireParams'
        FireParams(1)=FireParams'ClassicMultiFireParams'
        FireParams(2)=FireParams'ClassicSniperFireParams'
        AltFireParams(0)=FireParams'ClassicLaserFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-UTC
		LayoutName="Police Issue"
	    Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.E5UTC-Main-Shine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.E5UTC-Main2-Shine",Index=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.E5UTC-Padding-Shine",Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5)
		
		SightingTime=0.30000	 
        MagAmmo=45        
        InventorySize=12
        SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=256)
		SightOffset=(X=-15.000000,Y=-0.850000,Z=10.850000)
		ViewOffset=(X=4.000000,Y=6.000000,Z=-8.500000)
		WeaponModes(0)=(ModeName="Series Pulse",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(1)=(ModeName="Multi Pulse",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Sniper Pulse",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicSeriesFireParams'
        FireParams(1)=FireParams'ClassicMultiFireParams'
        FireParams(2)=FireParams'ClassicSniperFireParams'
        AltFireParams(0)=FireParams'ClassicLaserFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-AU
		LayoutName="Warlord Issue"
	    Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_AUWeapon_Shine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_AUWeapon2_Shine",Index=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_CC_Tex.MVPR.Shader',Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.MVPRCamos.MVPR_AUPadding_Shine",Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny',Index=5)
		
		SightingTime=0.30000	 
        MagAmmo=45        
        InventorySize=12
        SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=256)
		SightOffset=(X=-15.000000,Y=-0.850000,Z=10.850000)
		ViewOffset=(X=4.000000,Y=6.000000,Z=-8.500000)
		WeaponModes(0)=(ModeName="Series Pulse",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(1)=(ModeName="Multi Pulse",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Sniper Pulse",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicSeriesFireParams'
        FireParams(1)=FireParams'ClassicMultiFireParams'
        FireParams(2)=FireParams'ClassicSniperFireParams'
        AltFireParams(0)=FireParams'ClassicLaserFireParams'
    End Object
    
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-BY'
	Layouts(2)=WeaponParams'ClassicParams-RS'
	Layouts(3)=WeaponParams'ClassicParams-UTC'
	Layouts(4)=WeaponParams'ClassicParams-AU'
}