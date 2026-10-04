//=============================================================================
// NullFire.
//
// Fire mode for the NullGun. It never fires. It is only there because the
// engine's weapon and bot code expect a held weapon to have its fire modes,
// and log Accessed None for every call that looks at them otherwise.
//=============================================================================
class NullFire extends WeaponFire;

simulated function bool AllowFire()
{
	return false;
}

function DoFireEffect();

defaultproperties
{
     bModeExclusive=False
     BotRefireRate=0.000000
}
