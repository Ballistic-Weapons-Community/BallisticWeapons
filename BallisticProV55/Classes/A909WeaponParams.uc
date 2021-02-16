class A909WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    Begin Object Class=RecoilParams Name=UniversalRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
        DeclineTime=1.500000
    End Object

    Begin Object Class=AimParams Name=UniversalAimParams
        ViewBindFactor=0.00
        SprintOffSet=(Pitch=-3000,Yaw=-4000)
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

    Begin Object Class=MeleeEffectParams Name=ArenaPriEffectParams
        TraceRange=(Min=150.000000,Max=150.000000)
        Damage=45.000000
        Fatigue=0.030000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.A909.A909Slash',Volume=0.5,Radius=32.000000,bAtten=True)
        DamageType=Class'BallisticProV55.DTA909Blades'
        DamageTypeHead=Class'BallisticProV55.DTA909Head'
        DamageTypeArm=Class'BallisticProV55.DTA909Limb'
        MomentumTransfer=100
        WarnTargetPct=0.300000
    End Object

    Begin Object Class=MeleeEffectParams Name=ArenaSecEffectParams
        Fatigue=0.200000
        TraceRange=(Min=150.000000,Max=150.000000)
        Damage=60.000000
        DamageType=Class'BallisticProV55.DTA909Blades'
        DamageTypeHead=Class'BallisticProV55.DTA909Head'
        DamageTypeArm=Class'BallisticProV55.DTA909Limb'
        MomentumTransfer=100
        HookStopFactor=1.700000
        HookPullForce=100.000000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.A909.A909Slash',Volume=0.5,Radius=32.000000,bAtten=True)
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=ArenaPriFireParams
        AmmoPerFire=0
        FireAnim="PrepHack"
        FireAnimRate=1.200000
        FireInterval=0.350000
        FireEffectParams(0)=MeleeEffectParams'ArenaPriEffectParams'
    End Object

    Begin Object Class=FireParams Name=ArenaSecFireParams
        AmmoPerFire=0
        PreFireAnim="PrepBigHack3"
        FireAnim="BigHack3"
        FireInterval=1.000000
        FireEffectParams(0)=MeleeEffectParams'ArenaSecEffectParams'
    End Object

    Begin Object Class=WeaponParams Name=UniversalParams
        PlayerSpeedFactor=1.10
        DisplaceDurationMult=0.0
        MagAmmo=1
        InventorySize=3
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
        FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}