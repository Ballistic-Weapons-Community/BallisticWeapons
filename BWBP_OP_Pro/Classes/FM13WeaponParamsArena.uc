class FM13WeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
		RangeAtten=0.15000
		TraceCount=10
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		HeadMult=2.0f
        LimbMult=0.75f
		DamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FM13ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		MuzzleFlashClass=Class'BWBP_OP_Pro.FM13FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=768.000000
		Chaos=0.30000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=200,Y=200)
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.85
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=0.9	
		TargetState="FireFromImpact"
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
			ProjectileClass=Class'BWBP_OP_Pro.FM13Grenade'
			Speed=3500.000000
			Damage=30
			DamageRadius=64.000000
			FlashScaleFactor=2.000000
			Recoil=1280.000000
			Chaos=0.500000
			BotRefireRate=0.3
			WarnTargetPct=0.75
			FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
		End Object

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=0.750000
			FireEndAnim=
			AimedFireAnim="SightFire"
			FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
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

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.5
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimSpread=(Min=16,Max=128)
        ChaosSpeedThreshold=550.000000
		ChaosDeclineTime=0.750000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		ViewOffset=(X=-9.000000,Y=5.000000,Z=-25.000000)
		SightOffset=(X=10.000000,Y=-0.100000,Z=27.000000)
		SightPivot=(Pitch=128)
		MagAmmo=6
        SightingTime=0.350000
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}