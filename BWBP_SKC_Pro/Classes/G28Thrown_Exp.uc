//=============================================================================
// G28Thrown_Exp.
//
// Gas grenade projectile. Spawns cloud control actor, makes little noises...
// Heals people and is flammable.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class G28Thrown_Exp extends BallisticPineapple;

#exec OBJ LOAD FILE=BW_Core_WeaponSound.uax

var() class<damageType>	ShotDamageType;	// Damagetype to use when detonated by damage
var   Emitter PATrail;
var() bool				bDamaged;		// Has been damaged and is about to blow
var   bool				bDetonate;		// Flaged for detonation next tick. Sent to net clients when detonated on server
var   bool				bDetonated;		// Blown up, no more blowing up.
var() int				Health;			// Distance from death

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


event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> Damagetype)
{
	if (VSize(Momentum) < 2000)
		return;

	NetKickForce = Momentum/75;
	if (Base != None)
		NetKickForce.Z += 250;
	KickPineApple(NetKickForce);

	if (bDamaged || class<BallisticDamageType>(DamageType)!=None && !class<BallisticDamageType>(DamageType).default.bIgniteFires)
		return;

	Health-=Damage;
	if (Health > 0)
		return;
	bDamaged = true;
	if (InstigatedBy != None)
	{
		Instigator = InstigatedBy;
		InstigatorController = InstigatedBy.Controller;
		MyRadiusDamageType = ShotDamageType;
	}
	ExplodeFire(Location, vector(Rotation));
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
	local G28CloudControl C;
	local vector X,Y,Z;

	if (bExploded)
		return;
	if ( Role == ROLE_Authority )
	{
		C = Spawn(class'G28CloudControl',self,,HitLocation-HitNormal*2);
		if (C!=None)
		{
			C.Instigator = Instigator;
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
	LifeSpan = 12;
	SetTimer(10.5,false);
}


simulated function ExplodeFire(vector HitLocation, vector HitNormal)
{
	if(bDetonated)
		return;

	bDetonated = true;
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    	if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}
	Destroy();
}


simulated function BlowUp(vector HitLocation)
{
	local vector Start;
    	local rotator Dir;
    	local int i;

	Start = Location/* + 10 * HitNormal*/;
	if (FlakCount > 0 && FlakClass != None)
	{
		for (i=0;i<FlakCount;i++)
		{
			Dir.Yaw += FRand()*40000-20000;
			Dir.Pitch += FRand()*40000-20000;
			Spawn( FlakClass,, '', Start, Dir);
		}
	}
	TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

simulated function Timer()
{
	super.Timer();
	
	// Was damaged or detonated, now it can blow
	if (bDetonate)
		ExplodeFire(Location, vect(0,0,1));
	else if (bDamaged)
		Detonate();
	

	if (LifeSpan < 3 && Trail != None)
	{
		AmbientSound = None;
		Emitter(Trail).Kill();
		Trail = None;
	}
}


// Call this to make it go BOOM...
simulated function Detonate()
{
	bDetonate = true;
	SetTimer(0.01+0.1*FRand(), false);
}

simulated function Tick(float DT)
{
	super.Tick(DT);

	// It's time to blow
	if (bDetonate && Level.NetMode == NM_Client)
		Explode(Location, vect(0,0,1));
}


function InitPineapple(float PSpeed, float PDelay)
{
	Speed = PSpeed;
	DetonateDelay = PDelay;
	NewSpeed = Speed;
	NewDetonateDelay = DetonateDelay;

	if (DetonateDelay <= 0)
		DetonateDelay = 0.05;
	if (DetonateDelay <= StartDelay)
		StartDelay = DetonateDelay / 2;
}

defaultproperties
{
     ShotDamageType=Class'BWBP_SKC_Pro.DTG28Explode'
     Health=20
     DetonateDelay=2.000000
     ImpactDamage=3
     ImpactDamageType=Class'BWBP_SKC_Pro.DTG28Grenade'
     ImpactManager=Class'BWBP_SKC_Pro.IM_G28Explode'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BWBP_SKC_Pro.G28Spray'
     TrailOffset=(Z=8.000000)
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTG28Gas'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Damage=120.000000
     DamageRadius=300.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTG28Grenade'
     ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BWBP_SKC_Static.G28.G28Proj'
     SoundVolume=192
     SoundRadius=128.000000
}
