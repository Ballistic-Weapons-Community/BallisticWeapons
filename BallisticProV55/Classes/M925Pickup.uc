//=============================================================================
// M925Pickup.
//=============================================================================
class M925Pickup extends BallisticWeaponPickup
	placeable;

var() StaticMesh AlternateMesh;
var() StaticMesh AlternateMeshLo;
var   StaticMesh DaMesh;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925Main');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925Small');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925AmmoBox');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925HeatShield');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925Main');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925Small');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925AmmoBox');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M925.M925HeatShield');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M925AmmoBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925PickupAltHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925PickupAltLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925PickupLo');
}

simulated event Tick(float DT)
{
	local PlayerController PC;

	if (ChangeTime > 0 && level.TimeSeconds > ChangeTime && (IsInState('Sleeping') || /*!level.Game.bWeaponStay || */!PlayerCanSeeMe()))
		OnItemChange(self);

	super(UTWeaponPickup).Tick(DT);

	if (level.NetMode == NM_DedicatedServer)
		return;

	PC = Level.GetLocalPlayerController();
	if (PC==None)
		return;
	if (VSize(Location - PC.ViewTarget.Location) > LowPolyDist * (90 / PC.FOVAngle))
	{
		if (StaticMesh != LowPolyStaticMesh)
			SetStaticMesh(LowPolyStaticMesh);
	}
	else if (StaticMesh != DaMesh)
		SetStaticMesh(DaMesh);
}


// Two different appearances
simulated function PostBeginPlay()
{
	if (FRand() > 0.5)
	{
		SetStaticMesh(AlternateMesh);
		DaMesh = AlternateMesh;
		LowPolyStaticMesh = AlternateMeshLo;
//		default.LowPolyStaticMesh = AlternateMeshLo;
	}
	else
		DaMesh = StaticMesh;
	super.PostBeginPlay();
}

defaultproperties
{
     AlternateMesh=StaticMesh'BallisticHardware2.M925.M925PickupAltHi'
     AlternateMeshLo=StaticMesh'BallisticHardware2.M925.M925PickupAltLo'
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M925.M925PickupLo'
     PickupDrawScale=0.250000
     StandUp=(Y=0.800000)
     InventoryType=Class'BallisticProV55.M925Machinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M925 machinegun."
     PickupSound=Sound'BallisticSounds2.M925.M925-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.M925.M925PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.250000
     TransientSoundVolume=0.600000
     CollisionHeight=8.000000
}
