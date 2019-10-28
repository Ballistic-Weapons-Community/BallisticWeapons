class Menu_TabUTCompFR extends UT2k3TabPanel;

var GUILabel l_ColorNameLetters[20];
var GUILabel l_LetterSelection;
var GUIComboBox co_SavedNames;
var GUIButton bu_SaveName, bu_DeleteName, bu_ResetWhite, bu_Apply;
var GUISlider sl_RedColor, sl_BlueColor, sl_GreenColor;
var GUILabel l_RedLabel, l_BlueLabel, l_GreenLabel;
var GUISlider sl_LetterSelect;
var moCheckBox co_ScoreBoard, co_ScoreboardSkillAsDefault, co_ScoreBoardColor, co_Death, co_Talk, co_HUD, co_HideSkill, co_HudNameTint;

event Opened(GUIComponent Sender)
{
	InitSliderAndLetters();
	Super.Opened(Sender);
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;

	co_ScoreBoard = moCheckBox(Controls[1]);
	co_ScoreBoardColor = moCheckBox(Controls[37]);
	co_ScoreboardSkillAsDefault = moCheckBox(Controls[38]);
	co_Death =  moCheckBox(Controls[2]);
	co_Talk =  moCheckBox(Controls[3]);
	co_HUD =  moCheckBox(Controls[4]);
	co_HudNameTint = moCheckBox(Controls[39]);
	co_HideSkill = moCheckBox(Controls[40]);
	l_ColorNameLetters[0] = GUILabel(Controls[5]);
	l_ColorNameLetters[1] = GUILabel(Controls[6]);
	l_ColorNameLetters[2] = GUILabel(Controls[7]);
	l_ColorNameLetters[3] = GUILabel(Controls[8]);
	l_ColorNameLetters[4] = GUILabel(Controls[9]);
	l_ColorNameLetters[5] = GUILabel(Controls[10]);
	l_ColorNameLetters[6] = GUILabel(Controls[11]);
	l_ColorNameLetters[7] = GUILabel(Controls[12]);
	l_ColorNameLetters[8] = GUILabel(Controls[13]);
	l_ColorNameLetters[9] = GUILabel(Controls[14]);
	l_ColorNameLetters[10] = GUILabel(Controls[15]);
	l_ColorNameLetters[11] = GUILabel(Controls[16]);
	l_ColorNameLetters[12] = GUILabel(Controls[17]);
	l_ColorNameLetters[13] = GUILabel(Controls[18]);
	l_ColorNameLetters[14] = GUILabel(Controls[19]);
	l_ColorNameLetters[15] = GUILabel(Controls[20]);
	l_ColorNameLetters[16] = GUILabel(Controls[21]);
	l_ColorNameLetters[17] = GUILabel(Controls[22]);
	l_ColorNameLetters[18] = GUILabel(Controls[23]);
	l_ColorNameLetters[19] = GUILabel(Controls[24]);
	co_SavedNames = GUIComboBox(Controls[25]);
	bu_SaveName = GUIButton(Controls[26]);
	bu_DeleteName = GUIButton(Controls[27]);
	bu_ResetWhite = GUIButton(Controls[28]);
	bu_Apply = GUIButton(Controls[29]);
	sl_RedColor = GUISlider(Controls[30]);
	sl_BlueColor = GUISlider(Controls[31]);
	sl_GreenColor = GUISlider(Controls[32]);
	l_RedLabel = GUILabel(Controls[33]);
	l_BlueLabel = GUILabel(Controls[34]);
	l_GreenLabel = GUILabel(Controls[35]);
	sl_LetterSelect = GUISlider(Controls[36]);
		
	Super.InitComponent(MyController, MyOwner);
	
	co_ScoreBoard.Checked(class'UTComp_Settings_FREON'.default.bUseEnhancedScoreboard);
	co_ScoreBoardColor.Checked(class'UTComp_Settings_FREON'.default.bEnableColoredNamesOnScoreboard);
	co_ScoreboardSkillAsDefault.Checked(class'UTComp_Settings_FREON'.default.bViewSkillByDefaultOnEnhancedScoreboard);
	co_Death.Checked(class'UTComp_Settings_FREON'.default.bColoredNamesInDM);
	co_Talk.Checked(class'UTComp_Settings_FREON'.default.bColoredNamesInChat);
	co_HUD.Checked(class'UTComp_Settings_FREON'.default.bColoredNamesInHUD);
	
	if (Freon_Player_UTComp_LDG(PlayerOwner()).bSkillMode)
	{
		if (Freon_Player_UTComp_LDG(PlayerOwner()).UTCompPRI != None)
			co_HideSkill.Checked(Freon_Player_UTComp_LDG(PlayerOwner()).UTCompPRI.bHideSkill);
		else
			co_HideSkill.DisableMe();
	}
	else
	{
		co_HideSkill.DisableMe();
		co_ScoreboardSkillAsDefault.DisableMe();
	}
	
	for(i = 0; i < class'UTComp_Settings'.default.ColoredName.Length; i++)
		co_SavedNames.AddItem(Freon_Player_UTComp_LDG(PlayerOwner()).FindColoredName(i));
	
	co_SavedNames.ReadOnly(True);
	InitSliderAndLetters();
	SetColorSliders(0);
}

