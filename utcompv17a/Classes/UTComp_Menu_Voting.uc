

defaultproperties
{
     Begin Object Class=GUIButton Name=GameTypeButton
         Caption="Gametype"
         WinTop=0.572916
         WinLeft=0.312500
         WinWidth=0.180000
         WinHeight=0.123437
         OnClick=UTComp_Menu_Voting.InternalOnClick
         OnKeyEvent=GameTypeButton.InternalOnKeyEvent
     End Object
     bu_GameTypeMenu=GUIButton'utcompv17a.UTComp_Menu_Voting.GameTypeButton'

     Begin Object Class=GUIButton Name=MapChangeButton
         Caption="Change Map"
         WinTop=0.449999
         WinLeft=0.315625
         WinWidth=0.373751
         WinHeight=0.123437
         OnClick=UTComp_Menu_Voting.InternalOnClick
         OnKeyEvent=MapChangeButton.InternalOnKeyEvent
     End Object
     bu_MapChangeMenu=GUIButton'utcompv17a.UTComp_Menu_Voting.MapChangeButton'

     Begin Object Class=GUIButton Name=UTComp_SettingsButton
         Caption="Settings"
         WinTop=0.572916
         WinLeft=0.512501
         WinWidth=0.180000
         WinHeight=0.123437
         OnClick=UTComp_Menu_Voting.InternalOnClick
         OnKeyEvent=UTComp_SettingsButton.InternalOnKeyEvent
     End Object
     bu_UTComp_SettingsMenu=GUIButton'utcompv17a.UTComp_Menu_Voting.UTComp_SettingsButton'

     Begin Object Class=GUILabel Name=DemnoHeadingLabel
         Caption="------- Select your voting type -------"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.385000
         WinLeft=0.281250
     End Object
     l_VotingLabel=GUILabel'utcompv17a.UTComp_Menu_Voting.DemnoHeadingLabel'

}
