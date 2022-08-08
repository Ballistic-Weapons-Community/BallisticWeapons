//=============================================================================
// BallisticWeaponPickup.
//
// Changes some ammo and rotation stuff
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticWeaponPickup extends KFWeaponPickup
	config(BallisticProV55)

	placeable;

var() int					MagAmmo;					// How much ammo is in this thing's mag
var() bool					bOnSide;					// Should lie on its side
var() StaticMesh			LowPolyStaticMesh;		    // Mesh for low poly stuff, like when its far away
var() float					LowPolyDist;				// How far must player be to use low poly mesh
var() float					PickupDrawScale;			// DrawScale may be weird so it looks good in the menu. Use this for in game pickups

var   float					ChangeTime;				    // Time when next change should occur
var	float					PassedRespawnTime; 	        //Set on a swapped-in pickup if the replaced pickup was sleeping
var   int					ReplacementsIndex;		    // Index into Mutator Replacement list associated with this pickup

var   rotator				LandedRot;
var   Actor					FadeOutEffect;
var   Pawn					LastPickedUpBy;
var   bool					bAlternativePickups;    // tp prevent class<BallisticWeapon>(InventoryType).default.BCRepClass.default.bAlternativePickups;
var   BallisticPickupTrigger    puTrigger;


var float	                LastBlockNotificationTime;

var	int						DetectedInventorySize;		// Hack. Tracking inventory size calculcated during BallisticWeapon.HandlePickupQuery

replication
{
	unreliable if (Role == ROLE_Authority && bNetDirty)
		LandedRot;
}

simulated function PreBeginPlay()
{
	if (PickupDrawScale != 0)
		SetDrawScale(PickupDrawScale);
	
	bAlternativePickups = class<BallisticWeapon>(InventoryType).default.BCRepClass.default.bAlternativePickups;

    if(bAlternativePickups)
    {
        // spawn pickup trigger
        puTrigger = Spawn(class'BallisticPickupTrigger',self ,, Location);
        puTrigger.bwPickUp = self;
        puTrigger.SetBase(self);
        puTrigger.SetCollisionSize(CollisionRadius, CollisionHeight);

        // disable collusion
        SetCollision(false);
    }
	
	super.PrebeginPlay();
}

delegate OnItemChange (Pickup Pickup);
delegate OnItemPickedUp (Pickup Pickup);

function SetWeaponStay()
{
	if (class<BallisticWeapon>(InventoryType) != None && class<BallisticWeapon>(InventoryType).default.bWT_Super)
		bWeaponStay = False;
	else bWeaponStay = ( bWeaponStay && Level.Game.bWeaponStay );
}

simulated event Tick(float DT)
{
	local PlayerController PC;

	if (ChangeTime > 0 && level.TimeSeconds > ChangeTime && (IsInState('Sleeping') || !PlayerCanSeeMe()))
		OnItemChange(self);
		

	super.Tick(DT);

	if (level.NetMode == NM_DedicatedServer)
		return;

	PC = Level.GetLocalPlayerController();
	if (PC==None)
		return;
	if (PC.ViewTarget != None && VSize(Location - PC.ViewTarget.Location) > LowPolyDist * (90 / PC.FOVAngle))
	{
		if (StaticMesh != LowPolyStaticMesh)
			SetStaticMesh(LowPolyStaticMesh);
	}
	else if (StaticMesh != default.StaticMesh)
		SetStaticMesh(default.StaticMesh);
}

