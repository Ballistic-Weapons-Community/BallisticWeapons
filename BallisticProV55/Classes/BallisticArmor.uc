//=============================================================================
// BallisticArmor
//
// Used only to display hit effects.
//
// by Nolan "Dark Carnivour" Richert, modified by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticArmor extends Armor;

var   byte HitType;

event PostBeginPlay()
{
	AttachToPawn(Pawn(Owner));
	super.PostBeginPlay();
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
	// Pawn is authoritative over the shield value.
	// Destroy if pawn ran out of shields.
	if (xPawn(Owner).ShieldStrength == 0)
	{
		Destroy();
	}

	// Work out hit effect to use for this damage type.
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

	// Neutralize any damage that this armor can handle.
	if( (DamageType != None) && (ProtectionType == DamageType) )
		return 0;

	// Otherwise, return full damage and rely on standard code, so that hitsounds, damage popups and game rules that work based on damage can do their job.
	return Damage;
}

defaultproperties
{
     ArmorAbsorption=100
     AbsorptionPriority=1
     Charge=100
     AttachmentClass=Class'BallisticProV55.ArmorAttachment'
}
