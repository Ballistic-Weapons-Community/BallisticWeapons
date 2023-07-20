class MG36SecondaryFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
	{
		FireAnim='Undeploy';
		MG36MG_TW(Weapon).Notify_Undeploy();
	}
	else
		MG36Machinegun(Weapon).Notify_Deploy();
}

defaultproperties
{
     FireRate=1.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_68mm'
}
