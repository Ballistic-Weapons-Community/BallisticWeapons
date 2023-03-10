class UTComp_xPlayer_BW extends UTComp_xPlayer;

struct UIWeaps 
{ 
	var array<Inventory> Items; 
};//List of items in a group

var bool			bIsInWeaponUI;		// Weapon selector UI is active
var UIWeaps			WeaponGroups[11];	// A list of all inventory groups and the items in them
var int				WGroup, WItem;		// Current inventory group and item highlited in UI
var String			GroupNames[11];		// key binding text displayed next to each group
var	Sound			WeapUIEnter;		// Sound when UI opens
var	Sound			WeapUIExit;			// Sound when UI is closed with alt fire
var	Sound			WeapUIFail;			// Sound when unable to change to selected weapon
var	Sound			WeapUIUse;			// Sound when switching to new weapon and leaving UI
var	Sound			WeapUICycle;		// Sound when moving selection to another weapon
var	Sound			WeapUIChange;		// Sound when moving selection to another group
var int				InventoryLength;	// Number of items last in the inventory chain. Use to see if inventory changes

var() localized string	WeapUIHelp[4];

var float			IconPulsePhase;		// Stuff for pulsing selected icon
var float			LastUIDrawTime;

var float           DesiredFlashScale;
var Vector          DesiredFlashFog;

var string BallisticMenu, WeaponStatsMenu;

replication
{
    unreliable if( Role==ROLE_Authority )
        ClientDmgFlash;
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
			C.DrawTileStretched(Texture'BW_Core_WeaponTex.UI.WeaponUIFrame', XS, YS);
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
				C.DrawTile(Texture'BW_Core_WeaponTex.Icons.BigIcon_NA', XS, YS, 0,0,512,256);
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
			C.DrawTile(Texture'BW_Core_WeaponTex.Icons.BigIcon_NA',
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

	if (UnrealPawn(Pawn) == None || (!class'BallisticPlayer'.default.bUseWeaponUI && !bIsInWeaponUI) || F == 1 || F == 10)
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
}// Cycle back through list

exec function PrevWeapon()
{
	local int OldGroupNum, i;

	if (UnrealPawn(Pawn) == None || (!class'BallisticPlayer'.default.bUseWeaponUI && !bIsInWeaponUI))
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

	if (UnrealPawn(Pawn) == None || (!class'BallisticPlayer'.default.bUseWeaponUI && !bIsInWeaponUI))
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

exec function GetLoadoutWeapon(byte Slot)
{
	GetWeaponOrSubclass(class'ClientOutfittingInterface'.default.LastLoadoutClasses[Slot]);
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
	
	if (class'ClientOutfittingInterface'.default.LastLoadoutClasses[2] == Pawn.Weapon.Class)
		GetWeaponOrSubclass (class'ClientOutfittingInterface'.default.LastLoadoutClasses[3]);
	else GetWeaponOrSubclass(class'ClientOutfittingInterface'.default.LastLoadoutClasses[2]);
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
	ClientOpenMenu(BallisticMenu);
}

// Command to access the ballistic config menu
exec simulated function BWStats()
{
	ClientOpenMenu(WeaponStatsMenu);
}

// Cheat to get all BW weapons...
exec function Reloaded()
{
	local class<Weapon> Weap;
	local Inventory Inv;
	local int i;
	local array<CacheManager.WeaponRecord> Recs;

	if (Level.Netmode != NM_Standalone || Pawn == None || Vehicle(Pawn) != None)
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

simulated function ReskinAll()
{
	local UTComp_BallisticPawn P;
	
	if(Level.NetMode == NM_DedicatedServer)
		return;
		
	foreach DynamicActors(class'UTComp_BallisticPawn', P)
	   P.ColorSkins();
}

simulated function MatchHudColor()
{
	local HudCDeathMatch DMHud;
	
	if(myHud==None || HudCDeathMatch(myHud)==None)
		return;
		
  DMHud=HudCDeathMatch(myHud);
  if(!class'UTComp_HudSettings'.default.bMatchHudColor)
  {
		DMHud.HudColorRed=class'HudCDeathMatch'.default.HudColorRed;
		DMHud.HudColorBlue=class'HudCDeathMatch'.default.HudColorBlue;
		return;
  }

	if(!class'UTComp_Settings'.default.bEnemyBasedSkins)
	{
		if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 3)
			DMHud.HudColorRed = class'UTComp_Settings'.default.RedTeammateUTCompSkinColor;
		else if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 2
	    || class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 1)
			DMHud.HudColorRed = class'UTComp_BallisticPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorRedTeammate];
	
		if(class'UTComp_Settings'.default.ClientSkinModeBlueEnemy == 3)
			DMHud.HudColorBlue = class'UTComp_Settings'.default.BlueEnemyUTCompSkinColor;
		else if(class'UTComp_Settings'.default.ClientSkinModeBlueEnemy == 2
	    || class'UTComp_Settings'.default.ClientSkinModeBlueEnemy == 1)
	    DMHud.HudColorBlue = class'UTComp_BallisticPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy];
	}
	else
	{
		if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 3)
		{
	    DMHud.HudColorBlue = class'UTComp_Settings'.default.RedTeammateUTCompSkinColor;
	    DMHud.HudColorRed = class'UTComp_Settings'.default.RedTeammateUTCompSkinColor;
		}
		else if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 2
		    || class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 1)
		{
	    DMHud.HudColorBlue = class'UTComp_BallisticPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorRedTeammate];
	    DMHud.HudColorRed = class'UTComp_BallisticPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorRedTeammate];
		}
	}
}

