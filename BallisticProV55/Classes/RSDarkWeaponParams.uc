class RSDarkWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//BOLT FIRE
	Begin Object Class=ProjectileEffectParams Name=ArenaBoltPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.RSDarkProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=5000.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=70
		DamageRadius=128.000000
		MomentumTransfer=10000.000000
		MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.250000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaBoltPrimaryFireParams
		FireInterval=1.350000
		AmmoPerFire=5
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaBoltPrimaryEffectParams'
	End Object
	
	//FAST FIRE
	Begin Object Class=ProjectileEffectParams Name=ArenaFastPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.RSDarkFastProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=4000.000000
		MaxSpeed=10000.000000
		AccelSpeed=80000.000000
		Damage=40
		DamageRadius=0.000000
		MomentumTransfer=100.000000
		MuzzleFlashClass=Class'BallisticProV55.RSDarkFastMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire2',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=220.000000
		Chaos=0.090000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaFastPrimaryFireParams
		FireInterval=0.145000
		FireAnim="Fire2"
		AmmoPerFire=1
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaFastPrimaryEffectParams'
	End Object
	
	//FLAME FIRE
	Begin Object Class=ProjectileEffectParams Name=ArenaFlamePrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.RSDarkFlameProjectile'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=3000.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=6
		DamageRadius=192.000000
		MomentumTransfer=0.000000
		MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=7.000000
		Chaos=0.250000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaFlamePrimaryFireParams
		FireInterval=0.100000
		AmmoPerFire=1
		FireAnim="SecFireLoop"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaFlamePrimaryEffectParams'
	End Object
	
	//CONE FIRE 
	Begin Object Class=InstantEffectParams Name=ArenaConePrimaryEffectParams
		Damage=6
		MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=7.000000
		Chaos=0.050000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaConePrimaryFireParams
		FireInterval=0.100000
		AmmoPerFire=1
		FireAnim="SecFireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaConePrimaryEffectParams'
	End Object
	
	//BOMB FIRE
	Begin Object Class=ProjectileEffectParams Name=ArenaBombPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.RSDarkFireBomb'
		SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
		Speed=4000.000000
		MaxSpeed=4000.000000
		AccelSpeed=100000.000000
		Damage=130
		DamageRadius=256.000000
		MomentumTransfer=80000.000000
		MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-FireBall',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.150000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaBombPrimaryFireParams
		FireInterval=0.800000
		AmmoPerFire=4
		FireEndAnim=	
		FireAnim="Fire"
	FireEffectParams(0)=ProjectileEffectParams'ArenaBombPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=180.000000,Max=180.000000)
		Damage=25
		DamageType=Class'BallisticProV55.DT_RSDarkStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSDarkStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSDarkStab'
		HookStopFactor=1.000000
		HookPullForce=100.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-SawOpen',Volume=0.750000,Radius=256.000000)
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
	
	//BOLT FIRE
	Begin Object Class=RecoilParams Name=ArenaBoltRecoilParams
     	XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
     	YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=0.8
		DeclineTime=1.5
		ViewBindFactor=0.3
		DeclineDelay=0.8
	End Object
 
	//FAST FIRE
	Begin Object Class=RecoilParams Name=ArenaFastRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
	    XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.5
		ViewBindFactor=0.5
		DeclineDelay=0.25
	End Object
	
	//FLAME FIRE 
	Begin Object Class=RecoilParams Name=ArenaFlameRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
	    XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.5
		ViewBindFactor=0.5
		DeclineDelay=0.25
	End Object

	//CONE FIRE 
	Begin Object Class=RecoilParams Name=ArenaConeRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
	    XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.5
		ViewBindFactor=0.5
		DeclineDelay=0.25
	End Object
	
	//BOMB FIRE
	Begin Object Class=RecoilParams Name=ArenaBombRecoilParams
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
		SightPivot=(Pitch=1024)
		SightOffset=(X=-22.000000,Z=10.000000)
		SightingTime=0.300000
        DisplaceDurationMult=0.75
		MagAmmo=24
        InventorySize=12
		WeaponModes(0)=(ModeName="Bolt",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Flame",RecoilParamsIndex=1)
		WeaponModes(3)=(ModeName="Cone Immolation",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		WeaponModes(4)=(ModeName="Fire Bomb",ModeID="WM_FullAuto")
		RecoilParams(0)=RecoilParams'ArenaBoltRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaBoltPrimaryFireParams'
		FireParams(1)=FireParams'ArenaFastPrimaryFireParams'
		FireParams(2)=FireParams'ArenaFlamePrimaryFireParams'
		FireParams(3)=FireParams'ArenaConePrimaryFireParams'
		FireParams(4)=FireParams'ArenaBombPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}