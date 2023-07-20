//=============================================================================
// BallisticLoadOutMenu.
//
// Menu for players to select their inventory for Mut_Loadout (Evolution)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticLoadOutMenu extends UT2K4GUIPage;

// Use GUILoadOutItems to select weapons. This control has some text with an image that cycles when your click on it
var automated GUILoadOutItem Item_Melee, Item_SideArm, Item_Primary, Item_Secondary, Item_Grenade;
var automated GUIComboBox	 cb_Melee, cb_SideArm, cb_Primary, cb_Secondary, cb_Grenade;
var Automated GUIImage MyBack, Box_Melee, Box_SideArm, Box_Primary, Box_Secondary, Box_Grenade, MeleeBack, SideArmBack, PrimaryBack, SecondaryBack, GrenadeBack;
var Automated GUIButton BDone, BCancel, BStats;
var automated GUIHeader MyHeader;
var automated GUILabel	l_Receiving, l_StatTime, l_StatFrags, l_StatEfficiency, l_StatDamageRate, l_StatSniperEff, l_StatShotgunEff, l_StatHazardEff, l_StatHeading;

var() localized string QuickListText;

var localized string ReceivingText[2];

var() localized string StatTimeCaption;
var() localized string StatFragsCaption;
var() localized string StatEffCaption;
var() localized string StatDmgRtCaption;
var() localized string StatSnprEffCaption;
var() localized string StatStgnEffCaption;
var() localized string StatHzrdEffCaption;

var ClientLoadoutInterface COI;	// The ClientLoadoutInterface actor we can use to comunicate with the mutatr

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	if (COI == None || !COI.bWeaponsReady)
	{
		if (PlayerOwner().level.NetMode == NM_Client)
		{
			l_Receiving.Caption = ReceivingText[0];
			SetTimer(0.5, true);
		}
		else
		{
			l_Receiving.Caption = ReceivingText[1];
			SetTimer(0.1, true);
		}
	}
	else
		LoadWeapons();

	cb_Melee.List.bSorted=true;
	cb_SideArm.List.bSorted=true;
	cb_Primary.List.bSorted=true;
	cb_Secondary.List.bSorted=true;
	cb_Grenade.List.bSorted=true;
}

event Timer()
{
	if (COI != None && COI.bWeaponsReady)
	{
		KillTimer();
		LoadWeapons();
	}
}

function bool ValidItem (int Index, PlayerReplicationInfo PRI)
{
//	if (PlayerOwner().level.Game.GameReplicationInfo.ElapsedTime < COI.GetItem(Index).Requirements.MatchTime)
	if (COI.ElapsedTime < COI.GetItem(Index).Requirements.MatchTime)
		return false;
	if (PRI.Score < COI.GetItem(Index).Requirements.Frags)
		return false;
	if (PRI.Deaths == 0)
	{
		if (PRI.Score / 0.1 < COI.GetItem(Index).Requirements.Efficiency)
			return false;
	}
	else
	{
		if (PRI.Score / PRI.Deaths < COI.GetItem(Index).Requirements.Efficiency)
			return false;
	}
	if (COI.MyLoadoutInfo.SniperEff < COI.GetItem(Index).Requirements.SniperEff)
		return false;
	if (COI.MyLoadoutInfo.ShotgunEff < COI.GetItem(Index).Requirements.ShotgunEff)
		return false;
	if (COI.MyLoadoutInfo.HazardEff < COI.GetItem(Index).Requirements.HazardEff)
		return false;
	if (COI.MyLoadoutInfo.DamageRate < COI.GetItem(Index).Requirements.DamageRate)
		return false;
	return true;
}

