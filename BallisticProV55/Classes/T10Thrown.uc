//=============================================================================
// T10Thrown.
//
// Gas grenade projectile. Spawns cloud control actor, makes little noises...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class T10Thrown extends BallisticProPineapple;

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
	local T10CloudControl C;
	local vector X,Y,Z;

	if (bExploded)
		return;

	if ( Role == ROLE_Authority )
	{
		C = Spawn(class'T10CloudControl',self,,HitLocation-HitNormal*2);
		
		if (C!=None)
		{
			C.Instigator = Instigator;
			C.InstigatorController = InstigatorController;
		}
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
		PlaySound(sound'BW_Core_WeaponSound.T10.T10-Ignite',, 0.7,, 128, 1.0, true);
		AmbientSound = Sound'BW_Core_WeaponSound.T10.T10-toxinLoop';
	}

	bExploded=true;
	LifeSpan = 8;
	SetTimer(6.5,false);
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
    WeaponClass=Class'BallisticProV55.T10Grenade'
	DampenFactor=0.050000
	DampenFactorParallel=0.350000
	DetonateDelay=2.000000
	ImpactDamage=15
	ImpactDamageType=Class'BallisticProV55.DTT10Grenade'
	ImpactManager=Class'BallisticProV55.IM_Grenade'
	ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
	TrailClass=Class'BallisticProV55.T10Spray'
	TrailOffset=(Z=8.000000)
	MyRadiusDamageType=Class'BallisticProV55.DTT10Gas'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Damage=20.000000
	DamageRadius=200.000000
	MyDamageType=Class'BallisticProV55.DTT10Grenade'
	ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.T10.T10Projectile'
	DrawScale=0.350000
	SoundVolume=192
	SoundRadius=128.000000
}
