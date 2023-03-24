class CX85DartDirect extends BallisticProjectile;

var() Class<DamageType>	StuckDamageType;// Type of Damage caused for sticking to players
var() bool 							bNoFXOnExplode; //Do FX in Destroyed and not in Explode

var int 								TrackCount;
var bool								bIsMaster;
var array<CX85DartDirect>	Slaves;
var Pawn							Tracked;

replication
{
	reliable if (bNetOwner && Role == ROLE_Authority)
		TrackCount, Tracked;
	reliable if (bNetOwner && Role < ROLE_Authority)
		ServerNotifyReceived;
}

function SetMaster()
{
	bIsMaster=True;
	Tracked.bAlwaysRelevant = True;
	SetTimer(5, true);
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Instigator.IsLocallyControlled())
		ServerNotifyReceived();
}

function ServerNotifyReceived()
{
	if (Role == ROLE_Authority && CX85AssaultWeapon(Owner) != None)
		CX85AssaultWeapon(Owner).AddProjectile(self);
}

function Timer()
{
	if (!Tracked.bProjTarget || Tracked.Health < 1)
		Destroy();
}

event BaseChange()
{
	if (Base == None)
		Explode(Location, Vector(Rotation));
}

event GainedChild(Actor Proj)
{
	Slaves[Slaves.Length] = CX85DartDirect(Proj);
	TrackCount++;
}

event LostChild(Actor Proj)
{
	//Clean up the Slaves array if this happens?
	TrackCount--;
}

simulated function Destroyed()
{
	local int Surf;
	local int i;
	
	if (bNoFXOnExplode && !bNoFX)
    {
		if (EffectIsRelevant(Location,false) && ImpactManager != None && level.NetMode != NM_DedicatedServer)
		{
			if (bCheckHitSurface)
				CheckSurface(Location, -Vector(Rotation), Surf);
			if (Instigator == None)
				ImpactManager.static.StartSpawn(Location, -Vector(Rotation), Surf, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(Location, -Vector(Rotation), Surf, Instigator);
		}
	}
	
	if (bIsMaster)
	{
		for (i=0; i < Slaves.Length; i++)
		{
			if (Slaves[i] != None)
				Slaves[i].Explode(Slaves[i].Location, Vector(Slaves[i].Rotation));
		}
	
		//TODO: Search for other Master darts!
		if (Tracked != None)
			Tracked.bAlwaysRelevant=Tracked.default.bAlwaysRelevant;
	}
	
	Super.Destroyed();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
		
	if (!bNoFXOnExplode)
	{
   		if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
		{
			if (bCheckHitSurface)
				CheckSurface(HitLocation, HitNormal, Surf);
			if (Instigator == None)
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
		}
	}

	if (bIsMaster)
		BlowUp(HitLocation);
	bExploded = True;
	
	if (!bNetTemporary && bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
	{
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else Destroy();
}

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
				Damage * ((1 + Slaves.Length) ** 1.4),
				Instigator,
				HitLocation,
				MomentumTransfer * Normal(Base.Location-Location),
				MyDamageType
			);
			
			TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, Base);
		}
		else
			TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation);
	}
//	HitActor = None;
	MakeNoise(1.0);
}

simulated function ProcessTouch (Actor Other, vector HitLocation);

function bool IsStationary()
{
	return true;
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.CX85AssaultWeapon'
	 bApplyParams=False
     ModeIndex=1
     bNoFXOnExplode=True
     TrackCount=1
     ImpactManager=Class'BallisticProV55.IM_MRLRocket'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTCX85DartRadius'
     bTearOnExplode=False
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Damage=10.000000
     DamageRadius=384.000000
     MyDamageType=Class'BWBP_OP_Pro.DTCX85DartRadius'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart'
     CullDistance=2500.000000
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     DrawScale=0.450000
     bUnlit=False
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideActors=False
     bCollideWorld=False
     bBlockActors=False
     bProjTarget=True
     bNetNotify=True
}
