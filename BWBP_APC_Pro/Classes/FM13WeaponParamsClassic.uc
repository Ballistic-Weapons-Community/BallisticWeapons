class FM13WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2072.000000,Max=2072.000000)
		RangeAtten=0.150000
		TraceCount=7
		TracerClass=Class'BWBP_APC_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=Class'BWBP_APC_Pro.DTFM13Shotgun'
		DamageTypeHead=Class'BWBP_APC_Pro.DTFM13ShotgunHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTFM13Shotgun'
		MuzzleFlashClass=Class'BWBP_APC_Pro.FM13FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.FM13.FM13-Fire',Volume=1.300000)
		Recoil=1024.000000
		Chaos=1.000000
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=900,Y=900)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.750000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.000000	
		TargetState="FireFromFireControl"
	FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object	
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.FM13Grenade'
		Speed=3500.000000
		Damage=30
		DamageRadius=64.000000
		FlashScaleFactor=2.000000
		Recoil=1280.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		FireSound=(Sound=Sound'BWBP_CC_Sounds.FM13.FM13-Fire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.750000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.2
		XRandFactor=0.200000
		YRandFactor=0.500000
		MaxRecoil=4096
		DeclineTime=1.400000
		DeclineDelay=0.4
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		ADSMultiplier=0.5
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimSpread=(Min=16,Max=1760)
        ChaosSpeedThreshold=550.000000
		ChaosDeclineTime=0.750000
		ViewBindFactor=0.25
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		ViewOffset=(X=6.000000,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=27.000000)
		SightPivot=(Pitch=128)
		bNeedCock=True
		MagAmmo=6
        SightingTime=0.350000
        InventorySize=6
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Pitbull
		Weight=30
		LayoutMesh=SkeletalMesh'BWBP_CC_Anim.FPm_Pitbull'
		ViewOffset=(X=6.000000,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=29.000000)
		SightPivot=(Pitch=128)
		bNeedCock=True
		MagAmmo=6
        SightingTime=0.350000
        InventorySize=6
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Pitbull'

}