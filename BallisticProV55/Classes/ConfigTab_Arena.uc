//=============================================================================
// ConfigTab_Arena
//
// The weapons of the Ballistic Arena mutator, in the shared weapon chooser,
// with presets and the random options.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class ConfigTab_Arena extends ConfigTabBase;

var automated BC_WeaponListEditor	Editor;			// spare and chosen weapons
var Automated GUIButton				BSave;			// Save Preset
var Automated GUIButton				BDelete;		// Delete Preset
var automated moCheckbox			ch_Random;		// One Random Weapon
var automated moCheckbox			ch_PerSpawn;	// Random Per Spawn
var automated GUIComboBox			cb_Presets;		// Presets
var automated GUILabel				l_PresetLabel;	// Presets Label

struct ArenaPreset
{
	var() config string			PresetName;
	var() config array<string>	WeaponClassNames;
};
var() config Array<ArenaPreset>		Presets;
var bool							bIgnorePresetChange;	// The preset box is being changed by code

var() localized string Headings[3];

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;

	Super.InitComponent(MyController, MyOwner);

	for (i = 0; i < Presets.length; i++)
		cb_Presets.AddItem(Presets[i].PresetName,, string(i));
	cb_Presets.SetText("");
}

// The weapons are listed when the tab is first shown: going through every weapon of the game is too much for opening the menu
function InitializeConfigTab()
{
	Editor.AddAllGameWeapons(Headings[0], Headings[1], Headings[2]);
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i, j;
	local string S;
	local array<string> Names;

	if (Sender == BSave) // Save Preset
	{
		S = cb_Presets.GetText();
		if (S == "")
			return true;
		// A name that is in use saves over that preset
		i = FindPreset(S);
		if (i < 0)
		{
			i = Presets.length;
			Presets.length = i + 1;
			Presets[i].PresetName = S;
			bIgnorePresetChange = true;
			cb_Presets.AddItem(S,, string(i));
			bIgnorePresetChange = false;
		}
		Editor.GetChosen(Names);
		Presets[i].WeaponClassNames = Names;
		SaveConfig();
	}
	else if (Sender == BDelete) // Delete Preset
	{
		i = FindPreset(cb_Presets.GetText());
		if (i >= 0)
		{
			Presets.Remove(i, 1);
			// Taking the item out selects its neighbour, which is not to be loaded
			bIgnorePresetChange = true;
			j = cb_Presets.FindIndex(cb_Presets.GetText());
			if (j >= 0)
				cb_Presets.RemoveItem(j);
			cb_Presets.SetText("");
			bIgnorePresetChange = false;
			SaveConfig();
		}
	}
	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	local int i;

	// GetExtra is empty while a name is being typed
	if (Sender == cb_Presets && !bIgnorePresetChange && cb_Presets.GetExtra() != "")
	{
		// by name: the numbers stored with the items go stale when a preset is deleted
		i = FindPreset(cb_Presets.GetText());
		if (i >= 0)
			Editor.SetChosen(Presets[i].WeaponClassNames);
	}
}

function int FindPreset(string PresetName)
{
	local int i;

	for (i = 0; i < Presets.length; i++)
		if (Presets[i].PresetName ~= PresetName)
			return i;
	return -1;
}

//==================================================================
// Settings & Defaults
//==================================================================

// Also RESET: back to the saved list
function LoadSettings()
{
	ch_Random.Checked(class'Mut_BallisticArena'.default.bRandomPickOne);
	ch_PerSpawn.Checked(class'Mut_BallisticArena'.default.bRandomPerSpawn);
	Editor.SetChosen(class'Mut_BallisticArena'.default.WeaponClassNames);
}

function DefaultSettings()
{
	local array<string> Names;

	ch_Random.Checked(true);
	ch_PerSpawn.Checked(true);
	Names[0] = "BallisticProV55.D49Revolver";
	Editor.SetChosen(Names);
}

function SaveSettings()
{
	local array<string> Names;

	if (!bInitialized)
		return;

	Editor.GetChosen(Names);
	if (Names.Length < 1)
		Names.Length = 1;
	class'Mut_BallisticArena'.default.WeaponClassNames = Names;
	class'Mut_BallisticArena'.default.bRandomPickOne = ch_Random.IsChecked();
	class'Mut_BallisticArena'.default.bRandomPerSpawn = ch_PerSpawn.IsChecked();
	class'Mut_BallisticArena'.static.StaticSaveConfig();
	SaveConfig();
}

