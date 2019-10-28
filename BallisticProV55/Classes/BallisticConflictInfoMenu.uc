//=============================================================================
// BallisticConflictInfoMenu.
//
// A menu to list all the weapons and show their skill requirements
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticConflictInfoMenu extends UT2K4GUIPage;

var Automated GUIImage		MyBack, Box_WeaponList, Box_WeaponIcon, IconBack, WeaponIcon;
var Automated GUIButton		BDone;
var automated GUIHeader 	MyHeader;
var automated GUILabel		l_StatTime, l_StatFrags, l_StatEfficiency, l_StatDamageRate, l_StatSniperEff, l_StatShotgunEff, l_StatHazardEff, l_StatHeading, l_StatTimeMy, l_StatFragsMy, l_StatEfficiencyMy, l_StatDamageRateMy, l_StatSniperEffMy, l_StatShotgunEffMy, l_StatHazardEffMy, l_StatHeadingMy;
var automated GUIListBox	lb_Weapons;

var() localized string StatTimeCaption;
var() localized string StatFragsCaption;
var() localized string StatEffCaption;
var() localized string StatDmgRtCaption;
var() localized string StatSnprEffCaption;
var() localized string StatStgnEffCaption;
var() localized string StatHzrdEffCaption;

var BallisticTab_EliminationInventoryPro ConflictMenu;

struct s_WeaponInfo
{
	var string ItemName;
	var	Material ItemImage;
	var string ItemClassName;
	var IntBox ImageCoords;
};
var array<s_WeaponInfo> WeaponInfo;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
}

function LoadWeapons(BallisticTab_EliminationInventoryPro Source)
{
	local int i;
	local s_WeaponInfo WI;

	ConflictMenu = Source;

	for(i=0;i<Source.EPRI.FullInventoryList.Length;i++)
	{
		if (Source.EPRI.FullInventoryList[i] != "")
		{
			if (GetItemInfo( i, WI.ItemName, WI.ItemImage, WI.ItemClassName, WI.ImageCoords ))
			{
				lb_Weapons.List.Add(WI.ItemName, , string(i));
				WeaponInfo[i] = WI;
			}
		}
	}
	lb_Weapons.List.OnChange = InternalOnChange;

	l_StatTimeMy.Caption =		StatTimeCaption		$ ConflictMenu.EPRI.MySkillInfo.ElapsedTime;
	l_StatFragsMy.Caption =		StatFragsCaption	$ int(PlayerOwner().PlayerReplicationInfo.Score);
	if (PlayerOwner().PlayerReplicationInfo.Deaths == 0)
		l_StatEfficiencyMy.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / 0.1;
	else
		l_StatEfficiencyMy.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / PlayerOwner().PlayerReplicationInfo.Deaths;

	l_StatSniperEffMy.Caption =		StatSnprEffCaption	$ ConflictMenu.EPRI.MySkillInfo.SniperEff;
	l_StatShotgunEffMy.Caption =	StatStgnEffCaption	$ ConflictMenu.EPRI.MySkillInfo.ShotgunEff;
	l_StatHazardEffMy.Caption =		StatHzrdEffCaption	$ ConflictMenu.EPRI.MySkillInfo.HazardEff;
	l_StatDamageRateMy.Caption =	StatDmgRtCaption	$ ConflictMenu.EPRI.MySkillInfo.DamageRate;

	UpdateInfo();
}

