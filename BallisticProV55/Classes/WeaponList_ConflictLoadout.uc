class WeaponList_ConflictLoadout extends Object 
	PerObjectConfig
	config(BallisticProV55);

struct Entry
{
	var() config string 	ClassName;
	var() config bool		bRed;
	var() config bool		bBlue;
};

var() config array<Entry>	ConflictWeapons;	// 	Big list of all available weapons and the teams for which they are selectable
var() config byte			LoadoutOption;		//	0: Normal loadout, 1: Evolution skill requirements, 2: Purchasing system (not implemented yet)

defaultproperties
{
	 ConflictWeapons(0)=(ClassName="BallisticProV55.M806Pistol",bRed=True,bBlue=True)
	 ConflictWeapons(1)=(ClassName="BallisticProV55.M50AssaultRifle",bRed=True,bBlue=True)
}