// tell the bot how much it wants this weapon pickup
// called when the bot is trying to decide which inventory pickup to go after next
function float BotDesireability(Pawn Bot)
{
	local Weapon AlreadyHas;
	local class<Pickup> AmmoPickupClass;
	local float desire;

	// bots adjust their desire for their favorite weapons
	desire = MaxDesireability + Bot.Controller.AdjustDesireFor(self);

	// see if bot already has a weapon of this type
	AlreadyHas = Weapon(Bot.FindInventoryType(InventoryType)); 
	
	if ( AlreadyHas != None )
	{
		if ( Bot.Controller.bHuntPlayer )
			return 0;
			
		// can't pick it up if weapon stay is on
		if ( !AllowRepeatPickup() )
			return 0;
		if ( (RespawnTime < 10) 
			&& ( bHidden || AlreadyHas.AmmoMaxed(0)) )
			return 0;

		if ( AlreadyHas.AmmoMaxed(0) )
			return 0.25 * desire;

		// bot wants this weapon for the ammo it holds
		if( AlreadyHas.AmmoAmount(0) > 0 )
		{
			AmmoPickupClass = AlreadyHas.AmmoPickupClass(0);
			
			if ( AmmoPickupClass == None )
				return 0.05;
			else
				return FMax( 0.25 * desire, 
						AmmoPickupClass.Default.MaxDesireability
						* FMin(1, 0.15 * AlreadyHas.MaxAmmo(0)/AlreadyHas.AmmoAmount(0)) );
		} 
		else
			return 0.05;
	}
	if ( Bot.Controller.bHuntPlayer && (MaxDesireability * 0.833 < Bot.Weapon.AIRating - 0.1) )
		return 0;
	
	// incentivize bot to get this weapon if it doesn't have a good weapon already
	if ( (Bot.Weapon == None) || (Bot.Weapon.AIRating < 0.5) )
		return 2*desire;

	return desire;
}

auto state Pickup
{
	function BeginState()
	{
		if (!bDropped && class<BallisticWeapon>(InventoryType) != None)
			MagAmmo = class<BallisticWeapon>(InventoryType).static.GetPickupMagAmmo();
		
		if(bAlternativePickups)
        {
            if(puTrigger != none)
                puTrigger.InitTrigger();
        }
		Super.BeginState();
	}
	

	function bool ValidTouch( actor Other )
	{
		// make sure its a live player
		if ( (Pawn(Other) == None) || !Pawn(Other).bCanPickupInventory || (Pawn(Other).DrivenVehicle == None && Pawn(Other).Controller == None) )
			return false;

		// make sure not touching through wall
		if ( !FastTrace(Other.Location, Location) )
			return false;

		DetectedInventorySize = class<BallisticWeapon>(InventoryType).static.GetInventorySize();

		// make sure game will let player pick me up
		if( Level.Game.PickupQuery(Pawn(Other), self) )
		{
			DetectedInventorySize = 0;
			LastPickedUpBy = Pawn(Other);
			TriggerEvent(Event, self, Pawn(Other));
			return true;
		}
		if (PlayerController(Pawn(Other).Controller) != None && LastPickedUpBy != Pawn(Other))
			PlayerController(Pawn(Other).Controller).ReceiveLocalizedMessage(class'BallisticWeaponPickupMessage', ,,, self);
		return false;
	}
}

//Returns true if the particular weapon slot is full at the moment.
function bool SlotCapacityReached(Pawn P, int InvGroup, int Max)
{
	local Inventory Inv;
	local int Count;
	
	for (Inv = P.Inventory; Inv != None; Inv = Inv.Inventory)
	{
		if (Weapon(Inv) != None && Weapon(Inv).InventoryGroup == InvGroup)
		{
			if (Weapon(Inv).Class == InventoryType)
				return false;
			Count++;
			if (Count >= Max)
				break;
		}
	}
		
	if (Count >= Max)
		return true;
	
	return false;
}

//Provides ammo to an existing copy of this weapon.
function GiveWeaponAmmo (Weapon W, Pawn Other)
{
	local BallisticWeapon BW;

	if (bDropped)
	{
		BW = BallisticWeapon(W);
		if (BW != None && !BW.bNoMag)
			BW.AddAmmo(MagAmmo, 0);
		W.AddAmmo(AmmoAmount[0], 0);
		W.AddAmmo(AmmoAmount[1], 1);
		return;
	}
	if (class<BallisticWeapon>(InventoryType) != None && class<BallisticWeapon>(InventoryType).default.bNoMag == false)
		W.AddAmmo(class<BallisticWeapon>(InventoryType).static.GetPickupMagAmmo() * 2, 0);	//BE: Doubled amount of ammo recieved from weapon pickups.
	else
		W.AddAmmo(W.GetAmmoClass(0).default.InitialAmount, 0);
	if (W.GetAmmoClass(1) != None && W.GetAmmoClass(1) != W.GetAmmoClass(0))
		W.AddAmmo(W.GetAmmoClass(1).default.InitialAmount, 1);
}

