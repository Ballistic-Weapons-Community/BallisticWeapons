//=============================================================================
// A73WeaponParams
//=============================================================================
class A73WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
    	SpawnOffset=(X=30.000000,Y=5.000000,Z=-8.000000)
        Speed=5500.000000
        AccelSpeed=100000.000000
        MaxSpeed=14000.000000
        Damage=45.000000
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=200.000000
	    Chaos=0.020000
		Heat=0.6
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.A73Projectile'
        WarnTargetPct=0.200000
        BotRefireRate=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaProjFireParams
	    FireEndAnim=
        AimedFireAnim="SightFire"
	    FireInterval=0.125000
        FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams'
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams_Rapid
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
    	SpawnOffset=(X=30.000000,Y=5.000000,Z=-8.000000)
        Speed=3500.000000
        AccelSpeed=70000.000000
        MaxSpeed=12000.000000
        Damage=35.000000
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=130.000000
	    Chaos=0.020000
		Heat=0.4
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Pitch=1.1,Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.A73ProjectileBal'
        WarnTargetPct=0.200000
        BotRefireRate=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaProjFireParams_Rapid
	    FireEndAnim=
        AimedFireAnim="SightFire"
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams_Rapid'
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams_Elite
		ProjectileClass=Class'BallisticProV55.A73ProjectileB'
    	SpawnOffset=(X=30.000000,Y=5.000000,Z=-8.000000)
        Speed=6500.000000
        AccelSpeed=150000.000000
        MaxSpeed=18000.000000
        Damage=62.000000
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=1536.000000
	    Chaos=0.020000
		Heat=1.0
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.200000
        BotRefireRate=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaProjFireParams_Elite
        AmmoPerFire=2
	    FireEndAnim=
        AimedFireAnim="SightFire"
	    FireInterval=0.150000
        FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams_Elite'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=ArenaPowerEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
        SpawnOffset=(X=30.000000,Y=5.000000,Z=-8.000000)
        Speed=3000.000000
        AccelSpeed=8000.000000
        MaxSpeed=7000.000000
        Damage=87.000000
        DamageRadius=100.000000
        MomentumTransfer=2000.000000
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=1536.000000
        Chaos=0.500000
		Heat=3.4
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectile'
        WarnTargetPct=0.500000
        BotRefireRate=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaPowerFireParams
        AmmoPerFire=8
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'ArenaPowerEffectParams'
    End Object

	//Pink alt for layout 2
    Begin Object Class=ProjectileEffectParams Name=ArenaPowerEffectParams_Rapid
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterBal'
        SpawnOffset=(X=30.000000,Y=5.000000,Z=-8.000000)
        Speed=3000.000000
        AccelSpeed=8000.000000
        MaxSpeed=7000.000000
        Damage=87.000000
        DamageRadius=100.000000
        MomentumTransfer=2000.000000
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=1536.000000
        Chaos=0.500000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectileBal'
        WarnTargetPct=0.500000
        BotRefireRate=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaPowerFireParams_Rapid
        AmmoPerFire=8
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'ArenaPowerEffectParams_Rapid'
    End Object
	
	//Elite layout alt
	Begin Object Class=ProjectileEffectParams Name=ArenaPowerEffectParams_Elite
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
        SpawnOffset=(X=30.000000,Y=5.000000,Z=-8.000000)
        Speed=1500.000000
        AccelSpeed=0.000000
        MaxSpeed=2000.000000
        Damage=115.000000
        DamageRadius=200.000000
        MomentumTransfer=2000.000000
		SplashDamage=True
		RecommendSplashDamage=True
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=1536.000000
        Chaos=0.020000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Power',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		ProjectileClass=Class'BallisticProV55.A73PowerProjectileB'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaPowerFireParams_Elite
        AmmoPerFire=10
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.850000
        FireEffectParams(0)=ProjectileEffectParams'ArenaPowerEffectParams_Elite'
    End Object

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		ClimbTime=0.05
		DeclineDelay=0.125000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
 	End Object

    //=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.350000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		AimSpread=(Min=64,Max=378)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.350000
		ChaosDeclineDelay=0.300000
		ChaosSpeedThreshold=300
	End Object

    //=================================================================
    // WEAPON
    //=================================================================

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Standard"
		Weight=30
		AllowedCamos(0)=0
		//Attachments
		//Function
        ReloadAnimRate=1.250000
		MagAmmo=32
		SightPivot=(Pitch=450)
		//SightOffset=(X=10.000000,Z=11.90000)
		SightMoveSpeedFactor=0.8
		InventorySize=6
	    RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaProjFireParams'
        AltFireParams(0)=FireParams'ArenaPowerFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_CQC
		//Layout core
		LayoutName="CQC"
		Weight=10
		AllowedCamos(0)=1
		//Attachments
		//Function
        ReloadAnimRate=1.250000
		MagAmmo=32
		SightPivot=(Pitch=450)
		//SightOffset=(X=10.000000,Z=11.90000)
		InventorySize=6
	    RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaProjFireParams_Rapid'
        AltFireParams(0)=FireParams'ArenaPowerFireParams_Rapid'
    End Object 
	
    Begin Object Class=WeaponParams Name=ArenaParams_Elite
		//Layout core
		LayoutName="Elite"
		Weight=10
		AllowedCamos(0)=2
		//Attachments
		//Function
        ReloadAnimRate=1.250000
		MagAmmo=32
		SightPivot=(Pitch=450)
		//SightOffset=(X=10.000000,Z=11.90000)
		InventorySize=6
	    RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaProjFireParams_Elite'
        AltFireParams(0)=FireParams'ArenaPowerFireParams_Elite'
    End Object 	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_CQC'
    Layouts(2)=WeaponParams'ArenaParams_Elite'
	
	//Camos =========================================
	Begin Object Class=WeaponCamo Name=A73_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=A73_Pink
		Index=1
		CamoName="Pink"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73AmmoSkin',Index=1,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.A73PurpleLayout.A73Skin_SD',Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.A73PurpleLayout.A73Skin_SD',Index=2,AIndex=-1,PIndex=4)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73SkinB',Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.A73.A73BladeShader',Index=4,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=A73_Orange
		Index=2
		CamoName="Orange"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.A73RedLayout.A73BAmmoSkin',Index=1,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BSkin_SD',Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BSkin_SD',Index=2,AIndex=-1,PIndex=4)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.A73RedLayout.A73BSkinB0',Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BBladeShader',Index=4,AIndex=1,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'A73_Blue'
	Camos(1)=WeaponCamo'A73_Pink'
	Camos(2)=WeaponCamo'A73_Orange'
}