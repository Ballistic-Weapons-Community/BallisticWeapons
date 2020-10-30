class FLASHWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
	 	DeclineTime=0.750000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=512,Max=2048)
		ADSMultiplier=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.750000
		ChaosSpeedThreshold=1200.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=35
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=4
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}