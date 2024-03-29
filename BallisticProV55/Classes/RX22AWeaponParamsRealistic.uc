class RX22AWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		//TraceRange=(Min=1800.000000,Max=1800.000000)
		//WaterTraceRange=5000.0
		//DecayRange=(Min=0.0,Max=0.0)
		Speed=3000
		MaxSpeed=3000
		Damage=20.0
		HeadMult=3.3
		LimbMult=0.6
		//PenetrateForce=50
		//PDamageFactor=0.6
		//WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=64.000000
		Chaos=0.050000
		Inaccuracy=(X=96,Y=96)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	// Azarael note:
	// though the RX22A primary is defined as an instant fire,
	// conceptually, it is not - it uses some convoluted handling in which
	// its FireControl does most of the work, including for spawning
	// the projectiles that do its hit registration
	//
	// attempting to use instant fire parameters for it will have no gameplay effect,
	// and the code expects projectile params here
	// 
	// I've fixed the issue further up in the core, where the mode would attempt to assign
	// instant params and complain if none existed
	/*Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=500.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=20.0
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=64.000000
		Chaos=0.050000
		Inaccuracy=(X=96,Y=96)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object*/
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-FuelLoop',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=32.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
        EffectString="Spray gas"
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.600000)))
		PitchFactor=0.500000
		YawFactor=0.500000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=512
		DeclineTime=0.400000
		ViewBindFactor=0.250000
		ADSViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.875000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1792)
		CrouchMultiplier=0.875000
		ADSMultiplier=0.875000
		ViewBindFactor=0.150000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-2048,Yaw=-4096)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.500000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.775000
		PlayerJumpFactor=0.800000
        InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.4
		MagAmmo=200
		//ViewOffset=(X=6.000000,Y=6.000000,Z=-8.000000)
		//SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		WeaponName="RX220-A Incinerator"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
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