class FG50DeployFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		FG50Machinegun(Weapon).Notify_Deploy();
}

defaultproperties
{
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_50IncDrum'
}
