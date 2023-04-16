//=============================================================================
// AY90Mine.
//
// A plasma grenade that attaches to walls and stuff
// Explodes after a second so your foes can realize what they've gotten into
//
// by Sarge
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90Mine extends BallisticProjectile;

var   bool				bDetonated;		// Been detonated, waiting for net syncronization or something
var() Sound				ArmingSound;
var   AY90MineLight			MineEffect;			//scary run away!
var int StuckDamage;
var() class<DamageType>	MyStuckDamageType;
var() class<DamageType>	MyStuckRadiusDamageType;

replication
{
	reliable if(Role == ROLE_Authority)
		bDetonated;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		MineEffect = Spawn(class'AY90MineLight',self,,Location,Rotation);
		MineEffect.SetBase(self);
	}
}

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

simulated event PostNetReceive()
{
	Super.PostNetReceive();
	if (bDetonated)
		Explode(Location, vector(Rotation));
}


simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role==ROLE_Authority)
	{
		PlaySound(ArmingSound,,2.0,,512,,);
		SetTimer(1.00, false);
	}

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
	else
	{
		//removed tearoff - use bTearOnExplode if you need it to tear off, but you shouldn't have to do that
		bDetonated = true;
		Explode(Location, vector(Rotation));
	}
}

simulated function ProcessTouch (Actor Other, vector HitLocation);
simulated singular function HitWall(vector HitNormal, actor Wall);


// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
	if(DamageRadius > 0)
	{
		if(Pawn(Base) != None)
		{
			class'BallisticDamageType'.static.GenericHurt
			(
				Base,
				StuckDamage,
				Instigator,
				HitLocation,
				MomentumTransfer * Normal(Base.Location-Location),
				MyStuckDamageType
			);
			
			TargetedHurtRadius(Damage, DamageRadius, MyStuckRadiusDamageType, MomentumTransfer, HitLocation, Base);
		}
		else
			TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation);
	}
//	HitActor = None;
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
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
	{
		GoToState('NetTrapped');
	}
	else
		Destroy();
}

function bool IsStationary()
{
	return true;
}

defaultproperties
{
	 WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
     ArmingSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-Fuse'
     ImpactManager=Class'BWBP_SKC_Pro.IM_SkrithbowSticky'
     StartDelay=0.300000
     MyStuckDamageType=Class'BWBP_SKC_Pro.DTAY90Skrith_BoltStuckExplode'
     MyStuckRadiusDamageType=Class'BWBP_SKC_Pro.DTAY90Skrith_BoltStuckExplodeRadius'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTAY90SkrithRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1000.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=1.500000
     MotionBlurTime=3.000000
     StuckDamage=180
     Damage=150
     DamageRadius=256.000000
     DrawScale=0.500000
     MyDamageType=Class'BWBP_SKC_Pro.DTAY90SkrithRadius'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
     CullDistance=2500.000000
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     bUnlit=False
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=192
     LightSaturation=200
     LightBrightness=200.000000
     LightRadius=15.000000
     bDynamicLight=True
}
