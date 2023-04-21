//=============================================================================
// LAWMineHvy.
//
// A giant missile that just happened to get stuck in a wall and is melting you.
//
// Will emit 5 damaging pulses that ignore walls. If shot or past 5 pulses,
// it will blow up. Detonation strength decays with each pulse.
// Classic version. Spawns different effects on destruction before pulse.
//
//
// by Sarge
// Coding help by Azarael
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class LAWMineHvy extends BallisticProjectile;

var   bool				bDetonated;		// Been detonated, waiting for net syncronization or something
var   bool				bDetonating;		// Been detonated, waiting for net syncronization or something
var() Sound				DetonateSound;
var     int				ShockRadius;
var		int				ShockDamage;

var() class<damageType>			MyShotDamageType;	// Damagetype to use when detonated by damage
var() class<BCImpactManager>		ImpactManager2;		// Impact manager to use for shockwaves
var	byte					TeamLightColor;


var   int				Health;			// Distance from his glorious holiness, the source. Wait, thats not what this is...
var   Emitter			TeamLight;		// A flare emitter to show the glowing core
var   float				TriggerStartTime;	// Time when trigger will be active
var   int				PulseNum;		// HOW MANY PULSES. WHAT DO THE NUMBERS MEAN?
var bool				bShot;			// you shot it
var bool				bPulse;
var bool				bOldPulse;

replication
{
	reliable if(Role == ROLE_Authority)
		bShot, bDetonated, bDetonating, bPulse, TeamLightColor;
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
		if (TeamLightColor == 0)
			TeamLight = Spawn(class'LAWSparkEmitterRed',self,,Location, Rotation);
		else TeamLight = Spawn(class'LAWSparkEmitter',self,,Location, Rotation);
		TeamLight.SetBase(self);
	}	
	if (bShot || bDetonated)
		Explode(Location, vector(Rotation));
	if (bPulse != bOldPulse)
	{
		bOldPulse = bPulse;
		ShockwaveExplode(Location, vector(Rotation));
	}
}


simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role==ROLE_Authority)
	{
		bDetonating = true;
		PlaySound(DetonateSound,,2.0,,256,,);
		SetTimer(1.25, false);
	}
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

	if (PulseNum < 5 && !bShot)
	{
		if (level.Netmode == NM_Standalone) //Standalone games just call the effect
		{
			ShockwaveExplode(Location, vector(Rotation));
		}
		else
		{
			Shockwave(Location);
			bPulse = !bPulse;
		}
	}
	else
	{
		//removed tearoff - use bTearOnExplode if you need it to tear off, but you shouldn't have to do that
		bDetonated = true;
		Explode(Location, vector(Rotation));
	}
}

simulated function ProcessTouch (Actor Other, vector HitLocation);
simulated singular function HitWall(vector HitNormal, actor Wall);

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (class<DTLAWPulse>(DamageType) != None)
		return;
	if (StartDelay > 0)
		return;
	if (bShot)
		return;
	Health-=Damage;
	if (Health > 0)
		return;
	bShot = true; //Here this applies only to damaged rockets

	SetTimer(0.1, false);
}


// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;

	if(DamageRadius > 0)
	{
		if (bShot && PulseNum == 0) //it's been shot, play custom death messages
			TargetedHurtRadius(Damage, DamageRadius, MyShotDamageType, MomentumTransfer, HitLocation);
		else if (bShot) //it's been shot, play custom death messages
			TargetedHurtRadius(Damage/PulseNum, DamageRadius/PulseNum, MyShotDamageType, MomentumTransfer, HitLocation);
		else //it ran out of power on its own
			TargetedHurtRadius(Damage/PulseNum, DamageRadius/PulseNum, MyRadiusDamageType, MomentumTransfer, HitLocation);
	}

	MakeNoise(1.0);
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
    	if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (bShot) //Shooting it will spawn the big explosion
			ImpactManager = class'IM_LAWSmall';
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

//	if (bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
//		bTearOff = true;
	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
		GotoState('NetTrapped');
	else
		Destroy();
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
	foreach RadiusActors( class 'Actor', A, ShockRadius, Location )
	{
		if (A.bCanBeDamaged)
		{
			class'BallisticDamageType'.static.Hurt(A, ShockDamage, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTLAWPulse');
		}
	}
	PulseNum++;
	SetTimer(3.1, false);

}

function bool IsStationary()
{
	return true;
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.LAWLauncher'
     DetonateSound=Sound'BWBP_SKC_Sounds.LAW.LAW-MineAlarm'
     Health=70
     ImpactManager=Class'BallisticProV55.IM_RPG'
     ImpactManager2=Class'BWBP_SKC_Pro.IM_LAWWave'
     StartDelay=0.300000
     MyShotDamageType=Class'BWBP_SKC_Pro.DTLAWShot'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTLAWMineDet'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=3000.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Damage=210.000000
     DamageRadius=2500.000000
	 ShockDamage=50
     ShockRadius=1600.000000 //1400
     MyDamageType=Class'BWBP_SKC_Pro.DTLAWMineDet'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LAW.LAWRocket'
     CullDistance=2500.000000
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     DrawScale=0.450000
     bUnlit=False
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bShot=False
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True
}
