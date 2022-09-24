//=============================================================================
// BX5SpringMine.
//
// Mine base for launching spring mines. The projectile is spawned and remains
// inactive until launched. Trigger acotr is spawned to detect enemies and use
// events. Mine base has health which decreases when damaged and triggers when
// it runs out.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5SpringMine extends BallisticProjectile;

var   bool				bDetonated;		// Been detonated, waiting for net syncronization or something
var   BX5SpringProj		Proj;			// The projectile or actual mine
var   BX5SpringTrigger	MyUseTrigger;	// The trigger used to start off all the unpleasantness
var   int				Health;			// Distance from his glorious holiness, the source. Wait, thats not what this is...
var   float				TriggerStartTime;	// Time when trigger will be active

replication
{
	reliable if(Role == ROLE_Authority)
		Proj;
}

simulated function InitProjectile()
{
	local Actor TA;
	local Teleporter TB;

	super.InitProjectile();
	
	if (Role==ROLE_Authority)
	{
		MyUseTrigger = Spawn(class'BX5SpringTrigger',self ,, Location);
		Proj = Spawn(class'BX5SpringProj',self,,Location, Rotation);
		TriggerStartTime = level.TimeSeconds + 3.0;
		Proj.Instigator=Instigator;
	}

	if (Proj != None)
	{
		//If we're on a pickup base, spring off.
		foreach TouchingActors(class'Actor', TA)
		{
			if (xPickUpBase(TA) != None || Pickup(TA) != None)
			{
				Proj.bAntiLameMode=True;
			}
		}
			
		//No teleporter camping, die die die
		foreach VisibleActors(class'Teleporter', TB, 256)
		{
			Proj.bAntiLameMode=True;
			return;
		}
	}
}

simulated function Destroyed()
{
	if (MyUseTrigger != None)
		MyUseTrigger.Destroy();
	if (!bDetonated && Proj != None)
		Proj.Destroy();
	super.Destroyed();
}

function SteppedOn (Actor Other)
{
	if (Pawn(Other) == None || StartDelay > 0 || bDetonated)
		return;
	if (InstigatorController != None && Pawn(Other).Controller != InstigatorController && InstigatorController.SameTeamAs(Pawn(Other).Controller))
		return;
	if (Vehicle(Other)!=None && VSize(Other.Velocity) < 50)
		return;
	if (Pawn(Other).Health < 1 && VSize(Other.Velocity) < 200)
		return;
	if (level.TimeSeconds < TriggerStartTime || TriggerStartTime == 0)
		return;
	if (vSize(Other.Velocity) == 0)
		return;
	if (VSize(Other.Velocity) <= 170 && ( Pawn(Other).Controller == InstigatorController || Vector(Pawn(Other).GetViewRotation()) Dot Normal(Location - Other.Location) > 0.2 ) ) //FMin(160, Pawn(Other).GroundSpeed * Pawn(Other).CrouchedPct * 1.01)
		return;
	bDetonated = true;
	SetTimer(0.05, false);
	bTearOff=True;
}

simulated event Timer()
{
	if (StartDelay > 0)
		super.Timer();
	else
	{
		if (Proj != None)
		{
			PlaySound(Sound'BW_Core_WeaponSound.BX5.BX5-Jump',,1.0,,64,,);
			Proj.SpringOff();
			GoToState('FadeOut');
		}
	}
}

simulated event TornOff()
{
	if(Proj == None)
		return;
		
	PlaySound(Sound'BW_Core_WeaponSound.BX5.BX5-Jump',,1.0,,64,,);
	Proj.SpringOff();
	GoToState('FadeOut');
}

simulated function ProcessTouch (Actor Other, vector HitLocation);

simulated singular function HitWall(vector HitNormal, actor Wall);

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
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
	bDetonated = true;
	if (!Proj.bAntiLameMode && EventInstigator != None && proj != None)
	{
		Proj.Instigator = EventInstigator;
		Proj.InstigatorController = EventInstigator.Controller;
	}
	SetTimer(0.05+0.2*FRand(), false);
	bTearOff=True;
}

function TryUse(Pawn User)
{
	local Ammunition Ammo;
	local Weapon newWeapon;
	local int AmmoAmount;

	if (bDetonated)
		return;

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

simulated state FadeOut
{
	simulated function Tick(float DeltaTime)
	{
		SetDrawScale(FMax(0.01, DrawScale - Default.DrawScale * DeltaTime));
	}

	simulated function BeginState()
	{
		LifeSpan = 1.0;
	}

	function EndState()
	{
		SetDrawScale(Default.DrawScale);
	}
}

defaultproperties
{
     Health=30
     StartDelay=0.300000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.BX5.MineSBase2'
     CullDistance=2500.000000
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     DrawScale=0.200000
     bUnlit=False
     CollisionRadius=32.000000
     CollisionHeight=16.000000
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True
}
