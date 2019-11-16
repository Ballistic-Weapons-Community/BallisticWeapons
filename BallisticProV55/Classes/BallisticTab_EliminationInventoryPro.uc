//=============================================================================
// BallisticTab_EliminationInventoryPro.
//
// Page where players choose their inventory for Conflict
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_EliminationInventoryPro extends MidGamePanel;

const INVENTORY_SIZE_MAX = 35;

var bool					bLoadInitialized;

var automated GUIListBox	lb_Weapons;
var Automated GUIImage		Box_WeapList, Box_Inventory, Pic_Weapon, Box_WeapIcon;
var automated GUILabel   	l_WeapTitle;
var automated GUIScrollTextBox	lb_Desc;
var Automated GUIButton BDone, BCancel, BStats;
var automated GUILabel	l_StatTime, l_StatFrags, l_StatEfficiency, l_StatDamageRate, l_StatSniperEff, l_StatShotgunEff, l_StatHazardEff, l_StatHeading, l_Loading;

var() localized string StatTimeCaption;
var() localized string StatFragsCaption;
var() localized string StatEffCaption;
var() localized string StatDmgRtCaption;
var() localized string StatSnprEffCaption;
var() localized string StatStgnEffCaption;
var() localized string StatHzrdEffCaption;

var() localized string HealthText;
var() localized string ArmorText;
var() localized string AmmoText;

var() Texture	HealthIcon;
var() Texture	ArmorIcon;
var() Texture	AmmoIcon;

struct Item
{
	var() String	Title;
	var() Material	Icon;
	var() string	ClassName;
	var() int		Size;
	var() string	Ammo;
	var() bool		bBad;
};
var() array<Item> Inventory;
var() int SpaceUsed;

var() material BoxTex;

var EliminationLRI EPRI;

var bool bWaitingWeaps, bWaitingSkill;

// Check for PRI update
function ShowPanel(bool bShow)
{
	super.ShowPanel(bShow);
	
	if (!bShow)
		return;
		
	lb_Weapons.List.OnChange = InternalOnChange;
	lb_Weapons.List.OnDblClick = InternalOnDblClick;
	EPRI = EliminationLRI(class'Mut_Ballistic'.static.GetBPRI(PlayerOwner().PlayerReplicationInfo));
	if (EPRI == None)
	{
		SetTimer(0.05, true);
		return;
	}
	DoInit();
}

//========================================================================
// Timer
//
// Waits for reception of weapons and skill requirements then initialises both
//========================================================================
event Timer()
{
	if (EPRI!=None)
	{
		if (bWaitingWeaps && EPRI.bHasList && (EPRI.LoadoutOption != 1 || EPRI.bHasSkillInfo))
		{
			bWaitingWeaps=false;
			InitWeaponLists();
		}
		if (bWaitingSkill && EPRI.bHasSkillInfo)
		{
			bWaitingSkill=false;
			DisplaySkills();
		}
		if (!bWaitingWeaps && !bWaitingSkill)
		{
			KillTimer();
		}
	}
	else if (PlayerOwner() != None && EliminationLRI(class'Mut_Ballistic'.static.GetBPRI(PlayerOwner().PlayerReplicationInfo)) !=None)
	{
		KillTimer();
		EPRI = EliminationLRI(class'Mut_Ballistic'.static.GetBPRI(PlayerOwner().PlayerReplicationInfo));
		DoInit();
		return;
	}
}

function DoInit()
{
	if (EPRI.LoadoutOption == 1)
	{
		EPRI.bHasSkillInfo = false;
		EPRI.RequestSkillInfo();
		if (!EPRI.bHasSkillInfo)
		{
			bWaitingSkill=true;
			SetTimer(0.1, true);
		}
		else
			DisplaySkills();
		lb_Desc.WinHeight = 0.23;
	}
	else
	{
		l_StatHeading.Caption =		"";
		l_StatTime.Caption =		"";
		l_StatFrags.Caption =		"";
		l_StatEfficiency.Caption =	"";
		l_StatSniperEff.Caption =	"";
		l_StatShotgunEff.Caption =	"";
		l_StatHazardEff.Caption =	"";
		l_StatDamageRate.Caption =	"";
		BStats.Hide();
	}

	if (EPRI.bHasList)
	{
		if (EPRI.LoadoutOption == 1 && !EPRI.bHasSkillInfo)
		{
			bWaitingWeaps=true;
			SetTimer(0.1, true);
		}
		else
		{
			InitWeaponLists();
		}
	}
	else
	{
		bWaitingWeaps=true;
		EPRI.FullInventoryList.length = 0;
		EPRI.RequirementsList.length = 0;
		EPRI.RequestFullList();
		SetTimer(0.1, true);
	}
}

