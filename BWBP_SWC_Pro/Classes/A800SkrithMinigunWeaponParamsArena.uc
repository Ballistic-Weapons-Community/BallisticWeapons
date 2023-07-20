class A800SkrithMinigunWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A73NewProjectile'
		SpawnOffset=(X=1.000000,Y=5.000000,Z=-5.000000)
		Speed=5500.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=30
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=100.000000
		Chaos=0.100000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.075000
		FireLoopAnim="FireLoop"
		FireEndAnim="FireEnd"
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A800StickyBombProjectile'
		SpawnOffset=(X=400.000000,Y=7.000000,Z=-9.000000)
		Speed=1000.000000
		MaxSpeed=2000.000000
		AccelSpeed=8000.000000
		Damage=75
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SWC_Sounds.A800.A800-AltFire2',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=650.000000
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.850000
		AmmoPerFire=15
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.700000
		DeclineDelay=0.40000
		MaxRecoil=10000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.2
		ADSMultiplier=1
		SprintOffset=(Pitch=-5000,Yaw=-2000)
		AimSpread=(Min=128,Max=768)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.780000
		PlayerJumpFactor=0.750000
		SightingTime=0.600000
        MagAmmo=90
        InventorySize=7
        SightMoveSpeedFactor=0.75
		ZoomType=ZT_Logarithmic
		SightOffset=(X=-15.000000,Y=-25.000000,Z=6.500000)
		SightPivot=(Roll=-1900)
		ViewOffset=(X=30.000000,Y=20.000000,Z=-16.000000)
		ViewPivot=(Roll=-256)
		ReloadAnimRate=1.300000
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}