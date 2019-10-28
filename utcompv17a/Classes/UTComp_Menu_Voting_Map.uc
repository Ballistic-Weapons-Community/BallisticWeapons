

defaultproperties
{
     Begin Object Class=GUIListBox Name=MapListBox
         bVisibleWhenEmpty=True
         OnCreateComponent=MapListBox.InternalOnCreateComponent
         WinTop=0.350000
         WinLeft=0.118750
         WinWidth=0.214061
         WinHeight=0.385937
         OnChange=UTComp_Menu_Voting_Map.InternalOnChange
     End Object
     lb_MapList=GUIListBox'utcompv17a.UTComp_Menu_Voting_Map.MapListBox'

     Begin Object Class=GUIEditBox Name=MapInputEditBox
         WinTop=0.493750
         WinLeft=0.550312
         WinWidth=0.250000
         WinHeight=0.030000
         OnActivate=MapInputEditBox.InternalActivate
         OnDeActivate=MapInputEditBox.InternalDeactivate
         OnKeyType=MapInputEditBox.InternalOnKeyType
         OnKeyEvent=MapInputEditBox.InternalOnKeyEvent
     End Object
     eb_MapInput=GUIEditBox'utcompv17a.UTComp_Menu_Voting_Map.MapInputEditBox'

     Begin Object Class=GUIButton Name=quickrestartButton
         Caption="Restart Current Map"
         WinTop=0.607500
         WinLeft=0.545314
         WinWidth=0.255000
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_Map.InternalOnClick
         OnKeyEvent=quickrestartButton.InternalOnKeyEvent
     End Object
     bu_QuickRestart=GUIButton'utcompv17a.UTComp_Menu_Voting_Map.quickrestartButton'

     Begin Object Class=GUIButton Name=ChangeMapButton
         Caption="Change Map"
         WinTop=0.542915
         WinLeft=0.546874
         WinWidth=0.256563
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_Map.InternalOnClick
         OnKeyEvent=ChangeMapButton.InternalOnKeyEvent
     End Object
     bu_ChangeMap=GUIButton'utcompv17a.UTComp_Menu_Voting_Map.ChangeMapButton'

     Begin Object Class=GUILabel Name=MapNameLabel
         Caption="Map Name"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.480417
         WinLeft=0.380438
     End Object
     l_MapName=GUILabel'utcompv17a.UTComp_Menu_Voting_Map.MapNameLabel'

     Begin Object Class=GUIButton Name=RefreshButton
         Caption="Refresh Maps"
         WinTop=0.738752
         WinLeft=0.110936
         WinWidth=0.217500
         WinHeight=0.047500
         OnClick=UTComp_Menu_Voting_Map.InternalOnClick
         OnKeyEvent=RefreshButton.InternalOnKeyEvent
     End Object
     bu_Refresh=GUIButton'utcompv17a.UTComp_Menu_Voting_Map.RefreshButton'

}
