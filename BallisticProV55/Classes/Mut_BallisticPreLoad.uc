Class Mut_BallisticPreLoad extends Mutator 
	transient
	HideDropDown
	CacheExempt
	config(BallisticProV55);

var config array<string> WeaponClassNames;

var globalconfig bool bEnablePreloading;
var globalconfig bool bEnableCamoLoading;		// Also send every camo skin of every weapon to the video card. Costs a lot of memory.
var globalconfig bool bEnableTextureLoading;	// Also send the weapons' own skins, effects and pickups to the video card

var BallisticPreloadReplicationInfo MyRI;
var int NumRewards;		// How many entries at the end of the list are killstreak rewards
var string PlayerModelPackage;	// The player models of this package, BW's own characters, are loaded as the map starts

var bool bGameWeapons;				// The game type gave its own weapon list (SetGameWeapons)
var array<string> GameWeapons;
var string GameWeaponSource;

event PostBeginPlay()
{
	if (bEnablePreloading)
	{
		MyRI = Spawn(class'BallisticProV55.BallisticPreloadReplicationInfo');
		MyRI.bEnableCamoLoading = bEnableCamoLoading;
		MyRI.bEnableTextureLoading = bEnableTextureLoading;
		PreloadPlayerModels();
	}

	SaveConfig();

	Super.PostBeginPlay();
}

// This mutator is spawned while the inventory mutator is still starting up, so the lists are read a moment later.
// Only the names go out: the server gets the classes it needs from the inventory mutator, the clients load them here.
function Tick(float DeltaTime)
{
	local array<string> PreloadList;
	local int i;

	Disable('Tick');

	if (MyRI == None)
		return;

	BuildWeaponList(PreloadList);
	LoadOnServer(PreloadList);

	// The clients wait for a count. A negative one tells them there is nothing to come.
	if (PreloadList.Length == 0)
	{
		MyRI.PreloadNum = -1;
		MyRI.SendInfo();
		return;
	}

	if (PreloadList.Length > ArrayCount(MyRI.CurrentName))
	{
		Log("Mut_BallisticPreLoad: List of"@PreloadList.Length@"cut to"@ArrayCount(MyRI.CurrentName), 'Warning');
		NumRewards = Max(0, NumRewards - (PreloadList.Length - ArrayCount(MyRI.CurrentName)));
		PreloadList.Length = ArrayCount(MyRI.CurrentName);
	}
	MyRI.RewardNum = NumRewards;

	for (i = 0; i < PreloadList.Length; i++)
		MyRI.CurrentName[i] = PreloadList[i];
	MyRI.PreloadNum = PreloadList.Length;
	MyRI.SendInfo();
}

// A server loaded each weapon the first time somebody was handed it, in the middle of play, and every player felt
// it: a frame of 50 to 300 ms whenever a bot came in or back with a weapon new to the map (bots take theirs at
// random, so it went on for minutes, and addbots handed out a whole set at once). The server loads them all here,
// in its first moment on the map. A dedicated server has hardly any of them by then; a host or an offline game has
// most already, and they are skipped.
function LoadOnServer(array<string> List)
{
	local int i, Loaded, Failed;
	local string S;

	for (i = 0; i < List.Length; i++)
	{
		if (FindObject(List[i], class'Class') != None)
			continue;
		if (DynamicLoadObject(List[i], class'Class', true) != None)
			Loaded++;
		else
		{
			Failed++;
			Log("Mut_BallisticPreLoad: Could not load weapon class" @ List[i]);
		}
	}

	S = "Mut_BallisticPreLoad:" @ (List.Length - Failed) @ "of" @ List.Length @ "weapon classes ready on the server," @ Loaded @ "loaded now,"
		@ (List.Length - Loaded - Failed) @ "were loaded already";
	if (Failed > 0)
		S = S $ "," @ Failed @ "could not be loaded";
	Log(S);
}

