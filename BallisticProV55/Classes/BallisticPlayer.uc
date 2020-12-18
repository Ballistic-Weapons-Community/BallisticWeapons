//=============================================================================
// BallisticPlayer.
//
// Custom PlayerController to add some cool extra BW features...
// Include:
// -Weapon selection UI
// -Expanded access to "Reloaded" cheat
// -Select best weapon selects second best if best already out
//
// The weapon selection UI works as follows:
// -Can be disabled and skipped with bNoWeaponUI option
// -Local-side only. Chooses weapon based on local info
// -When an weapon group key is pressed, the UI appears and lists all weapons in all inv groups
// -Weapon group keys can be sued to select weapons in other group or repressed to move to anotehr weapon in the same group
// -Next and Prev cycles through the whole list
// -Fire button is used to close the UI and switch to the selected weapon
// -AltFire closes the UI without changing weapon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticPlayer extends xPlayer config(User);

var() globalconfig bool					bUseWeaponUI;	// Option to use the weap selection UI
struct UIWeaps { var array<Inventory> 	Items; };//List of items in a group
var 	bool							bIsInWeaponUI;		// Weapon selector UI is active
var 	UIWeaps							WeaponGroups[11];	// A list of all inventory groups and the items in them
var 	int								WGroup, WItem;		// Current inventory group and item highlited in UI
var 	String							GroupNames[11];		// key binding text displayed next to each group
var	Sound								WeapUIEnter;		// Sound when UI opens
var	Sound								WeapUIExit;			// Sound when UI is closed with alt fire
var	Sound								WeapUIFail;			// Sound when unable to change to selected weapon
var	Sound								WeapUIUse;			// Sound when switching to new weapon and leaving UI
var	Sound								WeapUICycle;		// Sound when moving selection to another weapon
var	Sound								WeapUIChange;		// Sound when moving selection to another group
var 	int								InventoryLength;	// Number of items last in the inventory chain. Use to see if inventory changes

var	globalconfig	float				ZoomTimeMod;		//A modifier on how fast zoom changes.
var 	globalconfig 	bool			bOldBehindView;

var Rotator								BehindViewAimRotator;

var globalconfig		float			SavedBehindDistFactor;
var float								BehindDistFactor;
var() localized string					WeapUIHelp[4];

var 	float							IconPulsePhase;		// Stuff for pulsing selected icon
var 	float							LastUIDrawTime;

var class<Weapon>						LastLoadoutClasses[7];
var class<Weapon>						LastStreaks[2];

replication
{
	reliable if (Role == ROLE_Authority)
		LastLoadoutClasses;
	reliable if (Role < ROLE_Authority)
		ServerCamDist, ServerReloaded;
}

simulated event PostBeginPlay()
{
    local int c;

    Super(UnrealPlayer).PostBeginPlay();


    for (c = 0; c < ArrayCount(ComboList); c++)
    {
        if ( ComboNameList[c] != "" )
        {
        	if (ComboNameList[c] ~= "XGame.ComboInvis")
        		ComboList[c] = class'XGame.Combo';
        	else ComboList[c] = class<Combo>(DynamicLoadObject(ComboNameList[c],class'Class'));
			if ( ComboList[c] == None )
				break;
			MinAdrenalineCost = FMin(MinAdrenalineCost,ComboList[c].Default.AdrenalineCost);
		}
    }
    FillCameraList();
    LastKillTime = -5.0;
}

exec simulated function ChangeCamDist(float F)
{
	SavedBehindDistFactor = F;
	
	SaveConfig();

	BehindDistFactor = F;
	if (Role < ROLE_Authority)
		ServerCamDist(SavedBehindDistFactor);
}

function ServerCamDist(float F)
{
	BehindDistFactor = F;
}

simulated function bool CheckInventoryChange()
{
	local Inventory inv;
	local int i;

	for (Inv=Pawn.Inventory; Inv!=None; Inv=Inv.Inventory)
		i++;
	if (i != InventoryLength)
	{
		InventoryLength = i;
		return true;
	}
	return false;
}

simulated function RenderOverlays(Canvas C)
{
	super.RenderOverlays(C);
	if (bIsInWeaponUI)
		DrawWeaponUI(C);
}