simulated function DisplaySkills ()
{
	l_StatTime.Caption =		StatTimeCaption		$ EPRI.MySkillInfo.ElapsedTime;
	l_StatFrags.Caption =		StatFragsCaption	$ int(PlayerOwner().PlayerReplicationInfo.Score);
	if (PlayerOwner().PlayerReplicationInfo.Deaths == 0)
		l_StatEfficiency.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / 0.1;
	else
		l_StatEfficiency.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / PlayerOwner().PlayerReplicationInfo.Deaths;
	l_StatSniperEff.Caption =	StatSnprEffCaption	$ EPRI.MySkillInfo.SniperEff;
	l_StatShotgunEff.Caption =	StatStgnEffCaption	$ EPRI.MySkillInfo.ShotgunEff;
	l_StatHazardEff.Caption =	StatHzrdEffCaption	$ EPRI.MySkillInfo.HazardEff;
	l_StatDamageRate.Caption =	StatDmgRtCaption	$ EPRI.MySkillInfo.DamageRate;
}

//======================================================================
// InitWeaponLists
//
// Sets up the weapon list with the dividers, then adds weapons in after them by incrementing
// indices to get the new position. Adds the player's saved inventory to the inventory box.
// Won't add a weapon if it doesn't meet team requirements.
//
// Azarael: Uses Cache instead of DynamicLoadObject on the entire list, which caused 
// severe load lag.
//======================================================================
simulated function InitWeaponLists ()
{
	local class<actor> a;
	local class<Weapon> Weap;
	local class<ConflictItem> CI;
	local int i, lastIndex;
	local BC_WeaponInfoCache.WeaponInfo WI;

	l_Loading.Hide();

	lb_Weapons.List.Clear();

	//Only explicitly load saved inventory.	
	Inventory.length = 0;
	SpaceUsed = 0;
	
	for (i=0;i< EPRI.SavedInventory.length;i++)
	{
		a = class<Actor>(DynamicLoadObject(EPRI.SavedInventory[i], class'Class'));
		
		if (class<BallisticWeapon>(a) != None)
		{
			Weap = class<BallisticWeapon>(a);
			AddInventory(string(Weap), Weap, Weap.default.ItemName);
		}
		
		else if (class<ConflictItem>(a) != None)
		{
			CI = class<ConflictItem>(a);
			AddInventory(string(CI), CI, CI.default.ItemName);
		}
	}

	lastIndex = -1;
	
	//Use cache for the rest.
	//Weapons here will be loaded explicitly if they're selected in the list, via the Extra string data.
	// The Full Inventory List is already sorted by inventory group and Conflict item status.
	for (i=0; i < EPRI.FullInventoryList.length; i++)
	{
		if (!EPRI.WeaponRequirementsOk(EPRI.RequirementsList[i]))
			continue;
		
		if (InStr(EPRI.FullInventoryList[i], "CItem") != -1)
		{ 
			if (lastIndex != -1)
			{
				lastIndex = -1;
				lb_Weapons.List.Add("Misc",,"Mc",true);
			}
			
			CI = class<ConflictItem>(DynamicLoadObject(EPRI.FullInventoryList[i], class'Class'));
			
			if (CI != None)
				lb_Weapons.List.Add(CI.default.ItemName, , EPRI.FullInventoryList[i]);
		}
		
		else 
		{
			if (LoadWIFromCache(EPRI.FullInventoryList[i], WI))
			{
				if (WI.InventoryGroup > lastIndex)
				{
					lastIndex = WI.InventoryGroup;
					lb_Weapons.List.Add(class'BallisticTab_OutfittingPro'.static.GetHeading(lastIndex),,"Weapon Category",true);
				}
				
				lb_Weapons.List.Add(WI.ItemName, , EPRI.FullInventoryList[i]);
			}
		}
	}
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool LoadWIFromCache(string ClassStr, out BC_WeaponInfoCache.WeaponInfo WepInfo)
{
	local int i;

	WepInfo = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ClassStr, i);
	if (i==-1)
	{
		log("Error loading item for Conflict: "$ClassStr, 'Warning');
		return false;
	}
	return true;
}

