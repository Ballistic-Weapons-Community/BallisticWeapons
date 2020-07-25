//=============================================================================
// BallisticWeaponStatsMenu.
//
// A menu accessible by the BWStats command. Dynamically loads the requested weapon and
// shows relevant information for it.
//
// by Azarael
// based on code by Nolan "Dark Carnivour" Richert
//=============================================================================
class BallisticWeaponStatsMenu extends UT2K4GUIPage;

const TIME_DILATION_FIXED = 1.1f;

const BASELINE_DPS_DIVISOR = 2.42f;
const BASELINE_TTK_DIVISOR = 0.0077f;
const BASELINE_RECOIL_DIVISOR = 14.663f;

var Automated GUIImage			MyBack, Box_WeaponList, Box_Desc, Box_WeaponIcon, WeaponIcon;
var Automated GUISectionBackground GenBack, PriBack, AltBack;
var Automated GUIButton			BDone;
var automated GUIHeader 		MyHeader;
var automated GUIListBox			lb_Weapons;
var automated GUILabel			l_WeaponCaption, 
											lb_DShot, lb_DPS, lb_TTK, lb_RPM, lb_Recoil, lb_RPS, lb_Exp, lb_EPS,
											lb_DShotAlt, lb_DPSAlt, lb_TTKAlt, lb_RPMAlt, lb_RecoilAlt, lb_RPSAlt, lb_ExpAlt, lb_EPSAlt,
											lb_Raise, lb_HipSpr, lb_Mag, lb_DPM,lb_Range, lb_MovePen, lb_CAF,
											db_Dshot, db_RPM, db_Exp, db_Recoil,
											db_DshotAlt, db_RPMAlt, db_ExpAlt, db_RecoilAlt,
											db_Mag, db_Range, db_MovePen, db_CAF;
var automated moComboBox	cb_Display;
var automated GUIScrollTextBox sb_Desc;
var automated GUIProgressBar	pb_DPS, pb_TTK, pb_RPS, pb_EPS,	pb_DPSAlt, pb_TTKAlt, pb_RPSAlt, pb_EPSAlt, pb_Raise, pb_HipSpr, pb_DPM;

var InterpCurve 						RedCurve, GreenCurve, BlueCurve;

var bool									bInitialized, bAltStatsVisible;

var bool									bShowTextBox;

