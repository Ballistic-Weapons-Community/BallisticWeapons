class UTComp_Menu_Miscellaneous extends UTComp_Menu_MainMenu;

var automated GUILabel l_ScoreboardTitle;
var automated GUILabel l_OtherTitle;

var automated moCheckBox ch_UseScoreBoard;
var automated moCheckBox ch_InfoBox;
var automated moCheckBox ch_MatchHudColor;
var automated moCheckBox ch_OwnFootstepsCheck;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{	
	Super.InitComponent(MyController, MyOwner);
	
	ch_InfoBox.Checked(class'UTComp_Overlay'.default.DesiredOnJoinMessageTime != 0.0);
	ch_UseScoreboard.Checked(!class'UTComp_Settings'.default.bUseDefaultScoreboard);
	ch_MatchHudColor.Checked(class'UTComp_HudSettings'.default.bMatchHudColor);
}

event Opened(GuiComponent Sender)
{
	local UTComp_SRI UTCompSRI;
	
	Super.Opened(Sender);
	
	UTCompSRI = UTComp_xPlayer(PlayerOwner()).UTCompSRI;
	
	if (UTCompSRI == None || !UTCompSRI.bEnableScoreboard)
		ch_UseScoreboard.DisableMe();
	else
		ch_UseScoreboard.EnableMe();
		
	if (UTComp_xPlayer(PlayerOwner()).MutUTCompType != None)
	{
		ch_OwnFootstepsCheck.EnableMe();
		ch_OwnFootstepsCheck.Checked(class<UnrealPawn>(UTComp_xPlayer(PlayerOwner()).MutUTCompType.default.PawnType).default.bPlayOwnFootsteps);
	}
	else
		ch_OwnFootstepsCheck.DisableMe();
}

function InternalOnChange( GUIComponent C )
{
	switch(C)
	{
		case ch_InfoBox:  
			if(ch_InfoBox.IsChecked())
				class'UTComp_Overlay'.default.DesiredOnJoinMessageTime = 6.0;
			else
				class'UTComp_Overlay'.default.DesiredOnJoinMessageTime = 0.0;
				
			class'UTComp_Overlay'.static.StaticSaveConfig();
				
			break;
			
		case ch_UseScoreboard: 
			class'UTComp_Settings'.default.bUseDefaultScoreboard = !ch_UseScoreBoard.IsChecked();
			class'UTComp_Settings'.static.StaticSaveConfig();
			UTComp_xPlayer(PlayerOwner()).InitializeScoreboard();
			break;
					
		case ch_MatchHudColor:
			class'UTComp_HudSettings'.default.bMatchHudColor=ch_MatchHudColor.IsChecked();
			class'UTComp_HudSettings'.static.StaticSaveConfig();
			UTComp_xPlayer(PlayerOwner()).MatchHudColor();
			break;
			
		case ch_OwnFootstepsCheck:
			class<UnrealPawn>(UTComp_xPlayer(PlayerOwner()).MutUTCompType.default.PawnType).default.bPlayOwnFootsteps = ch_OwnFootstepsCheck.IsChecked();
			
			if (UnrealPawn(UTComp_xPlayer(PlayerOwner()).Pawn) != None)
				UnrealPawn(UTComp_xPlayer(PlayerOwner()).Pawn).bPlayOwnFootsteps = ch_OwnFootstepsCheck.IsChecked();
			
			UTComp_xPlayer(PlayerOwner()).MutUTCompType.default.PawnType.static.StaticSaveConfig();			
			break;
	}
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	return (Key != 0x1B);
}

defaultproperties
{
     Begin Object Class=GUILabel Name=ScoreboardLabel
         Caption="----------Scoreboard----------"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.310309
         WinLeft=0.250000
     End Object
     l_ScoreboardTitle=GUILabel'utcompr04.UTComp_Menu_Miscellaneous.ScoreboardLabel'

     Begin Object Class=GUILabel Name=OtherLabel
         Caption="--------Other Settings--------"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.387629
         WinLeft=0.250000
     End Object
     l_OtherTitle=GUILabel'utcompr04.UTComp_Menu_Miscellaneous.OtherLabel'

     Begin Object Class=moCheckBox Name=ScoreboardCheck
         Caption="Use UTComp enhanced scoreboard."
         OnCreateComponent=ScoreboardCheck.InternalOnCreateComponent
         WinTop=0.360000
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_UseScoreBoard=moCheckBox'utcompr04.UTComp_Menu_Miscellaneous.ScoreboardCheck'

     Begin Object Class=moCheckBox Name=InfoCheck
         Caption="Show UTComp info box on connect"
         OnCreateComponent=InfoCheck.InternalOnCreateComponent
         WinTop=0.443505
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_InfoBox=moCheckBox'utcompr04.UTComp_Menu_Miscellaneous.InfoCheck'

     Begin Object Class=moCheckBox Name=HudColorCheck
         Caption="Match HUD color to skins"
         OnCreateComponent=HudColorCheck.InternalOnCreateComponent
         WinTop=0.493505
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_MatchHudColor=moCheckBox'utcompr04.UTComp_Menu_Miscellaneous.HudColorCheck'

     Begin Object Class=moCheckBox Name=OwnFootstepsCheck
         Caption="Play own footsteps"
         OnCreateComponent=HudColorCheck.InternalOnCreateComponent
         WinTop=0.543505
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_OwnFootstepsCheck=moCheckBox'utcompr04.UTComp_Menu_Miscellaneous.OwnFootstepsCheck'

}
