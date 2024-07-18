//=============================================================================
// A42WeaponParams
//=============================================================================
class A42WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams
    	ProjectileClass=Class'BallisticProV55.A42Projectile'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
        Speed=4000.000000
        MaxSpeed=10000.000000
        AccelSpeed=60000.000000
        Damage=45.000000
        HeadMult=2.5
        LimbMult=0.75
        DamageRadius=48.000000
        MaxDamageGainFactor=0.35
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
	    MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
	    Recoil=96.000000
	    Chaos=0.130000
	    FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Fire',Volume=0.700000)
	    Inaccuracy=(X=32,Y=32)
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalProjFireParams
        FireInterval=0.155
        FireEndAnim=
		AimedFireAnim="Fire1"
        FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams'
    End Object

	//Triple Shot
    Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams_Tri
    	ProjectileClass=Class'BallisticProV55.A42ProjectileBal'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
        Speed=3000.000000
        MaxSpeed=10000.000000
        AccelSpeed=60000.000000
        Damage=30.000000
        HeadMult=2.5
        LimbMult=0.75
        DamageRadius=48.000000
        MaxDamageGainFactor=0.15
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
	    MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitterBal'
	    Recoil=280.000000
	    Chaos=0.130000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Fire',Volume=0.750000,Pitch=1.10000)
	    Inaccuracy=(X=32,Y=32)
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalProjFireParams_Tri
		TargetState="SpreadShot"
		FireInterval=0.240000
        FireEndAnim=
		AimedFireAnim="Fire1"
        FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams_Tri'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=TacticalBeamEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
    	TraceRange=(Min=8000.000000,Max=8000.000000)
        PenetrateForce=150
        Damage=65.000000
        HeadMult=2
        LimbMult=0.75
        DamageType=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeHead=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeArm=Class'BallisticProV55.DTA42SkrithBeam'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-SecFire',Volume=0.800000)
        Recoil=512.000000
	    Inaccuracy=(X=128,Y=128)
        MomentumTransfer=80000
        SplashDamage=False
        RecommendSplashDamage=False
        WarnTargetPct=0.5
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=TacticalBeamFireParams
        AmmoPerFire=7
        FireAnim="SecFire"
	    FireInterval=0.300000
        FireEffectParams(0)=InstantEffectParams'TacticalBeamEffectParams'
    End Object

    //=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=0.05000),(InVal=0.400000,OutVal=0.0800000),(InVal=0.600000,OutVal=0.0200000),(InVal=0.700000,OutVal=0.1),(InVal=1.000000,OutVal=0.000000)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.550000,OutVal=0.550000),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.0)))
		XRandFactor=0.1
		YRandFactor=0.1
		ViewBindFactor=0.5
		ClimbTime=0.03
        DeclineDelay=0.195
		DeclineTime=0.75
		CrouchMultiplier=1
        HipMultiplier=1
		MaxMoveMultiplier=1.25
    End Object

    //=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0.00
		ADSMultiplier=0.35
		AimAdjustTime=0.50
        AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
    End Object

    //=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout
		LayoutName="Standard"
		Weight=30
		//Visual
		AllowedCamos(0)=0
		//Stats
        MagAmmo=40
        InventorySize=2
		bDualBlocked=True
        SightingTime=0.20
        SightMoveSpeedFactor=0.6
        DisplaceDurationMult=0.5
		SightPivot=(Pitch=1024,Roll=-768)
		//SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalProjFireParams'
        AltFireParams(0)=FireParams'TacticalBeamFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_Tri
		//Layout core
		LayoutName="Elite"
		LayoutTags="elite"
		Weight=10
		//Visual
		AllowedCamos(0)=1
		//Stats
        MagAmmo=40
        InventorySize=2
		bDualBlocked=True
        SightingTime=0.20
        SightMoveSpeedFactor=0.6
        DisplaceDurationMult=0.5
		SightPivot=(Pitch=1024,Roll=-768)
		//SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalProjFireParams_Tri'
        AltFireParams(0)=FireParams'TacticalBeamFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Tri'
	
	//Camos =========================================
	Begin Object Class=WeaponCamo Name=A42_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=A42_Red
		Index=1
		CamoName="Red"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.A42Camos.A48Skin_SD',Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=A42_Green
		Index=2
		CamoName="Green"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.A42Camos.A512_ExpShine',Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'A42_Blue'
	Camos(1)=WeaponCamo'A42_Red'
	Camos(2)=WeaponCamo'A42_Green'
}