// Draw Weapon selection UI
simulated function DrawWeaponUI(Canvas C)
{
	local int i, j;
	local float ScaleFactor, XS, YS, IconXSize, IconYSize, OutXSize, SmoothPulsePhase;

	if (CheckInventoryChange())
		ListItems();

	IconPulsePhase = class'BUtil'.static.LoopFloat(IconPulsePhase, (Level.TimeSeconds-LastUIDrawTime)*2, 1, 0);
	if (IconPulsePhase > 0.5)
		SmoothPulsePhase = Smerp(IconPulsePhase*2-1, 1, 0);
	else
		SmoothPulsePhase = Smerp(IconPulsePhase*2, 0, 1);

	ScaleFactor = FMin(float(C.SizeX)/1600, float(C.SizeY)/1200) * class'HUD'.default.HudScale;
//	ScaleFactor = float(C.SizeX) / 1600 * class'HUD'.default.HudScale;
	XS = 128*ScaleFactor; YS = 64*ScaleFactor;
	LastUIDrawTime = Level.TimeSeconds;
	if (C.Style != 5)
		C.Style = 5;
	for (i=0;i<11;i++)
	{
		// Draw list of numbers down left side of screen
		C.SetPos(4*ScaleFactor, (188 + 96*i)*ScaleFactor);
		C.SetDrawColor(255, 255, 255);
		C.Font = class'BallisticWeapon'.static.GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.DrawText(GroupNames[i], false);

		for (j=0;j<WeaponGroups[i].Items.length;j++)
		{
			if (WeaponGroups[i].Items[j] == None)
				continue;
			// Draw background behind each icon. Color shows status of that item
			C.SetPos((96+132*j)*ScaleFactor, (160 + 96*i)*ScaleFactor);
			if (Weapon(WeaponGroups[i].Items[j]) != None && !Weapon(WeaponGroups[i].Items[j]).HasAmmo())
				C.SetDrawColor(255, 0, 0);
			else if (BallisticWeapon(WeaponGroups[i].Items[j]) != None && !BallisticWeapon(WeaponGroups[i].Items[j]).HasAmmoLoaded(255))
				C.SetDrawColor(255, 128, 0);
			else
				C.SetDrawColor(0, 0, 255);
			if (Weapon(WeaponGroups[i].Items[j]) != None && Weapon(WeaponGroups[i].Items[j]).ClientState != WS_Hidden)
				C.DrawColor.G += 128;
			if (i == WGroup && j == WItem)
			{
				C.DrawColor.R = Min(255, C.DrawColor.R+96);
				C.DrawColor.G = Min(255, C.DrawColor.G+96);
				C.DrawColor.B = Min(255, C.DrawColor.B+96);
			}
			C.DrawTileStretched(Texture'BallisticWeapons2.UI.WeaponUIFrame', XS, YS);
			// Draw the icons. Don't draw highlighted icon now though.
			if (i == WGroup && j == WItem)
				continue;
			C.SetDrawColor(255, 255, 255);
			if (BallisticWeapon(WeaponGroups[i].Items[j]) != None && BallisticWeapon(WeaponGroups[i].Items[j]).BigIconMaterial != None)
			{
				C.SetPos((96+132*j)*ScaleFactor, (160 + 96*i)*ScaleFactor);
				C.DrawTile(BallisticWeapon(WeaponGroups[i].Items[j]).BigIconMaterial,
				XS, YS, 0, 0, 512, 256);
			}
			else if (WeaponGroups[i].Items[j].IconMaterial != None)
			{
				IconXSize = WeaponGroups[i].Items[j].IconCoords.X2 - WeaponGroups[i].Items[j].IconCoords.X1;
				IconYSize = WeaponGroups[i].Items[j].IconCoords.Y2 - WeaponGroups[i].Items[j].IconCoords.Y1;
				OutXSize = YS*(IconXSize / IconYSize);
				C.SetPos((96+132*j)*ScaleFactor+XS/2-OutXSize/2, (160 + 96*i)*ScaleFactor);

				C.DrawTile(WeaponGroups[i].Items[j].IconMaterial, OutXSize, YS,
				WeaponGroups[i].Items[j].IconCoords.X1, WeaponGroups[i].Items[j].IconCoords.Y1,
				IconXSize, IconYSize);
			}
			else
			{
				C.SetPos((96+132*j)*ScaleFactor, (160 + 96*i)*ScaleFactor);
				C.DrawTile(Texture'BallisticUI2.Icons.BigIcon_NA', XS, YS, 0,0,512,256);
			}
		}
	}
	if (WeaponGroups[WGroup].Items.length > WItem && WeaponGroups[WGroup].Items[WItem] != None)
	{
		C.SetDrawColor(255, 255, 255);
		// Draw icon for highlighted item big and draw it last so it's drawn over everything else
		if (BallisticWeapon(WeaponGroups[WGroup].Items[WItem]) != None && BallisticWeapon(WeaponGroups[WGroup].Items[WItem]).BigIconMaterial != None)
		{
			XS = 192 + 128 * SmoothPulsePhase;
			YS = 96 + 64 * SmoothPulsePhase;

			C.SetPos(((160 + 132*WItem) - XS/2)*ScaleFactor, ((192 + 96*WGroup) - YS/2.5)*ScaleFactor);
			C.DrawTile(BallisticWeapon(WeaponGroups[WGroup].Items[WItem]).BigIconMaterial,
			XS*ScaleFactor, YS*ScaleFactor, 0, 0, 512, 256);
		}
		else if (WeaponGroups[WGroup].Items[WItem].IconMaterial != None)
		{
			IconXSize = WeaponGroups[WGroup].Items[WItem].IconCoords.X2 - WeaponGroups[WGroup].Items[WItem].IconCoords.X1;
			IconYSize = WeaponGroups[WGroup].Items[WItem].IconCoords.Y2 - WeaponGroups[WGroup].Items[WItem].IconCoords.Y1;

			YS = 96 + 64 * SmoothPulsePhase;

			OutXSize = YS*(IconXSize / IconYSize);
			C.SetPos(((160 + 132*WItem) - OutXSize/2)*ScaleFactor, ((192 + 96*WGroup) - YS/2.5)*ScaleFactor);

			C.DrawTile(WeaponGroups[WGroup].Items[WItem].IconMaterial, OutXSize*ScaleFactor, YS*ScaleFactor,
			WeaponGroups[WGroup].Items[WItem].IconCoords.X1, WeaponGroups[WGroup].Items[WItem].IconCoords.Y1, IconXSize, IconYSize);

		}
		else
		{
			XS = 192 + 128 * SmoothPulsePhase;
			YS = 96 + 64 * SmoothPulsePhase;

			C.SetPos(((160 + 132*WItem) - XS/2)*ScaleFactor, ((192 + 96*WGroup) - YS/2.5)*ScaleFactor);
			C.DrawTile(Texture'BallisticUI2.Icons.BigIcon_NA',
			XS*ScaleFactor, YS*ScaleFactor, 0, 0, 512, 256);
		}
		// Draw name of highlighted item
		C.Font = class'BallisticWeapon'.static.GetFontSizeIndex(C, -4 + int(2 * class'HUD'.default.HudScale));
		C.SetPos(C.ClipX - 512*ScaleFactor, 128*ScaleFactor);
		C.DrawText(WeaponGroups[WGroup].Items[WItem].ItemName, false);
		// Draw ammo for highlighted item
		C.SetPos(C.ClipX - 512*ScaleFactor, (128+32)*ScaleFactor);
		if (BallisticWeapon(WeaponGroups[WGroup].Items[WItem]) != None && !BallisticWeapon(WeaponGroups[WGroup].Items[WItem]).bNoMag)
			C.DrawText(BallisticWeapon(WeaponGroups[WGroup].Items[WItem]).AmmoAmount(0) @ BallisticWeapon(WeaponGroups[WGroup].Items[WItem]).MagAmmo, false);
		else if (Weapon(WeaponGroups[WGroup].Items[WItem]) != None)
			C.DrawText(Weapon(WeaponGroups[WGroup].Items[WItem]).AmmoAmount(0), false);
	}

	// Draw name of highlighted item
	C.Font = class'BallisticWeapon'.static.GetFontSizeIndex(C, -4 + int(2 * class'HUD'.default.HudScale));
	OutXSize=0;
	for (i=0;i<4;i++)
	{
		C.TextSize(WeapUIHelp[i], XS, YS);
		if (XS > OutXSize)
			OutXSize = XS;
	}
	OutXSize *= 1.1;
	C.SetDrawColor(0, 255, 0);
	C.SetPos(C.ClipX - OutXSize, 320*ScaleFactor);
	C.DrawText(WeapUIHelp[0], true);
	C.SetPos(C.ClipX - OutXSize, 352*ScaleFactor);
	C.DrawText(WeapUIHelp[1], true);
	C.SetPos(C.ClipX - OutXSize, 384*ScaleFactor);
	C.DrawText(WeapUIHelp[2], true);
	C.SetPos(C.ClipX - OutXSize, 416*ScaleFactor);
	C.DrawText(WeapUIHelp[3], true);
}

