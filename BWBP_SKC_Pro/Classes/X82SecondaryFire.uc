class X82SecondaryFire extends M353SecondaryFire;

// Allow undeploy even when out of ammo (#209)
simulated function bool AllowFire()
{
	if (BallisticTurret(Instigator) != None)
		return true;
	return super.AllowFire();
}

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
	{
		FireAnim='Undeploy';
		X82Rifle_TW(Weapon).Notify_Undeploy();
	}
	else
		X82Rifle(Weapon).Notify_Deploy();
}

defaultproperties
{
     FireRate=1.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_50BMG'
}
