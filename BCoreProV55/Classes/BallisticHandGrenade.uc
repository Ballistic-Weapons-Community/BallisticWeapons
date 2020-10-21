//=============================================================================
// BallisticHandGrenade.
//
// A base class that implements all the functions of a standard hand grenade
// with pin pulling, clip releasing, hand exploding, etc...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticHandGrenade extends BallisticWeapon
	abstract;

var()	bool				bCookable;			// This grenade can be cooked off.
var   float				ClipReleaseTime;	//Time when clip was released
var() name				ClipReleaseAnim;	//Anim to play when clip is released

var() float				FuseDelay;			//How long the fuse lasts...
var() int				HeldDamage;			//Damage to do to player when it blows in hand
var() int				HeldRadius;			//Radius of hand explode
var() int				HeldMomentum;		//Momentum for hand explode
var() Class<DamageType>	HeldDamageType;		//Damage type for hand explode
var() Class<Emitter>	GrenadeSmokeClass;	//Type of effect for when clip is released
var   Emitter			GrenadeSmoke;		//The smoke effect
var() BUtil.FullSound	ClipReleaseSound;	//Sound to play when clip is released
var() BUtil.FullSound	PinPullSound;		//Sound to play for pin pull
var   float				HandExplodeTime;	//The time when it blew up
var() name				GrenadeBone;		//Bone of whole grenade. Used to hide grenade at the right time
var() name				PinBone;			//Bone of pin. Used to hide pin
var() name				ClipBone;			//Bone of clip. used to hid clip
var() name				SmokeBone;			//Bone to which fuse smoke should be attached
var() int				DamageThisCook, DropThreshold;		//This much total damage during a cook will force the drop of a cooked grenade

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	SetBoneScale (0, 1.0, GrenadeBone);
	SetBoneScale (1, 1.0, PinBone);
	SetBoneScale (2, 1.0, ClipBone);
}

simulated function bool PutDown()
{
	local BCGhostWeapon GW;
	if (ClipReleaseTime > 0)
		return false;
	if (Super.PutDown())
	{
		SetBoneScale (1, 1.0, PinBone);
		ClipReleaseTime=0.0;
		if (Ammo[0].AmmoAmount < 1)
		{
			// Save a ghost of this weapon so it can be brought back
			GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);
        	if(GW != None)
	        {
    	    	GW.MyWeaponClass = class;
				GW.GiveTo(Instigator);
			}
			Timer();
			PickupClass=None;
			DropFrom(Location);
			return true;
		}
		return true;
	}
	return false;
}

simulated function PlayIdle()
{
	super.PlayIdle();
	SetBoneScale (1, 0.0, PinBone);
}

simulated function Notify_GrenadeLeaveHand()
{
	SetBoneScale (0, 0.0, GrenadeBone);
	if (ClipReleaseTime > 0)
		ClipReleaseTime=-1.0;
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == ClipReleaseAnim)
		SetBoneScale (1, 0.0, PinBone);
	else if (Anim == FireMode[0].FireAnim || Anim == FireMode[1].FireAnim)
	{
		SetBoneScale (2, 1.0, ClipBone);
		SetBoneScale (1, 1.0, PinBone);
		SetBoneScale (0, 1.0, GrenadeBone);
		CheckNoGrenades();
	}
	else if (Anim == SelectAnim)
		PlayIdle();
	else
		Super.AnimEnd(Channel);
}

// This is called as soon as grenade explodes. Don't put anything in here that could kill the player.
simulated function DoExplosionEffects()
{
	BallisticGrenadeAttachment(ThirdPersonActor).HandExplode();
	if (level.NetMode == NM_Client)
		CheckNoGrenades();
}
// Anything that does damage for the explosion should happen here.
// This delayed to prevent player being killed before ammo stuff is sorted out.
function DoExplosion()
{
	if (Role == ROLE_Authority)
	{
		SpecialHurtRadius(HeldDamage, HeldRadius, HeldDamageType, HeldMomentum, Location);
		CheckNoGrenades();
	}
}

// Hurt radius that uses delayed damage and makes sure if instigator is hit, he'll go last
simulated function SpecialHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local bool bHitInstigator;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) )
		{
			if (Victims == Instigator && Instigator != None)
			{
				bHitInstigator=true;
				continue;
			}
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
		}
	}
	if (bHitInstigator)
	{
		Victims = Instigator;
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
	}
	bHurtEntry = false;
}

