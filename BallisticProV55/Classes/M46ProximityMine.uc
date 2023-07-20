//=============================================================================
// M46ProximityMine.
//
// A small proximity grenade/mine that blows up when players approach it.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46ProximityMine extends M46Mine;

var   bool						bDetonated;		// Been detonated, waiting for net syncronization or something
var   M46GrenadeTrigger	MyUseTrigger;		// The trigger used to start off all the unpleasantness
var   int							Health;				// Distance from his glorious holiness, the source. Wait, thats not what this is...
var   BX5TeamLight			TeamLight;			// A flare emitter to show team mates' mines
var   byte						TeamLightColor;
var	float 						MDamage, MDamageRadius; //
var   Pawn						Stepper, OriginalPlacer;
var   bool 						bAntiLameMode;	// Someone tried to lame with me


replication
{
	reliable if(Role == ROLE_Authority)
		bDetonated, TeamLightColor;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		if(!Level.Game.bTeamGame)
			return;
			
		if (Instigator == None || Instigator.Controller == None)
			return;
			
		TeamLightColor = Instigator.Controller.GetTeamNum();
			
		if (Level.NetMode != NM_DedicatedServer)
		{
			if (TeamLightColor == Level.GetLocalPlayerController().GetTeamNum())
			{
				TeamLight = SpawnTeamLight();
				if (Instigator.Controller == Level.GetLocalPlayerController())
					TeamLight.SetTeamColor(2);
				else TeamLight.SetTeamColor(TeamLightColor);
				TeamLight.SetBase(self);
			}
		}		
	}
}

function SetManualMode(bool bManual)
{
	bManualMode = bManual;
	if (bManual)
	{
		MyRadiusDamageType = class'DTM46Manual';
		Damage = MDamage;
		DamageRadius = MDamageRadius;
	}
	else
	{
		MyRadiusDamageType = default.MyRadiusDamageType;
		Damage = default.Damage;
		DamageRadius= default.DamageRadius;
	}
}

simulated function BX5TeamLight SpawnTeamLight()
{
	local Vector X, Y, Z;
	local BX5TeamLight TL;
	
	GetAxes(Rotation, X, Y, Z);
	TL = Spawn(class'BX5TeamLight',self,,Location - (X * 16), Rotation);
	return TL;
}

simulated event PostNetReceive()
{
	if (TeamLightColor != default.TeamLightColor)
	{
		if (TeamLightColor == Level.GetLocalPlayerController().GetTeamNum() || class'BallisticReplicationInfo'.default.bUniversalMineLights)
		{
			TeamLight = SpawnTeamLight();
			if (Instigator.Controller == Level.GetLocalPlayerController())
				TeamLight.SetTeamColor(2);
			else TeamLight.SetTeamColor(TeamLightColor);
			TeamLight.SetBase(self);
		}
	}	
}

function SteppedOn (Actor Other)
{
	if ( Pawn(Other) == None || StartDelay > 0 || bManualMode || bDetonated )
		return;
	if (InstigatorController != None && Pawn(Other).Controller != InstigatorController && InstigatorController.SameTeamAs(Pawn(Other).Controller))
		return;
	if (Vehicle(Other)!=None && VSize(Other.Velocity) < 50)
		return;
	if (Pawn(Other).Health < 1 && VSize(Other.Velocity) < 190)
		return;
	if (level.TimeSeconds < TriggerStartTime || TriggerStartTime == 0)
		return;
	if (vSize(Other.Velocity) == 0)
		return;
	if (VSize(Other.Velocity) <= 190 && ( Pawn(Other).Controller == InstigatorController || Vector(Pawn(Other).GetViewRotation()) Dot Normal(Location - Other.Location) > 0.2 ) )
		return;
	if(Role == ROLE_Authority)
	{
		Stepper = Pawn(Other);
		PlaySound(DetonateSound,,2.0,,256,,);
		SetTimer(1.0, false);
		bDetonated=True;
	}
}

function OwnerDied()
{
    Destroy();
}

simulated function InitProjectile()
{
	local Actor TA;
	local Teleporter TB;
	
	super.InitProjectile();

	if(Role == ROLE_Authority)
	{
		MyUseTrigger = Spawn(class'M46GrenadeTrigger',self ,, Location);
		TriggerStartTime = level.TimeSeconds + 2.0;
		
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

simulated function Destroyed()
{
	if (MyUseTrigger != None)
		MyUseTrigger.Destroy();

	if (TeamLight != None)
		TeamLight.Destroy();
	super.Destroyed();
}

simulated event Timer()
{
	if (StartDelay > 0)
		super.Timer();
	else if (Role == ROLE_Authority)
		Explode(Location, vector(Rotation));
}

simulated singular function HitWall(vector HitNormal, actor Wall);

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (StartDelay > 0)
		return;
	if (bDetonated)
		return;
	Health-=Damage;
	if (Health > 0)
		return;
		
	PlaySound(DetonateSound,,2.0,,256,,);
	SetTimer(1, false);
	bDetonated=True;
}

function TryUse(Pawn User)
{
	local Ammunition Ammo;
	local int AmmoAmount;

	if (bDetonated)
		return;

	Ammo = Ammunition(User.FindInventoryType(class'Ammo_M46Grenades'));
	if(Ammo == None)
    {
		Ammo = Spawn(class'Ammo_M46Grenades');
		User.AddInventory(Ammo);
   	}
   	AmmoAmount = Ammo.AmmoAmount;
   	Ammo.UseAmmo(9999, true);

	Ammo.AddAmmo(AmmoAmount + 1);
	Ammo.GotoState('');
	Destroy();
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
	else if(DamageRadius > 0)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation);

	MakeNoise(1.0);
}

defaultproperties
{
     Health=20
     TeamLightColor=128
     mDamage=190.000000
     MDamageRadius=768.000000
     StartDelay=0.300000
     Damage=90.000000
     DamageRadius=384.000000
}
