class M925SecondaryFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		M925Machinegun(Weapon).Notify_Deploy();
}

defaultproperties
{
     AmmoClass=Class'BallisticProV55.Ammo_50CalBelt'
}