//FIXME: There's no NullGun support in the base class?
simulated function CheckNoGrenades()
{
	local Inventory Inv;
	local BCGhostWeapon GW;

	if (Ammo[0]!= None && ( Ammo[0].AmmoAmount < 1 || (Ammo[0].AmmoAmount == 1 && (BFireMode[0].ConsumedLoad > 0  || BFireMode[1].ConsumedLoad > 0)) ))
	{
		AIRating = -999;
		Priority = -999;

		// Save a ghost of this wepaon so it can be brought back
		if (Role == ROLE_Authority)
		{
			GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);
    	    if(GW != None)
        	{
        		GW.MyWeaponClass = class;
				GW.GiveTo(Instigator);
			}
		}

		if (Instigator != None)
		{
			if (PlayerController(Instigator.Controller) != None)
				Instigator.Controller.ClientSwitchToBestWeapon();
			else if (AIController(Instigator.Controller) != None)
			{
				for (Inv = Instigator.Inventory; Inv != None; Inv = Inv.Inventory)
					if (Weapon(Inv) != None && Weapon(Inv) != Self)
					{
						if(!Weapon(Inv).HasAmmo())
							continue;
						Instigator.PendingWeapon = Weapon(Inv);
						Instigator.ChangedWeapon();
						break;
					}
			}
		}
		//Instigator.Weapon = None;
		Destroy();
	}
	else
		PlayAnim(SelectAnim, SelectAnimRate, 0.0);
}

// Fuse ran out before grenade was tossed
simulated function ExplodeInHand()
{
	ClipReleaseTime=666;
	KillSmoke();
	SetBoneScale (2, 1.0, ClipBone);
	HandExplodeTime = Level.TimeSeconds + 1.0;
	if (IsFiring())
	{
		FireMode[0].bIsFiring=false;
		FireMode[1].bIsFiring=false;
	}
	if (Role == Role_Authority)
	{
		DoExplosionEffects();
		MakeNoise(1.0);
		ConsumeAmmo(0, 1);
	}
	SetTimer(0.1, false);
}

function HolderDied()
{
    local int m;

	if (AmbientSound != None)
		AmbientSound = None;

    if (Instigator != None && Instigator.Weapon == self && Role == ROLE_Authority && BallisticGrenadeFire(FireMode[0]) != None && !FireMode[0].IsFiring() && !FireMode[1].IsFiring() && FireMode[0].NextFireTime < level.TimeSeconds)
	{
		CurrentWeaponMode=0;
		FireMode[0].HoldTime = 0;
		FireMode[0].ModeDoFire();
		CurrentWeaponMode=1;
    }
    else
    {
	    for (m = 0; m < NUM_FIRE_MODES; m++)
    	{
			if (FireMode[m] == None)
				continue;
	        if (FireMode[m].bIsFiring)
    	    {
        	    StopFire(m);
            	if (FireMode[m].bFireOnRelease && (BFireMode[m] == None || BFireMode[m].bReleaseFireOnDie))
                	FireMode[m].ModeDoFire();
	        }
    	}
    }
/*	if (ClipReleaseTime > 0)
	{
		if (BallisticGrenadeFire(FireMode[0]) != None)
			FireMode[0].ModeDoFire();
		else if (BallisticGrenadeFire(FireMode[1]) != None)
			FireMode[1].ModeDoFire();
	}
*/
}

simulated function Timer()
{
	//Do damage
	if (ClipReleaseTime == 666)
	{
		ClipReleaseTime=0.0;
		DoExplosion();
	}
	// Reset
	else if (ClipReleaseTime < 0)
	{
		ClipReleaseTime=0.0;
		DamageThisCook = 0;
	}
	// Explode in hand
	else if (ClipReleaseTime > 0)
		ExplodeInHand();
	// Something else
	else
		Super.Timer();
}

// Aim goes bad when player takes damage
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (bBerserk)
		Damage *= 0.75;
		
	if (Level.TimeSeconds < ClipReleaseTime + FuseDelay)
	{
		DamageThisCook += Damage;
		if (Damage >= DropThreshold)
		{
			HolderDied();
			DamageThisCook = 0;
		}
	}
}

