class NoneWeaponDummy extends RandomWeaponDummy;

// makes this weapon unusable by destroying it right after it spawns
event PreBeginPlay()
{
    Destroy();
}

defaultproperties
{
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_NoGun'
     ItemName="No Weapon"
}
