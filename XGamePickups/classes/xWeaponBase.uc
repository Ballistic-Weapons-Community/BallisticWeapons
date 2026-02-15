//=============================================================================
// xWeaponBase
//=============================================================================
class xWeaponBase extends xPickUpBase
    placeable;

#exec OBJ LOAD FILE=2k4ChargerMeshes.usx

var() class<Weapon> WeaponType;

function bool CheckForErrors()
{
	if ( (WeaponType == None) || WeaponType.static.ShouldBeHidden() )
	{
		log(self$" ILLEGAL WEAPONTYPE "$Weapontype);
		return true;
	}
	return Super.CheckForErrors();
}

function byte GetInventoryGroup()
{
	if (WeaponType != None)
		return WeaponType.Default.InventoryGroup;
	return 999;
}

simulated function PostBeginPlay()
{
	if (WeaponType != None)
	{
		PowerUp = WeaponType.default.PickupClass;
		if ( WeaponType.Default.InventoryGroup == 0 )
			bDelayedSpawn = true;
	}
    Super.PostBeginPlay();
	SetLocation(Location + vect(0,0,-2)); // adjust because reduced drawscale
}

defaultproperties
{
    SpiralEmitter=class'XEffects.Spiral'

    DrawScale=0.5
    DrawType=DT_StaticMesh
    StaticMesh=XGame_rc.WildcardChargerMesh
    Skins(0)=Texture'XGameTextures.WildcardChargerTex'
    Skins(1)=Texture'XGameTextures.WildcardChargerTex'
    Texture=None

    CollisionRadius=60.000000
    CollisionHeight=3.000000

    NewStaticMesh=2k4chargerMESHES.WeaponChargerMESH-DS
    NewPrePivot=(Z=3.7)
    NewDrawScale=0.5
}
