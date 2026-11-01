class Misc_PickupBase extends WildcardBase;

function PostbeginPlay()
{
	Super.PostBeginPlay();
	SetLocation(Location + vect(0, 0, -42));
}

function SpawnPickup()
{
    if( PowerUp == None )
        return;

    myPickUp = Spawn(PowerUp,,,Location + SpawnHeight * vect(0,0,1), rot(0,0,0));

    if (myPickUp != None)
    {
        myPickUp.PickUpBase = self;
        myPickup.Event = event;
    }

	if (myMarker != None)
	{
		myMarker.markedItem = myPickUp;
		myMarker.ExtraCost = ExtraPathCost;
        if (myPickUp != None)
		    myPickup.MyMarker = MyMarker;
	}
}

defaultproperties
{
     PickupClasses(0)=Class'3SPNv3141BW.Misc_PickupHealth'
     PickupClasses(1)=Class'3SPNv3141BW.Misc_PickupShield'
     PickupClasses(2)=Class'3SPNv3141BW.Misc_PickupHealthL'
     PickupClasses(3)=Class'3SPNv3141BW.Misc_PickupShieldL'
     PickupClasses(4)=Class'3SPNv3141BW.Misc_PickupAdren'
     SpawnHeight=20.000000
     bDelayedSpawn=False
     StaticMesh=StaticMesh'XGame_rc.ShieldChargerMesh'
     bStatic=False
     RemoteRole=ROLE_SimulatedProxy
     DrawScale=0.700000
}