function UpdateInfo()
{
	local color Red;
	local color Green;
	local int i;
	Red.A=255;
	Red.R = 255;
	Green.A=255;
	Green.G = 255;

	i = int(lb_Weapons.List.GetExtra());

	if (ConflictMenu.EPRI.RequirementsList[i].MatchTime > ConflictMenu.EPRI.MySkillInfo.ElapsedTime)
		l_StatTime.TextColor = Red;
	else
		l_StatTime.TextColor = Green;
	l_StatTime.Caption =		StatTimeCaption		$ ConflictMenu.EPRI.RequirementsList[i].MatchTime;

	if (ConflictMenu.EPRI.RequirementsList[i].Frags > PlayerOwner().PlayerReplicationInfo.Score)
		l_StatFrags.TextColor = Red;
	else
		l_StatFrags.TextColor = Green;
	l_StatFrags.Caption =		StatFragsCaption	$ ConflictMenu.EPRI.RequirementsList[i].Frags;

	if (PlayerOwner().PlayerReplicationInfo.Deaths == 0)
	{
		if (ConflictMenu.EPRI.RequirementsList[i].Efficiency > PlayerOwner().PlayerReplicationInfo.Score / 0.1)
			l_StatEfficiency.TextColor = Red;
		else
			l_StatEfficiency.TextColor = Green;
	}
	else
	{
		if (ConflictMenu.EPRI.RequirementsList[i].Efficiency > PlayerOwner().PlayerReplicationInfo.Score / PlayerOwner().PlayerReplicationInfo.Deaths)
			l_StatEfficiency.TextColor = Red;
		else
			l_StatEfficiency.TextColor = Green;
	}
	if (ConflictMenu.EPRI.RequirementsList[i].SniperEff > ConflictMenu.EPRI.MySkillInfo.SniperEff)
		l_StatSniperEff.TextColor = Red;
	else
		l_StatSniperEff.TextColor = Green;

	if (ConflictMenu.EPRI.RequirementsList[i].ShotgunEff > ConflictMenu.EPRI.MySkillInfo.ShotgunEff)
		l_StatShotgunEff.TextColor = Red;
	else
		l_StatShotgunEff.TextColor = Green;

	if (ConflictMenu.EPRI.RequirementsList[i].HazardEff > ConflictMenu.EPRI.MySkillInfo.HazardEff)
		l_StatHazardEff.TextColor = Red;
	else
		l_StatHazardEff.TextColor = Green;

	l_StatEfficiency.Caption =		StatEffCaption	$ ConflictMenu.EPRI.RequirementsList[i].Efficiency;
	l_StatSniperEff.Caption =		StatSnprEffCaption	$ ConflictMenu.EPRI.RequirementsList[i].SniperEff;
	l_StatShotgunEff.Caption =		StatStgnEffCaption	$ ConflictMenu.EPRI.RequirementsList[i].ShotgunEff;
	l_StatHazardEff.Caption =		StatHzrdEffCaption	$ ConflictMenu.EPRI.RequirementsList[i].HazardEff;

	if (ConflictMenu.EPRI.RequirementsList[i].DamageRate > ConflictMenu.EPRI.MySkillInfo.DamageRate)
		l_StatDamageRate.TextColor = Red;
	else
		l_StatDamageRate.TextColor = Green;
	l_StatDamageRate.Caption =		StatDmgRtCaption	$ ConflictMenu.EPRI.RequirementsList[i].DamageRate;

	WeaponIcon.Image = WeaponInfo[i].ItemImage;
	WeaponIcon.X1 = WeaponInfo[i].ImageCoords.X1;
	WeaponIcon.X2 = WeaponInfo[i].ImageCoords.X2;
	WeaponIcon.Y1 = WeaponInfo[i].ImageCoords.Y1;
	WeaponIcon.Y2 = WeaponInfo[i].ImageCoords.Y2;
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool GetItemInfo(int Index, out string ItemCap, out Material ItemImage, out string ItemClassName, optional out IntBox ImageCoords)
{
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i;
	local string ItemCName;

	ItemCName = ConflictMenu.EPRI.FullInventoryList[Index];
	if (ItemCName == "")
		return false;
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ItemCName, i);
	if (i==-1)
	{
//		log("Error loading item for conflict: "$ItemCName, 'Warning');
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
	else if (Key == 0x1B && State == 3)	// Escape
		return InternalOnClick(BDone);

	return false;
}

function InternalOnClose(optional Bool bCanceled)
{
	Super.OnClose(bCanceled);
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==BDone) // DONE
		Controller.CloseMenu();
	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	if (Sender == lb_Weapons.List)
		UpdateInfo();
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=1.000000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.BallisticConflictInfoMenu.BackImage'

     Begin Object Class=GUIImage Name=ImageBoxWeapons
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.030000
         WinLeft=0.300000
         WinWidth=0.400000
         WinHeight=0.450000
         RenderWeight=0.002000
     End Object
     Box_WeaponList=GUIImage'BallisticProV55.BallisticConflictInfoMenu.ImageBoxWeapons'

     Begin Object Class=GUIImage Name=ImageBox_WeaponIcon
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.487500
         WinLeft=0.387500
         WinWidth=0.225000
         WinHeight=0.158333
         RenderWeight=0.002000
     End Object
     Box_WeaponIcon=GUIImage'BallisticProV55.BallisticConflictInfoMenu.ImageBox_WeaponIcon'

     Begin Object Class=GUIImage Name=IconBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.500000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.133333
         RenderWeight=0.003000
     End Object
     IconBack=GUIImage'BallisticProV55.BallisticConflictInfoMenu.IconBackImage'

     Begin Object Class=GUIImage Name=WeaponIconImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Scaled
         WinTop=0.500000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.133333
         RenderWeight=0.004000
     End Object
     WeaponIcon=GUIImage'BallisticProV55.BallisticConflictInfoMenu.WeaponIconImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.925000
         WinLeft=0.400000
         WinWidth=0.200000
         TabOrder=0
         OnClick=BallisticConflictInfoMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.BallisticConflictInfoMenu.DoneButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Weapon Requirement Stats"
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.031250
     End Object
     MyHeader=GUIHeader'BallisticProV55.BallisticConflictInfoMenu.DaBeegHeader'

     Begin Object Class=GUILabel Name=l_StatTimeLabel
         Caption="Time"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.700000
         WinLeft=0.500000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatTime=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatTimeLabel'

     Begin Object Class=GUILabel Name=l_StatFragsLabel
         Caption="Frags"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.730000
         WinLeft=0.500000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatFrags=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatFragsLabel'

     Begin Object Class=GUILabel Name=l_StatEfficiencyLabel
         Caption="Efficiency"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.760000
         WinLeft=0.500000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatEfficiency=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatEfficiencyLabel'

     Begin Object Class=GUILabel Name=l_StatDamageRateLabel
         Caption="DamageRate"
         TextColor=(B=0,G=255)
         FontScale=FNS_Small
         WinTop=0.790000
         WinLeft=0.500000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatDamageRate=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatDamageRateLabel'

     Begin Object Class=GUILabel Name=l_StatSniperEffLabel
         Caption="SniperEff"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.820000
         WinLeft=0.500000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatSniperEff=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatSniperEffLabel'

     Begin Object Class=GUILabel Name=l_StatShotgunEffLabel
         Caption="ShotgunEff"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.850000
         WinLeft=0.500000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatShotgunEff=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatShotgunEffLabel'

     Begin Object Class=GUILabel Name=l_StatHazardEffLabel
         Caption="HazardEff"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.880000
         WinLeft=0.500000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatHazardEff=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatHazardEffLabel'

     Begin Object Class=GUILabel Name=l_StatHeadingLabel
         Caption="Required Stats"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Small
         WinTop=0.650000
         WinLeft=0.500000
         WinWidth=0.200000
         WinHeight=0.040000
     End Object
     l_StatHeading=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatHeadingLabel'

     Begin Object Class=GUILabel Name=l_StatTimeLabelMy
         Caption="Time"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.700000
         WinLeft=0.260000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatTimeMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatTimeLabelMy'

     Begin Object Class=GUILabel Name=l_StatFragsLabelMy
         Caption="Frags"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.730000
         WinLeft=0.260000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatFragsMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatFragsLabelMy'

     Begin Object Class=GUILabel Name=l_StatEfficiencyLabelMy
         Caption="Efficiency"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.760000
         WinLeft=0.260000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatEfficiencyMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatEfficiencyLabelMy'

     Begin Object Class=GUILabel Name=l_StatDamageRateLabelMy
         Caption="DamageRate"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.790000
         WinLeft=0.260000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatDamageRateMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatDamageRateLabelMy'

     Begin Object Class=GUILabel Name=l_StatSniperEffLabelMy
         Caption="SniperEff"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.820000
         WinLeft=0.260000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatSniperEffMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatSniperEffLabelMy'

     Begin Object Class=GUILabel Name=l_StatShotgunEffLabelMy
         Caption="ShotgunEff"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.850000
         WinLeft=0.260000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatShotgunEffMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatShotgunEffLabelMy'

     Begin Object Class=GUILabel Name=l_StatHazardEffLabelMy
         Caption="HazardEff"
         TextColor=(B=128,G=255,R=64)
         FontScale=FNS_Small
         WinTop=0.880000
         WinLeft=0.260000
         WinWidth=0.240000
         WinHeight=0.040000
     End Object
     l_StatHazardEffMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatHazardEffLabelMy'

     Begin Object Class=GUILabel Name=l_StatHeadingLabelMy
         Caption="Your Stats"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Small
         WinTop=0.650000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.040000
     End Object
     l_StatHeadingMy=GUILabel'BallisticProV55.BallisticConflictInfoMenu.l_StatHeadingLabelMy'

     Begin Object Class=GUIListBox Name=WeaponList
         bVisibleWhenEmpty=True
         bSorted=True
         OnCreateComponent=WeaponList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="All the weapons that can become available. Click to see each one's skill requirements."
         WinTop=0.055000
         WinLeft=0.310000
         WinWidth=0.380000
         WinHeight=0.400000
         RenderWeight=0.510000
         TabOrder=1
     End Object
     lb_Weapons=GUIListBox'BallisticProV55.BallisticConflictInfoMenu.WeaponList'

     StatTimeCaption="Time: "
     StatFragsCaption="Frags: "
     StatEffCaption="Efficiency: "
     StatDmgRtCaption="DamageRate: "
     StatSnprEffCaption="Sniper Eff: "
     StatStgnEffCaption="Shotgun Eff: "
     StatHzrdEffCaption="Hazard Eff: "
     bRenderWorld=True
     bAllowedAsLast=True
     OnClose=BallisticConflictInfoMenu.InternalOnClose
     OnKeyEvent=BallisticConflictInfoMenu.InternalOnKeyEvent
}
