//=============================================================================
// A42Projectile.
//
// Simple projectile for da A42.
//
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42Projectile extends BallisticProjectile;

var() float		BoltLength;			// How long the mesh is: half of it is behind the projectile
var() float		MuzzleBlendTime;	// How long it takes from the third person muzzle onto its own path
var   bool		bFromMuzzle;		// Drawn coming out of the third person muzzle for now
var   vector	StartLocation;		// Where it started
var   vector	MuzzleSide;			// From its path to the muzzle of the third person weapon, across the path
var   float		MuzzleAhead;		// and along the path
var   float		MuzzleTime;			// When it started

// The projectile starts beside the shooter's eye, where his aim needs it, and its mesh is a long bolt with the projectile in the
// middle. In first person that is fine, the back half is behind the view. Whoever sees his third person model saw the bolt stick
// through his head, well behind and above the muzzle. For them it is drawn coming out of that muzzle: no further back than
// the muzzle while it is still getting past it, and moved over from the muzzle onto its path over the first moment of flight.
// Only the drawing changes (scale, PrePivot and the trail), the projectile is where it always was.
simulated function InitFromMuzzle()
{
	local BallisticAttachment Att;
	local vector Tip, Offset, X;
	local float BestDist;
	local int i;

	if (Level.NetMode == NM_DedicatedServer || Instigator == None || Instigator.IsFirstPerson())
		return;

	// The gun this came from (there may be two), if it is on screen and the projectile has not left it behind already
	BestDist = 64;
	for (i = 0; i < Instigator.Attached.Length; i++)
	{
		Att = BallisticAttachment(Instigator.Attached[i]);
		if (Att == None || Att.WeaponClass != WeaponClass || Level.TimeSeconds - Att.LastRenderTime > 0.5)
			continue;
		Tip = Att.GetBoneCoords(Att.FlashBone).Origin;
		if (VSize(Tip - Location) < BestDist)
		{
			BestDist = VSize(Tip - Location);
			Offset = Tip - Location;
			bFromMuzzle = true;
		}
	}
	if (!bFromMuzzle)
		return;

	X = vector(Rotation);
	StartLocation = Location;
	MuzzleAhead = Offset dot X;
	MuzzleSide = Offset - X * MuzzleAhead;
	MuzzleTime = Level.TimeSeconds;
}

// Where the bolt is drawn this tick, Ahead being how far the projectile will have flown
simulated function DrawFromMuzzle(float Ahead)
{
	local vector X, Offset, Scale3D;
	local float Back, Front, Alpha;

	// The back end stays at the muzzle until the bolt is out of it
	Front = Ahead + 0.5 * BoltLength;
	Back = FMax(Ahead - 0.5 * BoltLength, MuzzleAhead);
	Front = FMax(Front, Back + 1);
	Alpha = FClamp(1.0 - (Level.TimeSeconds - MuzzleTime) / MuzzleBlendTime, 0, 1);
	if (Alpha == 0 && Front - Back >= BoltLength)
		bFromMuzzle = false;

	X = vector(Rotation);
	Scale3D = default.DrawScale3D;
	Scale3D.X *= (Front - Back) / BoltLength;
	SetDrawScale3D(Scale3D);

	Offset = (MuzzleSide * Alpha + X * (0.5 * (Front + Back) - Ahead)) << Rotation;
	if (Trail != None)
		Trail.SetRelativeLocation(TrailOffset + Offset);
	Offset.X /= DrawScale * Scale3D.X;
	Offset.Y /= DrawScale * Scale3D.Y;
	Offset.Z /= DrawScale * Scale3D.Z;
	PrePivot = default.PrePivot - Offset;
}

simulated function Tick(float DT)
{
	Super.Tick(DT);

	// this runs before the move of this tick
	if (bFromMuzzle)
		DrawFromMuzzle((Location + (Velocity + Acceleration * DT) * DT - StartLocation) dot vector(Rotation));
	else
		Disable('Tick');
}

// A42 heals vehicles and PowerCores
simulated function DoDamage(Actor Other, vector HitLocation)
{
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	if (Instigator != None)
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
	}

	HealObjective = DestroyableObjective(Other);
	if ( HealObjective == None )
		HealObjective = DestroyableObjective(Other.Owner);
	if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
	{
		HealObjective.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}
	HealVehicle = Vehicle(Other);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		HealVehicle.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}
	super.DoDamage(Other, HitLocation);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local byte Flags;

	if (bExploded)
		return;
	if ( HitActor != None && (Vehicle(HitActor)!=None || DestroyableObjective(HitActor)!=None || DestroyableObjective(HitActor.Owner)!=None) && HitActor.TeamLink(Instigator.GetTeamNum()) )
	{
	}
	else if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (HitActor != None && (Vehicle(HitActor)!=None || DestroyableObjective(HitActor)!=None || DestroyableObjective(HitActor.Owner)!=None))
			Flags=4;//No Decals
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/, Flags);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator, Flags);
	}
	BlowUp(HitLocation);
	bExploded=true;

	Destroy();
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && Instigator!= None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
		BlowUp(Location + ExploWallOut * HitNormal);

		Destroy();
	}
	else
		Super.HitWall(HitNormal, Wall);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (level.DetailMode > DM_Low && level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}

	InitFromMuzzle();
	if (bFromMuzzle)
		DrawFromMuzzle(0);
}

simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
		{
			Emitter(Trail).Emitters[0].Disabled=true;
			Emitter(Trail).Kill();
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
    BoltLength=125.000000
    MuzzleBlendTime=0.100000
    WeaponClass=Class'BallisticProV55.A42SkrithPistol'
    ImpactManager=Class'BallisticProV55.IM_A42Projectile'
    PenetrateManager=Class'BallisticProV55.IM_A42Projectile'
    bPenetrate=True
    TrailClass=Class'BallisticProV55.A42TrailEmitter'
    MyRadiusDamageType=Class'BallisticProV55.DTA42Skrith'
    bUsePositionalDamage=True
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    MyDamageType=Class'BallisticProV55.DTA42Skrith'
    LightType=LT_Steady
    LightEffect=LE_QuadraticNonIncidence
    LightHue=180
    LightSaturation=100
    LightBrightness=192.000000
    LightRadius=6.000000
    StaticMesh=StaticMesh'BW_Core_WeaponStatic.A42.A42Projectile'
    bDynamicLight=True
    AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
    LifeSpan=4.000000
    DrawScale3D=(Y=0.500000,Z=0.500000)
    SoundVolume=255
    SoundRadius=75.000000
    bFixedRotationDir=True
    RotationRate=(Roll=16384)
}
