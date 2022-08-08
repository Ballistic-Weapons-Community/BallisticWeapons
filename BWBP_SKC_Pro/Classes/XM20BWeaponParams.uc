class XM20BWeaponParams extends BallisticWeaponParams;

defaultproperties
{ 
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.150000,OutVal=0.020000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.11),(InVal=0.400000,OutVal=0.130000),(InVal=0.600000,OutVal=0.20000),(InVal=0.800000,OutVal=0.25000),(InVal=1.000000,OutVal=0.30000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.500000,OutVal=0.600000),(InVal=0.600000,OutVal=0.670000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.8
		DeclineDelay=0.2
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=192)
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.5
		ChaosDeclineDelay=0.3
		ChaosSpeedThreshold=2500
	End Object
	
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=5000.000000,Max=7500.000000)
		Damage=16
		DamageType=Class'BWBP_SKC_Pro.DT_XM20B_Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20B_Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20B_Body'
		PenetrateForce=600
		bPenetrate=False
		MuzzleFlashClass=Class'BWBP_SKC_Pro.XM20BFlashEmitter'
		FlashScaleFactor=0.300000
		Recoil=96.000000
		BotRefireRate=0.90
		WarnTargetPct=0.10000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.135000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
		Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
			Damage=16
			 HeadMult=1.5f
			 LimbMult=0.5f
			 Chaos=0
			 Recoil=32
			FlashScaleFactor=0.100000
		End Object
		
		Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParamsOvercharge
			Damage=15
			 HeadMult=1.5f
			 LimbMult=0.5f
			 Chaos=0
			 Recoil=32
			FlashScaleFactor=0.200000
		End Object
		
		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=0.070000
			PreFireAnim="LoopStart"
			FireLoopAnim="LoopFire"
			FireEndAnim="LoopEnd"	
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
		End Object
		
		Begin Object Class=FireParams Name=ArenaSecondaryFireParamsOvercharge
			FireInterval=0.045000
			PreFireAnim="LoopOpenStart"
			FireLoopAnim="LoopOpenFire"
			FireEndAnim="LoopOpenEnd"
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParamsOvercharge'
		End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams
		SightPivot=(Pitch=600)
		SightOffset=(X=-10.000000,Y=11.7500000,Z=22.500000)
		ViewOffset=(X=6.000000,Y=1.000000,Z=-15.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.40000
		DisplaceDurationMult=1
		MagAmmo=50
        ZoomType=ZT_Smooth
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(2)=FireParams'ArenaSecondaryFireParamsOvercharge'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}