//Adds initial ammo if this wasn't a dropped pickup.
//God knows why it was done like this
function inventory SpawnCopy( pawn Other )
{
	local inventory Copy;
	local Weapon W;
		

	//if (!bDropped)				// This Section
	//	OnItemPickedUp(self); // Adds Initial Ammo
	

	LastPickedUpBy = Other;
    W = Weapon(Other.FindInventoryType(InventoryType));
	
	if (W != None)
	{
		GiveWeaponAmmo(W, Other);
		return None;
	}
	

	if ( Inventory != None )
	{
		Copy = Inventory;
		Inventory = None;
	}
		

	else
		Copy = spawn(InventoryType,Other,,,rot(0,0,0));

	Copy.GiveTo( Other, self );

	return Copy;
}

simulated function GetAmmoAmount (int m, Weapon W)
{
	if (bThrown)
	{
		if (BallisticWeapon(W)!=None && BallisticWeapon(W).bNoMag==false)
			AmmoAmount[m] = Min(W.AmmoAmount(m), BallisticWeapon(W).static.GetPickupMagAmmo());
		else
			AmmoAmount[m] = Min(W.AmmoAmount(m), W.GetAmmoClass(m).default.InitialAmount);
	}
	else
		AmmoAmount[m] = W.AmmoAmount(m);
	W.ConsumeAmmo(m, AmmoAmount[m]);
}

function InitDroppedPickupFor(Inventory Inv)
{
    local Weapon W;

    W = Weapon(Inv);
    if (W != None)
    {
		if (BallisticWeapon(W) == None || BallisticWeapon(W).bNoMag)
		{
			GetAmmoAmount(0, W);
			if (W!=None && W.GetAmmoClass(1) != W.GetAmmoClass(0))
				GetAmmoAmount(1, W);
		}
		else if (BallisticWeapon(W) != None && !BallisticWeapon(W).bNoMag)
		{
			MagAmmo = BallisticWeapon(W).MagAmmo;
	        if ((!bThrown || BallisticFire(W.GetFireMode(0)) == None || BallisticFire(W.GetFireMode(0)).bUseWeaponMag==false))
				GetAmmoAmount(0, W);
			if (W!=None && W.GetAmmoClass(1) != W.GetAmmoClass(0) && (!bThrown || BallisticFire(W.GetFireMode(1)) == None || BallisticFire(W.GetFireMode(1)).bUseWeaponMag==false))
				GetAmmoAmount(1, W);
		}
    }
	if (bOnSide)
		SetRotation(Rotation + Rot(0,0,16384));

    Super(Pickup).InitDroppedPickupFor(None);

    LifeSpan = 24;
}

event Landed(Vector HitNormal)
{
	local Rotator R, Dir;
	local Vector X, Y, Z;


	Dir = Rotator(HitNormal);
	Dir.Pitch -= 16384;
	R.Yaw = Rotation.Yaw;
		
	GetAxes (R,X,Y,Z);
	X = X >> Dir;
	Y = Y >> Dir;
	Z = Z >> Dir;
		
	Dir = OrthoRotation (X,Y,Z);
		
	Dir.Yaw = Rotation.Yaw;
	if (bOnSide)
		Dir.Roll += 16384;
	SetRotation(Dir);

	LandedRot = Rotation;
	
    GotoState('Pickup','Begin');
}

simulated function PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (LandedRot != rot(0,0,0))	{
		SetRotation(LandedRot);
	}
}

