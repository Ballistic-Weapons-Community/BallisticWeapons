

defaultproperties
{
     l_Mode(0)=GUILabel'utcompv17a.UTComp_Menu_OpenedMenu.BrightSkinsModeLabel'
     l_Mode(1)=GUILabel'utcompv17a.UTComp_Menu_OpenedMenu.HitSoundsModeLabel'
     l_Mode(2)=GUILabel'utcompv17a.UTComp_Menu_OpenedMenu.VersionLabel'
     l_Mode(3)=GUILabel'utcompv17a.UTComp_Menu_OpenedMenu.AmpModeLabel'
     l_Mode(4)=GUILabel'utcompv17a.UTComp_Menu_OpenedMenu.NewVersions'
     l_Mode(5)=GUILabel'utcompv17a.UTComp_Menu_OpenedMenu.NetCodeModeLabel'
     l_Mode(6)=GUILabel'utcompv17a.UTComp_Menu_OpenedMenu.ServerSetLabel'
     Begin Object Class=GUIImage Name=UTCompLogo
         Image=Texture'utcompv17a.UTCompLogo'
         ImageStyle=ISTY_Scaled
         WinTop=0.307113
         WinLeft=0.312500
         WinWidth=0.375000
         WinHeight=0.125000
     End Object
     i_UTCompLogo=GUIImage'utcompv17a.UTComp_Menu_OpenedMenu.UTCompLogo'

     Begin Object Class=GUIButton Name=ReadyButton
         WinTop=0.650000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.060000
         OnClick=UTComp_Menu_OpenedMenu.InternalOnClick
         OnKeyEvent=ReadyButton.InternalOnKeyEvent
     End Object
     bu_Ready=GUIButton'utcompv17a.UTComp_Menu_OpenedMenu.ReadyButton'

     Begin Object Class=GUIButton Name=NotReadyButton
         WinTop=0.650000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.060000
         OnClick=UTComp_Menu_OpenedMenu.InternalOnClick
         OnKeyEvent=NotReadyButton.InternalOnKeyEvent
     End Object
     bu_NotReady=GUIButton'utcompv17a.UTComp_Menu_OpenedMenu.NotReadyButton'

     GoldColor=(G=200,R=230)
}
