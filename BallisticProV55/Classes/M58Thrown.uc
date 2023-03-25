//=============================================================================
// M58Thrown.
//
// Gas grenade projectile. Spawns cloud control actor, makes little noises...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M58Thrown extends BallisticHandGrenadeProjectile;

#exec OBJ LOAD FILE=BW_Core_WeaponSound.uax

var   Emitter PATrail;

simulated function InitEffects ()
{
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

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local vector X,Y,Z;

	if (bExploded)
		return;
		
	if (Role == ROLE_Authority)
	{
		Spawn(class'M58Cloud',self,,HitLocation-HitNormal*2);
	}

	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(rot(16384,0,0),X,Y,Z);
		X = X >> Rotation;
		Y = Y >> Rotation;
		Z = Z >> Rotation;
		Trail = Spawn( TrailClass, self,, Location + class'BUtil'.static.AlignedOffset(Rotation,TrailOffset), OrthoRotation(X,Y,Z) );
		if (Trail != None)
			Trail.SetBase (self);
	}

	bExploded=true;
	LifeSpan = 12;
	SetTimer(10.5,false);
}

simulated function Timer()
{
	super.Timer();
	if (LifeSpan < 3 && Trail != None)
	{
		AmbientSound = None;
		Emitter(Trail).Kill();
		Trail = None;
	}
}

defaultproperties
{
	DetonateOn=DT_Still
    WeaponClass=Class'BallisticProV55.M58Grenade'
	DampenFactor=0.050000
	DampenFactorParallel=0.350000
	DetonateDelay=0.5
	ImpactDamage=15
	ImpactDamageType=Class'BallisticProV55.DTM58Grenade'
	ImpactManager=Class'BallisticProV55.IM_Grenade'
	TrailClass=Class'BallisticProV55.M58Spray'
	TrailOffset=(Z=8.000000)
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.M58.M58Projectile'
	DrawScale=0.350000
	SoundVolume=192
	SoundRadius=128.000000
}
