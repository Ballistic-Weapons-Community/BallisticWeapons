class XM20WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{ 
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.150000,OutVal=0.020000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.11),(InVal=0.400000,OutVal=0.130000),(InVal=0.600000,OutVal=0.20000),(InVal=0.800000,OutVal=0.25000),(InVal=1.000000,OutVal=0.30000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.5,OutVal=0.600000),(InVal=0.600000,OutVal=0.67),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.8
		DeclineDelay=0.2
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1536)
        ADSMultiplier=0.5
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.5
		ChaosDeclineDelay=0.3
		ChaosSpeedThreshold=300
	End Object
	
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=5000.000000,Max=7500.000000)
		Damage=26
        HeadMult=2.25
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_XM20_Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20_Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20_Body'
		PenetrateForce=600
		bPenetrate=False
		MuzzleFlashClass=Class'BWBP_SKC_Pro.XM20FlashEmitter'
		FlashScaleFactor=0.300000
		Recoil=96.000000
		BotRefireRate=0.90
		WarnTargetPct=0.10000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.135000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
		Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
			Damage=26
        HeadMult=2.25
        LimbMult=0.75f
			DamageType=Class'BWBP_SKC_Pro.DT_XM20_Body'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20_Head'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20_Body'
			 Chaos=0
			 Recoil=32
			FlashScaleFactor=0.100000
		End Object
		
		Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParamsOvercharge
			Damage=25
            HeadMult=2.25
            LimbMult=0.75f
			 Chaos=0
			 Recoil=32
			FlashScaleFactor=0.200000
		End Object
		
		Begin Object Class=FireParams Name=TacticalSecondaryFireParams
			FireInterval=0.070000
			PreFireAnim="LoopStart"
			FireLoopAnim="LoopFire"
			FireEndAnim="LoopEnd"	
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
		End Object
		
		Begin Object Class=FireParams Name=TacticalSecondaryFireParamsOvercharge
			FireInterval=0.045000
			PreFireAnim="LoopOpenStart"
			FireLoopAnim="LoopOpenFire"
			FireEndAnim="LoopOpenEnd"
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParamsOvercharge'
		End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(1)=(BoneName="Prototype",Slot=59,Scale=0f)
		SightPivot=(Pitch=600)
		SightOffset=(X=-10.000000,Y=11.7500000,Z=22.500000)
		ViewOffset=(X=6.000000,Y=1.000000,Z=-15.000000)
		InventorySize=6
		SightMoveSpeedFactor=0.35
		SightingTime=0.5
		DisplaceDurationMult=1
		MagAmmo=50
		// acog-like
        ZoomType=ZT_Logarithmic
		MinZoom=2
		MaxZoom=4
		ZoomStages=1
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParamsOvercharge'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XM20_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_HexGreen
		Index=1
		CamoName="Green Hex"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoGreen",Index=2,AIndex=1,PIndex=3)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_HexBlue
		Index=2
		CamoName="Blue Hex"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoBlue",Index=2,AIndex=1,PIndex=3)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_HexOrange
		Index=3
		CamoName="Yellow Hex"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoWhite",Index=2,AIndex=1,PIndex=3)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoGold",Index=2,AIndex=1,PIndex=3)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20P_Blue
		Index=5
		CamoName="Prototype"
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20P_Yellow
		Index=6
		CamoName="Test Bed"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.XM20Prototype.XM20-MainBurnedShine',Index=2,AIndex=1,PIndex=3)
		Weight=5
	End Object
	
	Camos(0)=WeaponCamo'XM20_Black'
	Camos(1)=WeaponCamo'XM20_HexGreen'
	Camos(2)=WeaponCamo'XM20_HexBlue'
	Camos(3)=WeaponCamo'XM20_HexOrange'
	Camos(4)=WeaponCamo'XM20_Gold'
	Camos(5)=WeaponCamo'XM20P_Blue'
	Camos(6)=WeaponCamo'XM20P_Yellow'
}