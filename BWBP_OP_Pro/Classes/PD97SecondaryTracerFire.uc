//=============================================================================
// PD97SecondaryFire
// 
// Tracker fire.
//=============================================================================
class PD97SecondaryTracerFire extends BallisticProProjectileFire;

var PD97TrackerProj ActiveProj;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		FireAnim = 'OpenTazerFire';
		BW.IdleAnim = 'OpenTazerIdle';
	}
	else
	{
		FireAnim = 'TazerFire';
		BW.IdleAnim = 'TazerIdle';
	}
	super.PlayFiring();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		PD97TrackerProj(Proj).Master = PD97Bloodhound(BW);
		ActiveProj = PD97TrackerProj(Proj);
	}
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
		
	if (BW.Role == ROLE_Authority)
	{
		//There can BE ONLY ONE
		if (ActiveProj != None)
			ActiveProj.Destroy();
		if (PD97Bloodhound(BW) != None && PD97Bloodhound(BW).ActiveBeacon != None)
		{
			PD97Bloodhound(BW).ActiveBeacon.Destroy();
		}
	}

	super.ModeDoFire();

	// Reset idle anim after firing - dart doesn't stay deployed like the tazer
	if (PD97Bloodhound(BW) != None)
	{
		if (BW.MagAmmo - ConsumedLoad < 1)
			PD97Bloodhound(BW).IdleAnim = 'OpenIdle';
		else
			PD97Bloodhound(BW).IdleAnim = 'Idle';
	}
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     FlashBone="Tazer"
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
     bFireOnRelease=True
     PreFireAnim=
     FireAnim="TazerFire"
     FireForce="AssaultRifleAltFire"
     FireRate=0.900000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_BloodhoundDarts'
     AmmoPerFire=0
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_OP_Pro.PD97TrackerProj'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
