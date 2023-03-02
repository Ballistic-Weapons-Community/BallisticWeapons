//=============================================================================
// JunkProjectile.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkProjectile extends BallisticGrenade;

enum EPImpactType
{
	IT_Explode,
	IT_Bounce,
	IT_Stick
};
var   class<JunkObject>		JunkClass;
var   JunkThrowFireInfo		FireInfo;
var() EPImpactType			WallImpactType;
var() EPImpactType			ActorImpactType;
var	  bool					bStuckInWall;
var() class<BCImpactManager>	ExplodeManager;
var() int					ImpactSoundThreshold;
var() int					ImpactEffectThreshold;
var() Rotator				StickRotation;
var() bool					bHitPlayer;
var() bool					bGotJunkClass;
var() bool					bDoServerInit;
var   float					NextEffectTime;
var() float					EffectInterval;
var() bool					bBounceDamageScaling;
var() float					StuckLifeSpan;
var   JunkProjTrigger		MyUseTrigger;

replication
{
	reliable if (Role == ROLE_Authority)
		JunkClass;
}

simulated event PostNetReceive()
{
	if (JunkClass != default.JunkClass && !bGotJunkClass)
	{
		InitJunkClass(JunkClass);
		bGotJunkClass=true;
	}
	super.PostNetReceive();
}

simulated function InitJunkClass(class<JunkObject> JC)
{
	JunkClass = JC;
//	if (Role < ROLE_Authority)
		InitJunkFire(JunkClass.default.ThrowFireInfo);
	if (Role == ROLE_Authority)
	{
		bDoServerInit=true;
		SetTimer(0.05, false);
	}
}

simulated function InitJunkFire (JunkThrowFireInfo FI)
{
	if (FI != None)
	{
		FireInfo 		=	FI;
		SetStaticMesh(		FI.ProjMesh);
		Speed 			= 	FI.ProjSpeed;
		Mass 			=	FI.ProjMass;
		SetDrawScale(		FI.ProjScale);
		TrailClass		=	FI.TrailClass;
		WallImpactType	=	EPImpactType(FI.WallImpactType);
		ActorImpactType	=	EPImpactType(FI.ActorImpactType);
		StickRotation	=	FI.StickRotation;
		DampenFactor	=	FI.DampenFactor;
		DampenFactorParallel = FI.DampenFactorParallel;
		if (Role < ROLE_Authority)
			RotationRate	=	FI.SpinRates;
//							FI.BounceImpactManager;
		ImpactManager	=	FI.ImpactManager;
		ExplodeManager	=	FI.ExplodeManager;
		//FIXME: Use decent IM splash...
		SplashManager	=	FI.ImpactManager;
		DetonateDelay	=	FI.DetonateTimer;
		ImpactDamage	=	FI.Damage.Misc;
		DamageRadius	=	FI.DamageRadius;
		bAlignToVelocity=	FI.bAlignToVelocity;
		Damage		=	FI.Damage.Misc;
		ImpactDamageType=	FI.DamageType;
		MyDamageType	=	FI.DamageType;
		MyRadiusDamageType=	FI.DamageType;
		MomentumTransfer=	FI.KickForce;
	}
	if (JunkClass != None)
		JunkClass.static.InitProjectile(self);
	if (Role==ROLE_Authority)
		InitProjectile();
}

simulated function InitProjectile ()
{
	InitEffects();
//	if (Role == ROLE_Authority)
//	{
		Velocity = Speed * Vector(VelocityDir);
		if (RandomSpin != 0 && !bNoInitialSpin)
			RandSpin(RandomSpin);
		if (DetonateDelay > 0)
			SetTimer(DetonateDelay, false);
//	}
}

simulated event Timer()
{
	if (bDoServerInit && FireInfo != None)
	{
		bDoServerInit = false;
		RotationRate	= FireInfo.SpinRates;
		return;
	}
	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		return;
	}
	HitActor = None;
	Explode(Location, vect(0,0,1));
}

simulated function PostBeginPlay()
{
	super(BallisticProjectile).PostBeginPlay();
	VelocityDir = Rotation;
}

simulated function PostNetBeginPlay()
{
//    local Rotator R;

/*	Velocity = Vector(Rotation);
    Acceleration = Velocity * AccelSpeed;
    Velocity *= Speed;

	if (bRandomStartRotaion)
	{
	    R = Rotation;
		R.Roll = Rand(65536);
		SetRotation(R);
	}
	if (StartDelay > 0)
	{
		SetPhysics(PHYS_None);
		bHidden=true;
		SetTimer(StartDelay, false);
		bDynamicLight=false;
		return;
	}
*/
	if (level.NetMode == NM_Client)
		InitProjectile();

	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
}

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	if (bStuckInWall)
	{
		if (Pawn(Other) != None)
			GiveTo(Pawn(Other));
		return;
	}
	if (Other == Instigator && !bCanHitOwner)
		return;
	if (Base != None)
		return;

	if (!bHitPlayer && Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (ActorImpactType == IT_Bounce)
		HitWall( Normal(HitLocation - Other.Location), Other );
	else if (ActorImpactType == IT_Stick)
	{
		if (bHitPlayer)
			return;
//		if (Role == ROLE_Authority)
//			DoDamage(Other, HitLocation);
		bHitPlayer = true;
		SetLocation(HitLocation);
		Velocity = Normal(HitLocation-Other.Location)*100;
	}
	else if (ActorImpactType == IT_Explode)
	{
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float SpeedFactor, Dmg;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (bUsePositionalDamage)
		Other = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);
	else
	{
		Dmg = Damage;
		DT = MyDamageType;
	}
	if (bHasImpacted && bBounceDamageScaling && FireInfo != None)
	{
		SpeedFactor = VSize(Velocity) / FireInfo.ProjSpeed;
		Dmg *= SpeedFactor;
		MomentumTransfer *= SpeedFactor;
	}
	class'BallisticDamageType'.static.GenericHurt (Other, Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);
}

