//=============================================================================
// MRDRWeaponParams
//=============================================================================
class MRDRWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.5
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.200000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.550000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.800000
		DeclineDelay=0.350000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
		AimSpread=(Min=16,Max=256)
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        MagAmmo=24
        InventorySize=6
        SightingTime=0.200000
        PlayerSpeedFactor=1.05
        DisplaceDurationMult=0.5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}