class SkrithStaffWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE PARAMS WEAPON MODE 0 - RAPID FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaRapidPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.SkrithStaffProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=5500.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=38
		DamageRadius=96.000000
		MomentumTransfer=150.000000
		MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=Sound'BWBP_SWC_Sounds.SkrithStaff.SkrithStaff-Shot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=128.000000
		Chaos=0.25000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaRapidPrimaryFireParams
		FireInterval=0.170000
		AmmoPerFire=2
		FireEndAnim=
		AimedFireAnim="FireSight"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaRapidPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE PARAMS WEAPON MODE 1 - BOMBS
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSlowPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.SkrithStaffPower'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=11000.000000
		MaxSpeed=11000.000000
		AccelSpeed=0.000000
		Damage=80
		DamageRadius=180.000000
		MomentumTransfer=150.000000
		MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Power',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaSlowPrimaryFireParams
		FireInterval=1.000000
		AmmoPerFire=12
		FireEndAnim=
		FireAnim="FireBomb"
		AimedFireAnim="FireSight"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSlowPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=10000.000000,Max=10000.000000)
		Damage=8
		DamageType=Class'BWBP_SWC_Pro.DT_SkrithStaff'
		DamageTypeHead=Class'BWBP_SWC_Pro.DT_SkrithStaffHead'
		DamageTypeArm=Class'BWBP_SWC_Pro.DT_SkrithStaff'
		PenetrateForce=200
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SWC_Pro.SkrithStaffFlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1.000000
		Chaos=0.010000
		BotRefireRate=0.99
		WarnTargetPct=0.2
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.085000
		FireAnim=
		FireLoopAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"
		AimedFireAnim="SecFireLoopSight"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.350000
		YRandFactor=0.500000
		DeclineTime=1.500000
		DeclineDelay=0.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=256,Max=768)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.50000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		SightingTime=0.550000	 
        MagAmmo=60       
        InventorySize=12
        SightMoveSpeedFactor=0.8
		SightOffset=(X=-20.000000,Y=0.310000,Z=12.500000)
		SightPivot=(Pitch=450)
		ViewOffset=(X=9.000000,Y=4.000000,Z=-7.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaRapidPrimaryFireParams'
		FireParams(1)=FireParams'ArenaSlowPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}