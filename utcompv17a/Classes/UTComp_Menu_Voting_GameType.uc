

defaultproperties
{
     Begin Object Class=GUIListBox Name=MapListBox
         bVisibleWhenEmpty=True
         OnCreateComponent=MapListBox.InternalOnCreateComponent
         WinTop=0.350000
         WinLeft=0.118750
         WinWidth=0.214061
         WinHeight=0.385937
         OnChange=UTComp_Menu_Voting_GameType.InternalOnChange
     End Object
     lb_MapList=GUIListBox'utcompv17a.UTComp_Menu_Voting_GameType.MapListBox'

     Begin Object Class=GUIEditBox Name=MapInputEditBox
         WinTop=0.462500
         WinLeft=0.559687
         WinWidth=0.250000
         WinHeight=0.030000
         OnActivate=MapInputEditBox.InternalActivate
         OnDeActivate=MapInputEditBox.InternalDeactivate
         OnKeyType=MapInputEditBox.InternalOnKeyType
         OnKeyEvent=MapInputEditBox.InternalOnKeyEvent
     End Object
     eb_MapInput=GUIEditBox'utcompv17a.UTComp_Menu_Voting_GameType.MapInputEditBox'

     Begin Object Class=GUINumericEdit Name=MaxPlayersNE
         MinValue=2
         WinTop=0.414046
         WinLeft=0.604999
         WinWidth=0.206250
         WinHeight=0.030000
         OnDeActivate=MaxPlayersNE.ValidateValue
     End Object
     ne_NumPlayers=GUINumericEdit'utcompv17a.UTComp_Menu_Voting_GameType.MaxPlayersNE'

     Begin Object Class=GUIComboBox Name=MapInputComboBox
         WinTop=0.362994
         WinLeft=0.560311
         WinWidth=0.250000
         WinHeight=0.035000
         OnChange=UTComp_Menu_Voting_GameType.InternalOnChange
         OnKeyEvent=MapInputComboBox.InternalOnKeyEvent
     End Object
     co_GameTypeList=GUIComboBox'utcompv17a.UTComp_Menu_Voting_GameType.MapInputComboBox'

     Begin Object Class=GUIButton Name=quickrestartButton
         Caption="Just Restart Map"
         WinTop=0.705418
         WinLeft=0.379687
         WinWidth=0.217500
         WinHeight=0.047500
         bVisible=False
         OnClick=UTComp_Menu_Voting_GameType.InternalOnClick
         OnKeyEvent=quickrestartButton.InternalOnKeyEvent
     End Object
     bu_QuickRestart=GUIButton'utcompv17a.UTComp_Menu_Voting_GameType.quickrestartButton'

     Begin Object Class=GUIButton Name=ChangeMapButton
         Caption="Call Vote"
         WinTop=0.740469
         WinLeft=0.456252
         WinWidth=0.262813
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_GameType.InternalOnClick
         OnKeyEvent=ChangeMapButton.InternalOnKeyEvent
     End Object
     bu_ChangeMap=GUIButton'utcompv17a.UTComp_Menu_Voting_GameType.ChangeMapButton'

     Begin Object Class=GUILabel Name=MapNameLabel
         Caption="Map Name"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.451250
         WinLeft=0.352313
     End Object
     l_MapName=GUILabel'utcompv17a.UTComp_Menu_Voting_GameType.MapNameLabel'

     Begin Object Class=GUILabel Name=gametypeLabel
         Caption="Gametype"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.349704
         WinLeft=0.353875
     End Object
     l_GameType=GUILabel'utcompv17a.UTComp_Menu_Voting_GameType.gametypeLabel'

     Begin Object Class=GUILabel Name=MaxPlayersLabe
         Caption="Max Players"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.400713
         WinLeft=0.353438
     End Object
     l_MaxPlayers=GUILabel'utcompv17a.UTComp_Menu_Voting_GameType.MaxPlayersLabe'

     Begin Object Class=moCheckBox Name=AdvancedOptionsCheck
         Caption="Advanced Options"
         OnCreateComponent=AdvancedOptionsCheck.InternalOnCreateComponent
         WinTop=0.500000
         WinLeft=0.350000
         WinWidth=0.240000
         OnChange=UTComp_Menu_Voting_GameType.InternalOnChange
     End Object
     cb_UseAdvancedOptions=moCheckBox'utcompv17a.UTComp_Menu_Voting_GameType.AdvancedOptionsCheck'

     Begin Object Class=moCheckBox Name=AdrenCheck
         Caption="Adren"
         OnCreateComponent=AdrenCheck.InternalOnCreateComponent
         WinTop=0.549998
         WinLeft=0.598437
         WinWidth=0.239062
     End Object
     cb_Adren=moCheckBox'utcompv17a.UTComp_Menu_Voting_GameType.AdrenCheck'

     Begin Object Class=moCheckBox Name=DDCheck
         Caption="DD"
         OnCreateComponent=DDCheck.InternalOnCreateComponent
         WinTop=0.600000
         WinLeft=0.350000
         WinWidth=0.240000
     End Object
     cb_DD=moCheckBox'utcompv17a.UTComp_Menu_Voting_GameType.DDCheck'

     Begin Object Class=moCheckBox Name=SuperWeaponsCheck
         Caption="SuperWeapons"
         OnCreateComponent=SuperWeaponsCheck.InternalOnCreateComponent
         WinTop=0.550000
         WinLeft=0.350000
         WinWidth=0.240000
     End Object
     cb_SuperWeapons=moCheckBox'utcompv17a.UTComp_Menu_Voting_GameType.SuperWeaponsCheck'

     Begin Object Class=moCheckBox Name=WeaponStayCheck
         Caption="WeaponStay"
         OnCreateComponent=WeaponStayCheck.InternalOnCreateComponent
         WinTop=0.650000
         WinLeft=0.350000
         WinWidth=0.240000
     End Object
     cb_WeaponStay=moCheckBox'utcompv17a.UTComp_Menu_Voting_GameType.WeaponStayCheck'

     Begin Object Class=GUINumericEdit Name=GoalScoreNE
         MinValue=0
         WinTop=0.598331
         WinLeft=0.736247
         WinWidth=0.103125
         WinHeight=0.030000
         OnDeActivate=GoalScoreNE.ValidateValue
     End Object
     ne_GoalScore=GUINumericEdit'utcompv17a.UTComp_Menu_Voting_GameType.GoalScoreNE'

     Begin Object Class=GUINumericEdit Name=timelimitNE
         MinValue=1
         WinTop=0.648331
         WinLeft=0.736247
         WinWidth=0.103125
         WinHeight=0.030000
         OnDeActivate=timelimitNE.ValidateValue
     End Object
     ne_TimeLimit=GUINumericEdit'utcompv17a.UTComp_Menu_Voting_GameType.timelimitNE'

     Begin Object Class=GUINumericEdit Name=GrenadeNE
         MinValue=0
         MaxValue=8
         WinTop=0.698331
         WinLeft=0.736247
         WinWidth=0.103125
         WinHeight=0.030000
         OnDeActivate=GrenadeNE.ValidateValue
     End Object
     ne_Grenades=GUINumericEdit'utcompv17a.UTComp_Menu_Voting_GameType.GrenadeNE'

     Begin Object Class=GUINumericEdit Name=OvertimeNE
         MinValue=0
         MaxValue=10
         WinTop=0.696269
         WinLeft=0.487810
         WinWidth=0.103125
         WinHeight=0.030000
         OnDeActivate=OvertimeNE.ValidateValue
     End Object
     ne_OverTime=GUINumericEdit'utcompv17a.UTComp_Menu_Voting_GameType.OvertimeNE'

     Begin Object Class=GUILabel Name=GoalScoreLabel
         Caption="GoalScore"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.584500
         WinLeft=0.598313
     End Object
     l_GoalScore=GUILabel'utcompv17a.UTComp_Menu_Voting_GameType.GoalScoreLabel'

     Begin Object Class=GUILabel Name=timelimitLabel
         Caption="Time Limit"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.636583
         WinLeft=0.598313
     End Object
     l_TimeLimit=GUILabel'utcompv17a.UTComp_Menu_Voting_GameType.timelimitLabel'

     Begin Object Class=GUILabel Name=grenadeLabel
         Caption="Grenades"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.685449
         WinLeft=0.598313
     End Object
     l_grenades=GUILabel'utcompv17a.UTComp_Menu_Voting_GameType.grenadeLabel'

     Begin Object Class=GUILabel Name=OvertimeLabel
         Caption="OT Length"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.683387
         WinLeft=0.346750
     End Object
     l_OverTime=GUILabel'utcompv17a.UTComp_Menu_Voting_GameType.OvertimeLabel'

     Begin Object Class=GUIButton Name=RefreshButton
         Caption="Refresh Maps"
         WinTop=0.738752
         WinLeft=0.110936
         WinWidth=0.217500
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_GameType.InternalOnClick
         OnKeyEvent=RefreshButton.InternalOnKeyEvent
     End Object
     bu_Refresh=GUIButton'utcompv17a.UTComp_Menu_Voting_GameType.RefreshButton'

}