// Weapon group key pressed
exec function SwitchWeapon(byte F)
{
	local int i;
	local byte G;

	// Azarael - allow quick melee and xloc weapon switching even when the menu is on. Should also work to allow porting to next objective in Assault gametype

	if (UnrealPawn(Pawn) == None || (!class'BallisticPlayer'.default.bUseWeaponUI && !bIsInWeaponUI) || (BallisticWeapon(Pawn.Weapon) != None && BallisticWeapon(Pawn.Weapon).bRedirectSwitchToFiremode) || F == 1 || F == 10)
	{
		super.SwitchWeapon(F);
		return;
	}

	G = F;
	
	if (F == 0)
		F = 9;
	else if (F < 10)
		F--;

	if (bIsInWeaponUI)
	{
		if (F != WGroup)
		{
			ClientPlaySound(WeapUIChange);
			WGroup = F;
			WItem = 0;
		}
		else
		{
			ClientPlaySound(WeapUICycle);
			WItem++;
			if (WItem >= WeaponGroups[WGroup].Items.length)
				WItem = 0;
		}
	}

	else
	{
		//Azarael - bypass weapon UI with direct switch if there is only one weapon in the group.
		ListItems();
		if (WeaponGroups[F].Items.length == 1)
		{
			super.SwitchWeapon(G);
			return;
		}
		ClientPlaySound(WeapUIEnter);
		LastUIDrawTime = Level.TimeSeconds;
		bIsInWeaponUI = true;
		WGroup = F;
		if (Pawn.Weapon != None && ( (Pawn.Weapon.InventoryGroup == 0 && F==9) || (Pawn.Weapon.InventoryGroup-1 == F) ))
		{
			for(i=0;i<WeaponGroups[WGroup].Items.length-1;i++)
				if (WeaponGroups[WGroup].Items[i] == Pawn.Weapon)
				{
					WItem=i+1;
					return;
				}
		}
		WItem = 0;
	}
}
// Cycle back through list
exec function PrevWeapon()
{
	local int OldGroupNum, i;

	if (UnrealPawn(Pawn) == None || (!class'BallisticPlayer'.default.bUseWeaponUI && !bIsInWeaponUI) || (BallisticWeapon(Pawn.Weapon) != None && BallisticWeapon(Pawn.Weapon).bRedirectSwitchToFiremode))
	{
		super.PrevWeapon();
		return;
	}

    if ( Level.Pauser != None )
        return;
    if (!bIsInWeaponUI && Pawn != None && Pawn.Weapon != None && BallisticWeapon(Pawn.Weapon) != None && BallisticWeapon(Pawn.Weapon).AllowWeapPrevUI())
    {
		ClientPlaySound(WeapUIEnter);
		ListItems();
		LastUIDrawTime = Level.TimeSeconds;
		bIsInWeaponUI = true;
		WGroup = Pawn.Weapon.InventoryGroup;
		if (WGroup == 0)
			WGroup = 9;
		else if (WGroup < 10)
			WGroup--;
		WItem = 0;
		for(i=0;i<WeaponGroups[WGroup].Items.length-1;i++)
			if (WeaponGroups[WGroup].Items[i] == Pawn.Weapon)
			{
				WItem=i;
				break;
			}
    }
    if (bIsInWeaponUI)
    {
		ClientPlaySound(WeapUICycle);
		WItem--;
		if (WItem < 0)
		{
			OldGroupNum = WGroup;
			WGroup = class'BUtil'.static.Loop(WGroup, -1, 10, 0);
			while (WGroup != OldGroupNum && WeaponGroups[WGroup].Items.length < 1)
				WGroup = class'BUtil'.static.Loop(WGroup, -1, 10, 0);
			WItem = Max(0, WeaponGroups[WGroup].Items.length-1);
		}
    }
	else
		super.PrevWeapon();
}
// Cycle forward through list
exec function NextWeapon()
{
	local int OldGroupNum, i;

	if (UnrealPawn(Pawn) == None || (!class'BallisticPlayer'.default.bUseWeaponUI && !bIsInWeaponUI) || (BallisticWeapon(Pawn.Weapon) != None && BallisticWeapon(Pawn.Weapon).bRedirectSwitchToFiremode))
	{
		super.NextWeapon();
		return;
	}

    if ( Level.Pauser != None )
        return;
    if (!bIsInWeaponUI && Pawn != None && Pawn.Weapon != None && BallisticWeapon(Pawn.Weapon) != None && BallisticWeapon(Pawn.Weapon).AllowWeapNextUI())
    {
		ClientPlaySound(WeapUIEnter);
		ListItems();
		LastUIDrawTime = Level.TimeSeconds;
		bIsInWeaponUI = true;
		WGroup = Pawn.Weapon.InventoryGroup;
		if (WGroup == 0)
			WGroup = 9;
		else if (WGroup < 10)
			WGroup--;
		WItem = 0;
		for(i=0;i<WeaponGroups[WGroup].Items.length-1;i++)
			if (WeaponGroups[WGroup].Items[i] == Pawn.Weapon)
			{
				WItem=i;
				break;
			}
    }
    if (bIsInWeaponUI)
    {
		ClientPlaySound(WeapUICycle);
		WItem++;
		if (WItem >= WeaponGroups[WGroup].Items.length)
		{
			WItem = 0;
			OldGroupNum = WGroup;
			WGroup = class'BUtil'.static.Loop(WGroup, 1, 10, 0);
			while (WGroup != OldGroupNum && WeaponGroups[WGroup].Items.length < 1)
				WGroup = class'BUtil'.static.Loop(WGroup, 1, 10, 0);
		}
    }
	else
		super.NextWeapon();
}