function int GetItemSize(class<Weapon> Item)
{
	if (class<BallisticWeapon>(Item) != None)
		return class<BallisticWeapon>(Item).default.InventorySize;
	return 5;
}

function bool AddInventory(string ClassName, class<actor> InvClass, string FriendlyName)
{
	local int i, Size, A;
	local class<BallisticWeapon> Weap;
	local class<Weapon> 		WeaponClass;

	if (InvClass == None)
		return false;
	if (class<ConflictItem>(InvClass) != None)
	{
		Size = class<ConflictItem>(InvClass).default.Size/5;
		if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
			return false;

		SpaceUsed += Size;
		i = Inventory.length;
		Inventory.length = i + 1;
		Inventory[i].ClassName = string(InvClass);
		Inventory[i].Size = Size;
		Inventory[i].Title = FriendlyName;
		Inventory[i].Icon = class<ConflictItem>(InvClass).default.Icon;
		Inventory[i].Ammo = class<ConflictItem>(InvClass).default.ItemAmount;
		return true;
	}
	if (class<Weapon>(InvClass) == None)
		return false;

	WeaponClass = class<Weapon>(InvClass);
	Weap = class<BallisticWeapon>(WeaponClass);

	Size = GetItemSize(WeaponClass);
	if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
		return false;

	SpaceUsed += Size;
	i = Inventory.length;
	Inventory.length = i + 1;
	Inventory[i].ClassName = string(WeaponClass);
	Inventory[i].Size = Size;
	Inventory[i].Title = FriendlyName;
	A = WeaponClass.default.FireModeClass[0].default.AmmoClass.default.InitialAmount;
	if (Weap!=None)
	{
		if (!Weap.default.bNoMag)
			A += Weap.default.MagAmmo;
		Inventory[i].Icon = Weap.default.BigIconMaterial;
	}
	else
	{
		Inventory[i].Icon = None;
	}
	Inventory[i].Ammo = string(A);
	if (WeaponClass.default.FireModeClass[1].default.AmmoClass != None &&
		WeaponClass.default.FireModeClass[1].default.AmmoClass != WeaponClass.default.FireModeClass[0].default.AmmoClass &&
		WeaponClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount > 0)
		Inventory[i].Ammo = WeaponClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount $ " / " $ Inventory[i].Ammo;
	if (!EPRI.ValidateWeapon(ClassName))
		Inventory[i].bBad = true;
	return true;
}

//Add inventory to the bottom bar
function bool InternalOnDblClick(GUIComponent Sender)
{
	if (Sender==lb_Weapons.List)
	{
		AddInventory(string(lb_Weapons.List.GetObject()), class<actor>(lb_Weapons.List.GetObject()), lb_Weapons.List.Get());
	}
	return true;
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;
	local float X, ItemSize;
	local string s;

	//Figure out which currently existing item the player clicked on and then remove it.
	if (Sender==Box_Inventory)
	{
		X = Box_Inventory.Bounds[0];
		for (i=0;i<Inventory.length;i++)
		{
			ItemSize = (Box_Inventory.ActualWidth()/INVENTORY_SIZE_MAX) * Inventory[i].Size;
			if (Controller.MouseX > X && Controller.MouseX < X + ItemSize)
			{
				SpaceUsed -= Inventory[i].Size;
				Inventory.Remove(i, 1);
				return true;
			}
			X += ItemSize;
		}
	}
	
	else if (Sender==BStats && EPRI!=None)
	{
		Controller.OpenMenu("BallisticProV55.BallisticConflictInfoMenu");
		if (BallisticConflictInfoMenu(Controller.ActivePage) != None)
			BallisticConflictInfoMenu(Controller.ActivePage).LoadWeapons(self);
	}
	else if (Sender==BCancel) // CANCEL
		Controller.CloseMenu();
	//Set the client PRI's local inventory to ours, send it to the server if we're a client
	//Then close
	else if (Sender==BDone) // DONE
	{
		EPRI.SavedInventory.length = 0;
		for (i=0;i<Inventory.length;i++)
			EPRI.SavedInventory[i] = Inventory[i].ClassName;
		EPRI.SaveConfig();
		
		if (PlayerOwner().level.NetMode == NM_Client)
		{
			for (i=0;i<Inventory.length;i++)
				if (s == "")
					s = Inventory[i].ClassName;
				else
					s = s $ "|" $ Inventory[i].ClassName;
			EPRI.ServerSetInventory(s);
		}
		
		else
		{
			EPRI.Loudout = EPRI.SavedInventory;
			EPRI.UpdateInventory();
		}
		Controller.CloseMenu();
	}
	return true;
}

