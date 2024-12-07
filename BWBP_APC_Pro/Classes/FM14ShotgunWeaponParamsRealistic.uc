class FM14ShotgunWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
		Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
			TraceRange=(Min=3072.000000,Max=3072.000000)
			RangeAtten=0.15000
			TraceCount=1
			TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
			ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
			Damage=80
			DamageType=Class'BWBP_APC_Pro.DTFM14Shotgun'
			DamageTypeHead=Class'BWBP_APC_Pro.DTFM14ShotgunHead'
			DamageTypeArm=Class'BWBP_APC_Pro.DTFM14Shotgun'
			MuzzleFlashClass=Class'BWBP_APC_Pro.FM14FlashEmitter'
			FlashScaleFactor=1.000000
			Recoil=768.000000
			Chaos=0.30000
			BotRefireRate=0.7
			WarnTargetPct=0.5	
			SpreadMode=FSM_Rectangle
			Inaccuracy=(X=200,Y=200)
			FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
		End Object

		Begin Object Class=FireParams Name=RealisticPrimaryFireParams
			FireInterval=0.85
			FireAnim="FireCombined"
			FireEndAnim=
			AimedFireAnim="FireCombinedSight"
			FireAnimRate=0.9	
			FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.FM14FlakGrenade'
		Speed=3500.000000
		Damage=15
		DamageRadius=256.000000
		FlashScaleFactor=2.000000
		Recoil=1280.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.750000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.500000
		DeclineDelay=0.75
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		ADSMultiplier=0.5
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimSpread=(Min=16,Max=128)
        ChaosSpeedThreshold=550.000000
		ChaosDeclineTime=0.750000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		ReloadAnimRate=1.100000
		ViewOffset=(X=6,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=29.000000)
		SightPivot=(Pitch=0)
		MagAmmo=6
        SightingTime=0.350000
        InventorySize=6
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}