exec function GetLoadoutWeapon(byte Slot)
{
	GetWeaponOrSubclass(LastLoadoutClasses[Slot]);
}

exec function GetWeaponOrSubclass(class<Weapon> NewWeaponClass )
{
    local Inventory Inv;

    if ( (Pawn == None) || (Pawn.Inventory == None) || (NewWeaponClass == None) )
        return;

    if ( (Pawn.Weapon != None) && (Pawn.Weapon.Class == NewWeaponClass) && (Pawn.PendingWeapon == None) )
    {
        Pawn.Weapon.Reselect();
        return;
    }

    if ( Pawn.PendingWeapon != None && Pawn.PendingWeapon.bForceSwitch )
        return;
		
	Inv = Pawn.FindInventoryType(NewWeaponClass);
	
	if (Inv == None)
		return;

	Pawn.PendingWeapon = Weapon(Inv);
	if ( !Pawn.PendingWeapon.HasAmmo() )
	{
		ClientMessage( Pawn.PendingWeapon.ItemName$Pawn.PendingWeapon.MessageNoAmmo );
		Pawn.PendingWeapon = None;
		return;
	}
	Pawn.Weapon.PutDown();
	return;
}

exec function ToggleMainWeapons()
{
	if (Pawn == None || Pawn.Weapon == None)
		return;
	
	if (LastLoadoutClasses[2] == Pawn.Weapon.Class)
		GetWeaponOrSubclass (LastLoadoutClasses[3]);
	else GetWeaponOrSubclass(LastLoadoutClasses[2]);
}

// Switch to chosen weapon
function WeapUIFire(float F)
{
	if (WeaponGroups[WGroup].Items.length > WItem && WeaponGroups[WGroup].Items[WItem] != None)
	{
		ClientPlaySound(WeapUIUse);
		bFire = 0;
		SetWeapon(Weapon(WeaponGroups[WGroup].Items[WItem]));
	}
	else
		ClientPlaySound(WeapUIFail);
	bIsInWeaponUI = false;
}
// Close UI, don't switch weapon
function WeapUIAltFire(float F)
{
	ClientPlaySound(WeapUIExit);
	bAltFire = 0;
	bIsInWeaponUI = false;
}
// Make sorted lists of all available weapons
function ListItems()
{
	local int i, j, G;
	local inventory Inv;

	for (i=0;i<11;i++)
		WeaponGroups[i].Items.length = 0;

	// Go through inventory and assemble list of weapons
	Inv = Pawn.Inventory;
	for (Inv=Pawn.Inventory;Inv!=None;Inv=Inv.inventory)
	{
		if (Weapon(Inv) != None)
		{
			G = Weapon(Inv).InventoryGroup;
			if (G == 0)
				G = 9;
			else if (G < 10)
				G--;
			for (j=0; j < WeaponGroups[G].Items.length; j++)
				if (Weapon(Inv).Priority > Weapon(WeaponGroups[G].Items[j]).Priority)
				{
					WeaponGroups[G].Items.Insert(j, 1);
					WeaponGroups[G].Items[j] = Inv;
					break;
				}
			if (j >= WeaponGroups[G].Items.length)
				WeaponGroups[G].Items[WeaponGroups[G].Items.length] = Inv;
		}
	}
	// Put duplicates at the end
	for (i=0;i<11;i++)
	{
		for (j=1;j<WeaponGroups[i].Items.length-1;j++)
			if (WeaponGroups[i].Items[j].class == WeaponGroups[i].Items[j-1].class)
			{
				WeaponGroups[i].Items[WeaponGroups[i].Items.length] = WeaponGroups[i].Items[j];
				WeaponGroups[i].Items.Remove(j,1);
				j--;
			}
	}
	// Key text for groups
	for (i=0;i<11;i++)
	{
		if (i == 9)
			j=0;
		else if (i > 9)
			j=i;
		else
			j = i+1;
		GroupNames[i] = class'Gameinfo'.static.GetKeyBindName("switchweapon"@j, self) $ ".";
	}
}

