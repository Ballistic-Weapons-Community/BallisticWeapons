

defaultproperties
{
     Begin Object Class=GUILabel Name=Label0
     End Object
     l_ColorNameLetters(0)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label0'

     Begin Object Class=GUILabel Name=Label1
     End Object
     l_ColorNameLetters(1)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label1'

     Begin Object Class=GUILabel Name=Label2
     End Object
     l_ColorNameLetters(2)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label2'

     Begin Object Class=GUILabel Name=Label3
     End Object
     l_ColorNameLetters(3)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label3'

     Begin Object Class=GUILabel Name=Label4
     End Object
     l_ColorNameLetters(4)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label4'

     Begin Object Class=GUILabel Name=Label5
     End Object
     l_ColorNameLetters(5)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label5'

     Begin Object Class=GUILabel Name=Label6
     End Object
     l_ColorNameLetters(6)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label6'

     Begin Object Class=GUILabel Name=Label7
     End Object
     l_ColorNameLetters(7)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label7'

     Begin Object Class=GUILabel Name=Label8
     End Object
     l_ColorNameLetters(8)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label8'

     Begin Object Class=GUILabel Name=Label9
     End Object
     l_ColorNameLetters(9)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label9'

     Begin Object Class=GUILabel Name=Label10
     End Object
     l_ColorNameLetters(10)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label10'

     Begin Object Class=GUILabel Name=Label11
     End Object
     l_ColorNameLetters(11)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label11'

     Begin Object Class=GUILabel Name=Label12
     End Object
     l_ColorNameLetters(12)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label12'

     Begin Object Class=GUILabel Name=Label13
     End Object
     l_ColorNameLetters(13)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label13'

     Begin Object Class=GUILabel Name=Label14
     End Object
     l_ColorNameLetters(14)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label14'

     Begin Object Class=GUILabel Name=Label15
     End Object
     l_ColorNameLetters(15)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label15'

     Begin Object Class=GUILabel Name=Label16
     End Object
     l_ColorNameLetters(16)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label16'

     Begin Object Class=GUILabel Name=Label17
     End Object
     l_ColorNameLetters(17)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label17'

     Begin Object Class=GUILabel Name=Label18
     End Object
     l_ColorNameLetters(18)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label18'

     Begin Object Class=GUILabel Name=Label19
     End Object
     l_ColorNameLetters(19)=GUILabel'utcompv17a.UTComp_Menu_ColorNames.Label19'

     Begin Object Class=moCheckBox Name=ColorChatCheck
         Caption="Show colored names in chat messages"
         OnCreateComponent=ColorChatCheck.InternalOnCreateComponent
         WinTop=0.330000
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_ColorChat=moCheckBox'utcompv17a.UTComp_Menu_ColorNames.ColorChatCheck'

     Begin Object Class=moCheckBox Name=ColorScoreboardCheck
         Caption="Show colored names on scoreboard"
         OnCreateComponent=ColorScoreboardCheck.InternalOnCreateComponent
         WinTop=0.365000
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_ColorScoreboard=moCheckBox'utcompv17a.UTComp_Menu_ColorNames.ColorScoreboardCheck'

     Begin Object Class=moCheckBox Name=Colorq3Check
         Caption="Show colored text in chat messages(Q3 Style)"
         OnCreateComponent=Colorq3Check.InternalOnCreateComponent
         WinTop=0.433814
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_ColorQ3=moCheckBox'utcompv17a.UTComp_Menu_ColorNames.Colorq3Check'

     Begin Object Class=moCheckBox Name=EnemyNamesCheck
         Caption="Show colored enemy names on targeting"
         OnCreateComponent=EnemyNamesCheck.InternalOnCreateComponent
         WinTop=0.400000
         WinLeft=0.200000
         WinWidth=0.600000
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     ch_EnemyNames=moCheckBox'utcompv17a.UTComp_Menu_ColorNames.EnemyNamesCheck'

     Begin Object Class=GUIComboBox Name=ComboSaved
         WinTop=0.612320
         WinLeft=0.140625
         WinWidth=0.300000
         WinHeight=0.031875
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=ComboSaved.InternalOnKeyEvent
     End Object
     co_SavedNames=GUIComboBox'utcompv17a.UTComp_Menu_ColorNames.ComboSaved'

     Begin Object Class=GUIButton Name=ButtonSave
         Caption="Save"
         WinTop=0.650000
         WinLeft=0.142187
         WinWidth=0.133437
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonSave.InternalOnKeyEvent
     End Object
     bu_SaveName=GUIButton'utcompv17a.UTComp_Menu_ColorNames.ButtonSave'

     Begin Object Class=GUIButton Name=ButtonDelete
         Caption="Delete"
         WinTop=0.650000
         WinLeft=0.303125
         WinWidth=0.133125
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonDelete.InternalOnKeyEvent
     End Object
     bu_DeleteName=GUIButton'utcompv17a.UTComp_Menu_ColorNames.ButtonDelete'

     Begin Object Class=GUIButton Name=ButtonWhite
         Caption="Reset entire name to white"
         WinTop=0.739585
         WinLeft=0.540625
         WinWidth=0.344063
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonWhite.InternalOnKeyEvent
     End Object
     bu_ResetWhite=GUIButton'utcompv17a.UTComp_Menu_ColorNames.ButtonWhite'

     Begin Object Class=GUIButton Name=ButtonApply
         Caption="Use This Name"
         WinTop=0.695833
         WinLeft=0.140625
         WinWidth=0.297188
         OnClick=UTComp_Menu_ColorNames.InternalOnClick
         OnKeyEvent=ButtonApply.InternalOnKeyEvent
     End Object
     bu_Apply=GUIButton'utcompv17a.UTComp_Menu_ColorNames.ButtonApply'

     Begin Object Class=GUISlider Name=RedSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.600000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=RedSlider.InternalOnClick
         OnMousePressed=RedSlider.InternalOnMousePressed
         OnMouseRelease=RedSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=RedSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedSlider.InternalCapturedMouseMove
     End Object
     sl_RedColor=GUISlider'utcompv17a.UTComp_Menu_ColorNames.RedSlider'

     Begin Object Class=GUISlider Name=BlueSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.700000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=BlueSlider.InternalOnClick
         OnMousePressed=BlueSlider.InternalOnMousePressed
         OnMouseRelease=BlueSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=BlueSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueSlider.InternalCapturedMouseMove
     End Object
     sl_BlueColor=GUISlider'utcompv17a.UTComp_Menu_ColorNames.BlueSlider'

     Begin Object Class=GUISlider Name=GreenSlider
         MaxValue=255.000000
         bIntSlider=True
         WinTop=0.650000
         WinLeft=0.600000
         WinWidth=0.300000
         OnClick=GreenSlider.InternalOnClick
         OnMousePressed=GreenSlider.InternalOnMousePressed
         OnMouseRelease=GreenSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=GreenSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenSlider.InternalCapturedMouseMove
     End Object
     sl_GreenColor=GUISlider'utcompv17a.UTComp_Menu_ColorNames.GreenSlider'

     Begin Object Class=GUILabel Name=RedLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.587500
         WinLeft=0.528125
     End Object
     l_RedLabel=GUILabel'utcompv17a.UTComp_Menu_ColorNames.RedLabel'

     Begin Object Class=GUILabel Name=BlueLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.685414
         WinLeft=0.528125
     End Object
     l_BlueLabel=GUILabel'utcompv17a.UTComp_Menu_ColorNames.BlueLabel'

     Begin Object Class=GUILabel Name=GreenLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.635417
         WinLeft=0.528125
     End Object
     l_GreenLabel=GUILabel'utcompv17a.UTComp_Menu_ColorNames.GreenLabel'

     Begin Object Class=GUISlider Name=LetterSlider
         Value=1.000000
         bIntSlider=True
         WinTop=0.535000
         OnClick=LetterSlider.InternalOnClick
         OnMousePressed=LetterSlider.InternalOnMousePressed
         OnMouseRelease=LetterSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
         OnKeyEvent=LetterSlider.InternalOnKeyEvent
         OnCapturedMouseMove=LetterSlider.InternalCapturedMouseMove
     End Object
     sl_LetterSelect=GUISlider'utcompv17a.UTComp_Menu_ColorNames.LetterSlider'

     Begin Object Class=moComboBox Name=ColorDeathCombo
         Caption="Death Message Color:"
         OnCreateComponent=ColorDeathCombo.InternalOnCreateComponent
         WinTop=0.467990
         WinLeft=0.168749
         WinWidth=0.660936
         OnChange=UTComp_Menu_ColorNames.InternalOnChange
     End Object
     co_DeathSelect=moComboBox'utcompv17a.UTComp_Menu_ColorNames.ColorDeathCombo'

}
