class FLASHWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=4500.000000
		Damage=80
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=1024.000000
		BotRefireRate=0.700000
		WarnTargetPct=1
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Flash.M202-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=4500.000000
		Damage=80
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=1024.000000
		BotRefireRate=0.300000
		WarnTargetPct=1	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Flash.M202-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=3.500000
		FireAnim="Fireall"
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
	 	DeclineTime=0.750000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=512,Max=2048)
		ADSMultiplier=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.750000
		ChaosSpeedThreshold=1200.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
        DisplaceDurationMult=1.25
		InventorySize=35
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000		
		MagAmmo=4
        ZoomType=ZT_Fixed
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}