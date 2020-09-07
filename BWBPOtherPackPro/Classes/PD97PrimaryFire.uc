class PD97PrimaryFire extends BallisticProProjectileFire;

simulated function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		AimedFireAnim = 'OpenSightFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	
	Super.PlayFiring();
	
	PD97Bloodhound(BW).ShellFired();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		PD97Dart(Proj).Master = PD97Bloodhound(BW);
	}
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=256.000000
     FireChaos=0.150000
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_FireDart',Radius=128,Volume=0.5)
     PreFireAnim=
     FireAnimRate=1.100000
     FireForce="AssaultRifleAltFire"
     FireRate=0.400000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_BloodhoundDarts'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPOtherPackPro.PD97Dart'
     BotRefireRate=0.700000
     WarnTargetPct=0.300000
}