function InternalOnChange(GUIComponent C)
{		
	switch(C)
	{			
		case co_ScoreBoard:
			class'UTComp_Settings_FREON'.default.bUseEnhancedScoreboard = co_ScoreBoard.IsChecked();
			
			if (class'UTComp_Settings_FREON'.default.bUseEnhancedScoreboard && Freon_Player_UTComp_LDG(PlayerOwner()).bSkillMode)
				co_ScoreboardSkillAsDefault.EnableMe();
			else
				co_ScoreboardSkillAsDefault.DisableMe();
			
			Freon_Player_UTComp_LDG(PlayerOwner()).InitializeScoreboard();
			class'UTComp_Settings_FREON'.static.StaticSaveConfig();
			break;
			
		case co_ScoreboardSkillAsDefault:
			class'UTComp_Settings_FREON'.default.bViewSkillByDefaultOnEnhancedScoreboard = co_ScoreboardSkillAsDefault.IsChecked();
			class'UTComp_Settings_FREON'.static.StaticSaveConfig();
			break;
		
		case co_ScoreBoardColor:
			class'UTComp_Settings_FREON'.default.bEnableColoredNamesOnScoreboard = co_ScoreBoardColor.IsChecked();
			class'UTComp_Settings_FREON'.static.StaticSaveConfig();
			break;
			
		case co_Death:
			class'UTComp_Settings_FREON'.default.bColoredNamesInDM = co_Death.IsChecked();
			class'UTComp_Settings_FREON'.static.StaticSaveConfig();
			break;
			
		case co_Talk:
			class'UTComp_Settings_FREON'.default.bColoredNamesInChat = co_Talk.IsChecked();
			class'UTComp_Settings_FREON'.static.StaticSaveConfig();
			break;
			
		case co_HUD:
			class'UTComp_Settings_FREON'.default.bColoredNamesInHUD = co_HUD.IsChecked();
			class'UTComp_Settings_FREON'.static.StaticSaveConfig();
			break;
			
		case co_HUDNameTint:
			class'Freon_HUD'.default.bAlwaysHPTint= co_HUDNameTint.IsChecked();
			class'Freon_HUD'.static.StaticSaveConfig();
			break;
			
		case co_HideSkill:
			Freon_Player_UTComp_LDG(PlayerOwner()).ServerToggleViewSkill(co_HideSkill.IsChecked());
			break;

		case sl_LetterSelect: 
			SetColorSliders(sl_LetterSelect.Value-1); 
			break;

    case sl_RedColor:   
    	class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value-1].R=sl_RedColor.Value;
			Freon_Player_UTComp_LDG(PlayerOwner()).SetColoredNameOldStyle();
			l_ColorNameLetters[sl_LetterSelect.Value-1].TextColor.R=sl_RedColor.Value;
			break;
			
    case sl_BlueColor:  
			class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value-1].B=sl_BlueColor.Value;
			Freon_Player_UTComp_LDG(PlayerOwner()).SetColoredNameOldStyle();
			l_ColorNameLetters[sl_LetterSelect.Value-1].TextColor.B=sl_BlueColor.Value;  
			break;
    
    case sl_GreenColor: 
			class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value-1].G=sl_GreenColor.Value;
			Freon_Player_UTComp_LDG(PlayerOwner()).SetColoredNameOldStyle();
			l_ColorNameLetters[sl_LetterSelect.Value-1].TextColor.G=sl_GreenColor.Value;  
			break;
	}
	
	class'UTComp_Settings'.static.StaticSaveConfig();
}