function LoadWeapons()
{
	local int i;
	local string IC, ICN;
	local Material IMat;
	local IntBox ICrds;

	// Load the weapons into their GUILoadOutItems
	for(i=0;i<COI.GetItemsLength();i++)
	{
		if (ValidItem(i, PlayerOwner().PlayerReplicationInfo))
		{
			if (!GetItemInfo(i, IC, IMat, ICN, ICrds))
				continue;
			if ((COI.GetItem(i).Groups & 1) > 0)
			{
				Item_Melee.AddItem(IC, IMat, ICN, ICrds);
	   			cb_Melee.AddItem(IC, ,ICN);
	   		}
			if ((COI.GetItem(i).Groups & 2) > 0)
			{
				Item_SideArm.AddItem(IC, IMat, ICN, ICrds);
	   			cb_SideArm.AddItem(IC, ,ICN);
	   		}
			if ((COI.GetItem(i).Groups & 4) > 0)
			{
				Item_Primary.AddItem(IC, IMat, ICN, ICrds);
	   			cb_Primary.AddItem(IC, ,ICN);
	   		}
			if ((COI.GetItem(i).Groups & 8) > 0)
			{
				Item_Secondary.AddItem(IC, IMat, ICN, ICrds);
	   			cb_Secondary.AddItem(IC, ,ICN);
	   		}
			if ((COI.GetItem(i).Groups & 16) > 0)
			{
				Item_Grenade.AddItem(IC, IMat, ICN, ICrds);
	   			cb_Grenade.AddItem(IC, ,ICN);
	   		}
		}
	}
	Item_Melee.SetItem(class'Mut_Loadout'.default.LoadOut[0]);
	cb_Melee.SetText(QuickListText);
	Item_SideArm.SetItem(class'Mut_Loadout'.default.LoadOut[1]);
	cb_SideArm.SetText(QuickListText);
	Item_Primary.SetItem(class'Mut_Loadout'.default.LoadOut[2]);
	cb_Primary.SetText(QuickListText);
	Item_Secondary.SetItem(class'Mut_Loadout'.default.LoadOut[3]);
	cb_Secondary.SetText(QuickListText);
	Item_Grenade.SetItem(class'Mut_Loadout'.default.LoadOut[4]);
	cb_Grenade.SetText(QuickListText);

	class'BC_WeaponInfoCache'.static.EndSession();
	l_Receiving.Caption = "";

//	l_StatTime.Caption =		StatTimeCaption		$ PlayerOwner().level.Game.GameReplicationInfo.ElapsedTime;
	l_StatTime.Caption =		StatTimeCaption		$ COI.ElapsedTime;
	l_StatFrags.Caption =		StatFragsCaption	$ int(PlayerOwner().PlayerReplicationInfo.Score);
	if (PlayerOwner().PlayerReplicationInfo.Deaths == 0)
		l_StatEfficiency.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / 0.1;
	else
		l_StatEfficiency.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / PlayerOwner().PlayerReplicationInfo.Deaths;
	l_StatSniperEff.Caption =	StatSnprEffCaption	$ COI.MyLoadoutInfo.SniperEff;
	l_StatShotgunEff.Caption =	StatStgnEffCaption	$ COI.MyLoadoutInfo.ShotgunEff;
	l_StatHazardEff.Caption =	StatHzrdEffCaption	$ COI.MyLoadoutInfo.HazardEff;
	l_StatDamageRate.Caption =	StatDmgRtCaption	$ COI.MyLoadoutInfo.DamageRate;
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool GetItemInfo(int Index, out string ItemCap, out Material ItemImage, out string ItemClassName, optional out IntBox ImageCoords)
{
//	local class<Weapon> W;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i;
	local string ItemCName;

	ItemCName = COI.GetItem(Index).ItemName;
	if (ItemCName == "")
		return false;
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ItemCName, i);
	if (i==-1)
	{
		log("Error loading item for loadout: "$ItemCName, 'Warning');
		return false;
	}
	ItemCap = WI.ItemName;
	ItemClassName = ItemCName;
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
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(BDone);

	return false;
}