// A game type that hands out its own weapons, such as GunGame, gives its list here before this mutator's first tick.
// Only those are loaded then: not the list of the inventory mutator it runs with, nor the killstreak rewards.
// bNoCamos: its weapons never wear a camo, so the camo skins are not loaded either.
function SetGameWeapons(array<string> List, string Source, optional bool bNoCamos)
{
	local int i;

	bGameWeapons = true;
	GameWeaponSource = Source;
	GameWeapons.Length = 0;
	for (i = 0; i < List.Length; i++)
		AddUniqueString(GameWeapons, List[i]);

	if (bNoCamos && MyRI != None)
		MyRI.bEnableCamoLoading = false;
}

// Build weapon list dynamically from active BW mutators, falling back to config
function BuildWeaponList(out array<string> OutList)
{
	local Mutator M;
	local Mut_Outfitting OutfitMut;
	local Mut_TeamOutfitting TeamOutfitMut;
	local Mut_Loadout LoadoutMut;
	local Mut_ConflictLoadout ConflictMut;
	local Mut_BallisticSwap SwapMut;
	local Mut_BallisticArena ArenaMut;
	local Mut_BallisticMelee MeleeMut;
	local Mut_Killstreak StreakMut;
	local array<string> GroupWeapons;
	local string Source;
	local int i, j, t;

	if (bGameWeapons)
	{
		OutList = GameWeapons;
		NumRewards = 0;
		Log("Mut_BallisticPreLoad: Built weapon list from"@GameWeaponSource@"("$OutList.Length@"weapons)");
		return;
	}

	for (M = Level.Game.BaseMutator; M != None; M = M.NextMutator)
	{
		if (Mut_Outfitting(M) != None)
			OutfitMut = Mut_Outfitting(M);
		else if (Mut_TeamOutfitting(M) != None)
			TeamOutfitMut = Mut_TeamOutfitting(M);
		else if (Mut_Loadout(M) != None)
			LoadoutMut = Mut_Loadout(M);
		else if (Mut_ConflictLoadout(M) != None)
			ConflictMut = Mut_ConflictLoadout(M);
		else if (Mut_BallisticSwap(M) != None)
			SwapMut = Mut_BallisticSwap(M);
		else if (Mut_BallisticArena(M) != None)
			ArenaMut = Mut_BallisticArena(M);
		else if (Mut_BallisticMelee(M) != None)
			MeleeMut = Mut_BallisticMelee(M);
		else if (Mut_Killstreak(M) != None)
			StreakMut = Mut_Killstreak(M);
	}

	if (OutfitMut != None)
	{
		// Loadout groups 0-6
		Source = "Outfitting";
		for (i = 0; i < 7; i++)
		{
			GroupWeapons = OutfitMut.GetGroup(i);
			for (j = 0; j < GroupWeapons.Length; j++)
				AddUniqueString(OutList, GroupWeapons[j]);
		}
	}
	else if (TeamOutfitMut != None)
	{
		// Each team has its own groups
		Source = "Team Outfitting";
		for (i = 0; i < 7; i++)
			for (t = 0; t < 2; t++)
			{
				GroupWeapons = TeamOutfitMut.GetGroup(i, t);
				for (j = 0; j < GroupWeapons.Length; j++)
					AddUniqueString(OutList, GroupWeapons[j]);
			}
	}
	else if (LoadoutMut != None)
	{
		// Evolution system
		Source = "Loadout";
		for (i = 0; i < LoadoutMut.Items.Length; i++)
			AddUniqueString(OutList, LoadoutMut.Items[i].ItemName);
	}
	else if (ConflictMut != None)
	{
		Source = "Conflict";
		for (i = 0; i < ConflictMut.ConflictWeapons.Length; i++)
			AddUniqueString(OutList, ConflictMut.ConflictWeapons[i].ClassName);
	}
	else if (SwapMut != None)
	{
		// Whatever a pickup can turn into
		Source = "Pickups";
		for (i = 0; i < SwapMut.GetNumWeapons(); i++)
		{
			GroupWeapons = SwapMut.GetNewWeapons(i);
			for (j = 0; j < GroupWeapons.Length; j++)
				AddUniqueString(OutList, GroupWeapons[j]);
		}
	}
	else if (ArenaMut != None)
	{
		Source = "Arena";
		for (i = 0; i < ArenaMut.WeaponClasses.Length; i++)
			AddUniqueString(OutList, string(ArenaMut.WeaponClasses[i]));
	}
	else if (MeleeMut != None)
	{
		Source = "Melee";
		for (i = 0; i < MeleeMut.Replacements.Length; i++)
			for (j = 0; j < MeleeMut.Replacements[i].NewItems.Length; j++)
				if (class<Weapon>(MeleeMut.GetInventoryFor(MeleeMut.Replacements[i].NewItems[j])) != None)
					AddUniqueString(OutList, string(MeleeMut.GetInventoryFor(MeleeMut.Replacements[i].NewItems[j])));
	}

	if (OutList.Length == 0)
	{
		// Fall back to hardcoded config list
		Source = "config";
		for (i = 0; i < WeaponClassNames.Length; i++)
			AddUniqueString(OutList, WeaponClassNames[i]);
	}

	// Killstreak rewards turn up in any mode
	NumRewards = OutList.Length;
	if (StreakMut != None)
	{
		for (i = 0; i < StreakMut.Streak1s.Length; i++)
			AddUniqueString(OutList, StreakMut.Streak1s[i]);
		for (i = 0; i < StreakMut.Streak2s.Length; i++)
			AddUniqueString(OutList, StreakMut.Streak2s[i]);
	}
	NumRewards = OutList.Length - NumRewards;

	Log("Mut_BallisticPreLoad: Built weapon list from"@Source@"("$(OutList.Length - NumRewards)@"weapons) and"@NumRewards@"killstreak rewards");
}

