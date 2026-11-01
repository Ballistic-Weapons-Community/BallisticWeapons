class UTComp_Menu_ColorNames extends UTComp_Menu_MainMenu;

var automated GUILabel l_ColorNameLetters[20];
var automated GUILabel l_LetterSelection;
var automated moCheckBox ch_ColorChat, ch_ColorScoreboard, ch_ColorQ3, ch_EnemyNames;
var automated GUIComboBox co_SavedNames;
var automated GUIButton bu_SaveName, bu_DeleteName, bu_ResetWhite, bu_Apply;
var automated GUISlider sl_RedColor, sl_BlueColor, sl_GreenColor;
var automated GUILabel l_RedLabel, l_BlueLabel, l_GreenLabel;
var automated GUISlider sl_LetterSelect;
var automated moComboBox co_DeathSelect;

event Opened(GUIComponent Sender)
{
  InitSliderAndLetters();
  super.Opened(Sender);
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;
	
	Super.InitComponent(myController,MyOwner);
	
	for(i = 0; i < class'UTComp_Settings'.default.ColoredName.Length; i++)
		co_SavedNames.AddItem(UTComp_xPlayer(PlayerOwner()).FindColoredName(i));
		
	co_SavedNames.ReadOnly(true);
	InitSliderAndLetters();
	SetColorSliders(0);
	
	ch_ColorChat.Checked(class'UTComp_Settings'.default.bEnableColoredNamesInTalk);
	ch_ColorScoreboard.Checked(class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard);
	ch_ColorQ3.Checked(class'UTComp_Settings'.default.bAllowColoredMessages);
	ch_EnemyNames.Checked(class'UTComp_Settings'.default.bEnableColoredNamesOnEnemies);
	
	co_DeathSelect.AddItem("Disabled");
	co_DeathSelect.AddItem("Colored Names");
	co_DeathSelect.AddItem("Red/Blue Colored Names");
	co_DeathSelect.ReadOnly(true);
	
	if(class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths)
		co_DeathSelect.SetIndex(2);
	else if(class'UTComp_xDeathMessage'.default.DrawColoredNamesInDeathMessages)
		co_DeathSelect.SetIndex(1);
}

