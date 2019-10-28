class MACSecondaryFire extends BallisticFire;

function PlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		FireAnim='Deploy';
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BallisticTurret(Instigator) != None)
		FireAnim='Undeploy';
	else
		FireAnim='Deploy';
	super.ServerPlayFiring();
}

function DoFireEffect();

simulated function bool AllowFire()
{
	if (BW.SightingState != SS_None)
		return false;
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
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_MAC'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
