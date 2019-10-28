class TargetDesignatorScopeFire extends BallisticScopeFire;

function Timer()
{
	BW.bNeedReload = False;
	if (Weapon.Role < ROLE_Authority)
		return;
	if ( !Weapon.AmmoMaxed(0) )
		Weapon.AddAmmo(1, 0);
}

defaultproperties
{
}