function InitSliderAndLetters()
{
	local int i, l;
	
	for(i = 0; i < Len(PlayerOwner().PlayerReplicationInfo.PlayerName); i++)
	{
		class'UTComp_Settings'.default.ColorName[i].A=255;     //make sure someone didnt change this
		l_ColorNameLetters[i].TextFont="UT2LargeFont";
		l_ColorNameLetters[i].WinTop=0.50;
		l_ColorNameLetters[i].WinWidth=0.029;
		l_ColorNameLetters[i].WinLeft=(0.50-(0.50*0.030*Len(PlayerOwner().PlayerReplicationInfo.PlayerName))+(0.030*i));
		l_ColorNameLetters[i].StyleName="TextLabel";
		l_ColorNameLetters[i].Caption=Right(Left(PlayerOwner().PlayerReplicationInfo.PlayerName, (i+1)), 1);
		l_ColorNameLetters[i].TextColor=class'UTComp_Settings'.default.ColorName[i];
		l_ColorNameLetters[i].TextAlign=TXTA_Center;
	}
	
	l = Len(PlayerOwner().PlayerReplicationInfo.PlayerName);
	
	if (l < 20)
		for(i = l; i < 20; i++)
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
	local int i, l;
	
	for(i = 0; i < Len(class'UTComp_Settings'.default.ColoredName[j].SavedName); i++)
	{
		class'UTComp_Settings'.default.ColorName[i].A=255;     //make sure someone didnt change this
		l_ColorNameLetters[i].TextFont="UT2LargeFont";
		l_ColorNameLetters[i].WinTop=0.50;
		l_ColorNameLetters[i].WinWidth=0.029;
		l_ColorNameLetters[i].WinLeft=(0.50-(0.50*0.030*Len(class'UTComp_Settings'.default.ColoredName[j].SavedName))+(0.030*i));
		l_ColorNameLetters[i].StyleName="TextLabel";
		l_ColorNameLetters[i].Caption=Right(Left(class'UTComp_Settings'.default.ColoredName[j].SavedName, (i+1)), 1);
		l_ColorNameLetters[i].TextColor=class'UTComp_Settings'.default.ColoredName[j].SavedColor[i];
		l_ColorNameLetters[i].TextAlign=TXTA_Center;
	}
	
	l = Len(class'UTComp_Settings'.default.ColoredName[j].SavedName);
	
	if (l < 20)
		for(i = l; i < 20; i++)
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

function InternalOnChange( GUIComponent C )
{
	switch(C)
	{
		case ch_ColorChat:
			class'UTComp_Settings'.default.bEnableColoredNamesInTalk = ch_ColorChat.IsChecked();
			class'UTComp_Settings'.static.StaticSaveConfig();
			break;
		
		case ch_ColorScoreboard:
			class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard = ch_ColorScoreboard.IsChecked();
			class'UTComp_ScoreBoard'.Static.StaticSaveConfig();
			break;
		
		case ch_ColorQ3:
			class'UTComp_Settings'.default.bAllowColoredMessages = ch_ColorQ3.IsChecked(); 
			class'UTComp_Settings'.static.StaticSaveConfig();
			break;
		
		case ch_EnemyNames:
			class'UTComp_Settings'.default.bEnableColoredNamesOnEnemies = ch_EnemyNames.IsChecked();
			class'UTComp_Settings'.static.StaticSaveConfig();
			break;
		
		case co_DeathSelect:
			class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths = (co_DeathSelect.GetIndex()==2);
			class'UTComp_xDeathMessage'.default.DrawColoredNamesInDeathMessages = (co_DeathSelect.GetIndex()==1);
			class'UTComp_xDeathMessage'.Static.StaticSaveConfig();
			break;
			
		case sl_LetterSelect:
			SetColorSliders(sl_LetterSelect.Value - 1);
			break;
		
		case sl_RedColor:
			class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value - 1].R = sl_RedColor.Value;
			UTComp_xPlayer(PlayerOwner()).SetColoredNameOldStyle();
			l_ColorNameLetters[sl_LetterSelect.Value - 1].TextColor.R = sl_RedColor.Value;
			class'UTComp_Settings'.static.StaticSaveConfig();
			break;
			
		case sl_BlueColor:
			class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value - 1].B = sl_BlueColor.Value;
			UTComp_xPlayer(PlayerOwner()).SetColoredNameOldStyle();
			l_ColorNameLetters[sl_LetterSelect.Value - 1].TextColor.B = sl_BlueColor.Value;
			class'UTComp_Settings'.static.StaticSaveConfig();
			break;
			
		case sl_GreenColor: 
			class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value - 1].G = sl_GreenColor.Value;
			UTComp_xPlayer(PlayerOwner()).SetColoredNameOldStyle();
			l_ColorNameLetters[sl_LetterSelect.Value - 1].TextColor.G = sl_GreenColor.Value;
			class'UTComp_Settings'.static.StaticSaveConfig();
			break;
	}	
	
}

function bool InternalOnClick( GUIComponent Sender )
{
	local int i;
	
	switch (Sender)
	{
		case bu_SaveName:
			UTComp_xPlayer(PlayerOwner()).SaveNewColoredName();
			co_SavedNames.ReadOnly(false);
			co_SavedNames.AddItem(UTComp_xPlayer(PlayerOwner()).FindColoredName(class'UTComp_Settings'.default.ColoredName.Length - 1));
			co_SavedNames.ReadOnly(true);
			class'UTComp_Settings'.static.staticSaveConfig();
			break;
	
		case bu_DeleteName:
			if(class'UTComp_Settings'.default.ColoredName.Length>co_SavedNames.GetIndex() && co_SavedNames.GetIndex()>=0)
				class'UTComp_Settings'.default.ColoredName.Remove(co_SavedNames.GetIndex(), 1);
				
			co_SavedNames.ReadOnly(false);
			co_SavedNames.RemoveItem(co_SavedNames.GetIndex());
			co_SavedNames.ReadOnly(true);
			class'UTComp_Settings'.static.staticSaveConfig();
			break;
	
	case bu_ResetWhite:
		for(i = 0; i < 20; i++)
		{
			class'UTComp_Settings'.default.colorname[i].R = 255;
			class'UTComp_Settings'.default.colorname[i].G = 255;
			class'UTComp_Settings'.default.colorname[i].B = 255;
			l_ColorNameLetters[i].TextColor.R = 255;
			l_ColorNameLetters[i].TextColor.G = 255;
			l_ColorNameLetters[i].TextColor.B = 255;
		}
		class'UTComp_Settings'.static.staticSaveConfig();
		break;
		
	case bu_Apply:
		UTComp_xPlayer(PlayerOwner()).SetColoredNameOldStyleCustom(,co_SavedNames.GetIndex());
		class'UTComp_Settings'.default.CurrentSelectedColoredName = co_savedNames.GetIndex();
		SpecialInitSliderAndLetters(co_SavedNames.GetIndex());
		SetColorSliders(sl_LetterSelect.Value - 1);
		class'UTComp_Settings'.static.staticSaveConfig();
		break;
	}
	
	Super.InternalOnClick(Sender);
	return true;
}

