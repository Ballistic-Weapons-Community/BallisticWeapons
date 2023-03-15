//=============================================================================
// RX22APickup.
//=============================================================================
class HMCPickup extends BallisticWeaponPickup
	placeable;


var bool		bCamoChoosen;
var bool		bRedTeam;

#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerPickupLD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerCanHeater');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerTank');
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


	if ((HMCBeamCannon(Inv) != None && HMCBeamCannon(Inv).bRedTeam))
	{
		bRedTeam=true;
		Skins[0] = Shader'BWBP_SKC_TexExp.BeamCannon.RedCannonSD';
	}

    LifeSpan = 24;
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerPickupLD'
     PickupDrawScale=0.550000
     InventoryType=Class'BWBP_SKC_Pro.HMCBeamCannon'
     PickupMessage="You picked up the HMC-117 photon cannon."
     PickupSound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerPickup'
     Physics=PHYS_None
     DrawScale=0.550000
     Skins(2)=Texture'ONSstructureTextures.CoreGroup.Invisible'
     Skins(3)=Texture'ONSstructureTextures.CoreGroup.Invisible'
     Skins(4)=Texture'ONSstructureTextures.CoreGroup.Invisible'
     CollisionHeight=5.000000
}
