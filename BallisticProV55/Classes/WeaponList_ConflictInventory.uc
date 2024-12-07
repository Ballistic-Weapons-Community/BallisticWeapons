class WeaponList_ConflictInventory extends Object 
	PerObjectConfig
	config(BallisticProV55);

var() config string PresetName[5];
var() config string	SavedInventory[5];
var() config string	SavedCamo[5];
var() config string	SavedLayout[5];

defaultproperties
{
	PresetName[0]="Infantry"
	PresetName[1]="Commando"
	PresetName[2]="Skrith"
	PresetName[3]="Support"
	PresetName[4]="Sniper"
	SavedInventory[0]="BallisticProV55.M50AssaultRifle|BallisticProV55.D49Revolver|BallisticProV55.X3Knife|BallisticProV55.NRP57Grenade"
	SavedInventory[1]="BallisticProV55.XK2Submachinegun|BWBP_SKC_Pro.SK410Shotgun|BallisticProV55.X4Knife|BWBP_SKC_Pro.ICISStimpack"
	SavedInventory[2]="BallisticProV55.A73SkrithRifle|BWBP_SKC_Pro.A49SkrithBlaster|BallisticProV55.A909SkrithBlades|BallisticProV55.M58Grenade"
	SavedInventory[3]="BallisticProV55.M353Machinegun|BWBP_OP_Pro.PD97Bloodhound|BallisticProV55.M806Pistol|BWBP_OP_Pro.L8GIAmmoPack"
	SavedInventory[4]="BallisticProV55.R78Rifle|BallisticProV55.GRS9Pistol|BallisticProV55.X3Knife|BallisticProV55.M58Grenade"
	SavedCamo[0]="0|0|0|0"
	SavedCamo[1]="0|0|0|0"
	SavedCamo[2]="0|0|0|0"
	SavedCamo[3]="0|1|0|0"
	SavedCamo[4]="0|0|0|0"
	SavedLayout[0]="0|0|0|0"
	SavedLayout[1]="0|0|0|0"
	SavedLayout[2]="0|0|0|0"
	SavedLayout[3]="0|0|0|0"
	SavedLayout[4]="0|0|0|0"
}