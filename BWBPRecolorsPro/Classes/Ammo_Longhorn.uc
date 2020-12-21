class Ammo_Longhorn extends BallisticAmmo;

static function int GetKillResupplyAmmo()
{
	return 6;
}

defaultproperties
{
     MaxAmmo=40
     InitialAmount=20
     IconFlashMaterial=Shader'BallisticRecolors4TexPro.Longhorn.AmmoIcon_LonghornFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_SMRTGrenade'
     IconMaterial=Texture'BallisticRecolors4TexPro.Longhorn.AmmoIcon_Longhorn'
     ItemName="X2 SMRT Grenade"
}
