//=============================================================================
// BallisticTab_Killstreaks

//
// Menu for selecting weapon loadout. Consists of several categories, user can
// pick what weapon they want for each category
//
// by Nolan "Dark Carnivour" Richert.
// Modified by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_Killstreaks extends MidGamePanel;

var bool					bInitialized; // showpanel
var bool					bLoadInitialized;

// Use GUILoadOutItems to select weapons. This control has some text with an image that cycles when you click on it
var automated GUILoadOutItem Item_Streak1, Item_Streak2;
var automated GUIComboBox	 cb_Streak1, cb_Streak2;
var Automated GUIImage MyBack, Box_Streak1, Box_Streak2, Streak1Back, Streak2Back;
var automated GUIHeader MyHeader;
var automated GUILabel	l_Receiving;

var bool bWeaponsLoaded;

var() array<String>								DefaultStreaks;

var() localized string QuickListText;

var localized string ReceivingText[2];

var KillstreakLRI KLRI;

function InitPanel()
{
	Super.InitPanel();

	Initialize();
}

function Initialize()
{
	if (bInitialized)
		return;

	Item_Streak1.OnItemChange = OnLoadoutItemChange;
	Item_Streak2.OnItemChange = OnLoadoutItemChange;

	Item_Streak1.SetItem(class'KillstreakConfig'.default.Killstreaks[0]);
	Item_Streak2.SetItem(class'KillstreakConfig'.default.Killstreaks[1]);

	KLRI = class'Mut_Killstreak'.static.GetKLRI(PlayerOwner().PlayerReplicationInfo);
	
	if (KLRI == None)
	{
		if (PlayerOwner().level.NetMode == NM_Client)
		{
			l_Receiving.Caption = ReceivingText[0];
			SetTimer(0.5, false);
		}
		else
		{
			l_Receiving.Caption = ReceivingText[1];
			SetTimer(0.1, false);
		}
	}
	
	else
	{		
		OnLRIAcquired();
	}

	bInitialized = true;
}

// timer is only here to attempt reacquisition of LRI
event Timer()
{
	if (KLRI != None) // retry weapon list init
	{
		OnLRIAcquired();
	}
	else if (PlayerOwner() != None && class'Mut_Killstreak'.static.GetKLRI(PlayerOwner().PlayerReplicationInfo) != None) // assign found lri
	{
		KLRI = class'Mut_Killstreak'.static.GetKLRI(PlayerOwner().PlayerReplicationInfo);
		OnLRIAcquired();
		return;
	}
	else // wait for lri
	{
		SetTimer(0.5, false);
	}
}

function OnLRIAcquired()
{
	if (!KLRI.bWeaponsReady)
		SetTimer(0.1, false);
	else 
		InitWeaponLists();
}

function InitWeaponLists()
{
	if(bWeaponsLoaded)
		return;

	LoadWeapons();

	cb_Streak1.List.bSorted=true;
	cb_Streak1.List.Sort();
	cb_Streak2.List.bSorted=true;
	cb_Streak2.List.Sort();
}