function InitSliderAndLetters()
{
	local int i;
	
	for(i=0; i<Len(PlayerOwner().PlayerReplicationInfo.PlayerName); i++)
	{
		class'UTComp_Settings'.default.ColorName[i].A=255;     //make sure someone didnt change this
		l_ColorNameLetters[i].TextFont="UT2LargeFont";
		l_ColorNameLetters[i].WinTop=0.65;
		l_ColorNameLetters[i].WinWidth=0.029;
		l_ColorNameLetters[i].WinLeft=(0.50-(0.50*0.030*Len(PlayerOwner().PlayerReplicationInfo.PlayerName))+(0.030*i));
		l_ColorNameLetters[i].StyleName="TextLabel";
		l_ColorNameLetters[i].Caption=Right(Left(PlayerOwner().PlayerReplicationInfo.PlayerName, (i+1)), 1);
		l_ColorNameLetters[i].TextColor=class'UTComp_Settings'.default.ColorName[i];
		l_ColorNameLetters[i].TextAlign=TXTA_Center;
	}
	
	for(i=Len(PlayerOwner().PlayerReplicationInfo.PlayerName); i<20; i++)
		l_ColorNameLetters[i].Caption="";
	
	sl_LetterSelect.MinValue=1;
	sl_LetterSelect.WinLeft=(0.50-(0.50*0.030*Len(PlayerOwner().PlayerReplicationInfo.PlayerName)));
	sl_LetterSelect.MaxValue=Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20);
	sl_LetterSelect.WinWidth=(0.0297*Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20));
	sl_LetterSelect.BarStyle=None;
	sl_LetterSelect.FillImage=None;
}

function SpecialInitSliderAndLetters(int j)
{
	local int i;
	
	for(i=0; i<Len(class'UTComp_Settings'.default.ColoredName[j].SavedName); i++)
	{
		class'UTComp_Settings'.default.ColorName[i].A=255;     //make sure someone didnt change this
		l_ColorNameLetters[i].TextFont="UT2LargeFont";
		l_ColorNameLetters[i].WinTop=0.65;
		l_ColorNameLetters[i].WinWidth=0.029;
		l_ColorNameLetters[i].WinLeft=(0.50-(0.50*0.030*Len(class'UTComp_Settings'.default.ColoredName[j].SavedName))+(0.030*i));
		l_ColorNameLetters[i].StyleName="TextLabel";
		l_ColorNameLetters[i].Caption=Right(Left(class'UTComp_Settings'.default.ColoredName[j].SavedName, (i+1)), 1);
		l_ColorNameLetters[i].TextColor=class'UTComp_Settings'.default.ColoredName[j].SavedColor[i];
		l_ColorNameLetters[i].TextAlign=TXTA_Center;
	}
	
	for(i=Len(class'UTComp_Settings'.default.ColoredName[j].SavedName); i<20; i++)
		l_ColorNameLetters[i].Caption="";
	
	sl_LetterSelect.MinValue=1;
	sl_LetterSelect.WinLeft=(0.50-(0.50*0.030*Len(PlayerOwner().PlayerReplicationInfo.PlayerName)));
	sl_LetterSelect.MaxValue=Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20);
	sl_LetterSelect.WinWidth=(0.0297*Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20));
	sl_LetterSelect.BarStyle=None;
	sl_LetterSelect.FillImage=None;
}

function SetColorSliders(byte offset)
{
	sl_RedColor.SetValue(class'UTComp_Settings'.default.colorname[offset].R);
	sl_BlueColor.SetValue(class'UTComp_Settings'.default.colorname[offset].B);
	sl_GreenColor.SetValue(class'UTComp_Settings'.default.colorname[offset].G);
}