// Fire pressed. We need fire input for the weapon UI
exec function Fire ( optional float F )
{
    if ( Level.Pauser == PlayerReplicationInfo  || !bIsInWeaponUI)
		Super.Fire(F);
	else
	{
		WeapUIFire (F);
		bFire=0;
	}
}
exec function AltFire ( optional float F )
{
    if ( Level.Pauser == PlayerReplicationInfo || !bIsInWeaponUI)
		Super.AltFire(F);
	else
	{
		WeapUIAltFire (F);
		bAltFire=0;
	}
}
// New weapon changeing command. GetWeapon() only changed to a weapon of a class and didn't have enough power
exec function SetWeapon(Weapon NewWeapon)
{
    if ( Pawn == None || Pawn.Inventory == None || NewWeapon == None )
        return;

    if ( Pawn.Weapon != None && Pawn.Weapon == NewWeapon && Pawn.PendingWeapon == None )
    {
        Pawn.Weapon.Reselect();
        return;
    }

    if ( Pawn.PendingWeapon != None && Pawn.PendingWeapon.bForceSwitch )
        return;

	Pawn.PendingWeapon = NewWeapon;
	if (Pawn.Weapon != None)
		Pawn.Weapon.PutDown();
	else
		Pawn.ChangedWeapon();
}

// Subclaseed to switch to next best weapon when already holding best weapon
exec function SwitchToBestWeapon()
{
	local float rating;

	if ( Pawn == None || Pawn.Inventory == None )
		return;

    if ( (Pawn.PendingWeapon == None) )
    {
    	// Give current weapon low priority
    	if (Pawn.Weapon != None && level.TimeSeconds - Pawn.SpawnTime > 3)
			Pawn.Weapon.default.Priority = 0;
		// Now find the best weapon...
	    Pawn.PendingWeapon = Pawn.Inventory.RecommendWeapon(rating);
    	// Restore it's old priority
    	if (Pawn.Weapon != None)
			Pawn.Weapon.default.Priority = Pawn.Weapon.Priority;

	    if ( Pawn.PendingWeapon == Pawn.Weapon )
		    Pawn.PendingWeapon = None;
	    if ( Pawn.PendingWeapon == None )
    		return;
    }
	StopFiring();

	if ( Pawn.Weapon == None )
		Pawn.ChangedWeapon();
	else if ( Pawn.Weapon != Pawn.PendingWeapon )
		Pawn.Weapon.PutDown();
}

// Command to access the ballistic config menu
exec simulated function Ballistic()
{
	ClientOpenMenu ("BallisticProV55.BallisticConfigMenuPro");
}

// Weapon stats
exec simulated function BWStats()
{
	ClientOpenMenu ("BallisticProV55.BallisticWeaponStatsMenu");
}

// Weapon stats
exec simulated function Stats()
{
	ClientOpenMenu ("BallisticProV55.BallisticWeaponStatsMenu");
}

// Weapon stats
exec simulated function Manual()
{
	ClientOpenMenu ("BallisticProV55.BallisticWeaponStatsMenu");
}

// Weapon stats
exec simulated function BWManual()
{
	ClientOpenMenu ("BallisticProV55.BallisticWeaponStatsMenu");
}

// Cheat to get all BW weapons...

exec simulated function Reloaded()
{
	ServerReloaded();
}

