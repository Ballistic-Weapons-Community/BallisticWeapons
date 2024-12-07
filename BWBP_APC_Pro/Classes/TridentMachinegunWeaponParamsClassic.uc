class TridentMachinegunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		RangeAtten=0.35
		Damage=20
		HeadMult=1.5f
		LimbMult=0.8f
		//DamageType=Class'BallisticProV55.DTM353MG'
		//DamageTypeHead=Class'BallisticProV55.DTM353MGHead'
		//DamageTypeArm=Class'BallisticProV55.DTM353MG'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=96.000000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_APC_Sounds.CruMG.MG-Fire',Volume=1.400000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.08000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
        TraceRange=(Min=2048.000000,Max=2048.000000)
        RangeAtten=0.350000
        TraceCount=6
        TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunHE'
        ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
        Damage=11
        DamageType=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_SK410ShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
        MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
        FlashScaleFactor=0.500000
        Recoil=378.000000
        Chaos=0.400000
        BotRefireRate=0.900000
        WarnTargetPct=0.500000
		Inaccuracy=(X=256,Y=256)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.300000)
    End Object

    Begin Object Class=FireParams Name=ClassicSecondaryFireParams
        AmmoPerFire=3
		FireInterval=0.120000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireAnimRate=1.750000	
        FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		HipMultiplier=1.5
		ViewBindFactor=0.500000
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		MaxRecoil=12288.000000
		DeclineTime=0.500000
		DeclineDelay=0.150000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		ADSMultiplier=0.5
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-4000,Yaw=3000)
		ChaosDeclineTime=1.600000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ClassicParams
		WeaponBoneScales(0)=(BoneName="Bullet1",Slot=101,Scale=0f)
		SightOffset=(X=-15.000000,Y=-0.900000,Z=19.30000)
		ViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
		PlayerSpeedFactor=0.950000
        PlayerJumpFactor=0.950000
        DisplaceDurationMult=1.25
        SightMoveSpeedFactor=0.8
		MagAmmo=100
		SightingTime=0.45
        InventorySize=6
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}