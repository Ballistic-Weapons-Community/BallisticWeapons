//=============================================================================
// T10PrimaryFire.
//
// T10 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class T10PrimaryFire extends BallisticHandGrenadeFire;

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local float Speed, DetonateDelay;
	local vector EnemyDir;
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;

	if (BallisticHandGrenadeProjectile(Proj) != None)
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

		if (BallisticHandGrenade(Weapon).ClipReleaseTime == 666)
			DetonateDelay = BallisticHandGrenadeProjectile(Proj).DetonateDelay - 3;
		else if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0.0)
			DetonateDelay = BallisticHandGrenadeProjectile(Proj).DetonateDelay - (Level.TimeSeconds - BallisticHandGrenade(Weapon).ClipReleaseTime);
		else
			DetonateDelay = BallisticHandGrenadeProjectile(Proj).DetonateDelay;
            
		BallisticHandGrenadeProjectile(Proj).SetThrowPowerAndDelay(Speed, DetonateDelay);
	}
}

defaultproperties
{
     NoClipPreFireAnim="ThrowNoClip"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BallisticProV55.Brass_T10Clip'
     BrassBone="tip"
     BrassOffset=(X=-20.000000,Z=-2.000000)
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     AmmoClass=Class'BallisticProV55.Ammo_T10Grenades'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.T10Thrown'
	 
	 // AI
	 BotRefireRate=0.3
     WarnTargetPct=0.75
}
