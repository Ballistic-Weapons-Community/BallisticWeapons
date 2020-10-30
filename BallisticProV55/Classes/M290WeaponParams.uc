class M290WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.2
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.400000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.900000
        DeclineDelay=0.500000
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=0.350000
        SprintOffSet=(Pitch=-1000,Yaw=-2048)
        JumpChaos=1.000000
        ChaosDeclineTime=1.000000	
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		MagAmmo=6
		SightingTime=0.3
        InventorySize=24
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}