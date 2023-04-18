//=============================================================================
// MARSMine_Sensor
// A pulsing radar that pings nearby pawns, adds them to scope view
//
// Will emit 1 radar ping, not as strong as G51 sensor
//
// by SK and Aza
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class MARSMine_Sensor extends BallisticProjectile;

var() Sound			DetonateSound;
var() Sound			PingSound;
var() Sound			PingDirectSound;
var	int					SensorRadius;

var() class<DamageType>			MyShotDamageType;	// Damagetype to use when you get pulsed
var() class<DamageType>			MyPulseDamageType;	// Damagetype to use when detonated by damage
var() class<BCImpactManager>		ImpactManager2;		// Impact manager to spawn on final hit

var	int						Health;			// dont hurt the poor sonar
var	Emitter				TeamLight;		// A flare emitter to show the glowing core
var	byte					PulseNum;		// 
var byte					MaxPulseNum;
var	bool					bPulse, bOldPulse;
var	float					EndDamageRadius;
var	byte					TeamLightColor;
var	float					ActivationDelay;

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
			TeamLightColor = 0;
			if (Level.NetMode != NM_DedicatedServer)
				TeamLight = Spawn(class'LAWSparkEmitterRed',self,,Location, Rotation);
		}
		
		else 
		{
			TeamLightColor = 1;
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
	if (bPulse != bOldPulse)
	{
		bOldPulse = bPulse;
		EmitPulse(Location, vector(Rotation));
	}
}

simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role == ROLE_Authority)
	{
		PlaySound(DetonateSound,,0.3,,256,,);
		SetTimer(ActivationDelay, false);
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

	if (PulseNum < MaxPulseNum)
	{
		EmitPulse(Location, vector(Rotation));
		bPulse = !bPulse;
	}
	else Explode(Location, vector(Rotation));
}

simulated function ProcessTouch (Actor Other, vector HitLocation);
simulated singular function HitWall(vector HitNormal, actor Wall);

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (EventInstigator != Instigator && EventInstigator.Controller != None && EventInstigator.Controller.SameTeamAs(InstigatorController))
		return;
	if (StartDelay > 0)
		return;
	Health -= Damage;
	if (Health <= 0)
	{
		Explode(Location, vector(Rotation));
	}
}


// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
		
	MakeNoise(1.0);
}

// Do shockwave effects and run Shockwave.
simulated function EmitPulse(vector HitLocation, vector HitNormal)
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
	Ping(HitLocation);

}

// Search for players
function Ping(vector HitLocation)
{
	local Actor A;
	
	if (Role < ROLE_Authority || Instigator == None || Instigator.Controller == None)
		return;
	
	foreach CollidingActors( class 'Actor', A, SensorRadius, Location )
	{
		if (A.bCanBeDamaged && A != self && (A != Instigator && A != Owner) && !(Level.Game.bTeamGame && Instigator.Controller.SameTeamAs(Pawn(A).Controller)))
		{
			if (FastTrace(A.Location, Location))
			{
				A.PlaySound(PingDirectSound,,2.0,,768,,);
				if (Owner != None && Pawn(A) != None)
					MARSAssaultRifle(Owner).AddTarget(Pawn(A));
			}
			else 
			{
				A.PlaySound(PingSound,,2.0,,768,,);
				if (Owner != None && Pawn(A) != None)
					MARSAssaultRifle(Owner).AddTarget(Pawn(A));
			}
		}
	}
	PulseNum++;
	SetTimer(2.0, false);

}

function bool IsStationary()
{
	return true;
}

defaultproperties
{
	 WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     ModeIndex=1
	 MaxPulseNum=2
     DetonateSound=Sound'BWBP_SKC_Sounds.MARS.MARS-MineAlarm'
	 PingSound=Sound'GeneralAmbience.beep6'
	 PingDirectSound=Sound'GeneralAmbience.beep7'
     SensorRadius=768
     MyShotDamageType=Class'BWBP_SKC_Pro.DT_MARSMineShot'
     MyPulseDamageType=Class'BWBP_SKC_Pro.DT_MARSMinePulse'
     ImpactManager2=Class'BWBP_SKC_Pro.IM_RadarWave' //Ping fx
     Health=40
     EndDamageRadius=256.000000
     TeamLightColor=128
     ActivationDelay=2.000000
     ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornShatter'
     StartDelay=0.300000
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_MARSMineDet'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=16.000000
     MotionBlurRadius=16.000000
     MotionBlurFactor=1.500000
     MotionBlurTime=3.000000
     Damage=0.000000
     DamageRadius=256.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_MARSMineDet'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS3Grenade'
     DrawScale=0.500000
     CullDistance=2500.000000
     bNetTemporary=False
     bAlwaysRelevant=True
     Physics=PHYS_None
     LifeSpan=0.000000
     bUnlit=False
     CollisionRadius=24.000000
     CollisionHeight=24.000000
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True
}
