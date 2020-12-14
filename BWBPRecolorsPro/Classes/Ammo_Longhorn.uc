class Ammo_Longhorn extends BallisticAmmo;

static function int GetKillResupplyAmmo()
{
	return 6;
}

defaultproperties
{
     MaxAmmo=48
     InitialAmount=8
     IconFlashMaterial=Shader'BWBP_SKC_TexExp.Longhorn.AmmoIcon_LonghornFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_SMRTGrenade'
     IconMaterial=Texture'BWBP_SKC_TexExp.Longhorn.AmmoIcon_Longhorn'
     ItemName="X2 SMRT Grenade"
}