function LoadWeapons()
{
	local int i;
	local string IC, ICN;
	local Material IMat;
	local IntBox ICrds;

	// Load the weapons into their GUILoadOutItems

	for(i=0; i < KLRI.GroupLength(0); i++)
	{
		if (GetItemInfo(0, i, IC, IMat, ICN, ICrds))
		{
			Item_Streak1.AddItem(IC, IMat, ICN, ICrds);
   			cb_Streak1.AddItem(IC, ,ICN);
   			cb_Streak1.SetText(QuickListText);
   		}
	}
	
	for(i=0; i < KLRI.GroupLength(1); i++)
	{
		if (GetItemInfo(1, i, IC, IMat, ICN, ICrds))
		{
			Item_Streak2.AddItem(IC, IMat, ICN, ICrds);

   			cb_Streak2.AddItem(IC, ,ICN);
   			cb_Streak2.SetText(QuickListText);
   		}
	}
	
	Item_Streak1.SetItem(class'KillstreakConfig'.default.Killstreaks[0]);
	Item_Streak2.SetItem(class'KillstreakConfig'.default.Killstreaks[1]);
	
	class'BC_WeaponInfoCache'.static.EndSession();
	
	l_Receiving.Caption = "";

	bWeaponsLoaded=True;
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool GetItemInfo(int Group, int Index, out string ItemCap, out Material ItemImage, out string ItemClassName, optional out IntBox ImageCoords)
{
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i;

	if (KLRI.GetGroupItem(Group, Index) == "")
		return false;
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(KLRI.GetGroupItem(Group, Index), i);
	if (i==-1)
	{
		log("Error loading item for killstreaks: "$KLRI.GetGroupItem(Group, Index), 'Warning');
		return false;
	}
	ItemCap = WI.ItemName;
	ItemClassName = KLRI.GetGroupItem(Group, Index);
	if (WI.bIsBW)
	{
		ItemImage = WI.BigIconMaterial;
		ImageCoords.X1=-1; ImageCoords.X2=-1; ImageCoords.Y1=-1; ImageCoords.Y2=-1;
	}
	else
	{
		ItemImage = WI.SmallIconMaterial;
		ImageCoords = WI.SmallIconCoords;
	}
	return true;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	return false;
}

function SaveStreaks()
{
	if (!bWeaponsLoaded)
		return;
	
	if (Item_Streak1.Items.length > Item_Streak1.Index)
		class'KillstreakConfig'.default.Killstreaks[0] = Item_Streak1.Items[Item_Streak1.Index].Text;

	if (Item_Streak2.Items.length > Item_Streak2.Index)
		class'KillstreakConfig'.default.Killstreaks[1] = Item_Streak2.Items[Item_Streak2.Index].Text;
	
	class'KillstreakConfig'.static.StaticSaveConfig();
	
	KLRI.UpdateStreakChoices();
}

function OnLoadoutItemChange(GUIComponent Sender)
{
	SaveStreaks();
}

function InternalOnChange(GUIComponent Sender)
{
	if (KLRI == None || !KLRI.bWeaponsReady)
		return;
		
	if (Sender == cb_Streak1)
	{
		Item_Streak1.SetItem(cb_Streak1.GetExtra());
		Item_Streak1.OnItemChange(Item_Streak1);
	}
	
	else if (Sender == cb_Streak2)
	{
		Item_Streak2.SetItem(cb_Streak2.GetExtra());
		Item_Streak2.OnItemChange(Item_Streak2);
	}
}

defaultproperties
{
     Begin Object Class=GUILoadOutItem Name=Streak1Image
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="4 Kills"
         WinTop=0.200000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=Streak1Image.InternalOnDraw
         OnClick=Streak1Image.InternalOnClick
         OnRightClick=Streak1Image.InternalOnRightClick
     End Object
     Item_Streak1=GUILoadOutItem'BallisticProV55.BallisticTab_Killstreaks.Streak1Image'

     Begin Object Class=GUILoadOutItem Name=Streak2Image
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="9 Kills"
         WinTop=0.200000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=Streak2Image.InternalOnDraw
         OnClick=Streak2Image.InternalOnClick
         OnRightClick=Streak2Image.InternalOnRightClick
     End Object
     Item_Streak2=GUILoadOutItem'BallisticProV55.BallisticTab_Killstreaks.Streak2Image'

     Begin Object Class=GUIComboBox Name=cb_Streak1ComBox
         MaxVisibleItems=16
         Hint="Quick list of Streak1 items"
         WinTop=0.400000
         WinLeft=0.251563
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticTab_Killstreaks.InternalOnChange
         OnKeyEvent=cb_Streak1ComBox.InternalOnKeyEvent
     End Object
     cb_Streak1=GUIComboBox'BallisticProV55.BallisticTab_Killstreaks.cb_Streak1ComBox'

     Begin Object Class=GUIComboBox Name=cb_Streak2Box
         MaxVisibleItems=16
         Hint="Quick list of Streak2 items"
         WinTop=0.400000
         WinLeft=0.550977
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticTab_Killstreaks.InternalOnChange
         OnKeyEvent=cb_Streak2Box.InternalOnKeyEvent
     End Object
     cb_Streak2=GUIComboBox'BallisticProV55.BallisticTab_Killstreaks.cb_Streak2Box'

     Begin Object Class=GUIImage Name=ImageBoxStreak1
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.180000
         WinLeft=0.237500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Streak1=GUIImage'BallisticProV55.BallisticTab_Killstreaks.ImageBoxStreak1'

     Begin Object Class=GUIImage Name=ImageBoxStreak2
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.180000
         WinLeft=0.537500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Streak2=GUIImage'BallisticProV55.BallisticTab_Killstreaks.ImageBoxStreak2'

     Begin Object Class=GUIImage Name=Streak1BackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.200000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     Streak1Back=GUIImage'BallisticProV55.BallisticTab_Killstreaks.Streak1BackImage'

     Begin Object Class=GUIImage Name=Streak2BackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.200000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     Streak2Back=GUIImage'BallisticProV55.BallisticTab_Killstreaks.Streak2BackImage'
	 
     Begin Object Class=GUILabel Name=l_Receivinglabel
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.087000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.040000
     End Object
     l_Receiving=GUILabel'BallisticProV55.BallisticTab_Killstreaks.l_Receivinglabel'

     DefaultStreaks(0)="BallisticProV55.MRocketLauncher"
     DefaultStreaks(1)="BallisticProV55.RX22AFlamer"
     QuickListText="QuickList"
     ReceivingText(0)="Receiving..."
     ReceivingText(1)="Loading..."
}
