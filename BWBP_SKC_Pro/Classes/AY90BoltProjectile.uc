//=============================================================================
// Skrith Bow Bolt Projectile.
//
// Ranged sticky bomb
//
// by Sarge, based on code by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90BoltProjectile extends BallisticGrenade;
var() Sound FlySound;

var Actor StuckActor;
var bool bPlaced;

simulated function PreBeginPlay()
{
    local BallisticWeapon BW;
    Super(Projectile).PreBeginPlay();

    if (Instigator == None)
        return;

    BW = BallisticWeapon(Instigator.Weapon);

    if (BW == None)
        return;

    BW.default.ParamsClasses[BW.GameStyleIndex].static.OverrideProjectileParams(self, 0);
}

simulated event ProcessTouch(Actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Base != None)
		return;

	if(Pawn(Other) != None)
	{
		StuckActor = Other;
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		class'BallisticDamageType'.static.GenericHurt(Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
	}
	else
		Super.ProcessTouch(Other,HitLocation);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	if(Pawn(Wall) != None)
		StuckActor = Wall;
	Explode(Location, HitNormal);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Actor 	LastTrace;
	local Vector	Start, End, LastHitLoc, LastHitNorm;
	local Rotator R;
	local Projectile Proj;
	local float BoneDist;

	if(bPlaced)
		return;

	bPlaced = true;
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController());
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if(Role != ROLE_Authority)
	{
		Destroy();
		Return;
	}

	// Check for wall
	if(StuckActor == None)
	{
		Start = HitLocation - (Normal(Velocity) *16.0);
		End = Start + (Normal(Velocity) * 128);
		LastTrace = Trace(LastHitLoc, LastHitNorm, End, Start, false);
		if (LastTrace == None || (!LastTrace.bWorldGeometry && Mover(LastTrace) == None))
			return;

		if (LastTrace == None)
			return;

		LastHitLoc += (5.0 * LastHitNorm);
		LastHitNorm = -LastHitNorm;
	}
	else
	{
		R = Rotation;
		LastHitLoc = Location;
		LastHitNorm = Normal(Velocity);
	}
	R = Rotator(LastHitNorm);
	R.Roll = Rand(65536);
	if(StuckActor == None)
	{
		Proj = Spawn (class'AY90Mine',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.bHardAttach = true;
		Proj.SetBase(LastTrace);
	}
	else
	{
		StickActor(StuckActor);
		/*Proj = Spawn (class'AY90Mine',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.SetPhysics(PHYS_None);
		Proj.bHardAttach = true;
		if (StuckActor != Instigator && StuckActor.DrawType == DT_Mesh)
			StuckActor.AttachToBone(Proj, StuckActor.GetClosestBone(LastHitLoc, Velocity, BoneDist));
		else
			Proj.SetBase(StuckActor);
			*/
	}
	Proj.SetRotation(R);
	Proj.Velocity = vect(0,0,0);

	Destroy();
}

simulated function StickActor(Actor A)
{
	local AY90ActorExploder AE;

	AE = Spawn(class'AY90ActorExploder');
	AE.Instigator = Instigator;
	AE.Initialize(A);
}

//used to set falling gravity after a short delay
simulated function PostBeginPlay()
{
	SetTimer(0.30, false);
	super.PostBeginPlay();
	if (FastTrace(Location + vector(rotation) * 3000, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Tick(float DT)
{
	local Rotator R;

	R.Roll = Rotation.Roll;
	SetRotation(Rotator(velocity)+R);
}

simulated event Timer()
{
	SetPhysics(PHYS_Falling);
}


defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_A73Projectile'
     bCheckHitSurface=True
     bRandomStartRotation=False
     TrailClass=Class'BallisticProV55.A73TrailEmitter'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTAY90SkrithRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1024.000000
     MotionBlurRadius=200.000000
     Speed=2000.000000
     AccelSpeed=35000.000000
     MaxSpeed=35000.000000
	 DetonateDelay=0.00000
     ImpactDamage=30.000000
     DamageRadius=30.000000
     MomentumTransfer=30000.000000
	 LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=150
     LightSaturation=0
     LightBrightness=192.000000
     LightRadius=6.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73Projectile'
	 Skins(1)=FinalBlend'BWBP_SKC_Tex.SkrithBow.AY90ProjectileFast1-Final'
     Skins(0)=FinalBlend'BWBP_SKC_Tex.A73b.AY90Projectile2-Final'
     bDynamicLight=True
     AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
     LifeSpan=6.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTAY90Skrith'
	 DamageTypeHead=Class'BWBP_SKC_Pro.DTAY90SkrithHead'
     DrawScale3D=(X=0.500000,Y=1.000000,Z=1.000000)
     DrawScale=0.500000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bFixedRotationDir=True
     RotationRate=(Roll=12384)
}
