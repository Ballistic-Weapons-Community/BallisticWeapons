class RSNovaWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//BOLT FIRE
	Begin Object Class=ProjectileEffectParams Name=ArenaBoltPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.RSNovaProjectile'
		SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
		Speed=6000.000000
		MaxSpeed=10000.000000
		AccelSpeed=100000.000000
		Damage=60
		DamageRadius=128.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.250000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaBoltPrimaryFireParams
		FireInterval=1.350000
		AmmoPerFire=3
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaBoltPrimaryEffectParams'
	End Object
	
	//FAST FIRE
	Begin Object Class=ProjectileEffectParams Name=ArenaFastPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.RSNovaFastProjectile'
		SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
		Speed=5500.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=25
		DamageRadius=48.000000
		MomentumTransfer=10000.000000
		MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=150.000000
		Chaos=0.060000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaFastPrimaryFireParams
		FireInterval=0.170000
		AmmoPerFire=1
		FireEndAnim=	
		FireAnim="Fire2"
	FireEffectParams(0)=ProjectileEffectParams'ArenaFastPrimaryEffectParams'
	End Object
	
	//LIGHTNING FIRE
	Begin Object Class=InstantEffectParams Name=ArenaLightningPrimaryEffectParams
		Damage=2
		MuzzleFlashClass=Class'BallisticProV55.RSNovaLightMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-AltFireStart',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=7.000000
		Chaos=0.250000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaLightningPrimaryFireParams
		FireInterval=0.10000
		AmmoPerFire=1
		FireAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"	
	FireEffectParams(0)=InstantEffectParams'ArenaLightningPrimaryEffectParams'
	End Object
		
	//THUNDER STRIKE FIRE
	Begin Object Class=InstantEffectParams Name=ArenaThunderPrimaryEffectParams
		Damage=125
		MuzzleFlashClass=Class'BallisticProV55.RSNovaLightMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-LightningBolt',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=0.250000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaThunderPrimaryFireParams
		FireInterval=0.750000
		AmmoPerFire=2
		FireEndAnim=	
		FireAnim="Fire"
	FireEffectParams(0)=InstantEffectParams'ArenaThunderPrimaryEffectParams'
	End Object
	
	//CHAIN LIGHTNING FIRE
	Begin Object Class=InstantEffectParams Name=ArenaChainPrimaryEffectParams
		Damage=2
		MuzzleFlashClass=Class'BallisticProV55.RSNovaLightMuzzleFlash'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=0.250000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaChainPrimaryFireParams
		FireInterval=0.10000  
		AmmoPerFire=1
		FireAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"		
	FireEffectParams(0)=InstantEffectParams'ArenaChainPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		Damage=50
		DamageType=Class'BallisticProV55.DT_RSNovaStab'
		DamageTypeHead=Class'BallisticProV55.DT_RSNovaStabHead'
		DamageTypeArm=Class'BallisticProV55.DT_RSNovaStab'
		HookStopFactor=1.700000
		HookPullForce=150.000000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.NovaStaff.Nova-Melee',Volume=0.5,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		AmmoPerFire=0
		PreFireAnim="PrepSwipe"
		FireAnim="Swipe"
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
		ViewBindFactor=0.4
		DeclineDelay=0.8
	End Object

	Begin Object Class=RecoilParams Name=ArenaFastRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.65
		DeclineDelay=0.25
	End Object
	
	Begin Object Class=RecoilParams Name=ArenaLightningRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.65
		DeclineDelay=0.25
	End Object
	
	Begin Object Class=RecoilParams Name=ArenaThunderRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.65
		DeclineDelay=0.25
	End Object
	
	Begin Object Class=RecoilParams Name=ArenaChainRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.65
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
		SightPivot=(Pitch=512)
		SightOffset=(X=-60.000000,Z=15.000000)
		SightingTime=0.300000
        DisplaceDurationMult=0.5
		MagAmmo=32
        InventorySize=12
		WeaponModes(0)=(ModeName="Slow Bolt",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Rapid Fire",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Lightning",RecoilParamsIndex=1)
		WeaponModes(3)=(ModeName="Thunder Strike",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Chain Lightning",ModeID="WM_FullAuto",bUnavailable=True)
		RecoilParams(0)=RecoilParams'ArenaBoltRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaFastRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaBoltPrimaryFireParams'
		FireParams(1)=FireParams'ArenaFastPrimaryFireParams'
		FireParams(2)=FireParams'ArenaLightningPrimaryFireParams'
		FireParams(3)=FireParams'ArenaThunderPrimaryFireParams'
		FireParams(4)=FireParams'ArenaChainPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}