function ClientDmgFlash( float scale, vector fog )
{
	DesiredFlashScale = scale;
	DesiredFlashFog = 0.001 * fog;
}

// disallow scaling flash
function ClientFlash( float scale, vector fog )
{
    FlashScale = scale * vect(1,1,1);
    flashfog = 0.001 * fog;
	bOverrideDmgFlash = true;
}

function ViewFlash(float DeltaTime)
{
	local vector goalFog;
	local float goalScale, delta, Step;
    local PhysicsVolume ViewVolume;

    if ( Pawn != None )
    {
        if ( bBehindView )
            ViewVolume = Level.GetPhysicsVolume(CalcViewLocation);
        else
            ViewVolume = Pawn.HeadVolume;
    }

	if (bOverrideDmgFlash) //UT2k4 Style
	{
		delta = FMin(0.1, DeltaTime);
		goalScale = 1; // + ConstantGlowScale;
		goalFog = vect(0,0,0); // ConstantGlowFog;

		if ( ViewVolume != None )
		{
    		goalScale += ViewVolume.ViewFlash.X;
			goalFog += ViewVolume.ViewFog;
		}
			
		Step = 0.6 * delta;
		FlashScale.X = UpdateFlashComponent(FlashScale.X,step,goalScale);
		FlashScale = FlashScale.X * vect(1,1,1);

		FlashFog.X = UpdateFlashComponent(FlashFog.X,step,goalFog.X);
		FlashFog.Y = UpdateFlashComponent(FlashFog.Y,step,goalFog.Y);
		FlashFog.Z = UpdateFlashComponent(FlashFog.Z,step,goalFog.Z);
		if ( FlashFog.Z < 0.003 )
		{
			FlashFog.Z = 0;
			bOverrideDmgFlash=false;
		}
	}
	else //UT99 Style
	{
		delta = FMin(0.1, DeltaTime);
		goalScale = 1 + DesiredFlashScale + ConstantGlowScale;
		goalFog = DesiredFlashFog + ConstantGlowFog;

		if (ViewVolume != None ) 
		{
			goalScale += ViewVolume.ViewFlash.X;
			goalFog += ViewVolume.ViewFog;
		}

		DesiredFlashScale -= DesiredFlashScale * 2 * delta;
		DesiredFlashFog -= DesiredFlashFog * 2 * delta;
		FlashScale.X += (goalScale - FlashScale.X) * 10 * delta;
		FlashFog += (goalFog - FlashFog) * 10 * delta;

		if ( FlashScale.X > 0.981 )
			FlashScale.X = 1;
		FlashScale = FlashScale.X * vect(1,1,1);

		if ( FlashFog.X < 0.003 )
			FlashFog.X = 0;
		if ( FlashFog.Y < 0.003 )
			FlashFog.Y = 0;
		if ( FlashFog.Z < 0.003 )
			FlashFog.Z = 0;
	}
}

defaultproperties
{
     BallisticMenu="BallisticProV55.BallisticConfigMenuPro"
     WeaponStatsMenu="BallisticProV55.BallisticWeaponStatsMenu"
     ComboNameList(3)="BallisticProV55.Ballistic_ComboMiniMe"
}
