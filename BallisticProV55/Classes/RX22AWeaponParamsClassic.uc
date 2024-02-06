class RX22AWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		//TraceRange=(Min=1800.000000,Max=1800.000000)
		//WaterTraceRange=5000.0
		//DecayRange=(Min=0.0,Max=0.0)
		Speed=3000
		MaxSpeed=3000
		Damage=4.0
		HeadMult=3.3
		LimbMult=0.6
		//PenetrateForce=50
		//PDamageFactor=0.6
		//WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=64.000000
		Chaos=0.050000
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-FuelLoop',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=32.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
		EffectString="Spray gas"
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.600000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		DeclineTime=1.000000
		ViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-500,Yaw=-1024)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.500000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Fuel Sprayer"
		Weight=30
		
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
        InventorySize=11
		SightMoveSpeedFactor=0.500000
		MagAmmo=150
		//SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-BR
		LayoutName="Fireballer"
		Weight=10
		
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		MagAmmo=150
		ViewOffset=(X=2,Y=4,Z=-1.2)
		//SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	//Layouts(1)=WeaponParams'ClassicParams-BR'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=RX22A_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RX22A_Tan
		Index=1
		CamoName="Tan"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RX22ACamos.RX22ESkin",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'RX22A_Green'
	Camos(1)=WeaponCamo'RX22A_Tan'
}
