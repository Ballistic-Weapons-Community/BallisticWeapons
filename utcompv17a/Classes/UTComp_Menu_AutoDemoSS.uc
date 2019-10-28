

defaultproperties
{
     Begin Object Class=moCheckBox Name=AutoDemoCheck
         Caption="Automatically record a demo of each match."
         OnCreateComponent=AutoDemoCheck.InternalOnCreateComponent
         WinTop=0.412083
         WinLeft=0.140000
         WinWidth=0.740000
         OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
     End Object
     ch_AutoDemo=moCheckBox'utcompv17a.UTComp_Menu_AutoDemoSS.AutoDemoCheck'

     Begin Object Class=moCheckBox Name=AutoSSCheck
         Caption="Automatically take a screenshot at the end of each match."
         OnCreateComponent=AutoSSCheck.InternalOnCreateComponent
         WinTop=0.589168
         WinLeft=0.140000
         WinWidth=0.740000
         OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
     End Object
     ch_AutoSS=moCheckBox'utcompv17a.UTComp_Menu_AutoDemoSS.AutoSSCheck'

     Begin Object Class=GUIComboBox Name=AutoDemoInput
         WinTop=0.460000
         WinLeft=0.437500
         WinWidth=0.320000
         WinHeight=0.035000
         OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
         OnKeyEvent=UTComp_Menu_AutoDemoSS.InternalOnKeyEvent
     End Object
     co_DemoMask=GUIComboBox'utcompv17a.UTComp_Menu_AutoDemoSS.AutoDemoInput'

     Begin Object Class=GUIComboBox Name=AutoSSInput
         WinTop=0.645418
         WinLeft=0.437500
         WinWidth=0.320000
         WinHeight=0.035000
         OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
         OnKeyEvent=UTComp_Menu_AutoDemoSS.InternalOnKeyEvent
     End Object
     co_SSMask=GUIComboBox'utcompv17a.UTComp_Menu_AutoDemoSS.AutoSSInput'

     Begin Object Class=GUILabel Name=DemoMaskLabel
         Caption="Demo Mask:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.450000
         WinLeft=0.225000
     End Object
     l_AutoDemoMask=GUILabel'utcompv17a.UTComp_Menu_AutoDemoSS.DemoMaskLabel'

     Begin Object Class=GUILabel Name=SSMaskLabel
         Caption="Screenshot Mask:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.632918
         WinLeft=0.225000
     End Object
     l_AutoSSMask=GUILabel'utcompv17a.UTComp_Menu_AutoDemoSS.SSMaskLabel'

     Begin Object Class=GUILabel Name=SSHeadingLabel
         Caption="--- Auto Screenshot ---"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.514167
         WinLeft=0.342188
     End Object
     l_SSHeading=GUILabel'utcompv17a.UTComp_Menu_AutoDemoSS.SSHeadingLabel'

     Begin Object Class=GUILabel Name=DemnoHeadingLabel
         Caption="--- Auto Demo Recording---"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.347500
         WinLeft=0.326563
     End Object
     l_DemoHeading=GUILabel'utcompv17a.UTComp_Menu_AutoDemoSS.DemnoHeadingLabel'

}
