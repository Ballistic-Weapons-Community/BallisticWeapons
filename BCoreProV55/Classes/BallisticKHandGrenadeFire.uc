//=============================================================================
// BallisticKHandGrenadeFire.
// DEPRECATED. Doesn't work properly in netplay due to reliance on Karma.
//
// Throws Karma-based grenades with different derivation.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticKHandGrenadeFire extends BallisticHandGrenadeFire;

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local float Speed, DetonateDelay;
	local vector EnemyDir;

	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;

	if (BallisticKHandGrenadeProjectile(Proj) != None)
	{
		if (AIController(Instigator.Controller) == None)
		{
			if (BW != None && BW.WeaponModes[BW.CurrentWeaponMode].Value == 0)
				Speed = Proj.Speed * FClamp(HoldTime-0.5, 0, 2) / 2;
			else if (BW != None)
				Speed = Proj.Speed / BW.WeaponModes[BW.CurrentWeaponMode].Value;
		}
		else if (Instigator.Controller.Enemy != None)
		{
			EnemyDir = Instigator.Controller.Enemy.Location - Instigator.Location;
			Speed = FMin( Proj.Speed, (1+Normal(EnemyDir).Z) * (VSize(EnemyDir)/1.5) + VSize(Instigator.Controller.Enemy.Velocity) * (Normal(Instigator.Controller.Enemy.Velocity) Dot Normal(EnemyDir)) );
		}
		else
			Speed = Proj.Speed;
		if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0.0)
			DetonateDelay = BallisticKHandGrenadeProjectile(Proj).DetonateDelay - (Level.TimeSeconds - BallisticHandGrenade(Weapon).ClipReleaseTime);
		else
			DetonateDelay = BallisticKHandGrenadeProjectile(Proj).DetonateDelay;
		BallisticKHandGrenadeProjectile(Proj).SetThrowPowerAndDelay(Speed, DetonateDelay);
	}
}

defaultproperties
{

}