var() localized string Headings[10];

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	if (bInitialized)
		return;

	lb_Weapons.List.OnChange = InternalOnChange;
	
	//pri
	lb_DShot.Caption = "Damage";
	lb_DPS.Caption = "DPS";
	lb_TTK.Caption = "Time to Kill";
	lb_RPM.Caption = "Fire Rate";
	lb_Recoil.Caption = "Recoil/Shot";
	lb_RPS.Caption = "Recoil/Second";
	lb_Exp.Caption = "Expansion/Shot";
	lb_EPS.Caption = "Expansion/Second";
	
	pb_DPS.High = 520;
	pb_TTK.High = 1.4;
	pb_Raise.High = 0.8;
	pb_HipSpr.High = 2500;
	pb_DPM.High = 2500;
	pb_RPS.High = 2750;
	pb_EPS.High = 4096;
	
	//alt
	lb_DShotAlt.Caption = "Damage";
	lb_DPSAlt.Caption = "DPS";
	lb_TTKAlt.Caption = "Time to Kill";
	lb_RPMAlt.Caption = "Fire Rate";
	lb_RecoilAlt.Caption = "Recoil/Shot";
	lb_RPSAlt.Caption = "Recoil/Second";
	lb_ExpAlt.Caption = "Expansion/Shot";
	lb_EPSAlt.Caption = "Expansion/Second";
	
	pb_DPSAlt.High = 520;
	pb_TTKAlt.High = 1.4;
	pb_RPSAlt.High = 2750;

	pb_EPSAlt.High = 4096;
	
	//gen
	lb_Raise.Caption = "Sight Raise Time";
	lb_HipSpr.Caption = "Max Hip Spread";
	lb_Mag.Caption = "Capacity";
	lb_DPM.Caption = "Damage/Mag";
	lb_Range.Caption = "Effective Range";
	lb_CAF.Caption = "Crouch Stability";
	lb_MovePen.Caption = "Hip Move Penalty";
		
	pb_TTK.NumDecimals=2;
	pb_TTKAlt.NumDecimals=2;
	
	//pri
	PriBack.ManageComponent(lb_DShot);	PriBack.Managecomponent(db_DShot);
	PriBack.ManageComponent(lb_RPM);	PriBack.Managecomponent(db_RPM);
	PriBack.ManageComponent(lb_Recoil);	PriBack.ManageComponent(db_Recoil);
	PriBack.ManageComponent(lb_Exp);		PriBack.ManageComponent(db_Exp);

	PriBack.Managecomponent(lb_DPS);	PriBack.Managecomponent(pb_DPS);
	PriBack.Managecomponent(lb_TTK);	PriBack.Managecomponent(pb_TTK);
	PriBack.ManageComponent(lb_RPS);	PriBack.ManageComponent(pb_RPS);
	PriBack.ManageComponent(lb_EPS);	PriBack.ManageComponent(pb_EPS);
	
	//Alt
	AltBack.ManageComponent(lb_DShotAlt);	AltBack.Managecomponent(db_DShotAlt);
	AltBack.ManageComponent(lb_RPMAlt);	AltBack.Managecomponent(db_RPMAlt);
	AltBack.ManageComponent(lb_RecoilAlt);	AltBack.ManageComponent(db_RecoilAlt);
	AltBack.ManageComponent(lb_ExpAlt);		AltBack.ManageComponent(db_ExpAlt);
	
	AltBack.Managecomponent(lb_DPSAlt);	AltBack.Managecomponent(pb_DPSAlt);
	AltBack.Managecomponent(lb_TTKAlt);	AltBack.Managecomponent(pb_TTKAlt);
	AltBack.ManageComponent(lb_RPSAlt);	AltBack.ManageComponent(pb_RPSAlt);
	AltBack.ManageComponent(lb_EPSAlt);	AltBack.ManageComponent(pb_EPSAlt);
	
	//gen back
	
	GenBack.ManageComponent(lb_Range);	GenBack.ManageComponent(db_Range);
	GenBack.ManageComponent(lb_MovePen);	GenBack.ManageComponent(db_MovePen);
	GenBack.ManageComponent(lb_Mag);	GenBack.ManageComponent(db_Mag);
	GenBack.ManageComponent(lb_CAF);	GenBack.ManageComponent(db_CAF);
	GenBack.ManageComponent(lb_HipSpr);	GenBack.ManageComponent(pb_HipSpr);
	GenBack.ManageComponent(lb_Raise);	GenBack.ManageComponent(pb_Raise);
	GenBack.ManageComponent(lb_DPM);	GenBack.ManageComponent(pb_DPM);
	
	sb_Desc.bVisible = False;
	Box_Desc.bVisible = False;
	
	cb_Display.AddItem("Statistics");
	cb_Display.AddItem("Manual");

	cb_Display.bReadOnly = True;

	LoadList();
	bInitialized = true;
	cb_Display.SetIndex(1);
	SwitchDisplay(cb_Display.GetIndex());
	UpdateInfo();
}

