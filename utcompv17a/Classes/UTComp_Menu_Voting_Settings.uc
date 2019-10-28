

defaultproperties
{
     Begin Object Class=GUIComboBox Name=SkinsComboBox
         WinTop=0.400000
         WinLeft=0.382187
         WinWidth=0.250000
         WinHeight=0.030000
         OnKeyEvent=SkinsComboBox.InternalOnKeyEvent
     End Object
     co_Skins=GUIComboBox'utcompv17a.UTComp_Menu_Voting_Settings.SkinsComboBox'

     Begin Object Class=GUIComboBox Name=HitsoundsComboBox
         WinTop=0.450000
         WinLeft=0.382187
         WinWidth=0.250000
         WinHeight=0.030000
         OnKeyEvent=HitsoundsComboBox.InternalOnKeyEvent
     End Object
     co_Hitsounds=GUIComboBox'utcompv17a.UTComp_Menu_Voting_Settings.HitsoundsComboBox'

     Begin Object Class=GUIComboBox Name=TeamOverlayComboBox
         WinTop=0.500000
         WinLeft=0.382187
         WinWidth=0.250000
         WinHeight=0.030000
         OnKeyEvent=TeamOverlayComboBox.InternalOnKeyEvent
     End Object
     co_TeamOverlay=GUIComboBox'utcompv17a.UTComp_Menu_Voting_Settings.TeamOverlayComboBox'

     Begin Object Class=GUIComboBox Name=WarmupComboBox
         WinTop=0.622918
         WinLeft=0.382187
         WinWidth=0.250000
         WinHeight=0.035000
         OnKeyEvent=WarmupComboBox.InternalOnKeyEvent
     End Object
     co_Warmup=GUIComboBox'utcompv17a.UTComp_Menu_Voting_Settings.WarmupComboBox'

     Begin Object Class=GUIComboBox Name=NewNetComboBox
         WinTop=0.672918
         WinLeft=0.382187
         WinWidth=0.250000
         WinHeight=0.035000
         OnKeyEvent=NewNetComboBox.InternalOnKeyEvent
     End Object
     co_NewNet=GUIComboBox'utcompv17a.UTComp_Menu_Voting_Settings.NewNetComboBox'

     Begin Object Class=GUIComboBox Name=ForwardComboBox
         WinTop=0.722918
         WinLeft=0.382187
         WinWidth=0.250000
         WinHeight=0.035000
         OnKeyEvent=NewNetComboBox.InternalOnKeyEvent
     End Object
     co_forward=GUIComboBox'utcompv17a.UTComp_Menu_Voting_Settings.ForwardComboBox'

     Begin Object Class=GUIButton Name=SkinsButton
         Caption="Call Vote"
         WinTop=0.395000
         WinLeft=0.665625
         WinWidth=0.117500
         WinHeight=0.042500
         OnClick=UTComp_Menu_Voting_Settings.InternalOnClick
         OnKeyEvent=SkinsButton.InternalOnKeyEvent
     End Object
     bu_Skins=GUIButton'utcompv17a.UTComp_Menu_Voting_Settings.SkinsButton'

     Begin Object Class=GUIButton Name=HitsoundsButton
         Caption="Call Vote"
         WinTop=0.445000
         WinLeft=0.665625
         WinWidth=0.117500
         WinHeight=0.042500
         OnClick=UTComp_Menu_Voting_Settings.InternalOnClick
         OnKeyEvent=HitsoundsButton.InternalOnKeyEvent
     End Object
     bu_Hitsounds=GUIButton'utcompv17a.UTComp_Menu_Voting_Settings.HitsoundsButton'

     Begin Object Class=GUIButton Name=TeamOverlayButton
         Caption="Call Vote"
         WinTop=0.495000
         WinLeft=0.665625
         WinWidth=0.117500
         WinHeight=0.042500
         OnClick=UTComp_Menu_Voting_Settings.InternalOnClick
         OnKeyEvent=TeamOverlayButton.InternalOnKeyEvent
     End Object
     bu_TeamOverlay=GUIButton'utcompv17a.UTComp_Menu_Voting_Settings.TeamOverlayButton'

     Begin Object Class=GUIButton Name=WarmupButton
         Caption="Call Vote"
         WinTop=0.615834
         WinLeft=0.665625
         WinWidth=0.117500
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_Settings.InternalOnClick
         OnKeyEvent=WarmupButton.InternalOnKeyEvent
     End Object
     bu_Warmup=GUIButton'utcompv17a.UTComp_Menu_Voting_Settings.WarmupButton'

     Begin Object Class=GUIButton Name=NewNetButton
         Caption="Call Vote"
         WinTop=0.665834
         WinLeft=0.665625
         WinWidth=0.117500
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_Settings.InternalOnClick
         OnKeyEvent=NewNetButton.InternalOnKeyEvent
     End Object
     bu_newNet=GUIButton'utcompv17a.UTComp_Menu_Voting_Settings.NewNetButton'

     Begin Object Class=GUIButton Name=ForwardButton
         Caption="Call Vote"
         WinTop=0.715834
         WinLeft=0.665625
         WinWidth=0.117500
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_Settings.InternalOnClick
         OnKeyEvent=NewNetButton.InternalOnKeyEvent
     End Object
     bu_forward=GUIButton'utcompv17a.UTComp_Menu_Voting_Settings.ForwardButton'

     Begin Object Class=GUILabel Name=SkinsLabel
         Caption="Skins"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.395000
         WinLeft=0.162000
     End Object
     l_Skins=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.SkinsLabel'

     Begin Object Class=GUILabel Name=HitsoundsLabel
         Caption="Hitsounds"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.445000
         WinLeft=0.162000
     End Object
     l_HitSounds=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.HitsoundsLabel'

     Begin Object Class=GUILabel Name=TeamOverlayLabel
         Caption="Team Overlay"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.495000
         WinLeft=0.162000
     End Object
     l_TeamOverlay=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.TeamOverlayLabel'

     Begin Object Class=GUILabel Name=WarmupLabel
         Caption="Warmup"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.611668
         WinLeft=0.160125
     End Object
     l_Warmup=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.WarmupLabel'

     Begin Object Class=GUILabel Name=DemnoHeadingLabel
         Caption="--- These settings require a map reload to take effect ---"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.562085
         WinLeft=0.176562
     End Object
     l_Restart=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.DemnoHeadingLabel'

     Begin Object Class=GUILabel Name=RestartLabel
         Caption="--- These settings are applied instantly after the vote passes ---"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.332917
         WinLeft=0.118750
     End Object
     l_NoRestart=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.RestartLabel'

     Begin Object Class=GUILabel Name=NewNetLabel
         Caption="Enhanced Netcode"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.661667
         WinLeft=0.160125
     End Object
     l_NewNet=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.NewNetLabel'

     Begin Object Class=GUILabel Name=ForwardLabel
         Caption="Forward Mode"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.711667
         WinLeft=0.160125
     End Object
     l_forward=GUILabel'utcompv17a.UTComp_Menu_Voting_Settings.ForwardLabel'

}
