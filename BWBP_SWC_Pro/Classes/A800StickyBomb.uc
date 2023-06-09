//=============================================================================
// A800StickyBomb.
//
// A plasma grenade that attaches to walls and stuff
// Explodes after a second so your foes can realize what they've gotten into
//
// by Sarge
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A800StickyBomb extends BallisticProjectile;

var   bool				bDetonated;		// Been detonated, waiting for net syncronization or something
var	bool				bLightSpawned;

var() Sound				ArmingSound;
var   A800StickyBombLight			MineEffect;			//scary run away!
var int StuckDamage;
var() class<DamageType>	MyStuckDamageType;
var() class<DamageType>	MyStuckRadiusDamageType;

replication
{
	reliable if(Role == ROLE_Authority)
		bDetonated, bLightSpawned;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		MineEffect = SpawnMineLight();
		MineEffect.SetBase(self);
		bLightSpawned=true;
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
	if (MineEffect == None && bLightSpawned != default.bLightSpawned)
	{
		MineEffect = SpawnMineLight();
		MineEffect.SetBase(self);
	}	
}

simulated function A800StickyBombLight SpawnMineLight()
{
	local Vector X, Y, Z;
	local A800StickyBombLight ML;
	
	GetAxes(Rotation, X, Y, Z);
	ML = Spawn(class'A800StickyBombLight',self,,Location - (X * 16), Rotation);
	return ML;
}

simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role==ROLE_Authority)
	{
		SetTimer(1.00, false);
	}
	PlaySound(ArmingSound,,2.0,,128,,);
}

simulated function Timer()
{
	if (StartDelay > 0)
	{
		super.Timer();
		return;
	}
	else if (Role == ROLE_Authority)
	{
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
	if (DamageRadius > 0)
	{
		if (Pawn(Base) != None)
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

simulated function Destroyed()
{

	if (MineEffect != None)
		MineEffect.Destroy();
	super.Destroyed();
}

function bool IsStationary()
{
	return true;
}

defaultproperties
{
	WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
	ModeIndex=1
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
	LightHue=200
	LightSaturation=5
	LightBrightness=500.000000
	LightRadius=2.000000
	bDynamicLight=True
}
