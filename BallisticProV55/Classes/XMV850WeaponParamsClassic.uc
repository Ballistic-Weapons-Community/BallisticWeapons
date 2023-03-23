class XMV850WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=17.0
		HeadMult=3.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTXMV850MG'
		DamageTypeHead=Class'BallisticProV55.DTXMV850MGHead'
		DamageTypeArm=Class'BallisticProV55.DTXMV850MG'
		PenetrationEnergy=22.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Fire-1',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=50.000000
		Chaos=-1.0
		PushbackForce=25.000000
		Inaccuracy=(X=64,Y=64)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.050000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		SpreadMode=FSM_Rectangle
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Deploy weapon"
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Drop"
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.300000
		XRandFactor=0.500000
		YRandFactor=0.500000
		DeclineTime=2.500000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=512,Max=2048)
		AimAdjustTime=1.300000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.500000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Default"
		Weight=30
		//Attachments
		//Function
		
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.700000
		InventorySize=25
		SightMoveSpeedFactor=0.500000
		MagAmmo=900
		SightOffset=(X=8.000000,Z=28.000000)
		SightPivot=(Pitch=700,Roll=2048)
		WeaponModes(0)=(ModeName="1200 RPM",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="2400 RPM",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="3600 RPM",ModeID="WM_FullAuto")
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=XMV_Teal
		Index=0
		CamoName="Teal"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XMV_Green
		Index=1
		CamoName="Green"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV858_Main",Index=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV858_Barrels_SD",Index=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=XMV_Black
		Index=2
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV500_Main",Index=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV500_Barrels_SD",Index=2)
	End Object
	
	Camos(0)=WeaponCamo'XMV_Teal'
    Camos(1)=WeaponCamo'XMV_Green'
    Camos(2)=WeaponCamo'XMV_Black'

}