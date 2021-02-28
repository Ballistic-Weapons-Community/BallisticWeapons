class AH208WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.03),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.00),(InVal=0.7,OutVal=0.03),(InVal=1.0,OutVal=0.00)))
        ViewBindFactor=0.5
        XRandFactor=0.100000
        YRandFactor=0.100000
        MaxRecoil=6144.000000
        DeclineDelay=0.65
        DeclineTime=1
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=2
        AimSpread=(Min=16,Max=128)
        ChaosDeclineTime=0.60000
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.050000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=1
		SightingTime=0.250000
		DisplaceDurationMult=0.5
		MagAmmo=7
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}