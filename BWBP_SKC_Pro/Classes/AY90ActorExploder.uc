//=============================================================================
// AY90ActorExploder.
//
// An explosive effect. This is spawned on server to do damage and on
// client for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90ActorExploder extends BallisticEmitter
	placeable;

var   Actor						Victim;					// The guy who's stuck
var() class<DamageType>			DamageType;				// DamageType done to player
var() class<DamageType>			MyRadiusDamageType;		// DamageType done to people near the player
var() class<BCImpactManager>    ImpactManager;			// Impact manager to spawn on final hit
var() int						Damage;					// Damage done to surrounding players
var() int						StickDamage;			// Damage done to stuck player
var() int						DamageRadius;	
var()	bool						bDetonated;			// Been detonated, waiting for net syncronization or something
var()	bool					bExploded;
var() Sound						ArmingSound;
var Controller	InstigatorController;
var() ProjectileEffectParams.ERadiusFallOffType        RadiusFallOffType;

replication
{
	reliable if(Role == ROLE_Authority)
		bDetonated;
	reliable if (Role == ROLE_Authority)
		Victim;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (Role < Role_Authority && Victim != None)
		Initialize(Victim);
}

function PreBeginPlay()
{
	super.PreBeginPlay();
	Instigator = Pawn(Owner);
	if (Instigator != None)
		InstigatorController = Instigator.Controller;
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();
	if (bDetonated)
		Explode(Location, vector(Rotation));
}

function Reset()
{
	Destroy();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(1, true);

	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);
	
	if (Role==ROLE_Authority)
	{
		PlaySound(ArmingSound,,2.0,,256,,);
	}
}

simulated event Timer()
{
	if (Role < ROLE_Authority)
		return;
	else
	{
		bDetonated = true;
		
		if (Victim != None && Level.NetMode != NM_Client)
		{
			if ( Instigator == None || Instigator.Controller == None )
				Victim.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt (Victim, StickDamage, Instigator, Location, vect(0,0,0), DamageType);
		}
		
		Explode(Location, vector(Rotation));
		Kill();
	}
}

simulated event Tick(float DT)
{
	Super.Tick(DT);
	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (level.netMode == NM_DedicatedServer)
		Destroy();
	if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Kill();
	}
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;

	if(DamageRadius > 0)
	{
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, 10000, HitLocation, Victim);
	}

	MakeNoise(1.0);
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	//if (ShakeRadius > 0 || MotionBlurRadius > 0)
	//	ShakeView(HitLocation);
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		/*if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);*/
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
		GotoState('NetTrapped');
	else
		Destroy();
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
    local bool can_see;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( Victims.bCanBeDamaged && (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim )
		{
            can_see = FastTrace(Victims.Location, Location);

            damageScale = 1f;

            dir = Victims.Location;
            if (Victims.Location.Z > HitLocation.Z)
                dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
            else 
                dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
            dir -= HitLocation;
            dist = FMax(1, VSize(dir));
            dir /= dist;

            if (can_see)
            {
                if (RadiusFallOffType != RFO_None)
                    damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius) / DamageRadius);
                if (RadiusFallOffType == RFO_Quadratic)
                    damageScale = Square(damageScale);
            }

			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );

			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				damageScale * dir,
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

defaultproperties
{
     ArmingSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-Fuse'
     DamageType=Class'BWBP_SKC_Pro.DTAY90Skrith'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTAY90Skrith'
     ImpactManager=Class'BWBP_SKC_Pro.IM_SkrithbowSticky'
     StickDamage=150
     Damage=150
     DamageRadius=256.000000
     RadiusFallOffType=RFO_Quadratic
     AutoDestroy=True
     bNoDelete=False
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
	 
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.400000
         FadeOutStartTime=1.300000
         FadeInEndTime=1.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=9.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.AY90ActorExploder.SpriteEmitter0'
	 
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255))
         ColorScale(1)=(RelativeTime=1.000000)
         FadeInEndTime=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=40
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=7.000000,Max=7.000000))
         ParticlesPerSecond=4.000000
         Texture=Texture'AW-2004Particles.Energy.AirBlast'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.AY90ActorExploder.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.750000,Color=(B=255))
         ColorScale(2)=(RelativeTime=1.000000)
         Opacity=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=40
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=17.000000,Max=17.000000))
         ParticlesPerSecond=4.000000
         Texture=Texture'AW-2004Particles.Energy.EclipseCircle'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.AY90ActorExploder.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         UniformSize=True
         Acceleration=(Z=-1500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.920000
         MaxParticles=10
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=25.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         Texture=Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         LifetimeRange=(Min=0.401000,Max=0.401000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.AY90ActorExploder.SpriteEmitter5'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=192
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     bDynamicLight=True
     RemoteRole=ROLE_SimulatedProxy
}
