

defaultproperties
{
     Begin Object Class=moCheckBox Name=EnemyBasedSkinCheck
         Caption="Enemy Based Skins"
         OnCreateComponent=EnemyBasedSkinCheck.InternalOnCreateComponent
         WinTop=0.330583
         WinLeft=0.096875
         WinWidth=0.257812
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
     End Object
     ch_EnemySkins=moCheckBox'utcompv17a.UTComp_Menu_BrightSkins.EnemyBasedSkinCheck'

     Begin Object Class=GUIComboBox Name=TeamSelectCombo
         WinTop=0.375000
         WinLeft=0.096249
         WinWidth=0.421875
         WinHeight=0.035000
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
         OnKeyEvent=TeamSelectCombo.InternalOnKeyEvent
     End Object
     co_TeamSelect=GUIComboBox'utcompv17a.UTComp_Menu_BrightSkins.TeamSelectCombo'

     Begin Object Class=GUIComboBox Name=TypeSkinSelectCombo
         WinTop=0.491263
         WinLeft=0.096249
         WinWidth=0.423438
         WinHeight=0.035000
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
         OnKeyEvent=TypeSkinSelectCombo.InternalOnKeyEvent
     End Object
     co_TypeSkinSelect=GUIComboBox'utcompv17a.UTComp_Menu_BrightSkins.TypeSkinSelectCombo'

     Begin Object Class=GUIComboBox Name=ModelSelectCombo
         WinTop=0.737925
         WinLeft=0.100625
         WinWidth=0.417188
         WinHeight=0.035000
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
         OnKeyEvent=UTComp_Menu_BrightSkins.InternalOnKeyEvent
     End Object
     co_ModelSelect=GUIComboBox'utcompv17a.UTComp_Menu_BrightSkins.ModelSelectCombo'

     Begin Object Class=GUIComboBox Name=EpicSkinSelectCombo
         WinTop=0.537526
         WinLeft=0.097812
         WinWidth=0.420313
         WinHeight=0.035000
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
         OnKeyEvent=EpicSkinSelectCombo.InternalOnKeyEvent
     End Object
     co_EpicSkinSelect=GUIComboBox'utcompv17a.UTComp_Menu_BrightSkins.EpicSkinSelectCombo'

     Begin Object Class=GUIImage Name=spinnydudeboundsimage
         Image=Texture'2K4Menus.Controls.buttonSquare_b'
         DropShadow=Texture'2K4Menus.Controls.Shadow'
         ImageColor=(A=128)
         ImageStyle=ISTY_Stretched
         DropShadowX=4
         DropShadowY=4
         WinTop=0.095717
         WinLeft=0.620830
         WinWidth=0.220507
         WinHeight=0.746876
         RenderWeight=0.520000
         bBoundToParent=True
         bScaleToParent=True
         OnDraw=UTComp_Menu_BrightSkins.InternalOnDraw
     End Object
     SpinnyDudeBounds=GUIImage'utcompv17a.UTComp_Menu_BrightSkins.spinnydudeboundsimage'

     Begin Object Class=GUIEditBox Name=ClanSkinEditBox
         WinTop=0.429162
         WinLeft=0.329062
         WinWidth=0.187500
         WinHeight=0.035000
         OnActivate=ClanSkinEditBox.InternalActivate
         OnDeActivate=ClanSkinEditBox.InternalDeactivate
         OnKeyType=ClanSkinEditBox.InternalOnKeyType
         OnKeyEvent=UTComp_Menu_BrightSkins.InternalOnKeyEvent
     End Object
     eb_ClanSkin=GUIEditBox'utcompv17a.UTComp_Menu_BrightSkins.ClanSkinEditBox'

     Begin Object Class=GUISlider Name=RedSkinSlider
         MaxValue=128.000000
         bIntSlider=True
         WinTop=0.585000
         WinLeft=0.180000
         WinWidth=0.335000
         OnClick=RedSkinSlider.InternalOnClick
         OnMousePressed=RedSkinSlider.InternalOnMousePressed
         OnMouseRelease=RedSkinSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
         OnKeyEvent=RedSkinSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedSkinSlider.InternalCapturedMouseMove
     End Object
     sl_RedSkin=GUISlider'utcompv17a.UTComp_Menu_BrightSkins.RedSkinSlider'

     Begin Object Class=GUISlider Name=GreenSkinSlider
         MaxValue=128.000000
         bIntSlider=True
         WinTop=0.625000
         WinLeft=0.180000
         WinWidth=0.335000
         OnClick=GreenSkinSlider.InternalOnClick
         OnMousePressed=GreenSkinSlider.InternalOnMousePressed
         OnMouseRelease=GreenSkinSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
         OnKeyEvent=GreenSkinSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenSkinSlider.InternalCapturedMouseMove
     End Object
     sl_GreenSkin=GUISlider'utcompv17a.UTComp_Menu_BrightSkins.GreenSkinSlider'

     Begin Object Class=GUISlider Name=BlueSkinSlider
         MaxValue=128.000000
         bIntSlider=True
         WinTop=0.665000
         WinLeft=0.180000
         WinWidth=0.335000
         OnClick=BlueSkinSlider.InternalOnClick
         OnMousePressed=BlueSkinSlider.InternalOnMousePressed
         OnMouseRelease=BlueSkinSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
         OnKeyEvent=BlueSkinSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueSkinSlider.InternalCapturedMouseMove
     End Object
     sl_BlueSkin=GUISlider'utcompv17a.UTComp_Menu_BrightSkins.BlueSkinSlider'

     Begin Object Class=moCheckBox Name=ForceThisModelCheck
         Caption="Force This Model"
         OnCreateComponent=ForceThisModelCheck.InternalOnCreateComponent
         WinTop=0.702431
         WinLeft=0.098749
         WinWidth=0.309375
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
     End Object
     ch_ForceThisModel=moCheckBox'utcompv17a.UTComp_Menu_BrightSkins.ForceThisModelCheck'

     Begin Object Class=moCheckBox Name=DarkSkinCheck
         Caption="Darken Dead Bodies"
         OnCreateComponent=DarkSkinCheck.InternalOnCreateComponent
         WinTop=0.330916
         WinLeft=0.648436
         WinWidth=0.264062
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
     End Object
     ch_DarkSkins=moCheckBox'utcompv17a.UTComp_Menu_BrightSkins.DarkSkinCheck'

     Begin Object Class=moCheckBox Name=EnemyBasedModelCheck
         Caption="Enemy Based models"
         OnCreateComponent=EnemyBasedSkinCheck.InternalOnCreateComponent
         WinTop=0.330583
         WinLeft=0.367188
         WinWidth=0.273437
         OnChange=UTComp_Menu_BrightSkins.InternalOnChange
     End Object
     ch_EnemyModels=moCheckBox'utcompv17a.UTComp_Menu_BrightSkins.EnemyBasedModelCheck'

     Begin Object Class=GUIButton Name=DeleteClanSkinButton
         Caption="Delete ClanSkin"
         WinTop=0.445833
         WinLeft=0.095938
         WinWidth=0.208125
         OnClick=UTComp_Menu_BrightSkins.InternalOnClick
         OnKeyEvent=DeleteClanSkinButton.InternalOnKeyEvent
     End Object
     bu_DeleteClanSkin=GUIButton'utcompv17a.UTComp_Menu_BrightSkins.DeleteClanSkinButton'

     Begin Object Class=GUIButton Name=AddClanSkinButton
         Caption="Add Clanskin"
         WinTop=0.410417
         WinLeft=0.095938
         WinWidth=0.208125
         OnClick=UTComp_Menu_BrightSkins.InternalOnClick
         OnKeyEvent=AddClanSkinButton.InternalOnKeyEvent
     End Object
     bu_AddClanSkin=GUIButton'utcompv17a.UTComp_Menu_BrightSkins.AddClanSkinButton'

     Begin Object Class=GUILabel Name=RedSkinLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.570000
         WinLeft=0.100000
     End Object
     l_RedSkin=GUILabel'utcompv17a.UTComp_Menu_BrightSkins.RedSkinLabel'

     Begin Object Class=GUILabel Name=BlueSkinLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.650000
         WinLeft=0.100000
     End Object
     l_BlueSkin=GUILabel'utcompv17a.UTComp_Menu_BrightSkins.BlueSkinLabel'

     Begin Object Class=GUILabel Name=GreenSkinLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.610000
         WinLeft=0.100000
     End Object
     l_GreenSkin=GUILabel'utcompv17a.UTComp_Menu_BrightSkins.GreenSkinLabel'

}