//===========================================================================
//Update the boxes when the weapon list changes
//
// Azarael: Uses Cache.
//===========================================================================
function InternalOnChange(GUIComponent Sender)
{
	local class<BallisticWeapon> BW;
	
	if (Sender==lb_Weapons.List)
	{
		l_WeapTitle.Caption = lb_Weapons.List.Get();
		
		//Section header.
		if (lb_Weapons.List.IsSection())
		{
			switch (lb_Weapons.List.GetExtra())
			{
				case "Mc" : lb_Desc.SetContent("Miscellaneous non-weapons and equipment."); break;
				case "HW" : lb_Desc.SetContent("Heavy Weapons.|These are cumbersome weapons that take up a lot of space and are generally more powerful than other weapon types."); break;
				case "SW" : lb_Desc.SetContent("Standard Ballistic Weapons.|Average weapons that are fairly powerful, but do not place a huge burden on the wielder."); break;
				case "SA" : lb_Desc.SetContent("Sidearms.|Light, fast handguns and similar weapons that provide lower than average firepower, but are smaller and generally quicker to use."); break;
				case "MW" : lb_Desc.SetContent("Melee Weapons.|Light, fast, vicious weapons that are used to hack, stab and fight in melee combat.."); break;
				case "GT" : lb_Desc.SetContent("Grenades and Traps.|Non firearm weapons that are used in a different manner. These are genreally small and powerful, but require different skills and tactics to use."); break;
				case "OW" : lb_Desc.SetContent("Other Weapons.|Non-Ballistic Weapons like the standard UT weapons and other, unidentified weapons."); break;
			}
			return;
		}
		//Check for items which have already been loaded.
		if (lb_Weapons.List.GetObject() != None)
		{
			if (class<BallisticWeapon>(lb_Weapons.List.GetObject()) != None)
			{
				Pic_Weapon.Image = class<BallisticWeapon>(lb_Weapons.List.GetObject()).default.BigIconMaterial;
				lb_Desc.SetContent(class<BallisticWeapon>(lb_Weapons.List.GetObject()).default.Description);
				return;
			}
			if (class<ConflictItem>(lb_Weapons.List.GetObject()) != None)
			{
				Pic_Weapon.Image = class<ConflictItem>(lb_Weapons.List.GetObject()).default.Icon;
				lb_Desc.SetContent(class<ConflictItem>(lb_Weapons.List.GetObject()).default.Description);
				return;
			}
			return;
		}
		
		//Item not loaded. Load it and add it as the Object for the weapons list's current position.
		if (lb_Weapons.List.GetExtra() != "")
		{
			BW = class<BallisticWeapon>(DynamicLoadObject(lb_Weapons.List.GetExtra(), class'Class'));
			if (BW != None)
			{
				Pic_Weapon.Image = BW.default.BigIconMaterial;
				lb_Desc.SetContent(BW.default.Description);
				lb_Weapons.List.SetObjectAtIndex(lb_Weapons.List.Index, BW);
			}
		}
	}	
}

