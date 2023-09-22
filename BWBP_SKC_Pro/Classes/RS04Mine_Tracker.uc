//=============================================================================
// RS04Mine_Tracker
// A pulsing radar that pings nearby pawns.
//
// Will emit several beeps over a course of time, and will flash.
// Can be destroyed
//
// by SK and Aza
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04Mine_Tracker extends BallisticProjectile;

var() Sound						ArmingSound;
var() Sound						PingSound;
var() Sound						PingDirectSound;
var() float						PingSoundRadius;
var	int							SensorRadius;

var() class<DamageType>			MyShotDamageType;	// Damagetype to use when you get pulsed
var() class<DamageType>			MyPulseDamageType;	// Damagetype to use when detonated by damage
var() class<BCImpactManager>	ImpactManager2;		// Impact manager to spawn on final hit

var	int							Health;			// dont hurt the poor sonar
var	Emitter						TeamLight;		// A flare emitter to show the glowing core
var	byte						PulseNum;		// 
var byte						MaxPulseNum;
var	bool						bPulse, bOldPulse;
var	float						EndDamageRadius;
var	byte						TeamLightColor;
var	float						ActivationDelay;

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
				TeamLight = Spawn(class'MARSSparkEmitterRed',self,,Location, Rotation);
		}
		
		else 
		{
			TeamLightColor = 1;
			if (Level.NetMode != NM_DedicatedServer)
				TeamLight = Spawn(class'MARSSparkEmitter',self,,Location, Rotation);
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
			TeamLight = Spawn(class'MARSSparkEmitterRed',self,,Location, Rotation);
		else TeamLight = Spawn(class'MARSSparkEmitter',self,,Location, Rotation);
		TeamLight.SetBase(self);
	}
}

simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role == ROLE_Authority)
	{
		SetTimer(ActivationDelay, false);
	}
	PlaySound(ArmingSound,,0.3,,256,,);
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
		Ping();
		bPulse = !bPulse;
	}
	else Explode(Location, vector(Rotation));
}

// Make a sound
function Ping()
{
	if (bExploded)
		return;
	PlaySound(PingDirectSound, , 6.0, , PingSoundRadius);
	PulseNum++;
	SetTimer(2.0, false);
}

simulated function ProcessTouch (Actor Other, vector HitLocation);
simulated singular function HitWall(vector HitNormal, actor Wall);

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (EventInstigator != Instigator && EventInstigator.Controller != None && EventInstigator.Controller.SameTeamAs(InstigatorController))
		return;
	if (EventInstigator == Base)
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

function bool IsStationary()
{
	return true;
}

defaultproperties
{
	 WeaponClass=Class'BWBP_SKC_Pro.RS04Pistol'
     ModeIndex=1
	 MaxPulseNum=5
     ArmingSound=Sound'BWBP_SKC_Sounds.MARS.MARS-MineAlarm'
	 PingSound=Sound'GeneralAmbience.beep7'
	 PingDirectSound=Sound'GeneralAmbience.beep6'
	 PingSoundRadius=256 // PlaySound mechanics - see UDN
     MyShotDamageType=Class'BWBP_SKC_Pro.DT_MARSMineShot'
     MyPulseDamageType=Class'BWBP_SKC_Pro.DT_MARSMinePulse'
     Health=200
     EndDamageRadius=256.000000
     TeamLightColor=128
     ActivationDelay=2.000000
     ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornShatter'
     StartDelay=0.300000
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_MARSMineDet'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1000.000000
     MotionBlurRadius=384.000000
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
