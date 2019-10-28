class XMV850MinigunSecondaryFire extends BallisticFire;

function PlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		FireAnim='Drop';
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		FireAnim='Drop';
	super.ServerPlayFiring();
}

function DoFireEffect();

simulated function bool AllowFire()
{
	if (BallisticTurret(Instigator) == None && Instigator.HeadVolume.bWaterVolume)
		return false;
	return super.AllowFire();
}

defaultproperties
{
     bUseWeaponMag=False
     EffectString="Deploy weapon"
     bModeExclusive=False
     FireAnim="Drop"
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_MinigunRounds'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
