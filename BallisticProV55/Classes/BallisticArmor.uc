//=============================================================================
// BallisticArmor
//
// This armor uses its third person actor to spawn cool impact effects and play
// terrible sounds. Overwrites xPawn shield count for HUD purposes, cause noone
// made a nice way for inventory to draw on the HUD...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticArmor extends Armor;

var() int MaxCharge;
var() vector ShieldFlashV;

var   byte HitType;

event PostBeginPlay()
{
	AttachToPawn(Pawn(Owner));
	super.PostBeginPlay();
}

simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (Owner != None)
		xPawn(Owner).ShieldStrengthMax = FMax(xPawn(Owner).ShieldStrengthMax, MaxCharge);
}

function AttachToPawn(Pawn P)
{
	Instigator = P;
	if ( ThirdPersonActor == None )
	{
		ThirdPersonActor = Spawn(AttachmentClass, Owner);
		InventoryAttachment(ThirdPersonActor).InitFor(self);
	}
	else
		ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonActor.SetLocation(P.Location);
	ThirdPersonActor.SetBase(P);
}

function ArmorImpactEffect(vector HitLocation)
{
	if (ThirdPersonActor != None && ArmorAttachment(ThirdPersonActor) != None)
		ArmorAttachment(ThirdPersonActor).UpdateHit(HitLocation, HitType);
}

function int ArmorAbsorbDamage(int Damage, class<DamageType> DamageType, vector HitLocation)
{
	local int ArmorDamage;

	if ( DamageType.default.bArmorStops )
	{
		if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.ArmorHitType != 255)
			HitType = class<BallisticDamageType>(DamageType).default.ArmorHitType;
		else
		{
			if (DamageType.default.bBulletHit)
				HitType = 0;
			else if (DamageType.default.bLocationalHit)
				HitType = 1;
			else
				HitType = 2;
		}
		ArmorImpactEffect(HitLocation);
	}
	if( (DamageType != None) && (ProtectionType == DamageType) )
		return 0;

	if (!DamageType.default.bArmorStops)
		return Damage;

	ArmorDamage = (Damage * ArmorAbsorption) / 100;

	if( ArmorDamage >= Charge )
	{
		ArmorDamage = Charge;
		Destroy();
	}
	else
		Charge -= ArmorDamage;

    if (PlayerController(Instigator.Controller) != None)
        PlayerController(Instigator.Controller).ClientFlash( -0.019 * FClamp(ArmorDamage, 20, 60), ShieldFlashV);

	SetShieldDisplay(0);
	SetTimer(0.05, false);

	return (Damage - ArmorDamage);
}

event Timer()
{
	SetShieldDisplay(Charge);
}

event Destroyed()
{
	SetShieldDisplay(0);
	super.Destroyed();
}

function GiveTo(pawn Other, optional Pickup Pickup)
{
	Instigator = Other;
	if (Other.AddInventory( Self ))
	{
		GotoState('');
		if (Pickup != None && BallisticArmorPickup(Pickup) != None)
			Charge = BallisticArmorPickup(Pickup).ArmorCharge;
		SetShieldDisplay(Charge);
	}
	else
		Destroy();
}

function bool HandlePickupQuery( Pickup Item )
{
	if (item.InventoryType == class)
	{
		if ((BallisticArmorPickup(Item) != None) && (Charge < MaxCharge))
		{
			Charge = Min(Charge + BallisticArmorPickup(Item).ArmorCharge, MaxCharge);
			SetShieldDisplay(Charge);
			Item.AnnouncePickup(Pawn(Owner));
			Item.SetRespawn();
		}
		return true;
	}
	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

simulated function SetShieldDisplay(int Amount)
{
	if (Owner == None || xPawn(Owner) == None)
		return;
	xPawn(Owner).ShieldStrengthMax = FMax(xPawn(Owner).ShieldStrengthMax, MaxCharge);
	xPawn(Owner).ShieldStrength = Amount;
}

defaultproperties
{
     ShieldFlashV=(X=400.000000,Y=400.000000,Z=400.000000)
     MaxCharge=200
     ArmorAbsorption=100
     AbsorptionPriority=1
     Charge=50
     AttachmentClass=Class'BallisticProV55.ArmorAttachment'
}
