//=============================================================================
// MARS-3 shockwave mine.
//=============================================================================
class F2000ShockwaveMine extends BallisticProjectile;

var() Sound			DetonateSound;
var	int					ShockRadius;

var() class<DamageType>			MyShotDamageType;	// Damagetype to use when detonated by damage
var() class<BCImpactManager>		ImpactManager2;		// Impact manager to spawn on final hit

var	int						Health;			// Distance from his glorious holiness, the source. Wait, thats not what this is...
var	Emitter				TeamLight;		// A flare emitter to show the glowing core
var	int						PulseNum;
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
		ShockwaveExplode(Location, vector(Rotation));
	}
}

simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role == ROLE_Authority)
	{
		PlaySound(DetonateSound,,2.0,,256,,);
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

	if (PulseNum < 3)
	{
		ShockwaveExplode(Location, vector(Rotation));
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
		Explode(Location, vector(Rotation));
}


// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;

	HurtRadius(Damage / (1 + PulseNum), EndDamageRadius, class'DTF2000MineExplode', MomentumTransfer, HitLocation);
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
			if (FastTrace(A.Location, Location))
				class'BallisticDamageType'.static.Hurt(A, 25, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTF2000Pulse');
			else class'BallisticDamageType'.static.Hurt(A, 10, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTF2000Pulse');
	}
	PulseNum++;
	SetTimer(1.5, false);

}

function bool IsStationary()
{
	return true;
}

defaultproperties
{
     DetonateSound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_GrenadeBeep'
     ShockRadius=896
     MyShotDamageType=Class'BWBPRecolorsPro.DTLAWShot'
     ImpactManager2=Class'BWBPRecolorsPro.IM_F2000Wave'
     Health=40
     EndDamageRadius=256.000000
     TeamLightColor=128
     ActivationDelay=2.000000
     ImpactManager=Class'BWBPRecolorsPro.IM_PumaDet'
     StartDelay=0.300000
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTF2000MineExplode'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1000.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=1.500000
     MotionBlurTime=3.000000
     Damage=110.000000
     DamageRadius=512.000000
     MyDamageType=Class'BWBPRecolorsPro.DTLAWMineDet'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade'
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
