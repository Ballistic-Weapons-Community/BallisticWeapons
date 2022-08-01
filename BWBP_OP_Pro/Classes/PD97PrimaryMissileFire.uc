class PD97PrimaryMissileFire extends BallisticProProjectileFire;

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
		PD97Rocket(Proj).Master = PD97Bloodhound(BW);
	}
//	PD97Bloodhound(Weapon).AddProjectile(Proj);
}

defaultproperties
{
     BallisticFireSound=(Sound=SoundGroup'BWBP_OP_Sounds.PD97.PD97-RocketFire',Volume=1.0)
     PreFireAnim=
     FireAnimRate=1.100000
     FireForce="AssaultRifleAltFire"
     FireRate=0.200000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_BloodhoundDarts'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_OP_Pro.PD97Rocket'
     BotRefireRate=0.700000
     WarnTargetPct=0.300000
}