simulated function ClientStartReload(optional byte i)
{
	ClipReleaseTime = Level.TimeSeconds+0.2;
	SetTimer(FuseDelay + 0.2, false);

	SpawnSmoke();
	BFireMode[0].EjectBrass();
	class'BUtil'.static.PlayFullSound(self, ClipReleaseSound);

	if(!IsFiring())
		PlayAnim(ClipReleaseAnim, 1.0, 0.1);
	SetBoneScale (2, 0.001, ClipBone);
}
// Reload releases clip
function ServerStartReload (optional byte i)
{
	if (!bCookable)
		return;
	if (ClipReleaseTime > 0.0)
		return;
	if (Ammo[0].AmmoAmount < 1)
		return;
	if (AIController(Instigator.Controller) != None)
		return;
	if (FireMode[0].NextFireTime > Level.TimeSeconds || FireMode[1].NextFireTime > Level.TimeSeconds)
		return;
	ClipReleaseTime = Level.TimeSeconds+0.2;
	SetTimer(3.2, false);
	ClientStartReload(i);
	BallisticGrenadeAttachment(ThirdPersonActor).HandSmoke();
}
// Weapon special releases clip
//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (!Instigator.bNoWeaponFiring && ClientState == WS_ReadyToFire)
		ServerStartReload();
}
// Spawn the smoke when fuse i burning
simulated function SpawnSmoke()
{
    if ((GrenadeSmokeClass != None) && ((GrenadeSmoke == None) || GrenadeSmoke.bDeleteMe))
	{
		GrenadeSmoke = Spawn(GrenadeSmokeClass);

		if (GrenadeSmoke != None)
		{
			AttachToBone(GrenadeSmoke, SmokeBone);
			class'BallisticEmitter'.static.ScaleEmitter(GrenadeSmoke, DrawScale);
		}
		if (DGVEmitter(GrenadeSmoke) != None)
			DGVEmitter(GrenadeSmoke).InitDGV();
	}
}
// Remove the smoke of burning fuse
simulated function KillSmoke()
{
    if (GrenadeSmoke != None)
    	GrenadeSmoke.Kill();
	GrenadeSmoke = None;
}
// Anim Notify for pin pull
simulated function Notify_GrenadePinPull ()
{
    class'BUtil'.static.PlayFullSound(self, PinPullSound);
}
// Anim Notify for clip release
simulated function Notify_GrenadeClipOff ()
{
	class'BUtil'.static.PlayFullSound(self, ClipReleaseSound);
	BFireMode[0].EjectBrass();
	SpawnSmoke();
}

// Charging bar shows throw strength
simulated function float ChargeBar()
{
	if (FireMode[1].bIsFiring)
		return FClamp(FireMode[1].HoldTime - 0.5,  0, 2) / 2;
	else
		return FClamp(FireMode[0].HoldTime - 0.5,  0, 2) / 2;
}

function DropFrom(vector StartLocation)
{
    if (!bCanThrow)
        return;
	if (!HasAmmo())
		PickupClass=None;
	super.DropFrom(StartLocation);
}

// AI Interface =====
function byte BestMode()
{
	local Bot B;
	local float Dist, Height, result;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	result = 0.5;

	if (Dist > 500)
		result -= 0.4;
	else
		result += 0.4;
	if (Abs(Height) > 32)
		result -= Height / Dist;
	if (result > 0.5)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist, HeightFactor;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	HeightFactor = 1 + 0.3 * FClamp((B.Enemy.Location.Z - Instigator.Location.Z)/-500, -2, 1); 
	
	if (Dist < 512)
		return 0.5 * HeightFactor; // discourage close-range grenade
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 1536, 2048) * HeightFactor; 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.2;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}

// End AI Stuff =====

defaultproperties
{
	bCookable=True
	ClipReleaseAnim="ClipOut"
	FuseDelay=3.000000
	GrenadeBone="Grenade"
	PinBone="Pin"
	ClipBone="tip"
	SmokeBone="tip"
	DropThreshold=75
	InventorySize=3
	MagAmmo=1
	bNoMag=True
	 
	Begin Object Class=RecoilParams Name=GrenadeRecoilParams
		PitchFactor=0.000000
		YawFactor=0.000000
	End Object
	RecoilParamsList(0)=RecoilParams'GrenadeRecoilParams'

	WeaponModes(0)=(ModeName="Auto Throw",ModeID="WM_None",Value=0.000000)
	WeaponModes(1)=(ModeName="Long Throw",ModeID="WM_None",Value=1.000000)
	WeaponModes(2)=(ModeName="Short Throw",ModeID="WM_None",Value=2.000000)
	CurrentWeaponMode=0
	bUseSights=False
	SightingTime=0.000000
	GunLength=0.000000
	bAimDisabled=True
	SelectAnimRate=1.800000
	PutDownAnimRate=1.500000
	PutDownTime=1.000000
	BringUpTime=1.000000
	bShowChargingBar=True
	Priority=1
	ItemName="Hand Grenade"
}
