//=============================================================================
// BX5VehicleMine.
//
// Simple mine with high damage, small radius and a high, narrow trigger, good
// for vehicles.
//
// Azarael tweak: Lit for both teams, fixed light code, explodes when torn off
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5VehicleMine extends BallisticProjectile;

var   bool					bDetonated;			//
var() class<DamageType> 	VehicleDamageType;	// Damage type when it hurts a vehicle
var() float					HRadius;			// Horizontal limitation of damage radius
var() int					Health;				// Distance from death
var   BX5VehicleTrigger		MyUseTrigger;		// da trigger dat triggas dis mine
var   BX5TeamLight			TeamLight;			// A flare emitter to show team mates' mines
var   float					TriggerStartTime;	// Time when trigger will be active
var   Pawn					Stepper, OriginalPlacer;
var   byte					TeamLightColor;
var   bool 					bAntiLameMode;	// Someone tried to lame with me

replication
{
	reliable if (Role == ROLE_Authority)
		TeamLightColor;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		if (Instigator != None)
			TeamLightColor = Instigator.Controller.GetTeamNum();

		else TeamLightColor = 255;
		
		if (Level.NetMode != NM_DedicatedServer)
		{
			if (TeamLightColor == Level.GetLocalPlayerController().GetTeamNum() || class'BallisticReplicationInfo'.default.bUniversalMineLights)
			{
				TeamLight = Spawn(class'BX5TeamLight',self,,Location,Rotation);
				if (Instigator.Controller == Level.GetLocalPlayerController())
					TeamLight.SetTeamColor(2);
				else TeamLight.SetTeamColor(TeamLightColor);
				TeamLight.SetBase(self);
			}
		}	
	}
}

simulated event PostNetReceive()
{
	if (bDetonated)
		Explode(Location, vect(0,0,1));
		
	if (TeamLightColor != default.TeamLightColor)
	{
		if (TeamLightColor == Level.GetLocalPlayerController().GetTeamNum() || Level.GetLocalPlayerController().GetTeamNum() == 255 || class'BallisticReplicationInfo'.default.bUniversalMineLights)
		{
			TeamLight = Spawn(class'BX5TeamLight',self,,Location,Rotation);
			if (Instigator.Controller == Level.GetLocalPlayerController())
				TeamLight.SetTeamColor(2);
			else if (Level.GetLocalPlayerController().GetTeamNum() != 255 || class'BallisticReplicationInfo'.default.bUniversalMineLights)
				TeamLight.SetTeamColor(TeamLightColor);
			TeamLight.SetBase(self);
		}
	}		
}

simulated event TornOff()
{
	Explode(Location, Vector(Rotation));
}
	
simulated function InitProjectile ()
{
	local Actor TA;
	local Teleporter TB;
	
	super.InitProjectile();

	if (Role == ROLE_Authority)
	{
		MyUseTrigger = Spawn(class'BX5VehicleTrigger',self ,, Location);
		TriggerStartTime = level.TimeSeconds + 3.0;
		InstigatorController = Instigator.Controller;
		OriginalPlacer = Instigator;

		//Check for shit.
		foreach TouchingActors(class'Actor', TA)
		{
			if (xPickUpBase(TA) != None || Pickup(TA) != None)
			{
				bAntiLameMode = True;
				return;
			}
		}

		//No teleporter camping, die die die
		foreach RadiusActors(class'Teleporter', TB, 256)
		{
			bAntiLameMode=True;
			return;
		}
	}
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
		
	// Reverse damage if I was used to lame
	if(bAntiLameMode)
	{
		if(Stepper != None && OriginalPlacer != None)
		class'BallisticDamageType'.static.GenericHurt(OriginalPlacer, 666, Stepper, HitLocation, MomentumTransfer * vect(0,0,1), class'DT_TeleportLamer');
	}
	
	else if (DamageRadius > 0)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	MakeNoise(1.0);
}