function LoadList()
{
	local int i, j;
	//local array<CacheManager.WeaponRecord> Recs;
	//local string s;
	local int Index[10];
	//local BC_WeaponInfoCache.WeaponInfo WI;
	local array<BC_WeaponInfoCache.WeaponInfo> WIRecs;

	lb_Weapons.List.Add(Headings[0],,"MELEE",true);
	lb_Weapons.List.Add(Headings[1],,"SIDEARM",true);
	lb_Weapons.List.Add(Headings[2],,"SMG",true);
	lb_Weapons.List.Add(Headings[3],,"ASSAULT",true);
	lb_Weapons.List.Add(Headings[4],,"ENERGY",true);
	lb_Weapons.List.Add(Headings[5],,"MACHINEGUN",true);
	lb_Weapons.List.Add(Headings[6],,"SHOTGUN",true);
	lb_Weapons.List.Add(Headings[7],,"HEAVY",true);
	lb_Weapons.List.Add(Headings[8],,"SNIPER",true);
	lb_Weapons.List.Add(Headings[9],,"GRENADES",true);
	for (j=0;j<10;j++)
		Index[j] = j+1;

	class'BC_WeaponInfoCache'.static.GetBWWeps(WIRecs);
	
	for(i=0;i<WIRecs.length;i++)
	{
		if (WIRecs[i].ClassName != "")
		{
			if (WIRecs[i].InventoryGroup > 0 && WIRecs[i].InventoryGroup < 10)
			{
				lb_Weapons.List.Insert(Index[WIRecs[i].InventoryGroup-1], WIRecs[i].ItemName,, WIRecs[i].ClassName);
				for (j=WIRecs[i].InventoryGroup-1;j<10;j++)
					Index[j]++;
			}
			else if (WIRecs[i].InventoryGroup == 0)
			{
				lb_Weapons.List.Insert(Index[9], WIRecs[i].ItemName,, WIRecs[i].ClassName);
				Index[9]++;
			}
		}
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	if ((lb_Weapons.List.Index == 0 && lb_Weapons.List.IsSection()) || lb_Weapons.List.Index >= lb_Weapons.List.ItemCount)
	{
		lb_Weapons.List.SetIndex(1);
		l_WeaponCaption.Caption = lb_Weapons.List.Get();
	}
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
	if (!bInitialized)
		return;
	
	if (Sender == lb_Weapons.List)
		UpdateInfo();
	else if (Sender == cb_Display)
		SwitchDisplay(cb_Display.GetIndex());
}

function SwitchDisplay(int Index)
{
	local int i;
	
	if (Index == 0)
	{
		GenBack.bVisible = True;
		for(i=0; i < GenBack.AlignStack.Length; i++)
			GenBack.AlignStack[i].bVisible = True;
		PriBack.bVisible = True;
		for(i=0; i < PriBack.AlignStack.Length; i++)
			PriBack.AlignStack[i].bVisible = True;
		AltBack.bVisible = True;
		for(i=0; i < AltBack.AlignStack.Length; i++)
			AltBack.AlignStack[i].bVisible = True;
		sb_Desc.bVisible = False;
		Box_Desc.bVisible = False;
		UpdateInfo();
	}
	else
	{
		GenBack.bVisible = False;
		for(i=0; i < GenBack.AlignStack.Length; i++)
			GenBack.AlignStack[i].bVisible = False;
		PriBack.bVisible = False;
		for(i=0; i < PriBack.AlignStack.Length; i++)
			PriBack.AlignStack[i].bVisible = False;
		AltBack.bVisible = False;
		for(i=0; i < AltBack.AlignStack.Length; i++)
			AltBack.AlignStack[i].bVisible = False;
		sb_Desc.bVisible = True;
		Box_Desc.bVisible = True;
	}
}

function UpdateInfo()
{
	local class<BallisticWeapon> BW;
	local BallisticFire.FireModeStats FS, AFS;
	
	//FIXME DynamicLoadObject
	BW = class<BallisticWeapon>(DynamicLoadObject(lb_Weapons.List.GetExtra(), class'Class', True));
	if (BW != None)
	{
		FS = class<BallisticFire>(BW.default.FireModeClass[0]).static.GetStats();
		AFS = class<BallisticFire>(BW.default.FireModeClass[1]).static.GetStats();
		WeaponIcon.Image = BW.default.BigIconMaterial;
		l_WeaponCaption.Caption = BW.default.ItemName;
		l_WeaponCaption.TextColor = BW.default.HUDColor;
		sb_Desc.SetContent(BW.static.GetManual());
		
		
		// account for 1.1 speed that is native to UT
		FS.DPS *= TIME_DILATION_FIXED; 
		FS.TTK /= TIME_DILATION_FIXED;
		FS.RPS *= TIME_DILATION_FIXED;
		
		AFS.DPS *= TIME_DILATION_FIXED;
		AFS.TTK /= TIME_DILATION_FIXED;
		AFS.RPS *= TIME_DILATION_FIXED;

		
		//pri
		db_DShot.Caption = FS.Damage;
		
		pb_DPS.Value = FMin(FS.DPS, pb_DPS.High);
		pb_DPS.Caption = FS.DPS@"("$int(FS.DPS / BASELINE_DPS_DIVISOR)$"%)";
		pb_DPS.BarColor = ColorBar(pb_DPS.Value / pb_DPS.High);
		
		pb_TTK.Value = FMin(FS.TTK, pb_TTK.High);
		pb_TTK.Caption = FS.TTK@"("$int(FS.TTK / BASELINE_TTK_DIVISOR)$"%)";
		pb_TTK.BarColor = ColorBar(pb_TTK.Value / pb_TTK.High);
		
		db_RPM.Caption = FS.RPM;
		
		db_Recoil.Caption = String(FS.RPShot);
		
		pb_RPS.Value = FMin(FS.RPS, pb_RPS.High);
		pb_RPS.Caption = String(FS.RPS)@"("$int(FS.RPS / BASELINE_RECOIL_DIVISOR)$"%)";
		pb_RPS.BarColor = ColorBar(pb_RPS.Value / pb_RPS.High);
		
		db_Exp.Caption = String(int(FS.FCPShot * pb_HipSpr.Value));
		
		pb_EPS.Value = FMin(FS.FCPS * BW.default.ChaosAimSpread, pb_EPS.High);
		pb_EPS.Caption = String(int(FS.FCPS * BW.default.ChaosAimSpread));
		pb_EPS.BarColor = ColorBar(pb_EPS.Value / pb_EPS.High);
		
		//Alt
		
		if (AFS.DamageInt > 0)
		{
			if(!bAltStatsVisible)
			{
				if (AltBack.bVisible)
				{

					lb_RecoilAlt.bVisible = True;
					lb_RPSAlt.bVisible = True;
					lb_ExpAlt.bVisible = True;
					lb_EPSAlt.bVisible = True;
					lb_TTKAlt.bVisible = True;
					lb_DPSAlt.bVisible = True;
				
					pb_DPSAlt.bVisible = True;
					pb_TTKAlt.bVisible = True;
					pb_RPSAlt.bVisible = True;
					pb_EPSAlt.bVisible = True;
					db_ExpAlt.bVisible = True;
					db_RecoilAlt.bVisible = True;
				}
			
				lb_DShotAlt.Caption = "Damage";
				bAltStatsVisible=True;
			}
		}
		else if (bAltStatsVisible)
		{
			if (AltBack.bVisible)
			{
				lb_DShotAlt.Caption = "Effect";
				lb_RecoilAlt.bVisible = False;
				lb_RPSAlt.bVisible = False;
				lb_ExpAlt.bVisible = False;
				lb_EPSAlt.bVisible = False;
				lb_TTKAlt.bVisible = False;
				lb_DPSAlt.bVisible = False;
				
				pb_DPSAlt.bVisible = False;
				pb_TTKAlt.bVisible = False;
				pb_RPSAlt.bVisible = False;
				pb_EPSAlt.bVisible = False;
				db_ExpAlt.bVisible = False;
				db_RecoilAlt.bVisible = False;
			}
			
			bAltStatsVisible=False;
		}
		

		db_DShotAlt.Caption = AFS.Damage;
		
		pb_DPSAlt.Value = FMin(AFS.DPS, pb_DPSAlt.High);
		pb_DPSAlt.Caption = AFS.DPS@"("$int(AFS.DPS / 2.2)$"%)";
		pb_DPSAlt.BarColor = ColorBar(pb_DPSAlt.Value / pb_DPSAlt.High);
		
		pb_TTKAlt.Value = FMin(AFS.TTK, pb_TTKAlt.High);
		pb_TTKAlt.Caption = AFS.TTK@"("$int(AFS.TTK / 0.007)$"%)";
		pb_TTKAlt.BarColor = ColorBar(pb_TTKAlt.Value / pb_TTKAlt.High);
		
		db_RPMAlt.Caption = AFS.RPM;
		
		db_RecoilAlt.Caption = String(AFS.RPShot);
		
		pb_RPSAlt.Value = FMin(AFS.RPS, pb_RPSAlt.High);
		pb_RPSAlt.Caption = String(AFS.RPS)@"("$int(AFS.RPS / 13.33)$"%)";
		pb_RPSAlt.BarColor = ColorBar(pb_RPSAlt.Value / pb_RPSAlt.High);
		
		db_ExpAlt.Caption = String(int(AFS.FCPShot * pb_HipSpr.Value));
		
		pb_EPSAlt.Value = FMin(AFS.FCPS * BW.default.ChaosAimSpread, pb_EPSAlt.High);
		pb_EPSAlt.Caption = String(int(AFS.FCPS * BW.default.ChaosAimSpread));
		pb_EPSAlt.BarColor = ColorBar(pb_EPSAlt.Value / pb_EPSAlt.High);
		
		//general stats
		
		pb_Raise.Value = BW.default.SightingTime;
		pb_Raise.Caption = String(pb_Raise.Value);
		pb_Raise.BarColor = ColorBar(pb_Raise.Value/pb_Raise.High);
		
		pb_HipSpr.Value = BW.default.ChaosAimSpread;
		pb_HipSpr.Caption = string(BW.default.ChaosAimSpread)@"("$int(BW.default.ChaosAimSpread / 12.80)$"%)";
		pb_HipSpr.BarColor = ColorBar(pb_HipSpr.Value / pb_HipSpr.High);
		
		db_Mag.Caption = String(BW.default.MagAmmo);
		
		pb_DPM.Value = FMin(BW.default.MagAmmo * FS.DamageInt, pb_DPM.High);
		pb_DPM.Caption = String(int(pb_DPM.Value))@"("$int(pb_DPM.Value / 8.8)$"%)";
		pb_DPM.BarColor = ColorBar(pb_DPM.Value / pb_DPM.High);
		
		db_Range.Caption = FS.Range;
		
		db_CAF.Caption = string(int(100 * (1 - BW.default.CrouchAimFactor)))$"%";
		
		db_MovePen.Caption = string(int((class'BallisticPawn'.default.GroundSpeed/BW.default.ChaosSpeedThreshold)* 100))$"%";
	}
}

function Object.Color ColorBar(float Factor)
{
	local Color C;
		
	C.R = 255;
	C.G = 255 * (1-Factor);
	C.B = 0;
	C.A = 255;
	return C;
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinHeight=1.000000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.BallisticWeaponStatsMenu.BackImage'

     Begin Object Class=GUIImage Name=ImageBoxWeapons
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.367497
         WinLeft=0.035000
         WinWidth=0.265000
         WinHeight=0.535937
         RenderWeight=0.002000
     End Object
     Box_WeaponList=GUIImage'BallisticProV55.BallisticWeaponStatsMenu.ImageBoxWeapons'

     Begin Object Class=GUIImage Name=ImageBoxDesc
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.047400
         WinLeft=0.335000
         WinWidth=0.635000
         WinHeight=0.860000
         RenderWeight=0.002000
     End Object
     Box_Desc=GUIImage'BallisticProV55.BallisticWeaponStatsMenu.ImageBoxDesc'

     Begin Object Class=GUIImage Name=ImageBox_WeaponIcon
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.035000
         WinWidth=0.265000
         WinHeight=0.200000
         RenderWeight=0.002000
     End Object
     Box_WeaponIcon=GUIImage'BallisticProV55.BallisticWeaponStatsMenu.ImageBox_WeaponIcon'

     Begin Object Class=GUIImage Name=WeaponIconImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Scaled
         WinTop=0.070000
         WinLeft=0.050000
         WinWidth=0.227000
         WinHeight=0.150000
         RenderWeight=0.004000
     End Object
     WeaponIcon=GUIImage'BallisticProV55.BallisticWeaponStatsMenu.WeaponIconImage'

     Begin Object Class=GUISectionBackground Name=GenBackImage
         Caption="General Statistics"
         TopPadding=0.010000
         BottomPadding=0.010000
         MaxPerColumn=20
         WinTop=0.050000
         WinLeft=0.335000
         WinWidth=0.200000
         WinHeight=0.850000
         OnPreDraw=GenBackImage.InternalPreDraw
     End Object
     GenBack=GUISectionBackground'BallisticProV55.BallisticWeaponStatsMenu.GenBackImage'

     Begin Object Class=GUISectionBackground Name=PriBackImage
         Caption="Primary Fire Statistics"
         TopPadding=0.010000
         BottomPadding=0.010000
         MaxPerColumn=20
         WinTop=0.050000
         WinLeft=0.552500
         WinWidth=0.200000
         WinHeight=0.850000
         OnPreDraw=PriBackImage.InternalPreDraw
     End Object
     PriBack=GUISectionBackground'BallisticProV55.BallisticWeaponStatsMenu.PriBackImage'

     Begin Object Class=GUISectionBackground Name=AltBackImage
         Caption="Alt Fire Statistics"
         TopPadding=0.010000
         BottomPadding=0.010000
         MaxPerColumn=20
         WinTop=0.050000
         WinLeft=0.770000
         WinWidth=0.200000
         WinHeight=0.850000
         OnPreDraw=AltBackImage.InternalPreDraw
     End Object
     AltBack=GUISectionBackground'BallisticProV55.BallisticWeaponStatsMenu.AltBackImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.925000
         WinLeft=0.400000
         WinWidth=0.200000
         TabOrder=0
         OnClick=BallisticWeaponStatsMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.BallisticWeaponStatsMenu.DoneButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Ballistic Weapon Statistics"
         WinHeight=0.031250
     End Object
     MyHeader=GUIHeader'BallisticProV55.BallisticWeaponStatsMenu.DaBeegHeader'

     Begin Object Class=GUIListBox Name=WeaponList
         bVisibleWhenEmpty=True
         OnCreateComponent=WeaponList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="All the weapons that can become available."
         WinTop=0.409137
         WinLeft=0.045977
         WinWidth=0.245000
         WinHeight=0.458359
         RenderWeight=0.510000
         TabOrder=1
     End Object
     lb_Weapons=GUIListBox'BallisticProV55.BallisticWeaponStatsMenu.WeaponList'

     Begin Object Class=GUILabel Name=WeaponCaption
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.250000
         WinLeft=0.035000
         WinWidth=0.265000
         WinHeight=0.065000
     End Object
     l_WeaponCaption=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.WeaponCaption'

     Begin Object Class=GUILabel Name=myCaption
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinWidth=0.200000
         WinHeight=0.030000
     End Object
     lb_DShot=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_DPS=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_TTK=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_RPM=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_Recoil=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_RPS=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_Exp=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_EPS=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_DShotAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_DPSAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_TTKAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_RPMAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_RecoilAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_RPSAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_ExpAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_EPSAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_Raise=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_HipSpr=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_Mag=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_DPM=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_Range=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_MovePen=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     lb_CAF=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.myCaption'

     Begin Object Class=GUILabel Name=MyData
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinWidth=0.200000
         WinHeight=0.030000
     End Object
     db_Dshot=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_RPM=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_Exp=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_Recoil=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_DshotAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_RPMAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_ExpAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_RecoilAlt=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_Mag=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_Range=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_MovePen=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     db_CAF=GUILabel'BallisticProV55.BallisticWeaponStatsMenu.MyData'

     Begin Object Class=moComboBox Name=co_DisplayCB
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Show"
         OnCreateComponent=co_DisplayCB.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Choose the information to show."
         WinTop=0.310000
         WinLeft=0.043000
         WinWidth=0.250000
         OnChange=BallisticWeaponStatsMenu.InternalOnChange
     End Object
     cb_Display=moComboBox'BallisticProV55.BallisticWeaponStatsMenu.co_DisplayCB'

     Begin Object Class=GUIScrollTextBox Name=WeaponDescription
         CharDelay=0.001000
         EOLDelay=0.250000
         bVisibleWhenEmpty=True
         OnCreateComponent=WeaponDescription.InternalOnCreateComponent
         FontScale=FNS_Small
         WinTop=0.091000
         WinLeft=0.345000
         WinWidth=0.615000
         WinHeight=0.770000
         RenderWeight=0.510000
         TabOrder=0
         bAcceptsInput=False
         bNeverFocus=True
     End Object
     sb_Desc=GUIScrollTextBox'BallisticProV55.BallisticWeaponStatsMenu.WeaponDescription'

     Begin Object Class=GUIProgressBar Name=myPB
         BarBack=Texture'2K4Menus.NewControls.NewStatusBar'
         BarTop=Texture'BallisticProTextures.Stats.StatusFillDesat'
         BarColor=(G=200)
         CaptionWidth=0.500000
         FontName="UT2SmallFont"
         ValueRightWidth=0.000000
         bShowValue=False
         FontScale=FNS_Small
         StyleName="TextLabel"
         WinHeight=0.030000
         RenderWeight=1.200000
     End Object
     pb_DPS=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_TTK=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_RPS=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_EPS=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_DPSAlt=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_TTKAlt=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_RPSAlt=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_EPSAlt=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_Raise=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_HipSpr=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     pb_DPM=GUIProgressBar'BallisticProV55.BallisticWeaponStatsMenu.myPB'

     Headings(0)="Melee"
     Headings(1)="Sidearms"
     Headings(2)="Sub Machineguns"
     Headings(3)="Assault Rifles"
     Headings(4)="Energy Weapons"
     Headings(5)="Heavy Machineguns"
     Headings(6)="Shotguns"
     Headings(7)="Ordnance"
     Headings(8)="Sniper Rifles"
     Headings(9)="Grenades"
     bRenderWorld=True
     bAllowedAsLast=True
     OnClose=BallisticWeaponStatsMenu.InternalOnClose
     OnKeyEvent=BallisticWeaponStatsMenu.InternalOnKeyEvent
}
