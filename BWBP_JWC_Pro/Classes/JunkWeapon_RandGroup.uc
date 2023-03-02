//=============================================================================
// JunkWeapon_RandGroup.
//
// Special JunkWeapon that automatically gives a random piece of junk.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkWeapon_RandGroup extends JunkWeapon HideDropDown CacheExempt;

var() int		RandomJunkInventoryGroup;

function GiveTo( pawn Other, optional Pickup Pickup )
{
	if (Other != None)
	{
	    Instigator = Other;
		SetOwner(Other);
	}
	NetUpdateTime = Level.TimeSeconds - 1;

	if (Pickup == None || JunkWeaponPickup(Pickup) == None || JunkWeaponPickup(Pickup).JunkClass == None)
		SpawnMyRandomJunk ();

	super.GiveTo(Other, Pickup);
}

simulated function SpawnMyRandomJunk ()
{
	local array<string>			JunkNameList;
	local class<JunkObject>		JC;
	local int i, j, By;

	GetAllInt("JunkObject", JunkNameList);
	i = Rand(JunkNameList.length);
	JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
	if (!JC.default.bListed || JC.default.InventoryGroup != RandomJunkInventoryGroup || FindJunkOfClass(JC)!=None)
	{
		if (FRand() > 0.5)
			By = -1;
		else
			By = 1;
		while(j < JunkNameList.length-1)
		{
			i = class'BUtil'.static.Loop(i, By, JunkNameList.length-1);
			JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
			if (JC.default.bListed && JC.default.InventoryGroup == RandomJunkInventoryGroup && FindJunkOfClass(JC)==None)
				break;
			j++;
		}
	}
	GiveJunk(JC);
}

function DropFrom(vector StartLocation)
{
    local int m;
	local Pickup Pickup;
	local JunkObject OldJunk;

	if (Shield != None && Shield.bActive)
	{
		Shield.Velocity = Velocity + VRand() * 50;
		Shield.DropFrom(StartLocation);
		Shield = None;
        if (Instigator.Health > 0)
			return;
	}

	if (AmbientSound != None)
		AmbientSound = None;

	for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None && FireMode[m].bIsFiring)
            StopFire(m);
    }
    if (JunkChain == None || JunkChain.NextJunk == None || Instigator.Health < 1)
    {
		ClientWeaponThrown();
		if ( Instigator != None )
			DetachFromPawn(Instigator);
	}

	if (Junk != None)
		Pickup = Spawn(PickupClass,self,, StartLocation);
	if ( Pickup != None )
	{
    	Pickup.InitDroppedPickupFor(self);
	    Pickup.Velocity = Velocity;
	    Pickup.InventoryType = class;
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
		if (JunkWeaponPickup(Pickup) != None)
		{
			JunkWeaponPickup(Pickup).JunkAmmo = Junk.Ammo;
			JunkWeaponPickup(Pickup).SetJunkClass(Junk.Class);
		}
    }
    if (JunkChain == None || JunkChain.NextJunk == None || Instigator.Health < 1)
	    Destroy();
	else
	{
		OldJunk = Junk;
		SwitchJunk(GetNextJunk(Junk));
		KillJunk(OldJunk);
	}
}

defaultproperties
{
     RandomJunkInventoryGroup=99
     BigIconMaterial=Texture'BWBP_JW_Tex.Icons.BigIcon_PipeCorner'
     IconMaterial=Texture'BWBP_JW_Tex.Icons.SmallIcon-PipeCorner'
     ItemName="Group Random Junk"
}
