class WeaponList_Killstreak extends Object 
	PerObjectConfig
	config(BallisticProV55);

var() config array<string>	Streak1s;	// Killstreak One
var() config array<string>	Streak2s;	// Killstreak Two

defaultproperties
{
	Streak1s(0)="BallisticProV55.G5Bazooka"
	Streak2s(0)="BallisticProV55.MACWeapon"
}