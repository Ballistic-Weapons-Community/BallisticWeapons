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
	Streak2s(0)="BallisticProV55.G5Bazooka"
	Streak2s(1)="BallisticProV55.MRocketLauncher"
	Streak2s(2)="BallisticProV55.RX22AFlamer"
	Streak2s(3)="BallisticProV55.M75Railgun"
}