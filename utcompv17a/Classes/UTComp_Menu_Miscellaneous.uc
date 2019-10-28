

defaultproperties
{
     Begin Object Class=GUILabel Name=ScoreboardLabel
         Caption="----------Scoreboard----------"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.310309
         WinLeft=0.250000
     End Object
     l_ScoreboardTitle=GUILabel'utcompv17a.UTComp_Menu_Miscellaneous.ScoreboardLabel'

     Begin Object Class=GUILabel Name=InfoLabel
         Caption="--------Adrenaline Combos--------"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.487629
         WinLeft=0.250000
     End Object
     l_InfoTitle=GUILabel'utcompv17a.UTComp_Menu_Miscellaneous.InfoLabel'

     Begin Object Class=GUILabel Name=GenericLabel
         Caption="----Generic UT2004 Settings----"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.579382
         WinLeft=0.250000
     End Object
     l_GenericTitle=GUILabel'utcompv17a.UTComp_Menu_Miscellaneous.GenericLabel'

     Begin Object Class=GUILabel Name=NewNetLabel
         Caption="-----------Net Code-----------"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.697833
         WinLeft=0.250000
     End Object
     l_NewNet=GUILabel'utcompv17a.UTComp_Menu_Miscellaneous.NewNetLabel'

     Begin Object Class=moCheckBox Name=ScoreboardCheck
         Caption="Use UTComp enhanced scoreboard."
         OnCreateComponent=ScoreboardCheck.InternalOnCreateComponent
         WinTop=0.360000
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_UseScoreBoard=moCheckBox'utcompv17a.UTComp_Menu_Miscellaneous.ScoreboardCheck'

     Begin Object Class=moCheckBox Name=StatsCheck
         Caption="Show weapon stats on scoreboard."
         OnCreateComponent=StatsCheck.InternalOnCreateComponent
         WinTop=0.410000
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_WepStats=moCheckBox'utcompv17a.UTComp_Menu_Miscellaneous.StatsCheck'

     Begin Object Class=moCheckBox Name=PickupCheck
         Caption="Show pickup stats on scoreboard."
         OnCreateComponent=PickupCheck.InternalOnCreateComponent
         WinTop=0.460000
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_PickupStats=moCheckBox'utcompv17a.UTComp_Menu_Miscellaneous.PickupCheck'

     Begin Object Class=moCheckBox Name=FootCheck
         Caption="Play own footstep sounds."
         OnCreateComponent=FootCheck.InternalOnCreateComponent
         WinTop=0.633196
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_FootSteps=moCheckBox'utcompv17a.UTComp_Menu_Miscellaneous.FootCheck'

     Begin Object Class=moCheckBox Name=HudColorCheck
         Caption="Match Hud Color To Skins"
         OnCreateComponent=HudColorCheck.InternalOnCreateComponent
         WinTop=0.675774
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_MatchHudColor=moCheckBox'utcompv17a.UTComp_Menu_Miscellaneous.HudColorCheck'

     Begin Object Class=moCheckBox Name=NewNetCheck
         Caption="Enable Enhanced Netcode"
         OnCreateComponent=NewNetCheck.InternalOnCreateComponent
         WinTop=0.751134
         WinLeft=0.250000
         OnChange=UTComp_Menu_Miscellaneous.InternalOnChange
     End Object
     ch_UseNewNet=moCheckBox'utcompv17a.UTComp_Menu_Miscellaneous.NewNetCheck'

     Begin Object Class=GUIButton Name=AdrenButton
         Caption="Disable Adrenaline Combos"
         WinTop=0.530050
         WinLeft=0.250000
         WinWidth=0.400000
         WinHeight=0.050000
         OnClick=UTComp_Menu_Miscellaneous.InternalOnClick
         OnKeyEvent=AdrenButton.InternalOnKeyEvent
     End Object
     bu_adren=GUIButton'utcompv17a.UTComp_Menu_Miscellaneous.AdrenButton'

}