//=========================================================
// DrawInventory
//=========================================================
function DrawInventory(Canvas C)
{
	local int i, j;
	local float X, ItemSize, IconX, IconY, XL, YL;
	local float MyX, MyY, MyW, MyH, ScaleFactor;
	local string s;

	ScaleFactor = float(Controller.ResX)/1600;
	MyX = Box_Inventory.Bounds[0] + 24*ScaleFactor;
	MyY = Box_Inventory.Bounds[1] + 24*ScaleFactor;
	MyW = Box_Inventory.ActualWidth() - 48*ScaleFactor;
	MyH = Box_Inventory.ActualHeight() - 48*ScaleFactor;

	C.SetDrawColor(255,255,255,255);
	C.SetPos(MyX, Myy);
	C.DrawTile(Controller.DefaultPens[1], MyW, MyH, 0, 0, 1, 1);

	C.SetDrawColor(64,64,64,255);
	X = MyX;
	for(i=0;i<INVENTORY_SIZE_MAX;i++)
	{
		C.SetPos(X, Myy);
		C.DrawTile(BoxTex, MyW/INVENTORY_SIZE_MAX, MyH, 0, 0, 128, 64);
		X += MyW/INVENTORY_SIZE_MAX;
	}

	X = MyX;
	C.Style = 6;
	for (i=0;i<Inventory.length;i++)
	{
		if (Inventory[i].bBad)
			C.SetDrawColor(255,64,64,255);
		else
			C.SetDrawColor(255,255,255,255);

			//can't exceed twice the height - Azarael
			ItemSize = (MyW/INVENTORY_SIZE_MAX) * Inventory[i].Size;
			IconX = FMin(ItemSize, MyH*2.3);
			IconY = IconX/2;

			if (Inventory[i].Icon != None)
			{	C.SetPos(X + (ItemSize - IconX)/2, MyY + (MyH-IconY)/2);
				C.DrawTile(Inventory[i].Icon, IconX, IconY, 0, 0, Inventory[i].Icon.MaterialUSize(), Inventory[i].Icon.MaterialVSize());	}


		if (Inventory[i].bBad)
			C.SetDrawColor(255,0,0,255);
		else
			C.SetDrawColor(255,128,0,255);
		C.SetPos(X, MyY);
		C.DrawTileStretched(BoxTex, ItemSize, MyH);

		C.SetDrawColor(32,255,0,255);
		C.Font = Controller.GetMenuFont("UT2SmallFont").GetFont(C.ClipX*0.8);
		C.StrLen(Inventory[i].Title, XL, YL);
		if (XL > ItemSize)
		{
			j = InStr(Inventory[i].Title, " ");
			s = Left(Inventory[i].Title, j);
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL*2 - 4*ScaleFactor);
			C.DrawText(s, false);

			s = Right(Inventory[i].Title, Len(Inventory[i].Title)-j-1);
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL - 4*ScaleFactor);
			C.DrawText(s, false);
		}
		else
		{
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL - 4*ScaleFactor);
			C.DrawText(Inventory[i].Title, false);
		}

		C.SetDrawColor(255,64,64,255);
		C.StrLen(Inventory[i].Ammo, XL, YL);
		C.SetPos(X + ItemSize - 6*ScaleFactor - XL, MyY + 4*ScaleFactor);
		C.DrawText(Inventory[i].Ammo, false);
		X += ItemSize;
	}
}

//========================
// defprops
//========================

