class RSDarkWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.RSDarkProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=5000.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=70.0
		DamageRadius=128.000000
		MomentumTransfer=10000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=1.350000
		AmmoPerFire=5
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=200.000000,Max=200.000000)
		WaterTraceRange=5000.0
		Damage=25.0
		DamageType=Class'BallisticProV55.DT_RSDarkStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSDarkStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSDarkStab'
		ChargeDamageBonusFactor=1
		HookStopFactor=1.000000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-SawOpen',Volume=0.750000,Radius=32.000000)
		Recoil=0.0
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.100000
		PreFireAnim=
		FireAnim="SawStart"
		FireEndAnim="SawEnd"
		FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ArenaBoltRecoilParams
     	XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
     	YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=0.8
		DeclineTime=1.5
		ViewBindFactor=0.3
		DeclineDelay=0.8
	End Object
 
	Begin Object Class=RecoilParams Name=ArenaFastRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
	    XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.5
		ViewBindFactor=0.5
		DeclineDelay=0.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.100000
		SightingTime=0.300000
        DisplaceDurationMult=0.75
		MagAmmo=24
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaBoltRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaFastRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		//FireParams(0)=FireParams'ArenaPrimaryFireParams'
		//AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}