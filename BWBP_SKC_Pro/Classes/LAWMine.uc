//=============================================================================
// LAWMine.
//
// A giant missile that just happened to get stuck in a wall and is melting you.
//
// Will emit 5 damaging pulses that ignore walls. If shot or past 5 pulses,
// it will blow up. Detonation strength decays with each pulse.
//
// by Sarge and Azarael
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class LAWMine extends BallisticProjectile;

var() 	Sound					ArmingSound;
var     int						ShockRadius;
var		float					WallDecayFactor;

var() class<DamageType>			MyShotDamageType;	// Damagetype to use when detonated by damage
var() class<BCImpactManager>	ImpactManager2;		// Impact manager to spawn on final hit

var   int						Health;			// Distance from his glorious holiness, the source. Wait, thats not what this is...
var   Emitter					TeamLight;		// A flare emitter to show the glowing core
var   int						PulseNum;
var bool						bPulse, bOldPulse;
var bool						bShot;
var	byte						TeamLightColor;

replication
{
	reliable if(Role == ROLE_Authority)
		bPulse, TeamLightColor;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		if (Level.Game.bTeamGame && Instigator != None && Instigator.GetTeamNum() == 0)
		{
			TeamLightColor = 1;
			if (Level.NetMode != NM_DedicatedServer)
				TeamLight = Spawn(class'LAWSparkEmitterRed',self,,Location, Rotation);
		}
		
		else 
		{
			TeamLightColor = 0;
			if (Level.NetMode != NM_DedicatedServer)
				TeamLight = Spawn(class'LAWSparkEmitter',self,,Location, Rotation);
		}
		TeamLight.SetBase(self);	
	}
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();
	if (TeamLight == None && TeamLightColor != default.TeamLightColor)
	{
		if (TeamLightColor == 1)
			TeamLight = Spawn(class'LAWSparkEmitterRed',self,,Location, Rotation);
		else TeamLight = Spawn(class'LAWSparkEmitter',self,,Location, Rotation);
		TeamLight.SetBase(self);
	}	
	if (bPulse != bOldPulse)
	{
		bOldPulse = bPulse;
		ShockwaveExplode(Location, vector(Rotation));
	}
}

simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role == ROLE_Authority)
	{
		SetTimer(1.25, false);
	}
	PlaySound(ArmingSound,,2.0,,256,,);
}

simulated function Destroyed()
{
	if (TeamLight != None)
		TeamLight.Destroy();
	super.Destroyed();
}

simulated function Timer()
{
	if (StartDelay > 0)
	{
		super.Timer();
		return;
	}

	if (Role < ROLE_Authority)
		return;

	if (PulseNum < 5)
	{
		ShockwaveExplode(Location, vector(Rotation));
		bPulse = !bPulse;
	}
	else	Explode(Location, vector(Rotation));
}

simulated function ProcessTouch (Actor Other, vector HitLocation);
simulated singular function HitWall(vector HitNormal, actor Wall);

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (StartDelay > 0)
		return;
	Health -= Damage;
	if (Health <= 0)
	{
		bShot = True;
		Explode(Location, vector(Rotation));
	}
}


// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;

	if(DamageRadius > 0)
	{
		if (bShot) //it's been shot, play custom death messages
			HurtRadius(Damage/(1+PulseNum), DamageRadius/(1+PulseNum), MyShotDamageType, MomentumTransfer, HitLocation);
		else //it ran out of power on its own
			HurtRadius(Damage/(1+PulseNum), DamageRadius/(1+PulseNum), MyRadiusDamageType, MomentumTransfer, HitLocation);
	}

	MakeNoise(1.0);
}

// Do shockwave effects and run Shockwave.
simulated function ShockwaveExplode(vector HitLocation, vector HitNormal)
{
	local int Surf;

	if (bExploded)
		return;

	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);

    	if (ImpactManager2 != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager2.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager2.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator, TeamLightColor);
	}
	Shockwave(HitLocation);

}

// Do shockwave damage
function Shockwave(vector HitLocation)
{
	local Actor A;
	
	if (Role < ROLE_Authority)
		return;

	foreach CollidingActors( class 'Actor', A, ShockRadius, Location )
	{
		if (A != Self && A.bCanBeDamaged)
		{
			if ( Instigator == None || Instigator.Controller == None )
				A.SetDelayedDamageInstigatorController( InstigatorController );
				
			if (FastTrace(A.Location, Location))
				class'BallisticDamageType'.static.Hurt(A, Damage, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTLAWPulse');
			else if (VSize(A.Location - Location) < ShockRadius / 2)
				class'BallisticDamageType'.static.Hurt(A, Damage * WallDecayFactor, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTLAWPulse');
		}

	}
	PulseNum++;
	SetTimer(2, false);

}

function bool IsStationary()
{
	return true;
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.LAWLauncher'
	ModeIndex=1
    ArmingSound=Sound'BWBP_SKC_Sounds.LAW.LAW-MineAlarm'
	ShockRadius=1536
	MyShotDamageType=Class'BWBP_SKC_Pro.DTLAWShot'
	ImpactManager2=Class'BWBP_SKC_Pro.IM_LAWWave'
	Health=300
	ImpactManager=Class'BallisticProV55.IM_RPG'
	StartDelay=0.300000
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTLAWMineDet'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=2000.000000
	MotionBlurRadius=384.000000
	MotionBlurFactor=3.000000
	MotionBlurTime=4.000000
	Damage=75.000000
	WallDecayFactor=0.35
	DamageRadius=0.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTLAWMineDet'
	StaticMesh=StaticMesh'BWBP_SKC_Static.LAW.LAWRocket'
	bNetTemporary=False
	Physics=PHYS_None
	LifeSpan=0.000000
	DrawScale=0.450000
	bUnlit=False
	CollisionRadius=16.000000
	CollisionHeight=44.000000
	bCollideWorld=False
	bProjTarget=True
	bNetNotify=True
}
