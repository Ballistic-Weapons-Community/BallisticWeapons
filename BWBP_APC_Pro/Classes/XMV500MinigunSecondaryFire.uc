class XMV500MinigunSecondaryFire extends M353SecondaryFire;

simulated function bool AllowFire()
{
	local name Anim;
	local float Frame, Rate;

	Weapon.GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == 'Deploy' || Anim == 'Undeploy')
		return false;

	if (BallisticTurret(Instigator) != None)
		return Level.TimeSeconds - BallisticTurret(Instigator).DriverEnterTime >= 0.3;
	if (BallisticAutoTurret(Instigator) != None)
		return Level.TimeSeconds - BallisticAutoTurret(Instigator).DriverEnterTime >= 0.3;
	if (Instigator.HeadVolume.bWaterVolume)
		return false;
	if (BW != None && BW.LastTurretDeployTime > 0 && Level.TimeSeconds - BW.LastTurretDeployTime < 0.3)
		return false;
	return super.AllowFire();
}

defaultproperties
{
    AmmoClass=Class'BWBP_APC_Pro.Ammo_MinigunInc'
}
