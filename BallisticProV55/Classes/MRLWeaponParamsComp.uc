class MRLWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLRocket'
		SpawnOffset=(X=28.000000,Y=10.000000,Z=-8.000000)
		Speed=4500.000000
		MaxSpeed=25000.000000
		AccelSpeed=10000.000000
		Damage=35.000000
		DamageRadius=420.000000
		MomentumTransfer=20000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
		Chaos=0.170000
		Recoil=2.000000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.110000
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLRocketSecondary'
		SpawnOffset=(X=28.000000,Y=8.000000,Z=-6.000000)
		Speed=4500.000000
		MaxSpeed=25000.000000
		AccelSpeed=10000.000000
		Damage=35.000000
		DamageRadius=420.000000
		MomentumTransfer=20000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
		Chaos=0.170000
		Recoil=1.000000
		Inaccuracy=(X=768,Y=768)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.080000
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//=================================================================
    // Recoil
    //=================================================================	
	
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=0.000000
		YRandFactor=0.000000
 	End Object
	
	//=================================================================
    // AIM
    //=================================================================	
	
	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.25
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		SprintOffSet=(Pitch=-7000,Yaw=-3000)
		OffsetAdjustTime=0.600000
		AimSpread=(Min=128,Max=2048)
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
    // BASIC PARAMS
    //=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.250000
		ViewPivot=(Pitch=1024,Yaw=-512,Roll=1024)
		PlayerSpeedFactor=0.9
        DisplaceDurationMult=1.4
		SightingTime=0.65
		SightMoveSpeedFactor=0.7
		MagAmmo=36
        InventorySize=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
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