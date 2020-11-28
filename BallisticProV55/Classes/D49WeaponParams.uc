class D49WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.5,OutVal=0.03),(InVal=1,OutVal=0.07)))
		ViewBindFactor=0.65
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineTime=1.200000
		DeclineDelay=0.350000
		MaxRecoil=6144
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=378)
		JumpChaos=0.750000
		ChaosDeclineTime=0.450000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=1.050000
        DisplaceDurationMult=0.5
        SightingTime=0.200000
        MagAmmo=6
        InventorySize=6
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}