class Ammo_Longhorn extends BallisticAmmo;

static function int GetKillResupplyAmmo()
{
	return 6;
}

defaultproperties
{
     MaxAmmo=40
     InitialAmount=20
     IconFlashMaterial=Shader'BWBP_SKC_Tex.Longhorn.AmmoIcon_LonghornFlash'
     PickupClass=Class'BWBP_SKC_Pro.AP_SMRTGrenade'
     IconMaterial=Texture'BWBP_SKC_Tex.Longhorn.AmmoIcon_Longhorn'
     ItemName="X2 SMRT Grenade"
}
