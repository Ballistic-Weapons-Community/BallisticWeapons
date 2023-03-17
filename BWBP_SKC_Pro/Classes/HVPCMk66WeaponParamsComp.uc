class HVPCMk66WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66Projectile'
		SpawnOffset=(X=100.000000,Y=10.000000,Z=-9.000000)
		Speed=3000.000000
		MaxSpeed=3000.000000
		Damage=500
		DamageRadius=1280.000000
		MomentumTransfer=100000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.BFGFlashEmitter'
		Recoil=820.000000
		Chaos=0.600000
		WarnTargetPct=0.200000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.BFG.BFG-Fire',Volume=4.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=2.500000
		AmmoPerFire=100
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66ProjectileSmall'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=8000.000000
		MaxSpeed=8000.000000
		Damage=65
		DamageRadius=128.000000
		MomentumTransfer=12500.000000
		MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
		Recoil=100.000000
		Chaos=0.050000
		WarnTargetPct=0.200000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.BFG.BFG-SmallFire',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.110000
		AmmoPerFire=4
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		YawFactor=0.100000
		XRandFactor=0.300000
		YRandFactor=0.300000
		DeclineTime=0.750000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=192,Max=1024)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.400000
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		ViewOffset=(X=-3.000000,Y=9.500000,Z=-9.500000)
		SightPivot=(Pitch=768)
		SightOffset=(X=-18.000000,Z=23.300000)
		
		PlayerJumpFactor=1
		InventorySize=8
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=300
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}