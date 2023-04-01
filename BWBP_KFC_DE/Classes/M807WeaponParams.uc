class M807WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams
    	MuzzleFlashClass=Class'BallisticDE.A73FlashEmitter'
    	SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=5500.000000
        AccelSpeed=100000.000000
        MaxSpeed=14000.000000
     Damage=1500.000000
     DamageRadius=15500.000000
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=130.000000
	    Chaos=0.020000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BWBP_KFC_DE.NukeRocketONS'
        WarnTargetPct=0.200000
        BotRefireRate=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaProjFireParams
	    FireEndAnim=
        AimedFireAnim="SightFire"
	    FireInterval=1.125000
		AmmoPerFire=7
        FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.5
		DeclineDelay=0.37000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.320000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightOffset=(X=-5.000000,Y=-1.315,Z=12.600000)
		SightPivot=(Pitch=-110,Roll=-675)              //Aligned
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=3500)
		WristAdjust=(Yaw=-3500,Pitch=-000)
		ViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
		DisplaceDurationMult=0.5
		PlayerSpeedFactor=1.05
		SightingTime=0.20000
		MagAmmo=7
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaProjFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}