// Whether a character's mesh is one of BW's own player models
static function bool IsPreloadedModel(string MeshName)
{
	return Left(MeshName, Len(default.PlayerModelPackage) + 1) ~= (default.PlayerModelPackage $ ".");
}

// BW's player models (the characters of BWGuy.upl, where they are installed) were loaded by the first pawn that wore one,
// in the middle of play: on the server, and on every client that saw it (some 20 ms for all seven with the files cached,
// longer from a slow disk). The server loads their meshes now, as the map starts, and has the clients load them too,
// with their skins.
function PreloadPlayerModels()
{
	local array<xUtil.PlayerRecord> Records;
	local int i, Num, Failed;
	local string S;

	class'xUtil'.static.GetPlayerList(Records);
	for (i = 0; i < Records.Length; i++)
	{
		if (!IsPreloadedModel(Records[i].MeshName))
			continue;
		if (DynamicLoadObject(Records[i].MeshName, class'Mesh', true) != None)
			Num++;
		else
		{
			Failed++;
			Log("Mut_BallisticPreLoad: Could not load player model" @ Records[i].MeshName @ "(" $ Records[i].DefaultName $ ")");
		}
	}

	if (Num + Failed == 0)
		return;
	// clients are only told to load them when the server has them
	if (Num > 0)
		MyRI.bPreloadPlayerModels = true;
	S = "Mut_BallisticPreLoad:" @ Num @ "of" @ (Num + Failed) @ "player models of" @ PlayerModelPackage @ "ready on the server";
	if (Failed > 0)
		S = S $ "," @ Failed @ "could not be loaded";
	Log(S);
}

function AddUniqueString(out array<string> Arr, string Value)
{
	local int i;

	// Menu headings and placeholders sit among the class names of some lists
	if (InStr(Value, ".") == -1 || Right(Value, 5) ~= "Dummy")
		return;

	for (i = 0; i < Arr.Length; i++)
		if (Arr[i] ~= Value)
			return;

	Arr[Arr.Length] = Value;
}

defaultproperties
{
	bEnablePreloading=True
	bEnableCamoLoading=False
	bEnableTextureLoading=True
	PlayerModelPackage="BWGuyAnim"
    bAddToServerPackages=True
    GroupName="BallisticPro: Resource Preload"
    FriendlyName="BallisticPro: Resource Preload"
    Description="Preloads weapon resources, designed for use with BallisticPro. This will improve overall performance on all machines"
} 