defaultproperties
{
	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		ChosenCaption="In Play"
		WinTop=0.030000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.680000
		TabOrder=0
	End Object
	Editor=BC_WeaponListEditor'BallisticProV55.ConfigTab_Arena.WeaponEditor'


     Begin Object Class=GUIButton Name=SaveButton
         Caption="SAVE"
         WinTop=0.740000
         WinLeft=0.725000
         WinWidth=0.100000
         TabOrder=0
         OnClick=ConfigTab_Arena.InternalOnClick
         OnKeyEvent=SaveButton.InternalOnKeyEvent
     End Object
     bSave=GUIButton'BallisticProV55.ConfigTab_Arena.SaveButton'


     Begin Object Class=GUIButton Name=DeleteButton
         Caption="DELETE"
         WinTop=0.740000
         WinLeft=0.825000
         WinWidth=0.100000
         TabOrder=0
         OnClick=ConfigTab_Arena.InternalOnClick
         OnKeyEvent=DeleteButton.InternalOnKeyEvent
     End Object
     BDelete=GUIButton'BallisticProV55.ConfigTab_Arena.DeleteButton'


     Begin Object Class=moCheckBox Name=RandomCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="One Random Weapon"
         OnCreateComponent=RandomCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Gives players one random weapon from the list of weapons you have chosen."
         WinTop=0.800000
         WinLeft=0.550000
         WinWidth=0.350000
         WinHeight=0.040000
     End Object
     ch_Random=moCheckBox'BallisticProV55.ConfigTab_Arena.RandomCheck'


     Begin Object Class=moCheckBox Name=PerSpawnCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Random Per Spawn"
         OnCreateComponent=PerSpawnCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Players get a different random weapon from the chosen list each time they spawn."
         WinTop=0.800000
         WinLeft=0.100000
         WinWidth=0.350000
         WinHeight=0.040000
     End Object
     ch_PerSpawn=moCheckBox'BallisticProV55.ConfigTab_Arena.PerSpawnCheck'


     Begin Object Class=GUIComboBox Name=PresetsComboBox
         Hint="Pick a preset list of weapons."
         WinTop=0.740000
         WinLeft=0.400000
         WinWidth=0.300000
         WinHeight=0.030000
         TabOrder=0
         OnChange=ConfigTab_Arena.InternalOnChange
         OnKeyEvent=PresetsComboBox.InternalOnKeyEvent
     End Object
     cb_Presets=GUIComboBox'BallisticProV55.ConfigTab_Arena.PresetsComboBox'


     Begin Object Class=GUILabel Name=PresetLabel
         Caption="Presets"
         TextAlign=TXTA_Right
         TextColor=(B=255,G=255,R=255)
         bMultiLine=True
         FontScale=FNS_Large
         WinTop=0.740000
         WinLeft=0.100000
         WinWidth=0.275000
         WinHeight=0.030000
     End Object
     l_PresetLabel=GUILabel'BallisticProV55.ConfigTab_Arena.PresetLabel'
	 Presets(0)=(PresetName="Sidearm Shootout",WeaponClassNames=("BallisticProV55.M806Pistol","BallisticProV55.A42SkrithPistol","BallisticProV55.AM67Pistol","BallisticProV55.BOGPPistol","BallisticProV55.D49Revolver","BallisticProV55.Fifty9MachinePistol","BallisticProV55.GRS9Pistol","BallisticProV55.leMatRevolver","BallisticProV55.MD24Pistol","BallisticProV55.MRT6Shotgun","BallisticProV55.RS8Pistol","BallisticProV55.XK2SubMachinegun","BallisticProV55.XMK5SubMachinegun","BallisticProV55.XRS10SubMachinegun","BWBP_SKC_Pro.AH104Pistol","BWBP_SKC_Pro.AH250Pistol","BWBP_SKC_Pro.FMPMachinePistol","BWBP_SKC_Pro.GRSXXPistol","BWBP_SKC_Pro.MRDRMachinePistol","BWBP_SKC_Pro.PS9mPistol","BWBP_SKC_Pro.RS04Pistol","BWBP_SKC_Pro.SX45Pistol","BWBP_SKC_Pro.T9CNMachinePistol","BWBP_SKC_Pro.TyphonPDW","BWBP_OP_Pro.PD97Bloodhound","BWBP_OP_Pro.FC01SmartGun","BWBP_APC_Pro.GASCPistol","BWBP_APC_Pro.HKMKSpecPistol","BWBP_APC_Pro.SRKSubMachinegun","BWBP_SWC_Pro.MDKSubMachinegun"))
     Presets(1)=(PresetName="Monster Weapons",WeaponClassNames=("BallisticProV55.G5Bazooka","BallisticProV55.HVCMk9LightningGun","BallisticProV55.M75Railgun","BallisticProV55.MACWeapon","BallisticProV55.MRocketLauncher","BallisticProV55.RX22AFlamer","BallisticProV55.XMV850Minigun","BWBP_SKC_Pro.BulldogAssaultCannon","BWBP_SKC_Pro.FG50MachineGun","BWBP_SKC_Pro.HMCBeamCannon","BWBP_SKC_Pro.HVPCMk5PlasmaCannon","BWBP_SKC_Pro.HVPCMk66PlasmaCannon","BWBP_SKC_Pro.LAWLauncher","BWBP_SKC_Pro.PugAssaultCannon","BWBP_SKC_Pro.PumaRepeater","BWBP_SKC_Pro.SMATLauncher","BWBP_SKC_Pro.Supercharger_AssaultWeapon","BWBP_SKC_Pro.TAC30Cannon","BWBP_OP_Pro.MX32Weapon","BWBP_OP_Pro.ProtonStreamer","BWBP_OP_Pro.Raygun","BWBP_OP_Pro.Z250Minigun","BWBP_APC_Pro.HydraBazooka","BWBP_APC_Pro.ThorLightningCannon","BWBP_APC_Pro.XMV500Minigun","BWBP_JCF_Pro.RGPXBazooka","BWBP_SWC_Pro.A800SkrithMinigun"))
     Presets(2)=(PresetName="Shotgun Arena",WeaponClassNames=("BallisticProV55.M290Shotgun","BallisticProV55.M763Shotgun","BallisticProV55.MRS138Shotgun","BallisticProV55.MRT6Shotgun","BallisticProV55.A500Reptile","BWBP_SKC_Pro.CoachGun","BWBP_SKC_Pro.MK781Shotgun","BWBP_SKC_Pro.SK410Shotgun","BWBP_SKC_Pro.SKASShotgun","BWBP_OP_Pro.FM13Shotgun","BWBP_OP_Pro.RCS715Shotgun","BWBP_APC_Pro.FM14Shotgun","BWBP_JCF_Pro.SPASShotgun"))
     Presets(3)=(PresetName="Sniper Arena",WeaponClassNames=("BallisticProV55.M75Railgun","BallisticProV55.MarlinRifle","BallisticProV55.R78Rifle","BallisticProV55.SRS900Rifle","BWBP_SKC_Pro.AS50Rifle","BWBP_SKC_Pro.M2020GaussDMR","BWBP_SKC_Pro.VSKTranqRifle","BWBP_SKC_Pro.X82Rifle","BWBP_OP_Pro.KF8XCrossbow","BWBP_OP_Pro.LightningRifle","BWBP_OP_Pro.R9A1RangerRifle","BWBP_APC_Pro.R9000ERifle","BWBP_JCF_Pro.M99Rifle"))
     Presets(4)=(PresetName="Tricks n Traps",WeaponClassNames=("BallisticProV55.NRP57Grenade","BallisticProV55.FP7Grenade","BallisticProV55.FP9Explosive","BallisticProV55.BX5Mine","BallisticProV55.T10Grenade","BallisticProV55.M58Grenade","BWBP_SKC_Pro.ChaffGrenadeWeapon","BWBP_SKC_Pro.G28Grenade","BWBP_SKC_Pro.XM84Flashbang","BWBP_SKC_Pro.FLASHLauncher","BWBP_SKC_Pro.MGLauncher","BWBP_SKC_Pro.ThumperGrenadeLauncher","BWBP_SKC_Pro.LonghornLauncher","BWBP_OP_Pro.AkeronLauncher","BWBP_APC_Pro.HB4GrenadeBlaster"))
     Presets(5)=(PresetName="Assault Weapons",WeaponClassNames=("BallisticProV55.M50AssaultRifle","BallisticProV55.M46AssaultRifle","BallisticProV55.SARAssaultRifle","BWBP_SKC_Pro.AK490BattleRifle","BWBP_SKC_Pro.AK91ChargeRifle","BWBP_SKC_Pro.CYLOUAW","BWBP_SKC_Pro.G51Carbine","BWBP_SKC_Pro.LK05Carbine","BWBP_SKC_Pro.MARSAssaultRifle","BWBP_SKC_Pro.SRXRifle","BWBP_OP_Pro.CX61AssaultRifle","BWBP_APC_Pro.CryoLanceLauncher","BWBP_APC_Pro.MJ51Carbine","BWBP_APC_Pro.WendigoSMG","BWBP_APC_Pro.ZX98AssaultRifle","BWBP_JCF_Pro.M7A3AssaultRifle"))
     Presets(6)=(PresetName="Machinegun Battle",WeaponClassNames=("BallisticProV55.M353Machinegun","BallisticProV55.M925Machinegun","BallisticProV55.XMV850Minigun","BWBP_SKC_Pro.AR23HeavyRifle","BWBP_SKC_Pro.FG50MachineGun","BWBP_SKC_Pro.MG36Machinegun","BWBP_SKC_Pro.TAC30Cannon","BWBP_OP_Pro.CX85AssaultWeapon","BWBP_OP_Pro.M575Machinegun","BWBP_OP_Pro.MX32Weapon","BWBP_OP_Pro.Z250Minigun","BWBP_APC_Pro.PKMMachinegun","BWBP_APC_Pro.TridentMachinegun","BWBP_APC_Pro.XMV500Minigun","BWBP_SWC_Pro.A800SkrithMinigun","BWBP_SWC_Pro.BRINKAssaultRifle"))
     Presets(7)=(PresetName="Blade Match",WeaponClassNames=("BallisticProV55.X3Knife","BallisticProV55.X4Knife","BallisticProV55.A909SkrithBlades","BallisticProV55.EKS43Katana","BWBP_SKC_Pro.BlackOpsWristBlade","BWBP_SKC_Pro.DragonsToothSword","BWBP_SKC_Pro.X8Knife","BWBP_SKC_Pro.N3XPlaz","BWBP_OP_Pro.FlameSword","BWBP_OP_Pro.MAG78Longsword","BWBP_OP_Pro.DefibFists","BWBP_SWC_Pro.SkrithStaff"))
     Presets(8)=(PresetName="Skrith Arsenal",WeaponClassNames=("BallisticProV55.A42SkrithPistol","BallisticProV55.A500Reptile","BallisticProV55.A73SkrithRifle","BallisticProV55.A909SkrithBlades","BallisticProV55.E23PlasmaRifle","BallisticProV55.RSDarkStar","BallisticProV55.RSNovaStaff","BWBP_SKC_Pro.A49SkrithBlaster","BWBP_SKC_Pro.AY90SkrithBoltcaster","BWBP_SKC_Pro.HVPCMk5PlasmaCannon","BWBP_APC_Pro.E5PlasmaRifle","BWBP_SWC_Pro.A2WSkrithLance","BWBP_SWC_Pro.A800SkrithMinigun","BWBP_SWC_Pro.SkrithStaff"))
     Presets(9)=(PresetName="Energy Weapons",WeaponClassNames=("BallisticProV55.E23PlasmaRifle","BallisticProV55.HVCMk9LightningGun","BallisticProV55.RSDarkStar","BallisticProV55.RSNovaStaff","BallisticProV55.A73SkrithRifle","BWBP_SKC_Pro.A49SkrithBlaster","BWBP_SKC_Pro.AY90SkrithBoltcaster","BWBP_SKC_Pro.HMCBeamCannon","BWBP_SKC_Pro.HVPCMk5PlasmaCannon","BWBP_SKC_Pro.HVPCMk66PlasmaCannon","BWBP_SKC_Pro.LS14Carbine","BWBP_SKC_Pro.Supercharger_AssaultWeapon","BWBP_SKC_Pro.XM20Carbine","BWBP_OP_Pro.ProtonStreamer","BWBP_OP_Pro.Raygun","BWBP_OP_Pro.XOXOStaff","BWBP_APC_Pro.ThorLightningCannon","BWBP_APC_Pro.ParticleStreamer","BWBP_SWC_Pro.A2WSkrithLance"))
     Presets(10)=(PresetName="UT2004 Stuff",WeaponClassNames=("XWeapons.AssaultRifle","XWeapons.BioRifle","XWeapons.FlakCannon","XWeapons.Painter","XWeapons.SniperRifle","XWeapons.LinkGun","XWeapons.Minigun","XWeapons.Redeemer","XWeapons.RocketLauncher","XWeapons.ShieldGun","XWeapons.ShockRifle","UTClassic.ClassicSniperRifle","XWeapons.Translauncher","Onslaught.ONSAVRiL","Onslaught.ONSGrenadeLauncher","Onslaught.ONSMineLayer","OnslaughtFull.ONSPainter"))
	 Headings(0)="Ballistic Weapons"
     Headings(1)="UT2004 Standard"
     Headings(2)="Other"
}
