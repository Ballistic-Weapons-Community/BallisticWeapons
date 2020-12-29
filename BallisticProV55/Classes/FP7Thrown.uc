//=============================================================================
// FP7Thrown.
//
// Thrown overhand FP7. Spawns fires on detonation.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7Thrown extends BallisticPineapple;

var   Emitter PATrail;

simulated function InitEffects ()
{
	super.InitEffects();

	if (Level.NetMode != NM_DedicatedServer && Speed > 400 && PATrail==None && level.DetailMode == DM_SuperHigh)
	{
		PATrail = Spawn(class'PineappleTrail', self,, Location);
		if (PATrail != None)
			class'BallisticEmitter'.static.ScaleEmitter(PATrail, DrawScale);
		if (PATrail != None)
			PATrail.SetBase (self);
	}
}

simulated function DestroyEffects()
{
	super.DestroyEffects();
	if (PATrail != None)
		PATrail.Kill();
}

simulated event KVelDropBelow()
{
	super.KVelDropBelow();

	if (PATrail != None)
		PATrail.Kill();
}

simulated event KImpact(actor other, vector pos, vector impactVel, vector impactNorm)
{
	super.KImpact(other, pos, impactVel, impactNorm);
	if (PATrail!= None && VSize(impactVel) > 200)
		PATrail.Kill();
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
		F = Spawn(class'FP7FireControl',self,,HitLocation-HitNormal*2, rot(0,0,0));
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
     DampenFactor=0.050000
     DampenFactorParallel=0.350000
     ImpactDamage=15
     ImpactDamageType=Class'BallisticProV55.DTFP7Grenade'
     ImpactManager=Class'BallisticProV55.IM_Grenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BallisticProV55.NRP57Trail'
     TrailOffset=(X=1.600000,Z=6.400000)
     MyRadiusDamageType=Class'BallisticProV55.DTFP7Burned'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Damage=0.000000
     DamageRadius=0.000000
     MyDamageType=Class'BallisticProV55.DTFP7Grenade'
     ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.FP7.FP7Proj'
     DrawScale=0.500000
}
