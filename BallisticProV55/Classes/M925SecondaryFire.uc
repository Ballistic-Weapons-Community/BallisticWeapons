class M925SecondaryFire extends M353SecondaryFire;

function DoFireEffect()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		super.DoFireEffect();
}

defaultproperties
{
     AmmoClass=Class'BallisticProV55.Ammo_50CalBelt'
}
