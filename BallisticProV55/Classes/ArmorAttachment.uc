//=============================================================================
// ArmorAttachment
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ArmorAttachment extends InventoryAttachment;

var   byte			HitCount, OldHitCount, AHitType;
var   Vector		AHitLocation;

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		HitCount, AHitLocation, AHitType;
}

simulated function PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (HitCount != OldHitCount)
	{
		ThirdPersonEffects();
		OldHitCount = HitCount;
	}
}

// Ballistic armor has different effects for different attacks:
// 0=Bullet, 1=Other, 2=No FX. More may come as system develops...
simulated function ThirdPersonEffects()
{
	local Rotator R;

    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
    {
    	if (AHitType < 2)
    	{
			R = Rotator(AHitLocation - Instigator.Location);
			R.Pitch*=0.5;
			Spawn(class'IE_Armor',Instigator,,AHitLocation,R);
			if (AHitType == 1)
				PlaySound(SoundGroup'BallisticSounds2.BulletImpacts.ArmorMisc',,0.7,,64,,);
			else
				PlaySound(SoundGroup'BallisticSounds2.BulletImpacts.BulletArmor',,1.0,,64,,);
		}
    }
}

function UpdateHit (Vector HitLoc, byte HitType)
{
	AHitLocation = HitLoc;
	AHitType = HitType;
	HitCount++;
	ThirdPersonEffects();
}

defaultproperties
{
     bHidden=True
     bReplicateInstigator=True
     bNetNotify=True
}
