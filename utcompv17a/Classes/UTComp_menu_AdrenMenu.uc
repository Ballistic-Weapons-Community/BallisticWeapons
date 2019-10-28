

defaultproperties
{
     Begin Object Class=moCheckBox Name=BoosterCheck
         Caption="Enable Booster Combo"
         OnCreateComponent=BoosterCheck.InternalOnCreateComponent
         WinTop=0.430000
         WinLeft=0.250000
         OnChange=UTComp_menu_AdrenMenu.InternalOnChange
     End Object
     ch_booster=moCheckBox'utcompv17a.UTComp_menu_AdrenMenu.BoosterCheck'

     Begin Object Class=moCheckBox Name=InvisCheck
         Caption="Enable Invisibility Combo"
         OnCreateComponent=InvisCheck.InternalOnCreateComponent
         WinTop=0.480000
         WinLeft=0.250000
         OnChange=UTComp_menu_AdrenMenu.InternalOnChange
     End Object
     ch_invis=moCheckBox'utcompv17a.UTComp_menu_AdrenMenu.InvisCheck'

     Begin Object Class=moCheckBox Name=SpeedCheck
         Caption="Enable Speed Combo"
         OnCreateComponent=SpeedCheck.InternalOnCreateComponent
         WinTop=0.530000
         WinLeft=0.250000
         OnChange=UTComp_menu_AdrenMenu.InternalOnChange
     End Object
     ch_speed=moCheckBox'utcompv17a.UTComp_menu_AdrenMenu.SpeedCheck'

     Begin Object Class=moCheckBox Name=BerserkCheck
         Caption="Enable Berserk Combo"
         OnCreateComponent=BerserkCheck.InternalOnCreateComponent
         WinTop=0.580000
         WinLeft=0.250000
         OnChange=UTComp_menu_AdrenMenu.InternalOnChange
     End Object
     ch_berserk=moCheckBox'utcompv17a.UTComp_menu_AdrenMenu.BerserkCheck'

     Begin Object Class=GUILabel Name=AdrenLabel
         Caption="----Adrenaline Combo Settings----"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.360000
         WinLeft=0.250000
     End Object
     l_adren=GUILabel'utcompv17a.UTComp_menu_AdrenMenu.AdrenLabel'

}
