class LAWMine extends BallisticProjectile;

var() Sound			DetonateSound;
var     int				ShockRadius;

var() class<DamageType>			MyShotDamageType;	// Damagetype to use when detonated by damage
var() class<BCImpactManager>		ImpactManager2;		// Impact manager to spawn on final hit

var   int							Health;			// Distance from his glorious holiness, the source. Wait, thats not what this is...
var   LAWSparkEmitter		TeamLight;		// A flare emitter to show the glowing core
var   int							PulseNum;
var bool							bPulse, bOldPulse;
var bool							bShot;

replication
{
	reliable if(Role == ROLE_Authority)
		bPulse;
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();
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
		SetTimer(1.25, false);
	}
	if (level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		TeamLight = Spawn(class'LAWSparkEmitter',self,,Location, Rotation);
		TeamLight.SetBase(self);
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
			ImpactManager2.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
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
				class'BallisticDamageType'.static.Hurt(A, 75.0, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTLAWPulse');
			else 	class'BallisticDamageType'.static.Hurt(A, 40.0, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTLAWPulse');

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
     DetonateSound=Sound'BallisticSounds_25.OA-AR.OA-AR_GrenadeBeep'
     ShockRadius=1024
     MyShotDamageType=Class'BWBPRecolorsPro.DTLAWShot'
     ImpactManager2=Class'BWBPRecolorsPro.IM_LAWWave'
     Health=250
     ImpactManager=Class'BallisticProV55.IM_RPG'
     StartDelay=0.300000
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTLAWMineDet'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=2000.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Damage=210.000000
     DamageRadius=1536.000000
     MyDamageType=Class'BWBPRecolorsPro.DTLAWMineDet'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWRocket'
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
