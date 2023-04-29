class MRLWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLRocket'
		SpawnOffset=(X=28.000000,Y=10.000000,Z=-8.000000)
		Speed=4500.000000
		MaxSpeed=25000.000000
		AccelSpeed=10000.000000
		Damage=75.000000
		DamageRadius=378.000000
		MomentumTransfer=20000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
		Chaos=0.170000
		Recoil=2.000000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.135000
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLRocketSecondary'
		SpawnOffset=(X=28.000000,Y=8.000000,Z=-6.000000)
		Speed=4500.000000
		MaxSpeed=25000.000000
		AccelSpeed=10000.000000
		Damage=75.000000
		DamageRadius=378.000000
		MomentumTransfer=20000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
		Chaos=0.170000
		Recoil=1.000000
		Inaccuracy=(X=768,Y=768)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.100000
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//=================================================================
    // Recoil
    //=================================================================	
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XRandFactor=0.000000
		YRandFactor=0.000000
 	End Object
	
	//=================================================================
    // AIM
    //=================================================================	
	
	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.7
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		SprintOffSet=(Pitch=-3072,Yaw=-2048)
		OffsetAdjustTime=0.600000
		AimSpread=(Min=128,Max=2048)
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
    // BASIC PARAMS
    //=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ViewPivot=(Pitch=1024,Yaw=-512,Roll=1024)
		PlayerSpeedFactor=0.9
        SightMoveSpeedFactor=0.45
        DisplaceDurationMult=1.4
		SightingTime=0.55
		MagAmmo=36
        InventorySize=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=MRL_Military
		Index=0
		CamoName="OD Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MRL_Rad
		Index=1
		CamoName="Radical"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MRLCamos.MRL_MainRed_S1",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MRLCamos.MRL-MagRed",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'MRL_Military'
	Camos(1)=WeaponCamo'MRL_Rad'
}