function InternalOnClose(optional Bool bCanceled)
{
	Super.OnClose(bCanceled);
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==BCancel) // CANCEL
		Controller.CloseMenu();
	else if (Sender==BStats)
	{
		Controller.OpenMenu("BallisticProV55.BallisticLoadoutInfoMenu");
		if (BallisticLoadoutInfoMenu(Controller.ActivePage) != None)
			BallisticLoadoutInfoMenu(Controller.ActivePage).LoadWeapons(self);
	}
	else if (Sender==BDone) // DONE
	{
		if (Item_Melee.Items.length > Item_Melee.Index)
			class'Mut_Loadout'.default.LoadOut[0] = Item_Melee.Items[Item_Melee.Index].Text;
		if (Item_SideArm.Items.length > Item_SideArm.Index)
			class'Mut_Loadout'.default.LoadOut[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
		if (Item_Primary.Items.length > Item_Primary.Index)
			class'Mut_Loadout'.default.LoadOut[2] = Item_Primary.Items[Item_Primary.Index].Text;
		if (Item_Secondary.Items.length > Item_Secondary.Index)
			class'Mut_Loadout'.default.LoadOut[3] = Item_Secondary.Items[Item_Secondary.Index].Text;
		if (Item_Grenade.Items.length > Item_Grenade.Index)
			class'Mut_Loadout'.default.LoadOut[4] = Item_Grenade.Items[Item_Grenade.Index].Text;
		class'Mut_Loadout'.static.StaticSaveConfig();
		COI.LoadoutChanged(class'Mut_Loadout'.default.LoadOut);
		Controller.CloseMenu();
	}
	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	if (COI == None || !COI.bWeaponsReady)
		return;
	if (Sender == cb_Melee)
		Item_Melee.SetItem(cb_Melee.GetExtra());
	else if (Sender == cb_SideArm)
		Item_SideArm.SetItem(cb_SideArm.GetExtra());
	else if (Sender == cb_Primary)
		Item_Primary.SetItem(cb_Primary.GetExtra());
	else if (Sender == cb_Secondary)
		Item_Secondary.SetItem(cb_Secondary.GetExtra());
	else if (Sender == cb_Grenade)
		Item_Grenade.SetItem(cb_Grenade.GetExtra());
}

