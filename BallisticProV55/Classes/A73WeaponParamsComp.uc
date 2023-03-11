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
    	SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=5500.000000
        AccelSpeed=100000.000000
        MaxSpeed=14000.000000
        Damage=36.000000
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=130.000000
	    Chaos=0.020000
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

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=ArenaPowerEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=3000.000000
        AccelSpeed=8000.000000
        MaxSpeed=7000.000000
        Damage=70.000000
        DamageRadius=100.000000
        MomentumTransfer=2000.000000
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=960.000000
        Chaos=0.500000
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

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.5
		DeclineDelay=0.170000
 	End Object

    //=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.350000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
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
        ReloadAnimRate=1.250000
		MagAmmo=32
		ViewOffset=(X=-4.000000,Y=10.000000,Z=-10.000000)
		SightPivot=(Pitch=450)
		SightOffset=(X=10.000000,Z=12.150000)
		InventorySize=12
	    RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaProjFireParams'
        AltFireParams(0)=FireParams'ArenaPowerFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}