function bool InternalOnClick( GUIComponent Sender )
{
	local int i;
	
	switch (Sender)
	{
		case bu_SaveName:
			Freon_Player_UTComp_LDG(PlayerOwner()).SaveNewColoredName();
			co_SavedNames.ReadOnly(False);
			co_SavedNames.AddItem(Freon_Player_UTComp_LDG(PlayerOwner()).FindColoredName(class'UTComp_Settings'.default.ColoredName.Length-1));
			co_SavedNames.ReadOnly(True);
			break;

    case bu_DeleteName:  
			if(class'UTComp_Settings'.default.ColoredName.Length>co_SavedNames.GetIndex() && co_SavedNames.GetIndex()>=0)
				class'UTComp_Settings'.default.ColoredName.Remove(co_SavedNames.GetIndex(), 1);
                       
			co_SavedNames.ReadOnly(False);
			co_SavedNames.RemoveItem(co_SavedNames.GetIndex());
			co_SavedNames.ReadOnly(True); 
			break;

    case bu_ResetWhite:   
    	for(i=0; i<20; i++)
			{
				class'UTComp_Settings'.default.colorname[i].R=255;
				class'UTComp_Settings'.default.colorname[i].G=255;
				class'UTComp_Settings'.default.colorname[i].B=255;
				l_ColorNameLetters[i].TextColor.R=255;
				l_ColorNameLetters[i].TextColor.G=255;
				l_ColorNameLetters[i].TextColor.B=255;
			}
			Freon_Player_UTComp_LDG(PlayerOwner()).SetColoredNameOldStyle();   
			break;
			
    case bu_Apply:
			Freon_Player_UTComp_LDG(PlayerOwner()).SetColoredNameOldStyleCustom(,co_SavedNames.GetIndex());
			class'UTComp_Settings'.default.CurrentSelectedColoredName=co_savedNames.GetIndex();
			SpecialInitSliderAndLetters(co_SavedNames.GetIndex());
			SetColorSliders(sl_LetterSelect.Value-1);  
			break;
							
			return true;
	}
   
   
	class'UTComp_Settings'.static.StaticSaveConfig();

	return true;
}

