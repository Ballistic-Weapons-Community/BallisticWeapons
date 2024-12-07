//=============================================================================
// FP7Thrown.
//
// Thrown overhand FP7. Spawns fires on detonation.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7Thrown extends BallisticHandGrenadeProjectile;

var	    Actor					PATrail;					// The trail Actor
var() class<Actor>			    PATrailClass;				// Actor to use for trail

simulated function InitEffects ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Speed > 400 && PATrailClass != None && PATrail == None && level.DetailMode == DM_SuperHigh)
	{
		PATrail = Spawn(PATrailClass, self,, Location);
		if (Emitter(PATrail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(PATrail), DrawScale);
		if (PATrail != None)
			PATrail.SetBase (self);
	}
}

simulated function Destroyed()
{
	if (PATrail != None)
	{
		if (Emitter(PATrail) != None)
			Emitter(PATrail).Kill();
		else
			PATrail.Destroy();
	}
	Super.Destroyed();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local FP7FireControl F;
	local Teleporter TB;

	if ( Role == ROLE_Authority )
	{
		//No teleporter camping, die die die
		foreach RadiusActors(class'Teleporter', TB, 256)
		{
			if (Instigator != None)
				Level.Game.Broadcast(self, "FP7 Grenade thrown by"@Instigator.PlayerReplicationInfo.PlayerName@"too close to a teleporter!");
			return;
		}

		F = Spawn(class'FP7FireControl', self, , Location + vect(0,0,16), rot(0,0,0));

		if (F!=None)
		{
			F.Instigator = Instigator;
			F.Initialize();
		}
	}

	Destroy();
}

defaultproperties
{
    WeaponClass=Class'BallisticProV55.FP7Grenade'
     DampenFactor=0.050000
     DampenFactorParallel=0.350000
     ImpactDamage=15
     DetonateDelay=2
     ImpactDamageType=Class'BallisticProV55.DTFP7Grenade'
     ImpactManager=Class'BallisticProV55.IM_Grenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BallisticProV55.NRP57Trail'
     TrailOffset=(X=1.600000,Z=6.400000)
	 PATrailClass=Class'BallisticProV55.PineappleTrail'
     MyRadiusDamageType=Class'BallisticProV55.DTFP7Burned'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Damage=0.000000
     DamageRadius=0.000000
     MyDamageType=Class'BallisticProV55.DTFP7Grenade'
     ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.FP7.FP7Proj'
     DrawScale=0.500000
}
