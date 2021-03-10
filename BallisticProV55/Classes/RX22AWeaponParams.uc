class RX22AWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=1800.000000,Max=1800.000000)
		Damage=14
		PenetrateForce=50
		Chaos=0.050000
		BotRefireRate=0.99
		WarnTargetPct=0.4
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.090000
		FireAnim="FireLoop"
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		Recoil=32.000000
		WarnTargetPct=0.500000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.100000
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.600000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		DeclineTime=1.000000
    End Object
	 
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-500,Yaw=-1024)
		AimSpread=(Min=0,Max=32)
		ChaosSpeedThreshold=900.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.900000
		MagAmmo=75
        InventorySize=24
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}