defaultproperties
{
     Begin Object Class=GUILabel Name=Label0
     End Object
     l_ColorNameLetters(0)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label0'

     Begin Object Class=GUILabel Name=Label1
     End Object
     l_ColorNameLetters(1)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label1'

     Begin Object Class=GUILabel Name=Label2
     End Object
     l_ColorNameLetters(2)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label2'

     Begin Object Class=GUILabel Name=Label3
     End Object
     l_ColorNameLetters(3)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label3'

     Begin Object Class=GUILabel Name=Label4
     End Object
     l_ColorNameLetters(4)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label4'

     Begin Object Class=GUILabel Name=Label5
     End Object
     l_ColorNameLetters(5)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label5'

     Begin Object Class=GUILabel Name=Label6
     End Object
     l_ColorNameLetters(6)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label6'

     Begin Object Class=GUILabel Name=Label7
     End Object
     l_ColorNameLetters(7)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label7'

     Begin Object Class=GUILabel Name=Label8
     End Object
     l_ColorNameLetters(8)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label8'

     Begin Object Class=GUILabel Name=Label9
     End Object
     l_ColorNameLetters(9)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label9'

     Begin Object Class=GUILabel Name=Label10
     End Object
     l_ColorNameLetters(10)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label10'

     Begin Object Class=GUILabel Name=Label11
     End Object
     l_ColorNameLetters(11)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label11'

     Begin Object Class=GUILabel Name=Label12
     End Object
     l_ColorNameLetters(12)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label12'

     Begin Object Class=GUILabel Name=Label13
     End Object
     l_ColorNameLetters(13)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label13'

     Begin Object Class=GUILabel Name=Label14
     End Object
     l_ColorNameLetters(14)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label14'

     Begin Object Class=GUILabel Name=Label15
     End Object
     l_ColorNameLetters(15)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label15'

     Begin Object Class=GUILabel Name=Label16
     End Object
     l_ColorNameLetters(16)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label16'

     Begin Object Class=GUILabel Name=Label17
     End Object
     l_ColorNameLetters(17)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label17'

     Begin Object Class=GUILabel Name=Label18
     End Object
     l_ColorNameLetters(18)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label18'

     Begin Object Class=GUILabel Name=Label19
     End Object
     l_ColorNameLetters(19)=GUILabel'utcompr04.UTComp_Menu_ColorNames.Label19'

     Begin Object Class=moCheckBox Name=ColorChatCheck
         Caption="Show colored names in chat messages"
         OnCreateComponent=ColorChatCheck.InternalOnCreateComponent
         WinTop=0.330000
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_ColorChat=moCheckBox'utcompr04.UTComp_Menu_ColorNames.ColorChatCheck'

     Begin Object Class=moCheckBox Name=ColorScoreboardCheck
         Caption="Show colored names on scoreboard"
         OnCreateComponent=ColorScoreboardCheck.InternalOnCreateComponent
         WinTop=0.365000
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_ColorScoreboard=moCheckBox'utcompr04.UTComp_Menu_ColorNames.ColorScoreboardCheck'

     Begin Object Class=moCheckBox Name=Colorq3Check
         Caption="Show colored text in chat messages"
         OnCreateComponent=Colorq3Check.InternalOnCreateComponent
         WinTop=0.433814
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_ColorQ3=moCheckBox'utcompr04.UTComp_Menu_ColorNames.Colorq3Check'

     Begin Object Class=moCheckBox Name=EnemyNamesCheck
         Caption="Show colored enemy names on targeting"
         OnCreateComponent=EnemyNamesCheck.InternalOnCreateComponent
         WinTop=0.400000
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_EnemyNames=moCheckBox'utcompr04.UTComp_Menu_ColorNames.EnemyNamesCheck'

     Begin Object Class=GUIComboBox Name=ComboSaved
         WinTop=0.612320
         WinLeft=0.140625
         WinWidth=0.300000
         WinHeight=0.031875
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=ComboSaved.InternalOnKeyEvent
     End Object
     co_SavedNames=GUIComboBox'utcompr04.UTComp_Menu_ColorNames.ComboSaved'

     Begin Object Class=GUIButton Name=ButtonSave
         Caption="Save"
         WinTop=0.650000
         WinLeft=0.142187
         WinWidth=0.133437
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonSave.InternalOnKeyEvent
     End Object
     bu_SaveName=GUIButton'utcompr04.UTComp_Menu_ColorNames.ButtonSave'

     Begin Object Class=GUIButton Name=ButtonDelete
         Caption="Delete"
         WinTop=0.650000
         WinLeft=0.303125
         WinWidth=0.133125
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonDelete.InternalOnKeyEvent
     End Object
     bu_DeleteName=GUIButton'utcompr04.UTComp_Menu_ColorNames.ButtonDelete'

     Begin Object Class=GUIButton Name=ButtonWhite
         Caption="Reset entire name to white"
         WinTop=0.739585
         WinLeft=0.540625
         WinWidth=0.344063
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonWhite.InternalOnKeyEvent
     End Object
     bu_ResetWhite=GUIButton'utcompr04.UTComp_Menu_ColorNames.ButtonWhite'

     Begin Object Class=GUIButton Name=ButtonApply
         Caption="Use This Name"
         WinTop=0.695833
         WinLeft=0.140625
         WinWidth=0.297188
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonApply.InternalOnKeyEvent
     End Object
     bu_Apply=GUIButton'utcompr04.UTComp_Menu_ColorNames.ButtonApply'

     Begin Object Class=GUISlider Name=RedSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.600000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=RedSlider.InternalOnClick
         OnMousePressed=RedSlider.InternalOnMousePressed
         OnMouseRelease=RedSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=RedSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedSlider.InternalCapturedMouseMove
     End Object
     sl_RedColor=GUISlider'utcompr04.UTComp_Menu_ColorNames.RedSlider'

     Begin Object Class=GUISlider Name=BlueSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.700000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=BlueSlider.InternalOnClick
         OnMousePressed=BlueSlider.InternalOnMousePressed
         OnMouseRelease=BlueSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=BlueSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueSlider.InternalCapturedMouseMove
     End Object
     sl_BlueColor=GUISlider'utcompr04.UTComp_Menu_ColorNames.BlueSlider'

     Begin Object Class=GUISlider Name=GreenSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.650000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=GreenSlider.InternalOnClick
         OnMousePressed=GreenSlider.InternalOnMousePressed
         OnMouseRelease=GreenSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=GreenSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenSlider.InternalCapturedMouseMove
     End Object
     sl_GreenColor=GUISlider'utcompr04.UTComp_Menu_ColorNames.GreenSlider'

     Begin Object Class=GUILabel Name=RedLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.587500
         WinLeft=0.528125
     End Object
     l_RedLabel=GUILabel'utcompr04.UTComp_Menu_ColorNames.RedLabel'

     Begin Object Class=GUILabel Name=BlueLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.685414
         WinLeft=0.528125
     End Object
     l_BlueLabel=GUILabel'utcompr04.UTComp_Menu_ColorNames.BlueLabel'

     Begin Object Class=GUILabel Name=GreenLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.635417
         WinLeft=0.528125
     End Object
     l_GreenLabel=GUILabel'utcompr04.UTComp_Menu_ColorNames.GreenLabel'

     Begin Object Class=GUISlider Name=LetterSlider
         Value=1.000000
         bIntSlider=True
         WinTop=0.535000
         OnClick=LetterSlider.InternalOnClick
         OnMousePressed=LetterSlider.InternalOnMousePressed
         OnMouseRelease=LetterSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=LetterSlider.InternalOnKeyEvent
         OnCapturedMouseMove=LetterSlider.InternalCapturedMouseMove
     End Object
     sl_LetterSelect=GUISlider'utcompr04.UTComp_Menu_ColorNames.LetterSlider'

     Begin Object Class=moComboBox Name=ColorDeathCombo
         Caption="Death Message Color:"
         OnCreateComponent=ColorDeathCombo.InternalOnCreateComponent
         WinTop=0.467990
         WinLeft=0.168749
         WinWidth=0.660936
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     co_DeathSelect=moComboBox'utcompr04.UTComp_Menu_ColorNames.ColorDeathCombo'

}
