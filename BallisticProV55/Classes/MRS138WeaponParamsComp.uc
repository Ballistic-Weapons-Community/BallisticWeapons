class MRS138WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=2048.000000,Max=2048.000000)
        DecayRange=(Min=500,Max=2000)
		RangeAtten=0.200000
		TraceCount=8
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=13
		DamageType=Class'BallisticProV55.DTMRS138Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		Recoil=512.000000
		Chaos=0.400000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		Inaccuracy=(X=256,Y=256)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.550000
		FireAnim="FireCombined"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRS138TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=12800.000000
		MaxSpeed=12800.000000
		Damage=5
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="TazerStart"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=(,(InVal=0.3,OutVal=0.2),(InVal=0.55,OutVal=0.1),(InVal=0.8,OutVal=0.25),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.2,OutVal=0.2),(InVal=0.4,OutVal=0.45),(InVal=0.75,OutVal=0.7),(InVal=1.000000,OutVal=1)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineDelay=0.650000
		DeclineTime=0.5
		HipMultiplier=1
    End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.5
		ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
		AimSpread=(Min=0,Max=0)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.500000
		CockAnimRate=1.200000
		SightOffset=(X=15,Z=21.500000)
		SightPivot=(Pitch=256)
		ViewOffset=(Y=10.000000,Z=-14.000000)
		SightingTime=0.3
		MagAmmo=6
        InventorySize=6
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}