defaultproperties
{
     Begin Object Class=GUILoadOutItem Name=MeleeImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Melee Weapon"
         WinTop=0.300000
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=MeleeImage.InternalOnDraw
         OnClick=MeleeImage.InternalOnClick
         OnRightClick=MeleeImage.InternalOnRightClick
     End Object
     Item_Melee=GUILoadOutItem'BallisticProV55.BallisticLoadOutMenu.MeleeImage'

     Begin Object Class=GUILoadOutItem Name=SideArmImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="SideArm"
         WinTop=0.300000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=SideArmImage.InternalOnDraw
         OnClick=SideArmImage.InternalOnClick
         OnRightClick=SideArmImage.InternalOnRightClick
     End Object
     Item_SideArm=GUILoadOutItem'BallisticProV55.BallisticLoadOutMenu.SideArmImage'

     Begin Object Class=GUILoadOutItem Name=PrimaryImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Primary Weapon"
         WinTop=0.500000
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=PrimaryImage.InternalOnDraw
         OnClick=PrimaryImage.InternalOnClick
         OnRightClick=PrimaryImage.InternalOnRightClick
     End Object
     Item_Primary=GUILoadOutItem'BallisticProV55.BallisticLoadOutMenu.PrimaryImage'

     Begin Object Class=GUILoadOutItem Name=SecondaryImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Secondary Weapon"
         WinTop=0.500000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=SecondaryImage.InternalOnDraw
         OnClick=SecondaryImage.InternalOnClick
         OnRightClick=SecondaryImage.InternalOnRightClick
     End Object
     Item_Secondary=GUILoadOutItem'BallisticProV55.BallisticLoadOutMenu.SecondaryImage'

     Begin Object Class=GUILoadOutItem Name=GrenadeImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Grenades"
         WinTop=0.300000
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=GrenadeImage.InternalOnDraw
         OnClick=GrenadeImage.InternalOnClick
         OnRightClick=GrenadeImage.InternalOnRightClick
     End Object
     Item_Grenade=GUILoadOutItem'BallisticProV55.BallisticLoadOutMenu.GrenadeImage'

     Begin Object Class=GUIComboBox Name=cb_MeleeComBox
         MaxVisibleItems=16
         Hint="Quick list of Melee items"
         WinTop=0.431477
         WinLeft=0.102148
         WinWidth=0.196094
         WinHeight=0.026681
         TabOrder=0
         OnChange=BallisticLoadOutMenu.InternalOnChange
         OnKeyEvent=cb_MeleeComBox.InternalOnKeyEvent
     End Object
     cb_Melee=GUIComboBox'BallisticProV55.BallisticLoadOutMenu.cb_MeleeComBox'

     Begin Object Class=GUIComboBox Name=cb_SideArmBox
         MaxVisibleItems=16
         Hint="Quick list of SideArm items"
         WinTop=0.431477
         WinLeft=0.402930
         WinWidth=0.196094
         WinHeight=0.026681
         TabOrder=0
         OnChange=BallisticLoadOutMenu.InternalOnChange
         OnKeyEvent=cb_SideArmBox.InternalOnKeyEvent
     End Object
     cb_SideArm=GUIComboBox'BallisticProV55.BallisticLoadOutMenu.cb_SideArmBox'

     Begin Object Class=GUIComboBox Name=cb_PrimaryComBox
         MaxVisibleItems=16
         Hint="Quick list of Primary items"
         WinTop=0.631996
         WinLeft=0.102148
         WinWidth=0.196094
         WinHeight=0.026681
         TabOrder=0
         OnChange=BallisticLoadOutMenu.InternalOnChange
         OnKeyEvent=cb_PrimaryComBox.InternalOnKeyEvent
     End Object
     cb_Primary=GUIComboBox'BallisticProV55.BallisticLoadOutMenu.cb_PrimaryComBox'

     Begin Object Class=GUIComboBox Name=cb_SecondaryComBox
         MaxVisibleItems=16
         Hint="Quick list of Secondary items"
         WinTop=0.631996
         WinLeft=0.402930
         WinWidth=0.196094
         WinHeight=0.026681
         TabOrder=0
         OnChange=BallisticLoadOutMenu.InternalOnChange
         OnKeyEvent=cb_SecondaryComBox.InternalOnKeyEvent
     End Object
     cb_Secondary=GUIComboBox'BallisticProV55.BallisticLoadOutMenu.cb_SecondaryComBox'

     Begin Object Class=GUIComboBox Name=cb_GrenadeComBox
         MaxVisibleItems=16
         Hint="Quick list of Grenade Trap and Explosive items"
         WinTop=0.431477
         WinLeft=0.702148
         WinWidth=0.196094
         WinHeight=0.026681
         TabOrder=0
         OnChange=BallisticLoadOutMenu.InternalOnChange
         OnKeyEvent=cb_GrenadeComBox.InternalOnKeyEvent
     End Object
     cb_Grenade=GUIComboBox'BallisticProV55.BallisticLoadOutMenu.cb_GrenadeComBox'

     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinTop=0.200000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.600000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.BallisticLoadOutMenu.BackImage'

     Begin Object Class=GUIImage Name=ImageBoxMelee
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.287500
         WinLeft=0.087500
         WinWidth=0.225000
         WinHeight=0.158333
         RenderWeight=0.002000
     End Object
     Box_Melee=GUIImage'BallisticProV55.BallisticLoadOutMenu.ImageBoxMelee'

     Begin Object Class=GUIImage Name=ImageBoxSideArm
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.287500
         WinLeft=0.387500
         WinWidth=0.225000
         WinHeight=0.158333
         RenderWeight=0.002000
     End Object
     Box_SideArm=GUIImage'BallisticProV55.BallisticLoadOutMenu.ImageBoxSideArm'

     Begin Object Class=GUIImage Name=ImageBoxPrimary
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.487500
         WinLeft=0.087500
         WinWidth=0.225000
         WinHeight=0.158333
         RenderWeight=0.002000
     End Object
     Box_Primary=GUIImage'BallisticProV55.BallisticLoadOutMenu.ImageBoxPrimary'

     Begin Object Class=GUIImage Name=ImageBoxSecondary
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.487500
         WinLeft=0.387500
         WinWidth=0.225000
         WinHeight=0.158333
         RenderWeight=0.002000
     End Object
     Box_Secondary=GUIImage'BallisticProV55.BallisticLoadOutMenu.ImageBoxSecondary'

     Begin Object Class=GUIImage Name=ImageBoxGrenade
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.287500
         WinLeft=0.687500
         WinWidth=0.225000
         WinHeight=0.158333
         RenderWeight=0.002000
     End Object
     Box_Grenade=GUIImage'BallisticProV55.BallisticLoadOutMenu.ImageBoxGrenade'

     Begin Object Class=GUIImage Name=MeleeBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.300000
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.133333
         RenderWeight=0.003000
     End Object
     MeleeBack=GUIImage'BallisticProV55.BallisticLoadOutMenu.MeleeBackImage'

     Begin Object Class=GUIImage Name=SideArmBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.300000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.133333
         RenderWeight=0.003000
     End Object
     SideArmBack=GUIImage'BallisticProV55.BallisticLoadOutMenu.SideArmBackImage'

     Begin Object Class=GUIImage Name=PrimaryBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.500000
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.133333
         RenderWeight=0.003000
     End Object
     PrimaryBack=GUIImage'BallisticProV55.BallisticLoadOutMenu.PrimaryBackImage'

     Begin Object Class=GUIImage Name=SecondaryBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.500000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.133333
         RenderWeight=0.003000
     End Object
     SecondaryBack=GUIImage'BallisticProV55.BallisticLoadOutMenu.SecondaryBackImage'

     Begin Object Class=GUIImage Name=GrenadeBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.300000
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.133333
         RenderWeight=0.003000
     End Object
     GrenadeBack=GUIImage'BallisticProV55.BallisticLoadOutMenu.GrenadeBackImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.700000
         WinLeft=0.100000
         WinWidth=0.200000
         TabOrder=0
         OnClick=BallisticLoadOutMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.BallisticLoadOutMenu.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         WinTop=0.700000
         WinLeft=0.700000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticLoadOutMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'BallisticProV55.BallisticLoadOutMenu.CancelButton'

     Begin Object Class=GUIButton Name=BStatButton
         Caption="Stats"
         WinTop=0.700000
         WinLeft=0.400000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticLoadOutMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bStats=GUIButton'BallisticProV55.BallisticLoadOutMenu.BStatButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Select your equipment"
         WinTop=0.200000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.700000
     End Object
     MyHeader=GUIHeader'BallisticProV55.BallisticLoadOutMenu.DaBeegHeader'

     Begin Object Class=GUILabel Name=l_Receivinglabel
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.237000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.040000
     End Object
     l_Receiving=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_Receivinglabel'

     Begin Object Class=GUILabel Name=l_StatTimeLabel
         Caption="Time"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.480000
         WinLeft=0.650000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_StatTime=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatTimeLabel'

     Begin Object Class=GUILabel Name=l_StatFragsLabel
         Caption="Frags"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.510000
         WinLeft=0.650000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_StatFrags=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatFragsLabel'

     Begin Object Class=GUILabel Name=l_StatEfficiencyLabel
         Caption="Efficiency"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.540000
         WinLeft=0.650000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_StatEfficiency=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatEfficiencyLabel'

     Begin Object Class=GUILabel Name=l_StatDamageRateLabel
         Caption="DamageRate"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.570000
         WinLeft=0.650000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_StatDamageRate=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatDamageRateLabel'

     Begin Object Class=GUILabel Name=l_StatSniperEffLabel
         Caption="Sniper Efficiency"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.600000
         WinLeft=0.650000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_StatSniperEff=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatSniperEffLabel'

     Begin Object Class=GUILabel Name=l_StatShotgunEffLabel
         Caption="Shotgun Efficiency"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.630000
         WinLeft=0.650000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_StatShotgunEff=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatShotgunEffLabel'

     Begin Object Class=GUILabel Name=l_StatHazardEffLabel
         Caption="Hazard Efficiency"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.660000
         WinLeft=0.650000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_StatHazardEff=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatHazardEffLabel'

     Begin Object Class=GUILabel Name=l_StatHeadingLabel
         Caption="Your Stats"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Small
         WinTop=0.455000
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.040000
     End Object
     l_StatHeading=GUILabel'BallisticProV55.BallisticLoadOutMenu.l_StatHeadingLabel'

     QuickListText="QuickList"
     ReceivingText(0)="Receiving..."
     ReceivingText(1)="Loading..."
     StatTimeCaption="Time: "
     StatFragsCaption="Frags: "
     StatEffCaption="Efficiency: "
     StatDmgRtCaption="DamageRate: "
     StatSnprEffCaption="Sniper Efficiency: "
     StatStgnEffCaption="Shotgun Efficiency: "
     StatHzrdEffCaption="Hazard Efficiency: "
     bRenderWorld=True
     bAllowedAsLast=True
     OnClose=BallisticLoadOutMenu.InternalOnClose
     OnKeyEvent=BallisticLoadOutMenu.InternalOnKeyEvent
}
