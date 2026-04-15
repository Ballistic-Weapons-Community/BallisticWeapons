class AS50DeployFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		super.DoFireEffect();
}

defaultproperties
{
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_50Inc'
}