event Destroyed()
{
	if (FadeOutEffect != None)
		FadeOutEffect.Destroy();
		
	if(bAlternativePickups)
    {
        if(puTrigger != none)
            puTrigger.Destroy();
    }
	
	super.Destroyed();
}

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	PlaySound( PickupSound,SLOT_Interact,TransientSoundVolume, ,TransientSoundRadius );
}
state FallingPickup
{
	function BeginState()
	{
	    SetTimer(20, false);
	}
	
	function bool ValidTouch( actor Other )
	{
		// make sure its a live player
		if ( (Pawn(Other) == None) || !Pawn(Other).bCanPickupInventory || (Pawn(Other).DrivenVehicle == None && Pawn(Other).Controller == None) )
			return false;

		// make sure not touching through wall
		if ( !FastTrace(Other.Location, Location) )
			return false;

        DetectedInventorySize = class<BallisticWeapon>(InventoryType).static.GetInventorySize();


		// make sure game will let player pick me up
		if( Level.Game.PickupQuery(Pawn(Other), self) )
		{
			DetectedInventorySize = 0;
			LastPickedUpBy = Pawn(Other);
			TriggerEvent(Event, self, Pawn(Other));
			return true;
		}
		if (PlayerController(Pawn(Other).Controller) != None && LastPickedUpBy != Pawn(Other))
			PlayerController(Pawn(Other).Controller).ReceiveLocalizedMessage(class'BallisticWeaponPickupMessage', ,,, self);
		return false;
	}
}

simulated event ClientTrigger()
{
	bHidden=true;
	if (EffectIsRelevant(Location, false))
		FadeOutEffect = Spawn(class'BCPickupFadeEffect',self,,Location,Rotation);
}

State FadeOut
{
	function BeginState()
	{
		SetPhysics(PHYS_None);
		LifeSpan = 4.0;
		bClientTrigger = !bClientTrigger;
		if (level.NetMode != NM_DedicatedServer)
			ClientTrigger();
	}
	
	function bool ValidTouch( actor Other )
	{
		// make sure its a live player
		if ( (Pawn(Other) == None) || !Pawn(Other).bCanPickupInventory || (Pawn(Other).DrivenVehicle == None && Pawn(Other).Controller == None) )
			return false;

		// make sure not touching through wall
		if ( !FastTrace(Other.Location, Location) )
			return false;
		
        DetectedInventorySize = class<BallisticWeapon>(InventoryType).static.GetInventorySize();

		// make sure game will let player pick me up
		if( Level.Game.PickupQuery(Pawn(Other), self) )
		{
			DetectedInventorySize = 0;
			LastPickedUpBy = Pawn(Other);
			TriggerEvent(Event, self, Pawn(Other));
			return true;
		}
		if (PlayerController(Pawn(Other).Controller) != None && LastPickedUpBy != Pawn(Other))
			PlayerController(Pawn(Other).Controller).ReceiveLocalizedMessage(class'BallisticWeaponPickupMessage', ,,, self);
		return false;
	}
}

//Chance to override respawn time
function float GetRespawnTime()
{
	if (PassedRespawnTime != 0)
		return PassedRespawnTime;
	return Super.GetRespawnTime();
}

State Sleeping
{
	ignores Touch;

	function bool ReadyToPickup(float MaxWait)
	{
		return ( bPredictRespawns && (LatentFloat < MaxWait) );
	}

	function StartSleeping() {}

	function BeginState()
	{
		local int i;

		NetUpdateTime = Level.TimeSeconds - 1;
		bHidden = true;
		for ( i=0; i<4; i++ )
			TeamOwner[i] = None;
	}

	function EndState()
	{
		NetUpdateTime = Level.TimeSeconds - 1;
		bHidden = false;
	}

DelayedSpawn:
	if ( Level.NetMode == NM_Standalone )
		Sleep(FMin(30, Level.Game.GameDifficulty * 8));
	else
		Sleep(30);
	Goto('Respawn');
	
Begin:
	Sleep( GetReSpawnTime() - RespawnEffectTime );
	
Respawn:
	RespawnEffect();
	Sleep(RespawnEffectTime);
    if (PickUpBase != None)
		PickUpBase.TurnOn();
	PassedRespawnTime = 0;
    GotoState('Pickup');
}

defaultproperties
{
     bOnSide=True
     LowPolyDist=500.000000
     ReplacementsIndex=-1
     StandUp=(Y=0.250000,Z=0.000000)
     bAmbientGlow=False
     DrawType=DT_StaticMesh
     bOrientOnSlope=False
     bNetInitialRotation=True
     AmbientGlow=0
     TransientSoundVolume=1.000000
     TransientSoundRadius=64.000000
     CollisionRadius=26.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
