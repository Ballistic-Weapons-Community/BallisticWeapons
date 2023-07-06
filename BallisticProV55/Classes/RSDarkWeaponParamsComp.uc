class RSDarkWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ArenaBoltEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=5500
        AccelSpeed=100000
        MaxSpeed=14000
        Damage=90
		DamageRadius=128
		MomentumTransfer=10000
    	Recoil=512.000000
	    Chaos=0.250000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ArenaBoltFireParams
		AmmoPerFire=5
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=1.350000
        FireEffectParams(0)=ProjectileEffectParams'ArenaBoltEffectParams'
    End Object	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaFastEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=5500
        AccelSpeed=100000
        MaxSpeed=14000
        Damage=50
		DamageRadius=0
		MomentumTransfer=100
    	Recoil=96.000000
	    Chaos=0.090000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire2',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFastProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ArenaFastFireParams
		AmmoPerFire=1
		FireAnim="Fire2"
	    FireEndAnim=
        AimedFireAnim=
	    FireInterval=0.145000
        FireEffectParams(0)=ProjectileEffectParams'ArenaFastEffectParams'
    End Object	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaFlameEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=3000.000000
        AccelSpeed=0.000000
        MaxSpeed=3000.000000
        Damage=15.000000
		DamageRadius=192.000000
		MomentumTransfer=0.000000
    	Recoil=7.000000
	    Chaos=0.060000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFlameProjectile'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ArenaFlameFireParams
		TargetState="DarkFlamer"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
	    FireEndAnim="SecFireEnd"
        AimedFireAnim=
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'ArenaFlameEffectParams'
    End Object  

	Begin Object Class=ProjectileEffectParams Name=ArenaConeEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkFastMuzzleFlash'
		SpawnOffset=(X=0,Y=0,Z=0)
        Speed=
        AccelSpeed=
        MaxSpeed=
        Damage=60.000000
		DamageRadius=
		MomentumTransfer=
		MaxDamageGainFactor=
		DamageGainStartTime=
		DamageGainEndTime=
    	Recoil=7.000000
	    Chaos=0.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ArenaConeFireParams
		TargetState="Immolate"
		AmmoPerFire=1
		FireLoopAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'ArenaConeEffectParams'
    End Object     

	Begin Object Class=ProjectileEffectParams Name=ArenaBombEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.RSDarkFastMuzzleFlash'
    	SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
        Speed=4000.000000
        AccelSpeed=0.000000
        MaxSpeed=4000.000000
        Damage=100.000000
		DamageRadius=768.000000
		MomentumTransfer=80000.000000
    	Recoil=1024.000000
	    Chaos=0.150000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-FireBall',Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.RSDarkFireBomb'
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=ArenaBombFireParams
		TargetState="Fireball"
		AmmoPerFire=4
		FireAnim="Fire"
        AimedFireAnim=
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'ArenaBombEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=180.000000,Max=180.000000)
		WaterTraceRange=5000.0
		Damage=25.0
        HeadMult=1.0f
        LimbMult=1.0
		DamageType=Class'BallisticProV55.DT_RSDarkStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSDarkStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSDarkStab'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.000000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-SawOpen',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=0.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.100000
		AmmoPerFire=1
		FireAnim="SawStart"
		FireEndAnim="SawEnd"
		FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaBoltRecoilParams
     	XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.0)))
     	YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=0.8
		ClimbTime=0.06
		DeclineDelay=0.8
		DeclineTime=0.75
		CrouchMultiplier=1
		ViewBindFactor=0.3
		HipMultiplier=1.5
	End Object
 
	Begin Object Class=RecoilParams Name=ArenaFastRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
	    XRandFactor=0.05
		YRandFactor=0.05
		ClimbTime=0.04
		DeclineDelay=0.25
		DeclineTime=0.75
		CrouchMultiplier=1
		ViewBindFactor=0.5
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=64,Max=384)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.250000
		SightingTime=0.300000
        DisplaceDurationMult=0.75
		SightMoveSpeedFactor=0.8
		MagAmmo=24
        InventorySize=5
		WeaponModes(0)=(ModeName="Bolt",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Flame",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		WeaponModes(3)=(ModeName="Cone Immolation",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		WeaponModes(4)=(ModeName="Fire Bomb",ModeID="WM_FullAuto")
		RecoilParams(0)=RecoilParams'ArenaBoltRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaFastRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaBoltFireParams'
		FireParams(1)=FireParams'ArenaFastFireParams'
		FireParams(2)=FireParams'ArenaFlameFireParams'
		FireParams(3)=FireParams'ArenaConeFireParams'
		FireParams(4)=FireParams'ArenaBombFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=DS_Crimson
		Index=0
		CamoName="Crimson"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=DS_Corrupt
		Index=1
		CamoName="Corrupt"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.DSCamos.DS_Weapon_S2",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=DS_BloodRed
		Index=2
		CamoName="Archdemon"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.DSCamos.DS_Weapon_S1",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'DS_Crimson'
	Camos(1)=WeaponCamo'DS_Corrupt'
	Camos(2)=WeaponCamo'DS_BloodRed'
}