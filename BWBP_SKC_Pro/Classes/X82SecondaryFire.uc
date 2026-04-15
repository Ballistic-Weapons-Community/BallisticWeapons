class X82SecondaryFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
	{
		FireAnim='Undeploy';
		X82Rifle_TW(Weapon).Notify_Undeploy();
	}
	else
		super.DoFireEffect();
}

defaultproperties
{
     FireRate=1.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_50BMG'
}