function SteppedOn (Actor Other)
{
	//v2.1 tweak, you can stomp your own mine...
	if (Pawn(Other) == None || StartDelay > 0 || bDetonated || (InstigatorController != None && Pawn(Other).Controller != InstigatorController && InstigatorController.SameTeamAs(Pawn(Other).Controller)) || (Vehicle(Other)!=None && VSize(Other.Velocity) < 50) || (Pawn(Other).Health < 1 && VSize(Other.Velocity) < 50)/* || (Vehicle(Other) == None && (Pawn(Other) == Instigator || Pawn(Other).Controller == InstigatorController))*/)
		return;
	if (level.TimeSeconds < TriggerStartTime || TriggerStartTime == 0)
		return;
	if (vSize(Other.Velocity) == 0)
		return;
	if (VSize(Other.Velocity) <= 170 && ( Pawn(Other).Controller == InstigatorController || Vector(Pawn(Other).GetViewRotation()) Dot Normal(Location - Other.Location) > 0.2 ) ) //FMin(160, Pawn(Other).GroundSpeed * Pawn(Other).CrouchedPct * 1.01)
		return;
	Stepper = Pawn(Other);
	bTearOff = true;
	SetTimer(0.1, false);
}

simulated event Timer()
{
	if (StartDelay > 0)
		super.Timer();
	else
		Explode(Location, vector(Rotation));
}
simulated function ProcessTouch (Actor Other, vector HitLocation);

simulated singular function HitWall(vector HitNormal, actor Wall);

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (bDetonated)
		return;
	Health-=Damage;
	if (Health > 0)
		return;
	bDetonated = true;
	bTearOff = true;
	if (EventInstigator != None)
	{
		Instigator = EventInstigator;
		InstigatorController = EventInstigator.Controller;
	}
	SetTimer(0.1, false);
}

function TryUse(Pawn User)
{
	local Ammunition Ammo;
	local Weapon newWeapon;
	local int AmmoAmount;

	Ammo = Ammunition(User.FindInventoryType(class'Ammo_BX5Mines'));
	if(Ammo == None)
    {
		Ammo = Spawn(class'Ammo_BX5Mines');
		User.AddInventory(Ammo);
   	}
   	AmmoAmount = Ammo.AmmoAmount;
   	Ammo.UseAmmo(9999, true);

    if(User.FindInventoryType(class'BX5Mine')==None)
    {
        newWeapon = Spawn(class'BX5Mine',,,User.Location);
        if( newWeapon != None )
        {
            newWeapon.GiveTo(User);
			newWeapon.ConsumeAmmo(0, 9999, true);
        }
    }
	Ammo.AddAmmo(AmmoAmount + 1);
	Ammo.GotoState('');
	Destroy();
}

simulated function Destroyed()
{
	if (MyUseTrigger != None)
		MyUseTrigger.Destroy();
	if (TeamLight != None)
		TeamLight.Destroy();
	super.Destroyed();
}

// Useful if you want to spare a directly hit enemy from the radius damage
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	if (Stepper != None && Vehicle(Stepper) != None)
	{
		Victim = Stepper;

		DamageType = VehicleDamageType;

			dir = Stepper.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;

			if (normal(Stepper.Velocity) dot normal(Location - Stepper.Location) > 0.6)
				damageScale = 1.0;
			else
			{
				damageScale = FMax(1 - FMax(0,(dist - Stepper.CollisionRadius)/DamageRadius), 0.25);
			}

			if ( Instigator == None || Instigator.Controller == None )
				Stepper.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Stepper,
				Square(damageScale) * DamageAmount,
				Instigator,
				Stepper.Location - 0.5 * (Stepper.CollisionHeight + Stepper.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
	}

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && (Vehicle(Victims) != None || VSize(Victims.Location*vect(1,1,0) - HitLocation*(vect(1,1,0))) < HRadius))
		{
			if (Vehicle(Victims) != None)
				DamageType = VehicleDamageType;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;

			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			DamageType = MyRadiusDamageType;
		}
	}
	bHurtEntry = false;
}

defaultproperties
{
    WeaponClass=Class'BallisticProV55.BX5Mine'
     VehicleDamageType=Class'BallisticProV55.DTBX5VehicleRadius'
     HRadius=250.000000
     Health=30
     TeamLightColor=128
     ImpactManager=Class'BallisticProV55.IM_LandMine'
     StartDelay=0.300000
     MyRadiusDamageType=Class'BallisticProV55.DTBX5Radius'
     bTearOnExplode=False
     ShakeRadius=1200.000000
     Damage=100.000000
     DamageRadius=128.000000
     MomentumTransfer=90000.000000
     MyDamageType=Class'BallisticProV55.DTBX5Radius'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.BX5.MineV2'
     CullDistance=3000.000000
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     DrawScale=0.200000
     bUnlit=False
     CollisionRadius=26.000000
     CollisionHeight=16.000000
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True
}
