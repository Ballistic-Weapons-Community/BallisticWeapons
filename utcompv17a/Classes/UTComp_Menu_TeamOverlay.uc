

defaultproperties
{
     Begin Object Class=moCheckBox Name=CheckEnable
         Caption="Enable Overlay"
         OnCreateComponent=CheckEnable.InternalOnCreateComponent
         WinTop=0.350000
         WinLeft=0.150000
         WinWidth=0.300000
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
     End Object
     ch_Enable=moCheckBox'utcompv17a.UTComp_Menu_TeamOverlay.CheckEnable'

     Begin Object Class=moCheckBox Name=CheckShowSelf
         Caption="Show Self"
         OnCreateComponent=CheckShowSelf.InternalOnCreateComponent
         WinTop=0.400000
         WinLeft=0.150000
         WinWidth=0.300000
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
     End Object
     ch_ShowSelf=moCheckBox'utcompv17a.UTComp_Menu_TeamOverlay.CheckShowSelf'

     Begin Object Class=moCheckBox Name=CheckIcons
         Caption="Enable Icons"
         OnCreateComponent=CheckIcons.InternalOnCreateComponent
         WinTop=0.450000
         WinLeft=0.150000
         WinWidth=0.300000
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
     End Object
     ch_Icons=moCheckBox'utcompv17a.UTComp_Menu_TeamOverlay.CheckIcons'

     Begin Object Class=GUISlider Name=RedBGSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.515000
         WinLeft=0.200000
         WinWidth=0.300000
         OnClick=RedBGSlider.InternalOnClick
         OnMousePressed=RedBGSlider.InternalOnMousePressed
         OnMouseRelease=RedBGSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=RedBGSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedBGSlider.InternalCapturedMouseMove
     End Object
     sl_redBG=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.RedBGSlider'

     Begin Object Class=GUISlider Name=BlueBGSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.595000
         WinLeft=0.200000
         WinWidth=0.300000
         OnClick=BlueBGSlider.InternalOnClick
         OnMousePressed=BlueBGSlider.InternalOnMousePressed
         OnMouseRelease=BlueBGSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=BlueBGSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueBGSlider.InternalCapturedMouseMove
     End Object
     sl_blueBG=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.BlueBGSlider'

     Begin Object Class=GUISlider Name=GreenBGSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.555000
         WinLeft=0.200000
         WinWidth=0.300000
         OnClick=GreenBGSlider.InternalOnClick
         OnMousePressed=GreenBGSlider.InternalOnMousePressed
         OnMouseRelease=GreenBGSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=GreenBGSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenBGSlider.InternalCapturedMouseMove
     End Object
     sl_greenBG=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.GreenBGSlider'

     Begin Object Class=GUISlider Name=RedNameSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.665000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=RedNameSlider.InternalOnClick
         OnMousePressed=RedNameSlider.InternalOnMousePressed
         OnMouseRelease=RedNameSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=RedNameSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedNameSlider.InternalCapturedMouseMove
     End Object
     sl_redName=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.RedNameSlider'

     Begin Object Class=GUISlider Name=BlueNameSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.745000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=BlueNameSlider.InternalOnClick
         OnMousePressed=BlueNameSlider.InternalOnMousePressed
         OnMouseRelease=BlueNameSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=BlueNameSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueNameSlider.InternalCapturedMouseMove
     End Object
     sl_blueName=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.BlueNameSlider'

     Begin Object Class=GUISlider Name=GreenNameSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.705000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=GreenNameSlider.InternalOnClick
         OnMousePressed=GreenNameSlider.InternalOnMousePressed
         OnMouseRelease=GreenNameSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=GreenNameSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenNameSlider.InternalCapturedMouseMove
     End Object
     sl_greenName=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.GreenNameSlider'

     Begin Object Class=GUISlider Name=RedLocSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.665000
         WinLeft=0.200000
         WinWidth=0.300000
         OnClick=RedLocSlider.InternalOnClick
         OnMousePressed=RedLocSlider.InternalOnMousePressed
         OnMouseRelease=RedLocSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=RedLocSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedLocSlider.InternalCapturedMouseMove
     End Object
     sl_redLoc=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.RedLocSlider'

     Begin Object Class=GUISlider Name=BlueLocSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.745000
         WinLeft=0.200000
         WinWidth=0.300000
         OnClick=BlueLocSlider.InternalOnClick
         OnMousePressed=BlueLocSlider.InternalOnMousePressed
         OnMouseRelease=BlueLocSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=BlueLocSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueLocSlider.InternalCapturedMouseMove
     End Object
     sl_blueLoc=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.BlueLocSlider'

     Begin Object Class=GUISlider Name=GreenLocSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.705000
         WinLeft=0.200000
         WinWidth=0.300000
         OnClick=GreenLocSlider.InternalOnClick
         OnMousePressed=GreenLocSlider.InternalOnMousePressed
         OnMouseRelease=GreenLocSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=GreenLocSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenLocSlider.InternalCapturedMouseMove
     End Object
     sl_greenLoc=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.GreenLocSlider'

     Begin Object Class=GUILabel Name=RedBGLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.500000
         WinLeft=0.120000
     End Object
     l_redBG=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.RedBGLabel'

     Begin Object Class=GUILabel Name=BlueBGLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.580000
         WinLeft=0.120000
     End Object
     l_blueBG=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.BlueBGLabel'

     Begin Object Class=GUILabel Name=GreenBGLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.540000
         WinLeft=0.120000
     End Object
     l_greenBG=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.GreenBGLabel'

     Begin Object Class=GUILabel Name=RedNameLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.650000
         WinLeft=0.520000
     End Object
     l_redName=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.RedNameLabel'

     Begin Object Class=GUILabel Name=BlueNameLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.730000
         WinLeft=0.520000
     End Object
     l_blueName=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.BlueNameLabel'

     Begin Object Class=GUILabel Name=GreenNameLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.690000
         WinLeft=0.520000
     End Object
     l_greenName=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.GreenNameLabel'

     Begin Object Class=GUILabel Name=RedLocLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.650000
         WinLeft=0.120000
     End Object
     l_redLoc=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.RedLocLabel'

     Begin Object Class=GUILabel Name=BlueLocLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.730000
         WinLeft=0.120000
     End Object
     l_blueLoc=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.BlueLocLabel'

     Begin Object Class=GUILabel Name=GreenLocLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.690000
         WinLeft=0.120000
     End Object
     l_greenLoc=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.GreenLocLabel'

     Begin Object Class=GUILabel Name=BGColorLabel
         Caption="Background Color"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.475000
         WinLeft=0.120000
     End Object
     l_BGColor=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.BGColorLabel'

     Begin Object Class=GUILabel Name=NameColorLabel
         Caption="Location color"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.615000
         WinLeft=0.120000
     End Object
     l_NameColor=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.NameColorLabel'

     Begin Object Class=GUILabel Name=LocColorLabel
         Caption="Name color"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.615000
         WinLeft=0.520000
     End Object
     l_LocColor=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.LocColorLabel'

     Begin Object Class=GUILabel Name=HorizLabel
         Caption="Size:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.425000
         WinLeft=0.550000
     End Object
     l_Horiz=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.HorizLabel'

     Begin Object Class=GUILabel Name=VertLabel
         Caption="Vertical Location:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.365000
         WinLeft=0.550000
     End Object
     l_Vert=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.VertLabel'

     Begin Object Class=GUILabel Name=SizeLabel
         Caption="Horizontal Location:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.310000
         WinLeft=0.550000
     End Object
     l_Size=GUILabel'utcompv17a.UTComp_Menu_TeamOverlay.SizeLabel'

     Begin Object Class=GUISlider Name=SliderHoriz
         MaxValue=0.750000
         WinTop=0.350000
         WinLeft=0.560000
         WinWidth=0.300000
         OnClick=SliderHoriz.InternalOnClick
         OnMousePressed=SliderHoriz.InternalOnMousePressed
         OnMouseRelease=SliderHoriz.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=SliderHoriz.InternalOnKeyEvent
         OnCapturedMouseMove=SliderHoriz.InternalCapturedMouseMove
     End Object
     sl_Horiz=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.SliderHoriz'

     Begin Object Class=GUISlider Name=SliderVert
         MaxValue=1.000000
         WinTop=0.410000
         WinLeft=0.560000
         WinWidth=0.300000
         OnClick=SliderVert.InternalOnClick
         OnMousePressed=SliderVert.InternalOnMousePressed
         OnMouseRelease=SliderVert.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=SliderVert.InternalOnKeyEvent
         OnCapturedMouseMove=SliderVert.InternalCapturedMouseMove
     End Object
     sl_Vert=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.SliderVert'

     Begin Object Class=GUISlider Name=SliderSize
         MinValue=-7.000000
         MaxValue=0.000000
         bIntSlider=True
         WinTop=0.470000
         WinLeft=0.560000
         WinWidth=0.300000
         OnClick=SliderSize.InternalOnClick
         OnMousePressed=SliderSize.InternalOnMousePressed
         OnMouseRelease=SliderSize.InternalOnMouseRelease
         OnChange=UTComp_Menu_TeamOverlay.InternalOnChange
         OnKeyEvent=SliderSize.InternalOnKeyEvent
         OnCapturedMouseMove=SliderSize.InternalCapturedMouseMove
     End Object
     sl_Size=GUISlider'utcompv17a.UTComp_Menu_TeamOverlay.SliderSize'

}
