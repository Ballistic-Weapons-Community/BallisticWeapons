class leMatWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.2,OutVal=0.03),(InVal=0.36,OutVal=0.07),(InVal=0.62,OutVal=0.09),(InVal=0.6,OutVal=0.11),(InVal=1,OutVal=0.15)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		DeclineTime=1.000000
		DeclineDelay=0.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		ChaosDeclineTime=0.450000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=1.050000
        DisplaceDurationMult=0.5
        SightingTime=0.200000
        MagAmmo=9
        InventorySize=6
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}