class WeaponList_Killstreak extends Object 
	PerObjectConfig
	config(BallisticProV55);

var() config array<string>	Streak1s;	// Killstreak One
var() config array<string>	Streak2s;	// Killstreak Two

defaultproperties
{
	Streak1s(0)="BallisticProV55.G5Bazooka"
	Streak1s(1)="BallisticProV55.MRocketLauncher"
	Streak1s(2)="BallisticProV55.RX22AFlamer"
	Streak1s(3)="BallisticProV55.M75Railgun"
	Streak1s(4)="BWBP_SKC_Pro.GRSXXPistol"
	Streak1s(5)="BWBP_SKC_Pro.HVPCMk5PlasmaCannon"
	Streak1s(6)="BWBP_SKC_Pro.SKASShotgun"
	Streak1s(7)="BWBP_SKC_Pro.MGLauncher"
	Streak2s(0)="BallisticProV55.MACWeapon"
	Streak2s(1)="BWBP_SKC_Pro.HVPCMk66PlasmaCannon"
	Streak2s(2)="BWBP_SKC_Pro.SMATLauncher"
	Streak2s(3)="BWBP_SKC_Pro.LAWLauncher"
	Streak2s(4)="BWBP_SKC_Pro.FLASHLauncher"
	Streak2s(5)="BWBP_APC_Pro.HydraBazooka"
}