//=============================================================================
// GameMenu_WeaponStats.
//
// A menu accessible by the BWStats command. Dynamically loads the requested weapon and
// shows relevant information for it.
//
// by Azarael
// based on code by Nolan "Dark Carnivour" Richert
//=============================================================================
class GameMenu_WeaponStats extends UT2K4GUIPage;

var float BaselineDPS;
var float BaselineTTK;
var float BaselineRPS;

var Automated GUIImage			    MyBack, Box_WeaponList, Box_Desc, Box_WeaponIcon, WeaponIcon;
var Automated GUISectionBackground  GenBack, PriBack, AltBack;
var Automated GUIButton			    BDone;
var automated GUIHeader 		    MyHeader;
var automated GUIListBox			lb_Weapons;
var automated GUILabel			    l_WeaponCaption, 
											lb_DShot, lb_DPS, lb_TTK, lb_RPM, lb_Recoil, lb_RPS,
											lb_DShotAlt, lb_DPSAlt, lb_TTKAlt, lb_RPMAlt, lb_RecoilAlt, lb_RPSAlt,
											lb_Raise, lb_ViewRecoilFactor, lb_Mag, lb_DPM, lb_Range, lb_RangeAlt, lb_ADSMultiplier, lb_CrouchMultiplier,
                                            lb_MoveSpeed, lb_ADSMoveSpeed, lb_Displacement,

											db_Dshot, db_HeadMult, db_LimbMult, db_RPM, db_Recoil,
											db_DshotAlt, db_HeadMultAlt, db_LimbMultAlt, db_RPMAlt, db_RecoilAlt,
											db_Mag, db_RangeOpt, db_RangeOptAlt, db_RangeDecayed, db_RangeDecayedAlt, db_RangeMax, db_RangeMaxAlt, db_ADSMultiplier, db_CrouchMultiplier;
var automated moComboBox	        cb_Display;
var automated GUIScrollTextBox      sb_Desc;
var automated GUIProgressBar	    pb_DPS, pb_TTK, pb_RPS, pb_DPSAlt, pb_TTKAlt, pb_RPSAlt, pb_Raise, pb_ViewRecoilFactor, pb_DPM, pb_MoveSpeed, pb_ADSMoveSpeed, pb_Displacement;

var InterpCurve 					RedCurve, GreenCurve, BlueCurve;

var bool							bInitialized, bAltStatsVisible;

var bool							bShowTextBox;

var class<BallisticWeapon>          BaselineClass;

var() localized string Headings[10];

