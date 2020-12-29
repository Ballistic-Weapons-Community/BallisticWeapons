//=============================================================================
// X3Projectile.
//
// A thrown X3 Knife
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X3Projectile extends BallisticProjectile;

var   bool			bStuckInWall;
var   bool			bHitPlayer;


simulated function InitProjectile ()
{
	SetTimer(0.1, false);
	super.InitProjectile();
}
simulated event Timer()
{
	super.Timer();
	bFixedRotationDir = True;
	RotationRate.Pitch = -100000;
}

simulated function bool CanTouch(Actor Other)
{
    if (bHitPlayer)
		return false;
    
    return Super.CanTouch(Other);
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None)
		return;

	if (bStuckInWall)
	{
		if (Pawn(Other) != None)
			TakeBack(Pawn(Other));
		return;
	}

	if (!CanTouch(Other))
		return;

	if (Role == ROLE_Authority)
		DoDamage(Other, HitLocation);
	bHitPlayer = true;

	SetLocation(HitLocation);
	Velocity = Normal(HitLocation-Other.Location)*100;
}

function TakeBack(Pawn Other)
{
	local Ammunition Ammo;
	local Weapon newWeapon;
	local int AmmoAmount;

	if (!bStuckInWall || !Other.bCanPickupInventory)
		return;

	Ammo = Ammunition(Other.FindInventoryType(class'Ammo_Knife'));
	if(Ammo == None)
    {
		Ammo = Spawn(class'Ammo_Knife');
		Other.AddInventory(Ammo);
   	}
   	AmmoAmount = Ammo.AmmoAmount;
   	Ammo.UseAmmo(9999, true);

    if(Other.FindInventoryType(class'X3Knife')==None)
    {
        newWeapon = Spawn(class'X3Knife',,,Other.Location);
        if( newWeapon != None )
        {
            newWeapon.GiveTo(Other);
			newWeapon.ConsumeAmmo(0, 9999, true);
        }
    }
/*	Ammo = Ammunition(Other.FindInventoryType(class'Ammo_Knife'));
	if(Ammo == None)
    {
		Ammo = Spawn(class'Ammo_Knife');
		Other.AddInventory(Ammo);
   	}
*/	Ammo.AddAmmo(AmmoAmount + 1);
	Ammo.GotoState('');
	if (PlayerController(Other.Controller) != None)
		PlayerController(Other.Controller).ClientPlaySound(class'X3Pickup'.default.PickupSound);
	Destroy();
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, None );
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local int Surf;
	if (bStuckInWall)
		return;
	if (Wall != None && !Wall.bWorldGeometry && !Wall.bStatic)
	{
		if (Role == ROLE_Authority && !bHitPlayer)
			DoDamage(Wall, Location);
		if (Mover(Wall) == None)
		{
			bHitPlayer = true;
			Velocity = HitNormal*100;
			return;
		}
	}
	SetRotation(Rotator(Velocity)/*+rot(32768,0,0)*/);
	OnlyAffectPawns(true);
	SetCollisionSize(40, 40);
	SetPhysics(PHYS_None);
	bFixedRotationDir=false;
	bStuckInWall=true;
	bHardAttach=true;
	CheckSurface(Location, HitNormal, Surf, Wall);
	LifeSpan=20.0;
	if (Wall != None)
		SetBase(Wall);
	if (Level.NetMode != NM_DedicatedServer && ImpactManager != None && /*(!Level.bDropDetail) && (Level.DetailMode != DM_Low) && */EffectIsRelevant(Location,false))
		ImpactManager.static.StartSpawn(Location, HitNormal, Surf, self);
}
function UsedBy(Pawn User)
{
	TakeBack(User);
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_KnifeThrown'
     bRandomStartRotaion=False
     bUsePositionalDamage=True
     
     
     DamageTypeHead=Class'BallisticProV55.DTX3KnifeThrownHead'
     bWarnEnemy=False
     Speed=3000.000000
     Damage=40.000000
     MyDamageType=Class'BallisticProV55.DTX3KnifeThrown'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.X3.X3PickupHi'
     bNetTemporary=False
     Physics=PHYS_Falling
     LifeSpan=0.000000
     DrawScale=0.150000
     bUnlit=False
}
