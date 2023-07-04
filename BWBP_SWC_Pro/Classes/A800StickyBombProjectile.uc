//=============================================================================
// Skrith Bow Bolt Projectile.
//
// Ranged sticky bomb, attempts to seek nearby targets
//
// by Sarge, based on code by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A800StickyBombProjectile extends BallisticGrenade;

var   actor		Target;				// The actor we are trying to anihilate
var   vector	LastLoc;			// Place where target was last seen, used to guide the rocket
var() float		TurnRate;			// Rate of rotation towards target. Rotator units per seconds.
var() bool		bSeeking;			// Seeking mode on. Trying to get to our target point
var() float		LastSendTargetTime; // Time when a target location has been set, used for difference formula
var() float		SeekTime;			// Time before tracking stops and proj switches to falling

var() A800SkrithMinigun  Master;
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
//used to set falling gravity after a short delay
simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	//if (Master != None && Master.Target != None)
	//{
	//	SetProjTarget(Master.Target);
	//}
	SetTimer(SeekTime, false);
	if (FastTrace(Location + vector(rotation) * 3000, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Timer()
{
	SetPhysics(PHYS_Falling);
}

//===========================================================================
// Tracking Code
//===========================================================================
function SetProjTarget(Actor Targ)
{
	local vector HitLoc, HitNorm, Start, End;
	local Actor T;

	Target = Targ;
	if (Target != None)
		LastLoc = Target.Location;
	else
	{
 		Start = Instigator.Location + Instigator.EyePosition();
		End = Start + Vector(Instigator.GetViewRotation()) * 20000;
		T = Instigator.Trace(HitLoc, HitNorm, End, Start, true);
		if (T != None)
			LastLoc = HitLoc;
		else
			LastLoc = End;
	}
}

simulated event Tick(float DT)
{
	local vector V, X,Y,Z;
	local Rotator R, AxisDir;
	local float TurnNeeded;

	R.Roll = Rotation.Roll;
	SetRotation(Rotator(velocity)+R);
	
	// Hound our target
	if (Role == ROLE_Authority)
	{
		if (Target != None)
		{
			if(FastTrace(Location, Target.Location))
			{
				LastLoc = Target.Location;
				bSeeking=true;
			}
			else bSeeking = false; //break seek while target is out of sight
		}
	}
	
	if (bSeeking)  // Guide the projectile if the previous call returned a valid lock
	{
		V = LastLoc - Location;

		// Align velocity towards target, but limit how fast rocket can turn. Use a tricky units per second rate limit.
		X = Normal(Velocity);
		Y = Normal(V cross Velocity);
		Z = Normal(X cross Y);
		AxisDir = OrthoRotation(X,Y,Z);

		TurnNeeded = acos(Normal(V) Dot Normal(Velocity)) * (32768 / Pi);

		R.Pitch = FMin( TurnRate*DT, TurnNeeded );
		GetAxes(R,X,Y,Z);
		X = X >> AxisDir;
		Y = Y >> AxisDir;
		Z = Z >> AxisDir;
        R = OrthoRotation(X,Y,Z);
		Velocity = Normal(Vector(R)) * Speed;

		if (Normal(Velocity) Dot Normal (V) > 0.6 && VSize(V) < Speed * 0.1)
			bSeeking = false;
	}
	
}

//===========================================================================
// Sticky Bomb Code
//===========================================================================

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
		class'BallisticDamageType'.static.GenericHurt(Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
		Explode(HitLocation, Normal(HitLocation-Other.Location));
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
		Proj = Spawn (class'A800StickyBomb',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.bHardAttach = true;
		Proj.SetBase(LastTrace);
		Proj.SetRotation(R);
		Proj.Velocity = vect(0,0,0);
	}
	else
	{
		//StickActor(StuckActor);
		Proj = Spawn (class'A800StickyBomb',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.SetPhysics(PHYS_None);
		Proj.bHardAttach = true;
		//if (StuckActor != Instigator && StuckActor.DrawType == DT_Mesh)
		//	StuckActor.AttachToBone(Proj, StuckActor.GetClosestBone(LastHitLoc, Velocity, BoneDist));
		//else
			Proj.SetBase(StuckActor);
	}

	Destroy();
}

simulated function StickActor(Actor A)
{
	local AY90ActorExploder AE;

	AE = Spawn(class'AY90ActorExploder');
	AE.Instigator = Instigator;
	AE.Initialize(A);
}


defaultproperties
{
	WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
	ModeIndex=1
     TurnRate=12768.000000
	 SeekTime=0.5
    ArmedDetonateOn=DT_Impact
	ImpactManager=Class'BallisticProV55.IM_A73Projectile'
	bCheckHitSurface=True
	bRandomStartRotation=False
	TrailClass=Class'BallisticProV55.A73TrailEmitter'
	MyRadiusDamageType=Class'BWBP_SWC_Pro.DTA800SkrithRadius'
	ImpactDamageType=Class'BWBP_SWC_Pro.DTA800Skrith_BoltDirect'
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
	MyDamageType=Class'BWBP_SWC_Pro.DTA800Skrith'
	DamageTypeHead=Class'BWBP_SWC_Pro.DTA800Skrith_BoltDirect'
	DrawScale3D=(X=0.500000,Y=1.000000,Z=1.000000)
	DrawScale=0.500000
	Style=STY_Additive
	SoundVolume=255
	SoundRadius=75.000000
	bFixedRotationDir=True
	RotationRate=(Roll=12384)
	bNetTemporary=False
	bUpdateSimulatedPosition=True
}