defaultproperties
{
     Begin Object Class=GUIListBox Name=lb_WeaponsList
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_WeaponsList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Available items. Double-click to add them to your inventory."
         WinTop=0.070000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.580000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_Weapons=GUIListBox'BallisticProV55.BallisticTab_EliminationInventoryPro.lb_WeaponsList'

     Begin Object Class=GUIImage Name=Box_WeapListImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.035000
         WinLeft=0.035000
         WinWidth=0.430000
         WinHeight=0.650000
         RenderWeight=0.002000
     End Object
     Box_WeapList=GUIImage'BallisticProV55.BallisticTab_EliminationInventoryPro.Box_WeapListImg'

     Begin Object Class=GUIImage Name=Box_InventoryImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.700000
         WinHeight=0.200000
         RenderWeight=0.002000
         bAcceptsInput=True
         OnRendered=BallisticTab_EliminationInventoryPro.DrawInventory
         OnClick=BallisticTab_EliminationInventoryPro.InternalOnClick
     End Object
     Box_Inventory=GUIImage'BallisticProV55.BallisticTab_EliminationInventoryPro.Box_InventoryImg'

     Begin Object Class=GUIImage Name=Pic_WeaponImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Scaled
         WinTop=0.040000
         WinLeft=0.570000
         WinWidth=0.360000
         WinHeight=0.226000
         RenderWeight=0.004000
     End Object
     Pic_Weapon=GUIImage'BallisticProV55.BallisticTab_EliminationInventoryPro.Pic_WeaponImg'

     Begin Object Class=GUIImage Name=Box_WeapIconImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.020000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.266000
         RenderWeight=0.002000
     End Object
     Box_WeapIcon=GUIImage'BallisticProV55.BallisticTab_EliminationInventoryPro.Box_WeapIconImg'

     Begin Object Class=GUILabel Name=l_WeapTitlelabel
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.020000
         WinLeft=0.535000
         WinWidth=0.430000
         WinHeight=0.050000
     End Object
     l_WeapTitle=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_WeapTitlelabel'

     Begin Object Class=GUIScrollTextBox Name=WeaponDescription
         CharDelay=0.001500
         EOLDelay=0.250000
         bVisibleWhenEmpty=True
         OnCreateComponent=WeaponDescription.InternalOnCreateComponent
         FontScale=FNS_Small
         WinTop=0.280000
         WinLeft=0.530000
         WinWidth=0.450000
         WinHeight=0.400000
         RenderWeight=0.510000
         TabOrder=0
         bAcceptsInput=False
         bNeverFocus=True
     End Object
     lb_Desc=GUIScrollTextBox'BallisticProV55.BallisticTab_EliminationInventoryPro.WeaponDescription'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.920000
         WinLeft=0.100000
         WinWidth=0.200000
         TabOrder=0
         OnClick=BallisticTab_EliminationInventoryPro.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.BallisticTab_EliminationInventoryPro.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         WinTop=0.920000
         WinLeft=0.700000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticTab_EliminationInventoryPro.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'BallisticProV55.BallisticTab_EliminationInventoryPro.CancelButton'

     Begin Object Class=GUIButton Name=BStatButton
         Caption="Stats"
         WinTop=0.920000
         WinLeft=0.400000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticTab_EliminationInventoryPro.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bStats=GUIButton'BallisticProV55.BallisticTab_EliminationInventoryPro.BStatButton'

     Begin Object Class=GUILabel Name=l_StatTimeLabel
         Caption="Time"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.540000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatTime=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatTimeLabel'

     Begin Object Class=GUILabel Name=l_StatFragsLabel
         Caption="Frags"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.560000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatFrags=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatFragsLabel'

     Begin Object Class=GUILabel Name=l_StatEfficiencyLabel
         Caption="Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.580000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatEfficiency=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatEfficiencyLabel'

     Begin Object Class=GUILabel Name=l_StatDamageRateLabel
         Caption="DamageRate"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.600000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatDamageRate=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatDamageRateLabel'

     Begin Object Class=GUILabel Name=l_StatSniperEffLabel
         Caption="Sniper Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.620000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatSniperEff=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatSniperEffLabel'

     Begin Object Class=GUILabel Name=l_StatShotgunEffLabel
         Caption="Shotgun Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.640000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatShotgunEff=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatShotgunEffLabel'

     Begin Object Class=GUILabel Name=l_StatHazardEffLabel
         Caption="Hazard Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.660000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatHazardEff=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatHazardEffLabel'

     Begin Object Class=GUILabel Name=l_StatHeadingLabel
         Caption="Your Stats"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.510000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatHeading=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_StatHeadingLabel'

     Begin Object Class=GUILabel Name=l_LoadingLabel
         Caption="Receiving List..."
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         WinTop=0.400000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_Loading=GUILabel'BallisticProV55.BallisticTab_EliminationInventoryPro.l_LoadingLabel'

     StatTimeCaption="Time: "
     StatFragsCaption="Frags: "
     StatEffCaption="Efficiency: "
     StatDmgRtCaption="DamageRate: "
     StatSnprEffCaption="Sniper Efficiency: "
     StatStgnEffCaption="Shotgun Efficiency: "
     StatHzrdEffCaption="Hazard Efficiency: "
     BoxTex=Texture'BWEliminationTex.ui.SelectionBox'
}