function UsedBy( Pawn user )
{
	GiveTo(User);
}

function GiveTo(Pawn Other)
{
	local JunkWeapon newWeapon;
	local junkObject JO;

	if (!bStuckInWall || !Other.bCanPickupInventory)
		return;

    newWeapon = JunkWeapon(Other.FindInventoryType(class'JunkWeapon'));
    if (newWeapon == None)
    {
        newWeapon = Spawn(class'JunkWeapon',,,Other.Location);
        if( newWeapon != None )
            newWeapon.GiveTo(Other);
    }
	if (newWeapon != None)
	{
		JO = NewWeapon.FindJunkOfClass(JunkClass);
		if (JO != None && JO.Ammo >= JO.MaxAmmo)
			return;
	    newWeapon.GiveJunk(JunkClass, 1);
		if (PlayerController(Other.Controller) != None)
			PlayerController(Other.Controller).ClientPlaySound(JunkClass.default.PickupSound);
	}
	Destroy();
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;
	local int Surf;

	if (JunkClass.static.HandleHitWall(self, HitNormal, Wall))
		return;

	if (WallImpactType == IT_Explode)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (WallImpactType == IT_Stick)
	{
		if (bStuckInWall || (Wall != None && !Wall.bWorldGeometry && !Wall.bStatic && Mover(Wall) == None))
			return;
		SetRotation(Rotator(Velocity)+StickRotation);
		SetPhysics(PHYS_None);
		bStuckInWall=true;
		bHardAttach=true;
		LifeSpan=StuckLifeSpan;
		bFixedRotationDir=false;
		if (Wall != None)
			SetBase(Wall);
		if (Level.NetMode != NM_DedicatedServer && ImpactManager != None && EffectIsRelevant(Location,false))
		{
			CheckSurface(Location, HitNormal, Surf, Wall);
			ImpactManager.static.StartSpawn(Location, HitNormal, Surf, self);
		}
		if (FireInfo.bCanBePickedUp && level.NetMode != NM_Client)
		{
			OnlyAffectPawns(true);
			SetCollisionSize(40, 40);
			MyUseTrigger = Spawn(class'JunkProjTrigger',self ,, Location);
		}
		else
			Setcollision(false,false,false);
		return;
	}
//	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
//		SetTimer(DetonateDelay, false);
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.5;
		DampenFactorParallel *= 0.5;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	Speed = VSize(Velocity);

	if (Speed < 30)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		LifeSpan=StuckLifeSpan;
		if (Trail != None && !TrailWhenStill)
			DestroyEffects();
		if (FireInfo.bCanBePickedUp)
		{
			bStuckInWall=true;
			OnlyAffectPawns(true);
			SetCollisionSize(40, 40);
			SetRotation(Rotator(HitNormal)+StickRotation);
		}
	}
//	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	if (Speed > ImpactSoundThreshold && EffectIsRelevant(Location,false) && ImpactManager != None && level.TimeSeconds >= NextEffectTime)
	{
		CheckSurface(Location, HitNormal, Surf, Wall);
		if (Speed >= ImpactEffectThreshold)
			ImpactManager.static.StartSpawn(Location, HitNormal, Surf, self);
		else
			ImpactManager.static.StartSpawn(Location, HitNormal, Surf, self, 5 /*HF_NoEffects + HF_NoDecals*/);
		NextEffectTime = level.TimeSeconds + EffectInterval;
    }
}

simulated function BlowUp(vector HitLocation)
{
	TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    if (ExplodeManager != None)
		ExplodeManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	Destroy();
}
simulated function Destroyed()
{
	if (MyUseTrigger != None)
		MyUseTrigger.Destroy();
	super.Destroyed();
}

defaultproperties
{
     ImpactSoundThreshold=100
     ImpactEffectThreshold=300
     EffectInterval=0.250000
     bBounceDamageScaling=True
     StuckLifeSpan=20.000000
     DetonateOn=DT_Impact
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=120
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkPipeCorner'
     TrailOffset=(X=-8.000000)
     bUsePositionalDamage=True
     SplashManager=Class'BWBP_JWC_Pro.IM_JunkPipeCorner'
     ShakeRadius=0.000000
     bWarnEnemy=False
     Speed=2000.000000
     Damage=20.000000
     MomentumTransfer=10000.000000
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.PipeCornerLD'
     bNetTemporary=False
     AmbientGlow=32
     bUnlit=False
     bNetNotify=True
}