function InitBaselineParams()
{
    local class<BallisticWeaponParams> params;
    local int GameStyleIndex;
    local FireEffectParams.FireModeStats fire_stats;

    GameStyleIndex = class'BallisticReplicationInfo'.default.GameStyle;

    params = BaselineClass.default.ParamsClasses[GameStyleIndex];

    fire_stats = params.static.GetFireStats();
    
    BaselineDPS = fire_stats.DPS;
    BaselineTTK = fire_stats.TTK;
    BaselineRPS = fire_stats.RPS;
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

	if (bInitialized)
		return;

    InitBaselineParams();

	lb_Weapons.List.OnChange = InternalOnChange;
	
	//pri
	lb_DShot.Caption = "Damage";
	lb_DPS.Caption = "DPS";
	lb_TTK.Caption = "Time to Kill (175 HP)";
	lb_RPM.Caption = "Fire Rate";
	lb_Recoil.Caption = "Recoil/Shot";
	lb_RPS.Caption = "Recoil/Second";
    lb_Range.Caption = "Effective Ranges";
	
	pb_DPS.High = BaselineDPS * 3;
	pb_TTK.High = BaselineTTK * 3;
	pb_RPS.High = BaselineRPS * 3;
	
	//alt
	lb_DShotAlt.Caption = "Damage";
	lb_DPSAlt.Caption = "DPS";
	lb_TTKAlt.Caption = "Time to Kill (175 HP)";
	lb_RPMAlt.Caption = "Fire Rate";
	lb_RecoilAlt.Caption = "Recoil/Shot";
	lb_RPSAlt.Caption = "Recoil/Second";
    lb_RangeAlt.Caption = "Effective Ranges";
	
	pb_DPSAlt.High = BaselineDPS * 3;
	pb_TTKAlt.High = BaselineTTK * 3;
	pb_RPSAlt.High = BaselineRPS * 3;
	
	//gen

	lb_Raise.Caption = "ADS Transition Time";
	lb_ViewRecoilFactor.Caption = "Recoil View Bind Factor";
	lb_Mag.Caption = "Capacity";
	lb_DPM.Caption = "Damage/Mag";
    lb_MoveSpeed.Caption = "Movement Multiplier";
    lb_ADSMoveSpeed.Caption = "ADS Movement Multiplier";
	lb_CrouchMultiplier.Caption = "Crouch Recoil Multiplier";
	lb_ADSMultiplier.Caption = "ADS Sway Multiplier";
    lb_Displacement.Caption = "Displacement Factor";

    pb_Raise.High = 0.8f;
	pb_ViewRecoilFactor.High = 1f;
    pb_Displacement.High = 2f;
    pb_MoveSpeed.High = 1.15f;
    pb_ADSMoveSpeed.High = 1.15f;
	pb_DPM.High = 2500;
		
	pb_TTK.NumDecimals=2;
	pb_TTKAlt.NumDecimals=2;
	
	//pri
	PriBack.ManageComponent(lb_DShot);	    
    PriBack.Managecomponent(db_DShot);
    PriBack.Managecomponent(db_HeadMult);
    PriBack.Managecomponent(db_LimbMult);

    PriBack.ManageComponent(lb_RPM);	    PriBack.Managecomponent(db_RPM);
    PriBack.Managecomponent(lb_DPS);	    PriBack.Managecomponent(pb_DPS);
	PriBack.Managecomponent(lb_TTK);	    PriBack.Managecomponent(pb_TTK);

    PriBack.ManageComponent(lb_Range);	    
    PriBack.ManageComponent(db_RangeOpt); 
    PriBack.ManageComponent(db_RangeDecayed);
    PriBack.ManageComponent(db_RangeMax);

	PriBack.ManageComponent(lb_Recoil);	    PriBack.ManageComponent(db_Recoil);
	PriBack.ManageComponent(lb_RPS);	    PriBack.ManageComponent(pb_RPS);
	
	//Alt
	AltBack.ManageComponent(lb_DShotAlt);
    AltBack.Managecomponent(db_DShotAlt);
    AltBack.Managecomponent(db_HeadMultAlt);
    AltBack.Managecomponent(db_LimbMultAlt);

    AltBack.ManageComponent(lb_RPMAlt);	    AltBack.Managecomponent(db_RPMAlt);
    AltBack.Managecomponent(lb_DPSAlt);	    AltBack.Managecomponent(pb_DPSAlt);
    AltBack.Managecomponent(lb_TTKAlt);	    AltBack.Managecomponent(pb_TTKAlt);

    AltBack.ManageComponent(lb_RangeAlt);
    AltBack.ManageComponent(db_RangeOptAlt); 
    AltBack.ManageComponent(db_RangeDecayedAlt);
    AltBack.ManageComponent(db_RangeMaxAlt);

	AltBack.ManageComponent(lb_RecoilAlt);	AltBack.ManageComponent(db_RecoilAlt);
	AltBack.ManageComponent(lb_RPSAlt);	    AltBack.ManageComponent(pb_RPSAlt);
	
	//gen back

    GenBack.ManageComponent(lb_Mag);	                GenBack.ManageComponent(db_Mag);
    GenBack.ManageComponent(lb_DPM);	                GenBack.ManageComponent(pb_DPM);
    GenBack.ManageComponent(lb_MoveSpeed);	            GenBack.ManageComponent(pb_MoveSpeed);
    GenBack.ManageComponent(lb_ADSMoveSpeed);	        GenBack.ManageComponent(pb_ADSMoveSpeed);
    GenBack.ManageComponent(lb_Raise);	                GenBack.ManageComponent(pb_Raise);
    GenBack.ManageComponent(lb_ADSMultiplier);	        GenBack.ManageComponent(db_ADSMultiplier);
	GenBack.ManageComponent(lb_CrouchMultiplier);	    GenBack.ManageComponent(db_CrouchMultiplier);
    GenBack.ManageComponent(lb_ViewRecoilFactor);	    GenBack.ManageComponent(pb_ViewRecoilFactor);
    GenBack.ManageComponent(lb_Displacement);	        GenBack.ManageComponent(pb_Displacement);

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
    local class<BallisticWeaponParams> params;

	local FireEffectParams.FireModeStats FS, AFS;

    local int GameStyleIndex;

    GameStyleIndex = class'BallisticReplicationInfo'.default.GameStyle;
	
	//FIXME DynamicLoadObject
	BW = class<BallisticWeapon>(DynamicLoadObject(lb_Weapons.List.GetExtra(), class'Class', True));

	if (BW != None)
        params = BW.default.ParamsClasses[GameStyleIndex];

    if (params != None)
	{
		FS = params.static.GetFireStats();
		AFS = params.static.GetAltFireStats();
		WeaponIcon.Image = BW.default.BigIconMaterial;
		l_WeaponCaption.Caption = BW.default.ItemName;
		l_WeaponCaption.TextColor = BW.default.HUDColor;
		sb_Desc.SetContent(BW.static.GetManual());

		//pri
		db_DShot.Caption = FS.Damage;
        db_HeadMult.Caption = "Head: x"$String(FS.HeadMult);
        db_LimbMult.Caption = "Limb: x"$String(FS.LimbMult);

        db_RangeOpt.Caption = FS.RangeOpt;
        db_RangeDecayed.Caption = FS.RangeDecayed;
        db_RangeMax.Caption = FS.RangeMax;
		
		pb_DPS.Value = FMin(FS.DPS, pb_DPS.High);
		pb_DPS.Caption = FS.DPS @ "(" $ int((FS.DPS / BaselineDPS) * 100) $ "%)";
		pb_DPS.BarColor = ColorBar(pb_DPS.Value / pb_DPS.High);
		
		pb_TTK.Value = FMin(FS.TTK, pb_TTK.High);
		pb_TTK.Caption = FS.TTK @ "(" $ int((FS.TTK / BaselineTTK) * 100) $ "%)";
		pb_TTK.BarColor = ColorBar(pb_TTK.Value / pb_TTK.High);
		
		db_RPM.Caption = FS.RPM;
		
		db_Recoil.Caption = String(FS.RPShot);
		
		pb_RPS.Value = FMin(FS.RPS, pb_RPS.High);
		pb_RPS.Caption = String(FS.RPS) @ "(" $ int((FS.RPS / BaselineRPS)* 100) $ "%)";
		pb_RPS.BarColor = ColorBar(pb_RPS.Value / pb_RPS.High);
		
		//Alt
		
		if (AFS.DamageInt > 0)
		{
			if(!bAltStatsVisible)
			{
				if (AltBack.bVisible)
				{
                    lb_RangeAlt.bVisible = true;
					lb_RecoilAlt.bVisible = true;
					lb_RPSAlt.bVisible = true;
					lb_TTKAlt.bVisible = true;
					lb_DPSAlt.bVisible = true;
				
					pb_DPSAlt.bVisible = true;
                    db_HeadMultAlt.bVisible = true;
                    db_LimbMultAlt.bVisible = true;
					pb_TTKAlt.bVisible = true;
					pb_RPSAlt.bVisible = true;
					db_RecoilAlt.bVisible = true;
                    db_RangeOptAlt.bVisible = true;
                    db_RangeDecayedAlt.bVisible = true;
                    db_RangeMaxAlt.bVisible = true;
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
                db_HeadMultAlt.bVisible = false;
                db_LimbMultAlt.bVisible = false;
                lb_RangeAlt.bVisible = false;
				lb_RecoilAlt.bVisible = false;
				lb_RPSAlt.bVisible = false;
				lb_TTKAlt.bVisible = false;
				lb_DPSAlt.bVisible = false;
				
				pb_DPSAlt.bVisible = false;
				pb_TTKAlt.bVisible = false;
				pb_RPSAlt.bVisible = false;
				db_RecoilAlt.bVisible = false;
                db_RangeOptAlt.bVisible = false;
                db_RangeDecayedAlt.bVisible = false;
                db_RangeMaxAlt.bVisible = false;
			}
			
			bAltStatsVisible=false;
		}
		
        if (AFS.DamageInt > 0)
            db_DShotAlt.Caption = AFS.Damage;
        else 
            db_DShotAlt.Caption = AFS.EffectString;

        db_HeadMultAlt.Caption = "Head: x"$String(AFS.HeadMult);
        db_LimbMultAlt.Caption = "Limb: x"$String(AFS.LimbMult);

        db_RangeOptAlt.Caption = AFS.RangeOpt;
        db_RangeDecayedAlt.Caption = AFS.RangeDecayed;
        db_RangeMaxAlt.Caption = AFS.RangeMax;

		pb_DPSAlt.Value = FMin(AFS.DPS, pb_DPSAlt.High);
		pb_DPSAlt.Caption = AFS.DPS @ "("$int((AFS.DPS / BaselineDPS) * 100)$"%)";
		pb_DPSAlt.BarColor = ColorBar(pb_DPSAlt.Value / pb_DPSAlt.High);
		
		pb_TTKAlt.Value = FMin(AFS.TTK, pb_TTKAlt.High);
		pb_TTKAlt.Caption = AFS.TTK @ "("$int((AFS.TTK / BaselineTTK) * 100)$"%)";
		pb_TTKAlt.BarColor = ColorBar(pb_TTKAlt.Value / pb_TTKAlt.High);
		
		db_RPMAlt.Caption = AFS.RPM;
		
		db_RecoilAlt.Caption = String(AFS.RPShot);
		
		pb_RPSAlt.Value = FMin(AFS.RPS, pb_RPSAlt.High);
		pb_RPSAlt.Caption = String(AFS.RPS) @ "("$int((AFS.RPS / BaselineRPS) * 100)$"%)";
		pb_RPSAlt.BarColor = ColorBar(pb_RPSAlt.Value / pb_RPSAlt.High);
				
		//general stats
		pb_Raise.Value = params.default.Layouts[0].SightingTime;
		pb_Raise.Caption = String(pb_Raise.Value);
		pb_Raise.BarColor = ColorBar(pb_Raise.Value/pb_Raise.High);
		
		pb_ViewRecoilFactor.Value = params.default.Layouts[0].RecoilParams[0].ViewBindFactor;
		pb_ViewRecoilFactor.Caption = string(int(Ceil(pb_ViewRecoilFactor.Value * 100f)))$ "%";
		pb_ViewRecoilFactor.BarColor = ColorBar(pb_ViewRecoilFactor.Value / pb_ViewRecoilFactor.High);

        pb_MoveSpeed.Value = params.default.Layouts[0].PlayerSpeedFactor;
		pb_MoveSpeed.Caption = string(int(Ceil(pb_MoveSpeed.Value * 100f)))$ "%";
		pb_MoveSpeed.BarColor = ColorBar(pb_MoveSpeed.Value / pb_MoveSpeed.High);

        pb_ADSMoveSpeed.Value = params.default.Layouts[0].SightMoveSpeedFactor;
        
		pb_ADSMoveSpeed.Caption = string(int(Ceil(pb_ADSMoveSpeed.Value * 100f)))$ "%";
		pb_ADSMoveSpeed.BarColor = ColorBar(pb_ADSMoveSpeed.Value / pb_ADSMoveSpeed.High);

        pb_Displacement.Value = params.default.Layouts[0].DisplaceDurationMult;
		pb_Displacement.Caption = string(int(Ceil(pb_Displacement.Value * 100f)))$ "%";
		pb_Displacement.BarColor = ColorBar(pb_Displacement.Value / pb_Displacement.High);

		db_Mag.Caption = String(params.default.Layouts[0].MagAmmo);
		
		pb_DPM.Value = FMin(params.default.Layouts[0].MagAmmo * FS.DamageInt, pb_DPM.High);
		pb_DPM.Caption = String(int(pb_DPM.Value)) @ "("$int(pb_DPM.Value / 6.0f)$"%)";
		pb_DPM.BarColor = ColorBar(pb_DPM.Value / pb_DPM.High);
		
		db_CrouchMultiplier.Caption = string(int(Ceil(100f * params.default.Layouts[0].AimParams[0].CrouchMultiplier)))$"%";
		
		db_ADSMultiplier.Caption = string(int(100 * params.default.Layouts[0].AimParams[0].ADSMultiplier))$"%";
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
     MyBack=GUIImage'BallisticProV55.GameMenu_WeaponStats.BackImage'

     Begin Object Class=GUIImage Name=ImageBoxWeapons
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.367497
         WinLeft=0.035000
         WinWidth=0.265000
         WinHeight=0.535937
         RenderWeight=0.002000
     End Object
     Box_WeaponList=GUIImage'BallisticProV55.GameMenu_WeaponStats.ImageBoxWeapons'

     Begin Object Class=GUIImage Name=ImageBoxDesc
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.047400
         WinLeft=0.335000
         WinWidth=0.635000
         WinHeight=0.860000
         RenderWeight=0.002000
     End Object
     Box_Desc=GUIImage'BallisticProV55.GameMenu_WeaponStats.ImageBoxDesc'

     Begin Object Class=GUIImage Name=ImageBox_WeaponIcon
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.035000
         WinWidth=0.265000
         WinHeight=0.200000
         RenderWeight=0.002000
     End Object
     Box_WeaponIcon=GUIImage'BallisticProV55.GameMenu_WeaponStats.ImageBox_WeaponIcon'

     Begin Object Class=GUIImage Name=WeaponIconImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Scaled
         WinTop=0.070000
         WinLeft=0.050000
         WinWidth=0.227000
         WinHeight=0.150000
         RenderWeight=0.004000
     End Object
     WeaponIcon=GUIImage'BallisticProV55.GameMenu_WeaponStats.WeaponIconImage'

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
     GenBack=GUISectionBackground'BallisticProV55.GameMenu_WeaponStats.GenBackImage'

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
     PriBack=GUISectionBackground'BallisticProV55.GameMenu_WeaponStats.PriBackImage'

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
     AltBack=GUISectionBackground'BallisticProV55.GameMenu_WeaponStats.AltBackImage'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.925000
         WinLeft=0.400000
         WinWidth=0.200000
         TabOrder=0
         OnClick=GameMenu_WeaponStats.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BallisticProV55.GameMenu_WeaponStats.DoneButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Ballistic Weapon Statistics"
         WinHeight=0.031250
     End Object
     MyHeader=GUIHeader'BallisticProV55.GameMenu_WeaponStats.DaBeegHeader'

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
     lb_Weapons=GUIListBox'BallisticProV55.GameMenu_WeaponStats.WeaponList'

     Begin Object Class=GUILabel Name=WeaponCaption
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.250000
         WinLeft=0.035000
         WinWidth=0.265000
         WinHeight=0.065000
     End Object
     l_WeaponCaption=GUILabel'BallisticProV55.GameMenu_WeaponStats.WeaponCaption'

     Begin Object Class=GUILabel Name=myCaption
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinWidth=0.200000
         WinHeight=0.030000
     End Object

     lb_DShot=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_DPS=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_TTK=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_RPM=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_Recoil=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_RPS=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_DShotAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_DPSAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_TTKAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_RPMAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_RecoilAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_RPSAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_Raise=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_MoveSpeed=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_ADSMoveSpeed=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_Displacement=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_ViewRecoilFactor=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_Mag=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_DPM=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_Range=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_RangeAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_ADSMultiplier=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     lb_CrouchMultiplier=GUILabel'BallisticProV55.GameMenu_WeaponStats.myCaption'

     Begin Object Class=GUILabel Name=MyData
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinWidth=0.200000
         WinHeight=0.030000
     End Object

     db_Dshot=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_HeadMult=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_LimbMult=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_RPM=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_Recoil=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_DshotAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_HeadMultAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_LimbMultAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_RPMAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_RecoilAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_Mag=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_RangeOpt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_RangeDecayed=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_RangeMax=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_RangeOptAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_RangeDecayedAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'
     db_RangeMaxAlt=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_ADSMultiplier=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

     db_CrouchMultiplier=GUILabel'BallisticProV55.GameMenu_WeaponStats.MyData'

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
         OnChange=GameMenu_WeaponStats.InternalOnChange
     End Object
     cb_Display=moComboBox'BallisticProV55.GameMenu_WeaponStats.co_DisplayCB'

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
     sb_Desc=GUIScrollTextBox'BallisticProV55.GameMenu_WeaponStats.WeaponDescription'

     Begin Object Class=GUIProgressBar Name=myPB
         BarBack=Texture'2K4Menus.NewControls.NewStatusBar'
         BarTop=Texture'BW_Core_WeaponTex.Stats.StatusFillDesat'
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
     pb_DPS=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_TTK=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_RPS=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_DPSAlt=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_TTKAlt=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_RPSAlt=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_Raise=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_ViewRecoilFactor=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_MoveSpeed=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_ADSMoveSpeed=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_Displacement=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

     pb_DPM=GUIProgressBar'BallisticProV55.GameMenu_WeaponStats.myPB'

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
     OnClose=GameMenu_WeaponStats.InternalOnClose
     OnKeyEvent=GameMenu_WeaponStats.InternalOnKeyEvent

    BaselineClass=class'M50AssaultRifle'
}
