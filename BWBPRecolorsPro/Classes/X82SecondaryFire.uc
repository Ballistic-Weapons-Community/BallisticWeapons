class X82SecondaryFire extends M353SecondaryFire;

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
     AmmoClass=Class'BWBPRecolorsPro.Ammo_50BMG'
}
