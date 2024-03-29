//=============================================================================
// MACShell.
//
// Powerful artillery projectile.
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACShell extends BallisticProjectile;

var() Sound FlySound;
var() float ShellTime;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(0.15, false);
	if (FastTrace(Location + vector(rotation) * 3000, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	DamageRadius=400;
    WallPenetrationForce=256;
}

simulated event Tick(float DT)
{
	local Rotator R;

	R.Roll = Rotation.Roll;
	SetRotation(Rotator(velocity)+R);
}

simulated function bool CanTouch(Actor Other)
{
    if (Vehicle(Instigator) != None && Other == Vehicle(Instigator).Driver)
		return false;

    return Super.CanTouch(Other);
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

    class'BallisticDamageType'.static.GenericHurt(Other, Damage + 75 * FMin(default.LifeSpan - LifeSpan, 0.4)/ 0.4, Instigator, HitLocation, (MomentumTransfer * Normal(Velocity)) + vect(0,0,250), MyDamageType);
}

// Returns true if point is in a solid, i.e. FastTrace() fails at the point
final function bool PointInSolid(vector V)
{	
    return !FastTrace(V, V+vect(1,1,1));		
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int 		Surf;
	local Material 	HitMaterial;
	
	local bool 		bNoSecondary;
	local Vector 	tHitNorm, tHitLoc;
	
	if (bExploded)
		return;
		
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
		
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		CheckSurface(HitLocation, HitNormal, Surf);
	
		Trace(tHitLoc, tHitNorm, HitLocation, HitLocation + (DamageRadius * SurfaceScale(Surf) * Normal(Velocity)), False, , HitMaterial);
		
		if (tHitLoc == vect(0,0,0) || PointInSolid(tHitLoc) || WallPenetrationForce < VSize(Location - HitLocation))
			bNoSecondary = True;
		
		if (Instigator == None)
		{
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
			if (!bNoSecondary)
				ImpactManager.static.StartSpawn(tHitLoc, tHitNorm, int(HitMaterial.SurfaceType), Level.GetLocalPlayerController()/*.Pawn*/);
		}
		else
		{
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
			if (!bNoSecondary)
				ImpactManager.static.StartSpawn(tHitLoc, tHitNorm, int(HitMaterial.SurfaceType), Level.GetLocalPlayerController()/*.Pawn*/);
		}
	}
	
	BlowUp(HitLocation);
	bExploded = True;
	
	if (!bNetTemporary && bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else 
		Destroy();
}

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Dmg = Damage + 50 * FMin(default.LifeSpan - LifeSpan, 0.4)/ 0.4;
	return Other;
}

defaultproperties
{   
    WeaponClass=Class'BallisticProV55.MACWeapon'
     bLimitMomentumZ=False
     FlySound=Sound'BW_Core_WeaponSound.Artillery.Art-FlyBy'
     ImpactManager=Class'BallisticProV55.IM_HAMR'
     bCheckHitSurface=True
     bRandomStartRotation=False
     TrailClass=Class'BallisticProV55.HAMRShellTrail'
     MyRadiusDamageType=Class'BallisticProV55.DT_MACRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=6.000000
     MotionBlurTime=8.000000
     WallPenetrationForce=128
     ShakeRotMag=(X=512.000000,Y=400.000000,Z=350.000000)
     ShakeRotRate=(X=7000.000000,Y=7000.000000,Z=5500.000000)
     ShakeRotTime=8.000000
     ShakeOffsetMag=(X=30.000000,Y=30.000000,Z=30.000000)
     ShakeOffsetRate=(X=600.000000,Y=600.000000,Z=600.000000)
     ShakeOffsetTime=10.000000
     Speed=9000.000000
     MaxSpeed=9000.000000
     Damage=160.000000
     DamageRadius=192.000000
     MomentumTransfer=70000.000000
     MyDamageType=Class'BallisticProV55.DT_MAC'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Artillery.Artillery-Projectile'
     Physics=PHYS_Falling
     DrawScale=0.300000
     SoundVolume=192
     SoundRadius=256.000000
     bFixedRotationDir=True
     bIgnoreTerminalVelocity=True
     RotationRate=(Roll=32768)
}
