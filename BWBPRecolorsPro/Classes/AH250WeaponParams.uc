class AH250WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.1),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.02),(InVal=0.7,OutVal=-0.06),(InVal=1.0,OutVal=0.0)))
		ViewBindFactor=0.5
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=6144.000000
		DeclineDelay=0.65
		DeclineTime=1
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		AimSpread=(Min=16,Max=256)
		ChaosDeclineTime=0.60000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.050000
		PlayerJumpFactor=1.000000
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.40000
		DisplaceDurationMult=0.75
		MagAmmo=7
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}