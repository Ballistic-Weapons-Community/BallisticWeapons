//=============================================================================
// A42WeaponParams
//=============================================================================
class A42WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams
    	ProjectileClass=Class'BallisticProV55.A42Projectile'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
        Damage=38.000000
        Speed=3000.000000
        MaxSpeed=4500.000000
        DamageRadius=48.000000
        AccelSpeed=60000.000000
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

    Begin Object Class=FireParams Name=ArenaProjFireParams
        FireInterval=0.16
        FireEndAnim=
		AimedFireAnim="Fire"
        FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams'
    End Object

	//Spread Shot
    Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams_Tri
    	ProjectileClass=Class'BallisticProV55.A42ProjectileBal'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
        Damage=18.000000
        Speed=3000.000000
        MaxSpeed=4500.000000
        DamageRadius=48.000000
        AccelSpeed=60000.000000
        MaxDamageGainFactor=0.35
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
	    MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitterBal'
	    Recoil=280.000000
	    Chaos=0.130000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Fire',Volume=0.750000,Pitch=1.10000)
	    Inaccuracy=(X=32,Y=32)
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ArenaProjFireParams_Tri
		TargetState="SpreadShot"
		FireInterval=0.240000
        FireEndAnim=
		AimedFireAnim="Fire"
        FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams_Tri'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaBeamEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
    	TraceRange=(Min=8000.000000,Max=8000.000000)
        PenetrateForce=150
        Damage=65.000000
        DamageType=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeHead=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeArm=Class'BallisticProV55.DTA42SkrithBeam'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-SecFire',Volume=0.800000)
        Recoil=512.000000
	    Inaccuracy=(X=128,Y=128)
        MomentumTransfer=80000
        SplashDamage=False
        RecommendSplashDamage=False
        WarnTargetPct=0.500000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaBeamFireParams
        AmmoPerFire=7
        FireAnim="SecFire"
	    FireInterval=0.300000
        FireEffectParams(0)=InstantEffectParams'ArenaBeamEffectParams'
    End Object

    //=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=0.05000),(InVal=0.400000,OutVal=0.0800000),(InVal=0.600000,OutVal=0.0200000),(InVal=0.700000,OutVal=0.1),(InVal=1.000000,OutVal=0.000000)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.550000,OutVal=0.550000),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.0)))
        XRandFactor=0.100000
        YRandFactor=0.100000
		ViewBindFactor=0.5
		ClimbTime=0.03
        DeclineDelay=0.195
		DeclineTime=0.75
		CrouchMultiplier=1
        HipMultiplier=1
    End Object

    //=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=64,Max=128)
        ChaosDeclineTime=0.450000
        ADSMultiplier=2 
    End Object

    //=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout
		LayoutName="Standard"
		Weight=30
		//Visual
		AllowedCamos(0)=0
		//AllowedCamos(1)=2
		//Stats
        MagAmmo=40
        InventorySize=2
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
        DisplaceDurationMult=0.5
	    SightOffset=(X=-80.000000,Y=-6.000000,Z=18.250000)
	    SightPivot=(Pitch=1024)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaProjFireParams'
        AltFireParams(0)=FireParams'ArenaBeamFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Tri
		//Layout core
		LayoutName="Elite"
		LayoutTags="elite"
		Weight=10
		//Visual
		AllowedCamos(0)=1
		//Stats
        MagAmmo=40
        InventorySize=2
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
        DisplaceDurationMult=0.5
	    SightOffset=(X=-80.000000,Y=-6.000000,Z=18.250000)
	    SightPivot=(Pitch=1024)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaProjFireParams_Tri' //
        AltFireParams(0)=FireParams'ArenaBeamFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Tri'
	
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
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.A42Layouts.A48Skin_SD',Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=A42_Green
		Index=2
		CamoName="Green"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.A42Camos.A512_ExpShine",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'A42_Blue'
	Camos(1)=WeaponCamo'A42_Red'
	//Camos(2)=WeaponCamo'A42_Green'
}