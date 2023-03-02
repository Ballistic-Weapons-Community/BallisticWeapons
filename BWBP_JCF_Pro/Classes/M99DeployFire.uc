class M99DeployFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		M99Rifle(Weapon).Notify_Deploy();
}

defaultproperties
{
     AmmoClass=Class'BWBP_JCF_Pro.Ammo_50ECSRifle'
}