defaultproperties
{
     Begin Object Class=GUIImage Name=TabBackground
         Image=Texture'InterfaceContent.Menu.ScoreBoxA'
         ImageColor=(B=0,G=0,R=0)
         ImageStyle=ISTY_Stretched
         WinHeight=1.000000
         bNeverFocus=True
     End Object
     Controls(0)=GUIImage'LDGGameBW.Menu_TabUTCompFR.TabBackground'

     Begin Object Class=moCheckBox Name=ScoreboardCheck
         Caption="Enable UTComp Scoreboard"
         OnCreateComponent=ScoreboardCheck.InternalOnCreateComponent
         Hint="Use UTComp Scoreboard instead of 3SPN one."
         WinTop=0.050000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(1)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.ScoreboardCheck'

     Begin Object Class=moCheckBox Name=DeathCheck
         Caption="Colored Names In Death Messages"
         OnCreateComponent=DeathCheck.InternalOnCreateComponent
         Hint="Use colored names in death messages."
         WinTop=0.200000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(2)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.DeathCheck'

     Begin Object Class=moCheckBox Name=TalkCheck
         Caption="Colored Names In Chat"
         OnCreateComponent=TalkCheck.InternalOnCreateComponent
         Hint="Use colored names in chat."
         WinTop=0.250000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(3)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.TalkCheck'

     Begin Object Class=moCheckBox Name=HUDCheck
         Caption="Colored Names In HUD"
         OnCreateComponent=HUDCheck.InternalOnCreateComponent
         Hint="Use colored names in HUD."
         WinTop=0.300000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(4)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.HUDCheck'

     Begin Object Class=GUILabel Name=Label0
     End Object
     Controls(5)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label0'

     Begin Object Class=GUILabel Name=Label1
     End Object
     Controls(6)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label1'

     Begin Object Class=GUILabel Name=Label2
     End Object
     Controls(7)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label2'

     Begin Object Class=GUILabel Name=Label3
     End Object
     Controls(8)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label3'

     Begin Object Class=GUILabel Name=Label4
     End Object
     Controls(9)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label4'

     Begin Object Class=GUILabel Name=Label5
     End Object
     Controls(10)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label5'

     Begin Object Class=GUILabel Name=Label6
     End Object
     Controls(11)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label6'

     Begin Object Class=GUILabel Name=Label7
     End Object
     Controls(12)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label7'

     Begin Object Class=GUILabel Name=Label8
     End Object
     Controls(13)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label8'

     Begin Object Class=GUILabel Name=Label9
     End Object
     Controls(14)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label9'

     Begin Object Class=GUILabel Name=Label10
     End Object
     Controls(15)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label10'

     Begin Object Class=GUILabel Name=Label11
     End Object
     Controls(16)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label11'

     Begin Object Class=GUILabel Name=Label12
     End Object
     Controls(17)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label12'

     Begin Object Class=GUILabel Name=Label13
     End Object
     Controls(18)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label13'

     Begin Object Class=GUILabel Name=Label14
     End Object
     Controls(19)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label14'

     Begin Object Class=GUILabel Name=Label15
     End Object
     Controls(20)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label15'

     Begin Object Class=GUILabel Name=Label16
     End Object
     Controls(21)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label16'

     Begin Object Class=GUILabel Name=Label17
     End Object
     Controls(22)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label17'

     Begin Object Class=GUILabel Name=Label18
     End Object
     Controls(23)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label18'

     Begin Object Class=GUILabel Name=Label19
     End Object
     Controls(24)=GUILabel'LDGGameBW.Menu_TabUTCompFR.Label19'

     Begin Object Class=GUIComboBox Name=ComboSaved
         WinTop=0.762320
         WinLeft=0.140625
         WinWidth=0.300000
         WinHeight=0.031875
         OnChange=Menu_TabUTCompFR.InternalOnChange
         OnKeyEvent=ComboSaved.InternalOnKeyEvent
     End Object
     Controls(25)=GUIComboBox'LDGGameBW.Menu_TabUTCompFR.ComboSaved'

     Begin Object Class=GUIButton Name=ButtonSave
         Caption="Save"
         WinTop=0.825000
         WinLeft=0.142187
         WinWidth=0.133437
         WinHeight=0.050000
         OnClick=Menu_TabUTCompFR.InternalOnClick
         OnKeyEvent=ButtonSave.InternalOnKeyEvent
     End Object
     Controls(26)=GUIButton'LDGGameBW.Menu_TabUTCompFR.ButtonSave'

     Begin Object Class=GUIButton Name=ButtonDelete
         Caption="Delete"
         WinTop=0.825000
         WinLeft=0.303125
         WinWidth=0.133125
         WinHeight=0.050000
         OnClick=Menu_TabUTCompFR.InternalOnClick
         OnKeyEvent=ButtonDelete.InternalOnKeyEvent
     End Object
     Controls(27)=GUIButton'LDGGameBW.Menu_TabUTCompFR.ButtonDelete'

     Begin Object Class=GUIButton Name=ButtonWhite
         Caption="Reset entire name to white"
         WinTop=0.899585
         WinLeft=0.540625
         WinWidth=0.344063
         WinHeight=0.050000
         OnClick=Menu_TabUTCompFR.InternalOnClick
         OnKeyEvent=ButtonWhite.InternalOnKeyEvent
     End Object
     Controls(28)=GUIButton'LDGGameBW.Menu_TabUTCompFR.ButtonWhite'

     Begin Object Class=GUIButton Name=ButtonApply
         Caption="Use This Name"
         WinTop=0.899585
         WinLeft=0.140625
         WinWidth=0.297188
         WinHeight=0.050000
         OnClick=Menu_TabUTCompFR.InternalOnClick
         OnKeyEvent=ButtonApply.InternalOnKeyEvent
     End Object
     Controls(29)=GUIButton'LDGGameBW.Menu_TabUTCompFR.ButtonApply'

     Begin Object Class=GUISlider Name=RedSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.760000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=RedSlider.InternalOnClick
         OnMousePressed=RedSlider.InternalOnMousePressed
         OnMouseRelease=RedSlider.InternalOnMouseRelease
         OnChange=Menu_TabUTCompFR.InternalOnChange
         OnKeyEvent=RedSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedSlider.InternalCapturedMouseMove
     End Object
     Controls(30)=GUISlider'LDGGameBW.Menu_TabUTCompFR.RedSlider'

     Begin Object Class=GUISlider Name=BlueSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.860000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=BlueSlider.InternalOnClick
         OnMousePressed=BlueSlider.InternalOnMousePressed
         OnMouseRelease=BlueSlider.InternalOnMouseRelease
         OnChange=Menu_TabUTCompFR.InternalOnChange
         OnKeyEvent=BlueSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueSlider.InternalCapturedMouseMove
     End Object
     Controls(31)=GUISlider'LDGGameBW.Menu_TabUTCompFR.BlueSlider'

     Begin Object Class=GUISlider Name=GreenSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.810000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=GreenSlider.InternalOnClick
         OnMousePressed=GreenSlider.InternalOnMousePressed
         OnMouseRelease=GreenSlider.InternalOnMouseRelease
         OnChange=Menu_TabUTCompFR.InternalOnChange
         OnKeyEvent=GreenSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenSlider.InternalCapturedMouseMove
     End Object
     Controls(32)=GUISlider'LDGGameBW.Menu_TabUTCompFR.GreenSlider'

     Begin Object Class=GUILabel Name=RedLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.747500
         WinLeft=0.528125
     End Object
     Controls(33)=GUILabel'LDGGameBW.Menu_TabUTCompFR.RedLabel'

     Begin Object Class=GUILabel Name=BlueLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.845414
         WinLeft=0.528125
     End Object
     Controls(34)=GUILabel'LDGGameBW.Menu_TabUTCompFR.BlueLabel'

     Begin Object Class=GUILabel Name=GreenLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.795417
         WinLeft=0.528125
     End Object
     Controls(35)=GUILabel'LDGGameBW.Menu_TabUTCompFR.GreenLabel'

     Begin Object Class=GUISlider Name=LetterSlider
         Value=1.000000
         bIntSlider=True
         WinTop=0.695000
         OnClick=LetterSlider.InternalOnClick
         OnMousePressed=LetterSlider.InternalOnMousePressed
         OnMouseRelease=LetterSlider.InternalOnMouseRelease
         OnChange=Menu_TabUTCompFR.InternalOnChange
         OnKeyEvent=LetterSlider.InternalOnKeyEvent
         OnCapturedMouseMove=LetterSlider.InternalCapturedMouseMove
     End Object
     Controls(36)=GUISlider'LDGGameBW.Menu_TabUTCompFR.LetterSlider'

     Begin Object Class=moCheckBox Name=ColorScoreboardCheck
         Caption="Colored Names on Scoreboard"
         OnCreateComponent=ColorScoreboardCheck.InternalOnCreateComponent
         Hint="Use colored names on Scoreboard."
         WinTop=0.150000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(37)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.ColorScoreboardCheck'

     Begin Object Class=moCheckBox Name=ScoreboardSkillAsDefault
         Caption="   and view skill by default"
         OnCreateComponent=ScoreboardSkillAsDefault.InternalOnCreateComponent
         Hint="Whether by default skill shows on the scoreboard or not."
         WinTop=0.100000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(38)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.ScoreboardSkillAsDefault'

     Begin Object Class=moCheckBox Name=HUDNameTintCheck
         Caption="Always Tint Beacon Names"
         OnCreateComponent=HUDNameTintCheck.InternalOnCreateComponent
         Hint="Tints player beacon names according to player HP."
         WinTop=0.350000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(39)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.HUDNameTintCheck'

     Begin Object Class=moCheckBox Name=HideSkillCheck
         Caption="Hide Skill"
         OnCreateComponent=HideSkillCheck.InternalOnCreateComponent
         Hint="Hide skill on scoreboard (shows X.XX)."
         WinTop=0.400000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabUTCompFR.InternalOnChange
     End Object
     Controls(40)=moCheckBox'LDGGameBW.Menu_TabUTCompFR.HideSkillCheck'

}
