//=============================================================================
// rocket.
//=============================================================================
class GBU57Projectile extends AirstrikeProjectile;

var	NewTracer SmokeTrail;
var	ONSPowerNodeNeutral PowerNode;

// camera shakes //
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view
var Vector DeformLocation;

var class<Emitter> ExplosionEffectClass;

var byte Team;

replication
{
	reliable if (bTearOff && Role == ROLE_Authority)
		DeformLocation;
}

simulated function Destroyed()
{
	if ( SmokeTrail != None )
		SmokeTrail.Destroy();
		PowerNode.PowerCoreDestroyed();
	Super.Destroyed();
}

function BeginPlay()
{
	Super.BeginPlay();

	if (Instigator != None)
		Team = Instigator.GetTeamNum();
	SetTimer(0.5, true);
}

simulated function PostBeginPlay()
{
	local vector Dir;

	if ( bDeleteMe || IsInState('Dying') )
		return;

	Dir = vector(Rotation);
	Velocity = speed * Dir;

	if ( Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrail = Spawn(class'NewTracer',self,,Location - 40 * Dir, Rotation);
		SmokeTrail.SetBase(self);
	}

	Super.PostBeginPlay();
}

event bool EncroachingOn( actor Other )
{
	if ( Other.bWorldGeometry )
		return true;

	return false;
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( Other != instigator )
		Explode(HitLocation,Vect(0,0,1));
}

simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
}

simulated function Landed( vector HitNormal )
{
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
}

simulated event FellOutOfWorld(eKillZType KillType)
{
	BlowUp(Location);
}

function ShakeView()
{
    local Controller C;
    local PlayerController PC;
    local float Dist, Scale;

    for ( C=Level.ControllerList; C!=None; C=C.NextController )
    {
        PC = PlayerController(C);
        if ( PC != None && PC.ViewTarget != None )
        {
            Dist = VSize(Location - PC.ViewTarget.Location);
            if ( Dist < DamageRadius * 2.0)
            {
                if (Dist < DamageRadius)
                    Scale = 1.0;
                else
                    Scale = (DamageRadius*2.0 - Dist) / (DamageRadius);
                C.ShakeView(ShakeRotMag*Scale, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*Scale, ShakeOffsetRate, ShakeOffsetTime);
            }
        }
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Emitter E;
	
	if (Role == ROLE_Authority)
	{
    	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, Location + vect(0,0,256));
    	ShakeView();
    }
    
    PlaySound(sound'WeaponSounds.Redeemer_explosionsound');

    E = Spawn(ExplosionEffectClass,,, HitLocation - 100 * Normal(Velocity), Rot(0,16384,0));
	Spawn(class'GBU38Dirt',,,HitLocation + HitNormal*16, rotator(HitNormal) + rot(-16384,0,0));
	if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
		Spawn(ExplosionDecal,self,,Location + vect(0,0,256), rotator(-HitNormal));
			

	MakeNoise(1.0);
	Destroy();
}

function Timer()
{
	local Controller C;

	//Enemies who don't have anything else to shoot at will try to shoot WiCNuke down
	for (C = Level.ControllerList; C != None; C = C.NextController)
		if ( AIController(C) != None && C.Pawn != None && C.GetTeamNum() != Team && AIController(C).Skill >= 2.0
		     && !C.Pawn.IsFiring() && (C.Enemy == None || !C.LineOfSightTo(C.Enemy)) && C.Pawn.CanAttack(self) )
		{
			C.Focus = self;
			C.FireWeaponAt(self);
		}
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local Pawn Victims;
	local float damageScale, dist;
	local vector dir;

	if ( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Pawn', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') )
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if (!FastTrace(Victims.Location, Location))
				DamageScale *= 0.5;
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			Victims.TakeDamage
			(
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

		}
	}

	bHurtEntry = false;
}

defaultproperties
{
     ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
     ExplosionEffectClass=Class'BWBPAirstrikesPro.GBU57Explosion'
     Team=255
     Speed=2000.000000
     Damage=500.000000
     DamageRadius=1536.000000
     MomentumTransfer=1.000000
     MyDamageType=Class'BWBPAirstrikesPro.DamTypeGBU57'
     ExplosionDecal=Class'BWBPAirstrikesPro.GBU57BlastMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
     LightRadius=6.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.RedeemerMissile'
     bDynamicLight=True
     bNetTemporary=False
     AmbientSound=Sound'WeaponSounds.Misc.redeemer_flight'
     LifeSpan=50.000000
     DrawScale=0.750000
     AmbientGlow=96
     bUnlit=False
     SoundVolume=255
     SoundRadius=100.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=5000.000000
     CollisionRadius=24.000000
     CollisionHeight=12.000000
     bProjTarget=True
     bNetNotify=True
     bFixedRotationDir=True
     RotationRate=(Roll=50000)
     DesiredRotation=(Roll=30000)
     ForceType=FT_DragAlong
     ForceRadius=100.000000
     ForceScale=5.000000
}