final function ServerReloaded()
{
	local class<Weapon> Weap;
	local Inventory Inv;
	local int i;
	local array<CacheManager.WeaponRecord> Recs;

	if ((Level.Netmode != NM_Standalone && !PlayerReplicationInfo.bAdmin) || Pawn == None || Vehicle(Pawn) != None)
		return;

	class'CacheManager'.static.GetWeaponList(Recs);
	for (i=0;i<Recs.Length;i++)
	{
		if (!class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			continue;
		Weap = class<Weapon>(DynamicLoadObject(Recs[i].ClassName, class'Class'));
		if (Weap != None && ClassIsChildOf(Weap, class'BallisticWeapon'))
			Pawn.GiveWeapon(Recs[i].ClassName);
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	for(Inv=Pawn.Inventory; Inv!=None; Inv=Inv.Inventory)
		if (Weapon(Inv)!=None)
			Weapon(Inv).SuperMaxOutAmmo();
}


//===========================================================================
// Behind View support
//
// Over the shoulder
//===========================================================================
function CalcBehindView(out vector CameraLocation, out rotator CameraRotation, float Dist)
{
    local vector View,HitLocation,HitNormal;
    local float ViewDist,RealDist;
    local vector globalX,globalY,globalZ;
    local vector localX,localY,localZ;
	
	if (bOldBehindView || ViewTarget != Pawn || !Pawn.bProjTarget)
	{
		Super.CalcBehindView(CameraLocation, CameraRotation, Dist);
		return;
	}

    CameraRotation = Rotation;
    CameraRotation.Roll = 0;
	
	GetAxes(CameraRotation, localX, localY, localZ);
	
	CameraLocation.Z += 22;
	CameraLocation += localY * 1.8 * CameraDist;// * BehindDistFactor;
	CameraLocation += localZ * 3.4 * CameraDist;// * BehindDistFactor;

    // add view rotation offset to cameraview (amb)
    CameraRotation += CameraDeltaRotation;

    View = vect(1,0,0) >> CameraRotation;

    // add view radius offset to camera location and move viewpoint up from origin (amb)
    RealDist = Dist;
    Dist += CameraDeltaRad;

	Dist *=  BehindDistFactor;
    if( Trace( HitLocation, HitNormal, CameraLocation - Dist * vector(CameraRotation), CameraLocation,false,vect(10,10,10) ) != None )
        ViewDist = FMin( (CameraLocation - HitLocation) Dot View, Dist );
    else
        ViewDist = Dist;

    if ( !bBlockCloseCamera || !bValidBehindCamera || (ViewDist > 10 + FMax(ViewTarget.CollisionRadius, ViewTarget.CollisionHeight)) )
	{
		bValidBehindCamera = true;
		OldCameraLoc = CameraLocation - ViewDist * View;
		OldCameraRot = CameraRotation;
	}
	else
		SetRotation(OldCameraRot);

    CameraLocation = OldCameraLoc;
    CameraRotation = OldCameraRot;

    // add view swivel rotation to cameraview (amb)
    GetAxes(CameraSwivel,globalX,globalY,globalZ);
    localX = globalX >> CameraRotation;
    localY = globalY >> CameraRotation;
    localZ = globalZ >> CameraRotation;
    CameraRotation = OrthoRotation(localX,localY,localZ);
}

//Free aim in behind view.
simulated function rotator GetViewRotation()
{
	if (Pawn != None)
	{	
		if ( bBehindView )
		{
			if (bOldBehindView || Vehicle(Pawn) != None) 
				return Pawn.Rotation;
			return TraceView();	
		}
	}
    return Rotation;
}

simulated function rotator TraceView()
{
	local Vector HitLocation, HitNormal;
	
	if ( LastPlayerCalcView == Level.TimeSeconds && CalcViewActor != None && CalcViewActor.Location == CalcViewActorLocation )
		return BehindViewAimRotator;
	if (Trace( HitLocation, HitNormal, 15000 * vector(OldCameraRot) + OldCameraLoc, OldCameraLoc,false) != None)
		BehindViewAimRotator = Rotator(HitLocation - (Pawn.Location + Pawn.EyePosition()));
	else BehindViewAimRotator = Rotator(15000 * vector(OldCameraRot) + OldCameraLoc - (Pawn.Location + Pawn.EyePosition()));
	return BehindViewAimRotator;
}

function rotator AdjustAim(FireProperties FiredAmmunition, vector projStart, int aimerror)
{
    local vector FireDir, AimSpot, HitNormal, HitLocation, OldAim, AimOffset;
    local actor BestTarget;
    local float bestAim, bestDist, projspeed;
    local actor HitActor;
    local bool bNoZAdjust, bLeading;
    local rotator AimRot;

    FireDir = vector(GetViewRotation());
    if ( FiredAmmunition.bInstantHit )
        HitActor = Trace(HitLocation, HitNormal, projStart + 10000 * FireDir, projStart, true);
    else
        HitActor = Trace(HitLocation, HitNormal, projStart + 4000 * FireDir, projStart, true);
    if ( (HitActor != None) && HitActor.bProjTarget )
    {
        BestTarget = HitActor;
        bNoZAdjust = true;
        OldAim = HitLocation;
        BestDist = VSize(BestTarget.Location - Pawn.Location);
    }
    else
    {
        // adjust aim based on FOV
        bestAim = 0.90;
        if ( (Level.NetMode == NM_Standalone) && bAimingHelp )
        {
            bestAim = 0.93;
            if ( FiredAmmunition.bInstantHit )
                bestAim = 0.97;
            if ( FOVAngle < DefaultFOV - 8 )
                bestAim = 0.99;
        }
        else if ( FiredAmmunition.bInstantHit )
                bestAim = 1.0;
        BestTarget = PickTarget(bestAim, bestDist, FireDir, projStart, FiredAmmunition.MaxRange);
        if ( BestTarget == None )
        {
            return GetViewRotation();
        }
        OldAim = projStart + FireDir * bestDist;
    }
	InstantWarnTarget(BestTarget,FiredAmmunition,FireDir);
	ShotTarget = Pawn(BestTarget);
    if ( !bAimingHelp || (Level.NetMode != NM_Standalone) )
    {
        return GetViewRotation();
    }

    // aim at target - help with leading also
    if ( !FiredAmmunition.bInstantHit )
    {
        projspeed = FiredAmmunition.ProjectileClass.default.speed;
        BestDist = vsize(BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart);
        bLeading = true;
        FireDir = BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
        // if splash damage weapon, try aiming at feet - trace down to find floor
        if ( FiredAmmunition.bTrySplash
            && ((BestTarget.Velocity != vect(0,0,0)) || (BestDist > 1500)) )
        {
            HitActor = Trace(HitLocation, HitNormal, AimSpot - BestTarget.CollisionHeight * vect(0,0,2), AimSpot, false);
            if ( (HitActor != None)
                && FastTrace(HitLocation + vect(0,0,4),projstart) )
                return rotator(HitLocation + vect(0,0,6) - projStart);
        }
    }
    else
    {
        FireDir = BestTarget.Location - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
    }
    AimOffset = AimSpot - OldAim;

    // adjust Z of shooter if necessary
    if ( bNoZAdjust || (bLeading && (Abs(AimOffset.Z) < BestTarget.CollisionHeight)) )
        AimSpot.Z = OldAim.Z;
    else if ( AimOffset.Z < 0 )
        AimSpot.Z = BestTarget.Location.Z + 0.4 * BestTarget.CollisionHeight;
    else
        AimSpot.Z = BestTarget.Location.Z - 0.7 * BestTarget.CollisionHeight;

    if ( !bLeading )
    {
        // if not leading, add slight random error ( significant at long distances )
        if ( !bNoZAdjust )
        {
            AimRot = rotator(AimSpot - projStart);
            if ( FOVAngle < DefaultFOV - 8 )
                AimRot.Yaw = AimRot.Yaw + 200 - Rand(400);
            else
                AimRot.Yaw = AimRot.Yaw + 375 - Rand(750);
            return AimRot;
        }
    }
    else if ( !FastTrace(projStart + 0.9 * bestDist * Normal(FireDir), projStart) )
    {
        FireDir = BestTarget.Location - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
    }

    return rotator(AimSpot - projStart);
}

//===========================================================================
// Zoom fix
//===========================================================================
function AdjustView(float DeltaTime )
{
    // teleporters affect your FOV, so adjust it back down
    if ( FOVAngle != DesiredFOV )
    {
        if ( FOVAngle > DesiredFOV )
            FOVAngle = FOVAngle - FMax(7, 0.9 * DeltaTime * (FOVAngle - DesiredFOV));
        else
            FOVAngle = FOVAngle - FMin(-7, 0.9 * DeltaTime * (FOVAngle - DesiredFOV));
        if ( Abs(FOVAngle - DesiredFOV) <= 10 )
            FOVAngle = DesiredFOV;
    }

    // adjust FOV for weapon zooming
    if ( bZooming )
    {
		if (DesiredZoomLevel < ZoomLevel)
			ZoomLevel = FMax(ZoomLevel - (DeltaTime * ZoomTimeMod), DesiredZoomLevel);
        else ZoomLevel = FMin(ZoomLevel + (DeltaTime * ZoomTimeMod), DesiredZoomLevel);
        DesiredFOV = FClamp(90.0 - (ZoomLevel * 88.0), 1, 170);
    }
}
//===========================================================================
// Stock bugs and fixes
//===========================================================================

//Disallow auto-taunt except in offline games
function bool AutoTaunt()
{
	if (Level.NetMode == NM_Standalone)
		return Super.AutoTaunt();
	return false;
}

//Prevent rolling view bug caused by taking massive damage.
function DamageShake(int damage)
{
    Super.DamageShake(Min(damage, 50));
}

//AskForPawn label fix
function AskForPawn()
{
	if ( IsInState('GameEnded') )
		ClientGotoState('GameEnded', 'Begin');
	else if ( IsInState('RoundEnded') )
		ClientGotoState('RoundEnded', 'Begin');
	else if (IsInState('Spectating'))
		ClientGotoState('Spectating', '');
	else if ( Pawn != None )
		GivePawn(Pawn);
	else
	{
		bFrozen = false;
		ServerRestartPlayer();
	}
}

//Ignoring ServerSpectate in movement state code
state PlayerWalking
{
	ignores SeePlayer, HearNoise, Bump, ServerSpectate;
	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
    {
        local vector OldAccel;
        local bool OldCrouch;
		
		if ( Pawn == None )
			return;
		if ( (DoubleClickMove == DCLICK_Active) && (Pawn.Physics == PHYS_Falling) )
			DoubleClickDir = DCLICK_Active;
		else if ( (DoubleClickMove != DCLICK_None) && (DoubleClickMove < DCLICK_Active) )
		{
			if ( UnrealPawn(Pawn).Dodge(DoubleClickMove) )
				DoubleClickDir = DCLICK_Active;
		}
        OldAccel = Pawn.Acceleration;
        if ( Pawn.Acceleration != NewAccel )
			Pawn.Acceleration = NewAccel;
		if ( bDoubleJump && (bUpdating || Pawn.CanDoubleJump()) )
			Pawn.DoDoubleJump(bUpdating);
        else if ( bPressedJump )
			Pawn.DoJump(bUpdating);

		if (!bBehindView)
			Pawn.SetViewPitch(Rotation.Pitch);
		else
			Pawn.SetViewPitch(BehindViewAimRotator.Pitch);

        if ( Pawn.Physics != PHYS_Falling )
        {
            OldCrouch = Pawn.bWantsToCrouch;
            if (bDuck == 0)
                Pawn.ShouldCrouch(false);
            else if ( Pawn.bCanCrouch )
                Pawn.ShouldCrouch(true);
        }
    }
}

state PlayerClimbing
{
	ignores SeePlayer, HearNoise, Bump, ServerSpectate;
}

state PlayerDriving
{
	ignores SeePlayer, HearNoise, Bump, ServerSpectate;
}

state PlayerSwimming
{
	ignores SeePlayer, HearNoise, Bump, ServerSpectate;
}

state PlayerSpaceFlying
{
	ignores SeePlayer, HearNoise, Bump, ServerSpectate;
}

auto state PlayerWaiting
{
	ignores SeePlayer, HearNoise, NotifyBump, TakeDamage, PhysicsVolumeChange, NextWeapon, PrevWeapon, SwitchToBestWeapon, ServerSpectate;
}

state WaitingForPawn
{
	ignores SeePlayer, HearNoise, KilledBy, SwitchWeapon, ServerSpectate;
}

//This command is useful
exec function ViewSelf()
{
	ServerViewSelf();
}

function AwardAdrenaline(float amount)
{
	if (bGodMode)
		return;
	if ( bAdrenalineEnabled )
	{
		if ( (Adrenaline < AdrenalineMax) && (Adrenaline+amount >= AdrenalineMax) && ((Pawn == None) || !Pawn.InCurrentCombo()) )
			ClientDelayedAnnouncementNamed('Adrenalin',15);
		Super.AwardAdrenaline(Amount);
	}
}

//===========================================================================
//Titan RPG's fixes
//===========================================================================
//Allowing jump/crouch for up/down flying control!
state PlayerFlying
{
ignores SeePlayer, HearNoise, Bump, ServerSpectate;

	//copied from PlayerSwimming, updated
    function PlayerMove(float DeltaTime)
    {
        local rotator oldRotation;
        local vector X,Y,Z, NewAccel;

        GetAxes(Rotation, X, Y, Z);

        NewAccel = aForward * X + aStrafe * Y + aUp*vect(0,0,1);
		
        if ( VSize(NewAccel) < 1.0 )
            NewAccel = vect(0,0,0);

        // Update rotation.
        oldRotation = Rotation;
        UpdateRotation(DeltaTime, 2);

        if ( Role < ROLE_Authority ) // then save this move and replicate it
            ReplicateMove(DeltaTime, NewAccel, DCLICK_None, OldRotation - Rotation);
        else
            ProcessMove(DeltaTime, NewAccel, DCLICK_None, OldRotation - Rotation);
    }
}

// === FIXING SLOW MOUSE MOVEMENT WHILE USING MAGNET ===
// Player movement.
// Player walking on walls
state PlayerSpidering
{
ignores SeePlayer, HearNoise, Bump, ServerSpectate;

    // if spider mode, update rotation based on floor
    function UpdateRotation(float DeltaTime, float maxPitch)
    {
        local rotator ViewRotation;
        local vector MyFloor, CrossDir, FwdDir, OldFwdDir, OldX, RealFloor;

        if ( bInterpolating || Pawn.bInterpolating )
        {
            ViewShake(deltaTime);
            return;
        }

        TurnTarget = None;
        bRotateToDesired = false;
        bSetTurnRot = false;

        if ( (Pawn.Base == None) || (Pawn.Floor == vect(0,0,0)) )
            MyFloor = vect(0,0,1);
        else
            MyFloor = Pawn.Floor;

        if ( MyFloor != OldFloor )
        {
            // smoothly change floor
            RealFloor = MyFloor;
            MyFloor = Normal(6*DeltaTime * MyFloor + (1 - 6*DeltaTime) * OldFloor);
            if ( (RealFloor Dot MyFloor) > 0.999 )
                MyFloor = RealFloor;
			else
			{
				// translate view direction
				CrossDir = Normal(RealFloor Cross OldFloor);
				FwdDir = CrossDir Cross MyFloor;
				OldFwdDir = CrossDir Cross OldFloor;
				ViewX = MyFloor * (OldFloor Dot ViewX)
							+ CrossDir * (CrossDir Dot ViewX)
							+ FwdDir * (OldFwdDir Dot ViewX);
				ViewX = Normal(ViewX);

				ViewZ = MyFloor * (OldFloor Dot ViewZ)
							+ CrossDir * (CrossDir Dot ViewZ)
							+ FwdDir * (OldFwdDir Dot ViewZ);
				ViewZ = Normal(ViewZ);
				OldFloor = MyFloor;
				ViewY = Normal(MyFloor Cross ViewX);
			}
        }

		//aTurn - Mouse X Axis difference
		//aLookUp - Mouse Y Axis difference
		
        if ( (aTurn != 0) || (aLookUp != 0) )
        {
            // adjust Yaw based on aTurn
            if ( aTurn != 0 )
            	//corrects the mouse speed -pd
                ViewX = Normal(ViewX + 5 * ViewY * Sin(0.0005*DeltaTime*aTurn));

            // adjust Pitch based on aLookUp
            if ( aLookUp != 0 )
            {
                OldX = ViewX;
                //corrects the mouse speed -pd
                ViewX = Normal(ViewX + 5 * ViewZ * Sin(0.0005*DeltaTime*aLookUp));
                ViewZ = Normal(ViewX Cross ViewY);

                // bound max pitch
                if ( (ViewZ Dot MyFloor) < 0.707   )
                {
                    OldX = Normal(OldX - MyFloor * (MyFloor Dot OldX));
                    if ( (ViewX Dot MyFloor) > 0)
                        ViewX = Normal(OldX + MyFloor);
                    else
                        ViewX = Normal(OldX - MyFloor);

                    ViewZ = Normal(ViewX Cross ViewY);
                }
            }

            // calculate new Y axis
            ViewY = Normal(MyFloor Cross ViewX);
        }
		
        ViewRotation =  OrthoRotation(ViewX,ViewY,ViewZ);
        SetRotation(ViewRotation);
        ViewShake(deltaTime);
        ViewFlash(deltaTime);
        Pawn.FaceRotation(ViewRotation, deltaTime );
    }
}

// end Titan RPG handling

function ViewFlash(float DeltaTime)
{
    local vector goalFog;
    local float goalscale, delta, Step;
    local PhysicsVolume ViewVolume;

    delta = FMin(0.1, DeltaTime);
    goalScale = 1; // + ConstantGlowScale;
    goalFog = vect(0,0,0); // ConstantGlowFog;

    if ( Pawn != None )
    {
		if ( bBehindView )
			ViewVolume = Level.GetPhysicsVolume(CalcViewLocation);
		else
			ViewVolume = Pawn.HeadVolume;

		goalScale += ViewVolume.ViewFlash.X;
		goalFog += ViewVolume.ViewFog;
	}
		
	Step = 0.6 * delta;
	FlashScale.X = UpdateFlashComponent(FlashScale.X,step,goalScale);
    FlashScale = FlashScale.X * vect(1,1,1);

	FlashFog.X = UpdateFlashComponent(FlashFog.X,step,goalFog.X);
	FlashFog.Y = UpdateFlashComponent(FlashFog.Y,step,goalFog.Y);
	FlashFog.Z = UpdateFlashComponent(FlashFog.Z,step,goalFog.Z);
}

simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	Super.DisplayDebug(Canvas, YL, YPos);

	Canvas.SetDrawColor(255, 255, 255);
	Canvas.DrawText("Rotation:"@Rotation@"Pawn Rotation:"@Pawn.Rotation@"Smooth View Yaw:"@Pawn.SmoothViewYaw@"Aim rotator:"@BehindViewAimRotator);
	YPos += YL;
	Canvas.SetPos(4, YPos);
}

defaultproperties
{
     WeapUIEnter=Sound'MenuSounds.selectDshort'
     WeapUIExit=Sound'MenuSounds.selectK'
     WeapUIFail=Sound'MenuSounds.denied1'
     WeapUIUse=Sound'MenuSounds.selectJ'
     WeapUICycle=Sound'MenuSounds.MS_ListChangeDown'
     WeapUIChange=Sound'MenuSounds.MS_ListChangeUp'
     ZoomTimeMod=1.500000
     SavedBehindDistFactor=1.000000
	 InputClass=class'BallisticProV55.BallisticPlayerInput'
     BehindDistFactor=1.000000
     WeapUIHelp(0)="Fire to confirm selection."
     WeapUIHelp(1)="Altfire to exit UI."
     WeapUIHelp(2)="Next and Previous Weapon to cycle."
     WeapUIHelp(3)="Weapon Numbers to skip to group."
     ComboNameList(3)="BallisticProV55.Ballistic_ComboMiniMe"
     AnnouncerLevel=1
     PawnClass=Class'BallisticProV55.BallisticPawn'
}
