

defaultproperties
{
     Begin Object Class=GUIListBox Name=CrosshairListBox
         bVisibleWhenEmpty=True
         OnCreateComponent=CrosshairListBox.InternalOnCreateComponent
         WinTop=0.392917
         WinLeft=0.140000
         WinWidth=0.160000
         WinHeight=0.264375
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
     End Object
     lb_CrossHairs=GUIListBox'utcompv17a.UTComp_Menu_Crosshairs.CrosshairListBox'

     Begin Object Class=GUIComboBox Name=CrosshairCombo
         WinTop=0.366666
         WinLeft=0.350001
         WinWidth=0.248444
         WinHeight=0.035000
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=CrosshairCombo.InternalOnKeyEvent
     End Object
     co_UTCompCrosshairs=GUIComboBox'utcompv17a.UTComp_Menu_Crosshairs.CrosshairCombo'

     Begin Object Class=GUIButton Name=MoveUpHairButton
         Caption="Up"
         WinTop=0.734384
         WinLeft=0.126562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=MoveUpHairButton.InternalOnKeyEvent
     End Object
     bu_MoveUp=GUIButton'utcompv17a.UTComp_Menu_Crosshairs.MoveUpHairButton'

     Begin Object Class=GUIButton Name=MoveDownHairButton
         Caption="Down"
         WinTop=0.734384
         WinLeft=0.206562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=MoveDownHairButton.InternalOnKeyEvent
     End Object
     bu_MoveDown=GUIButton'utcompv17a.UTComp_Menu_Crosshairs.MoveDownHairButton'

     Begin Object Class=GUIButton Name=AddHairButton
         Caption="Add"
         WinTop=0.688559
         WinLeft=0.126562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=AddHairButton.InternalOnKeyEvent
     End Object
     bu_AddHair=GUIButton'utcompv17a.UTComp_Menu_Crosshairs.AddHairButton'

     Begin Object Class=GUIButton Name=DeleteHairButton
         Caption="Delete"
         WinTop=0.688559
         WinLeft=0.206562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=DeleteHairButton.InternalOnKeyEvent
     End Object
     bu_DeleteHair=GUIButton'utcompv17a.UTComp_Menu_Crosshairs.DeleteHairButton'

     Begin Object Class=moCheckBox Name=UseFactoryCheck
         Caption="Use Crosshair Factory"
         OnCreateComponent=UseFactoryCheck.InternalOnCreateComponent
         WinTop=0.324583
         WinLeft=0.126562
         WinWidth=0.350000
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
     End Object
     ch_UseFactory=moCheckBox'utcompv17a.UTComp_Menu_Crosshairs.UseFactoryCheck'

     Begin Object Class=moCheckBox Name=SizeIncreaseCheck
         Caption="Crosshair Size Increase"
         OnCreateComponent=SizeIncreaseCheck.InternalOnCreateComponent
         WinTop=0.328750
         WinLeft=0.548751
         WinWidth=0.350000
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
     End Object
     ch_SizeIncrease=moCheckBox'utcompv17a.UTComp_Menu_Crosshairs.SizeIncreaseCheck'

     Begin Object Class=GUISlider Name=SizeCrossSlider
         MaxValue=4.000000
         Value=1.000000
         WinTop=0.575000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=SizeCrossSlider.InternalOnClick
         OnMousePressed=SizeCrossSlider.InternalOnMousePressed
         OnMouseRelease=SizeCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=SizeCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=SizeCrossSlider.InternalCapturedMouseMove
     End Object
     sl_SizeHair=GUISlider'utcompv17a.UTComp_Menu_Crosshairs.SizeCrossSlider'

     Begin Object Class=GUISlider Name=OpacityCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.535000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=OpacityCrossSlider.InternalOnClick
         OnMousePressed=OpacityCrossSlider.InternalOnMousePressed
         OnMouseRelease=OpacityCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=OpacityCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=OpacityCrossSlider.InternalCapturedMouseMove
     End Object
     sl_OpacityHair=GUISlider'utcompv17a.UTComp_Menu_Crosshairs.OpacityCrossSlider'

     Begin Object Class=GUISlider Name=HorizCrossSlider
         MinValue=0.400000
         MaxValue=0.600000
         Value=0.500000
         WinTop=0.615000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=HorizCrossSlider.InternalOnClick
         OnMousePressed=HorizCrossSlider.InternalOnMousePressed
         OnMouseRelease=HorizCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=HorizCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=HorizCrossSlider.InternalCapturedMouseMove
     End Object
     sl_HorizHair=GUISlider'utcompv17a.UTComp_Menu_Crosshairs.HorizCrossSlider'

     Begin Object Class=GUISlider Name=VertCrossSlider
         MinValue=0.400000
         MaxValue=0.600000
         Value=0.500000
         WinTop=0.655000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=VertCrossSlider.InternalOnClick
         OnMousePressed=VertCrossSlider.InternalOnMousePressed
         OnMouseRelease=VertCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=VertCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=VertCrossSlider.InternalCapturedMouseMove
     End Object
     sl_VertHair=GUISlider'utcompv17a.UTComp_Menu_Crosshairs.VertCrossSlider'

     Begin Object Class=GUISlider Name=RedCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.415000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=RedCrossSlider.InternalOnClick
         OnMousePressed=RedCrossSlider.InternalOnMousePressed
         OnMouseRelease=RedCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=RedCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedCrossSlider.InternalCapturedMouseMove
     End Object
     sl_RedHair=GUISlider'utcompv17a.UTComp_Menu_Crosshairs.RedCrossSlider'

     Begin Object Class=GUISlider Name=GreenCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.455000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=GreenCrossSlider.InternalOnClick
         OnMousePressed=GreenCrossSlider.InternalOnMousePressed
         OnMouseRelease=GreenCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=GreenCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenCrossSlider.InternalCapturedMouseMove
     End Object
     sl_GreenHair=GUISlider'utcompv17a.UTComp_Menu_Crosshairs.GreenCrossSlider'

     Begin Object Class=GUISlider Name=BlueCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.495000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=BlueCrossSlider.InternalOnClick
         OnMousePressed=BlueCrossSlider.InternalOnMousePressed
         OnMouseRelease=BlueCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=BlueCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueCrossSlider.InternalCapturedMouseMove
     End Object
     sl_BlueHair=GUISlider'utcompv17a.UTComp_Menu_Crosshairs.BlueCrossSlider'

     Begin Object Class=GUILabel Name=SizeCrossLabel
         Caption="Size"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.560000
         WinLeft=0.340000
     End Object
     l_Size=GUILabel'utcompv17a.UTComp_Menu_Crosshairs.SizeCrossLabel'

     Begin Object Class=GUILabel Name=OpacityCrossLabel
         Caption="Alpha"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.520000
         WinLeft=0.340000
     End Object
     l_Opacity=GUILabel'utcompv17a.UTComp_Menu_Crosshairs.OpacityCrossLabel'

     Begin Object Class=GUILabel Name=HorizCrossLabel
         Caption="Left"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.600000
         WinLeft=0.340000
     End Object
     l_Horiz=GUILabel'utcompv17a.UTComp_Menu_Crosshairs.HorizCrossLabel'

     Begin Object Class=GUILabel Name=VertCrossLabel
         Caption="Up"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.640000
         WinLeft=0.340000
     End Object
     l_Vert=GUILabel'utcompv17a.UTComp_Menu_Crosshairs.VertCrossLabel'

     Begin Object Class=GUILabel Name=RedCrossLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.400000
         WinLeft=0.340000
     End Object
     l_Red=GUILabel'utcompv17a.UTComp_Menu_Crosshairs.RedCrossLabel'

     Begin Object Class=GUILabel Name=GreenCrossLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.440000
         WinLeft=0.340000
     End Object
     l_Green=GUILabel'utcompv17a.UTComp_Menu_Crosshairs.GreenCrossLabel'

     Begin Object Class=GUILabel Name=BlueCrossLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.480000
         WinLeft=0.340000
     End Object
     l_Blue=GUILabel'utcompv17a.UTComp_Menu_Crosshairs.BlueCrossLabel'

     Begin Object Class=GUIImage Name=CurrentHairBackgroundImage
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.372917
         WinLeft=0.680000
         WinWidth=0.200000
         WinHeight=0.200000
     End Object
     i_CurrentHairBG=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.CurrentHairBackgroundImage'

     Begin Object Class=GUIImage Name=CurrentHAirImage
         ImageStyle=ISTY_Scaled
         ImageAlign=IMGA_Center
         X1=0
         Y1=0
         X2=64
         Y2=64
     End Object
     i_CurrentHair=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.CurrentHAirImage'

     Begin Object Class=GUIImage Name=TotalHairBackgroundImage
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.583350
         WinLeft=0.680000
         WinWidth=0.200000
         WinHeight=0.200000
     End Object
     i_TotalHairBG=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairBackgroundImage'

     Begin Object Class=GUIImage Name=ListBoxBackgroundImage
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.372917
         WinLeft=0.120000
         WinWidth=0.200000
         WinHeight=0.304688
     End Object
     i_ListBoxBG=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.ListBoxBackgroundImage'

     i_TotalHair(0)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(1)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(2)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(3)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(4)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(5)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(6)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(7)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(8)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(9)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(10)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(11)=GUIImage'utcompv17a.UTComp_Menu_Crosshairs.TotalHairImage0'
     UTCompNewHairs(0)=(xHairName="Big Circle(0)",xHairTexture=Texture'utcompv17a.BigCircle')
     UTCompNewHairs(1)=(xHairName="Big Circle(1)",xHairTexture=Texture'utcompv17a.MedCircle')
     UTCompNewHairs(2)=(xHairName="Big Circle(2)",xHairTexture=Texture'utcompv17a.SmallCircle')
     UTCompNewHairs(3)=(xHairName="Big Circle(3)",xHairTexture=Texture'utcompv17a.UberSmallCircle')
     UTCompNewHairs(4)=(xHairName="Small Circle(0)",xHairTexture=Texture'utcompv17a.BigCircle_2')
     UTCompNewHairs(5)=(xHairName="Small Circle(1)",xHairTexture=Texture'utcompv17a.MedCircle_2')
     UTCompNewHairs(6)=(xHairName="Small Circle(2)",xHairTexture=Texture'utcompv17a.SmallCircle_2')
     UTCompNewHairs(7)=(xHairName="Small Circle(3)",xHairTexture=Texture'utcompv17a.UberSmallCircle_2')
     UTCompNewHairs(8)=(xHairName="Big Square(0)",xHairTexture=Texture'utcompv17a.BigSquare')
     UTCompNewHairs(9)=(xHairName="Big Square(1)",xHairTexture=Texture'utcompv17a.BigSquare_2')
     UTCompNewHairs(10)=(xHairName="Big Square(2)",xHairTexture=Texture'utcompv17a.BigSquare_3')
     UTCompNewHairs(11)=(xHairName="Big diamond(0)",xHairTexture=Texture'utcompv17a.Bigdiamond')
     UTCompNewHairs(12)=(xHairName="Big Diamond(1)",xHairTexture=Texture'utcompv17a.Bigdiamond_2')
     UTCompNewHairs(13)=(xHairName="Big Diamond(2)",xHairTexture=Texture'utcompv17a.Bigdiamond_3')
     UTCompNewHairs(14)=(xHairName="Big Horiz",xHairTexture=Texture'utcompv17a.SmallVert')
     UTCompNewHairs(15)=(xHairName="Small Horiz",xHairTexture=Texture'utcompv17a.BigVert')
     UTCompNewHairs(16)=(xHairName="Big Vert",xHairTexture=Texture'utcompv17a.SmallHoriz')
     UTCompNewHairs(17)=(xHairName="Small Vert",xHairTexture=Texture'utcompv17a.BigHoriz')
     UTCompNewHairs(18)=(xHairName="Big 'L'(0)",xHairTexture=Texture'utcompv17a.Bigbracket')
     UTCompNewHairs(19)=(xHairName="Big 'L'(1)",xHairTexture=Texture'utcompv17a.Bigbracket_1')
     UTCompNewHairs(20)=(xHairName="Big 'L'(2)",xHairTexture=Texture'utcompv17a.Bigbracket_2')
     UTCompNewHairs(21)=(xHairName="Big 'L'(3)",xHairTexture=Texture'utcompv17a.Bigbracket_3')
     UTCompNewHairs(22)=(xHairName="Big 'L'(4)",xHairTexture=Texture'utcompv17a.Bigbracket_4')
     UTCompNewHairs(23)=(xHairName="Big 'L'(5)",xHairTexture=Texture'utcompv17a.Bigbracket_5')
     UTCompNewHairs(24)=(xHairName="Big 'L'(6)",xHairTexture=Texture'utcompv17a.Bigbracket_6')
     UTCompNewHairs(25)=(xHairName="Big 'L'(7)",xHairTexture=Texture'utcompv17a.Bigbracket_7')
}
