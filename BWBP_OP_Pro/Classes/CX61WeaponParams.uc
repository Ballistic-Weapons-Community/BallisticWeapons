class CX61WeaponParams extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object

	//recoil aim default
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.2,OutVal=-0.03),(InVal=0.4,OutVal=0.11),(InVal=0.5,OutVal=0.13),(InVal=0.6,OutVal=0.15),(InVal=0.8,OutVal=0.16),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.190000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.620000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		DeclineDelay=0.135000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=768)
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=15000.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.300000
		DisplaceDurationMult=1
		MagAmmo=32
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireHealParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}