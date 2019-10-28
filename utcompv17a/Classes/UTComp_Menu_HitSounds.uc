

defaultproperties
{
     Begin Object Class=GUISlider Name=HitSoundVolume
         MaxValue=4.000000
         WinTop=0.440000
         WinLeft=0.250000
         WinWidth=0.500000
         OnClick=HitSoundVolume.InternalOnClick
         OnMousePressed=HitSoundVolume.InternalOnMousePressed
         OnMouseRelease=HitSoundVolume.InternalOnMouseRelease
         OnChange=UTComp_Menu_HitSounds.InternalOnChange
         OnKeyEvent=HitSoundVolume.InternalOnKeyEvent
         OnCapturedMouseMove=HitSoundVolume.InternalCapturedMouseMove
     End Object
     sl_Volume=GUISlider'utcompv17a.UTComp_Menu_HitSounds.HitSoundVolume'

     Begin Object Class=GUISlider Name=PitchMod
         MinValue=1.000000
         MaxValue=3.000000
         Value=1.000000
         WinTop=0.590000
         WinLeft=0.250000
         WinWidth=0.500000
         OnClick=PitchMod.InternalOnClick
         OnMousePressed=PitchMod.InternalOnMousePressed
         OnMouseRelease=PitchMod.InternalOnMouseRelease
         OnChange=UTComp_Menu_HitSounds.InternalOnChange
         OnKeyEvent=PitchMod.InternalOnKeyEvent
         OnCapturedMouseMove=PitchMod.InternalCapturedMouseMove
     End Object
     sl_Pitch=GUISlider'utcompv17a.UTComp_Menu_HitSounds.PitchMod'

     Begin Object Class=moCheckBox Name=CPMAstyle
         Caption="CPMA Style Hitsounds"
         OnCreateComponent=CPMAstyle.InternalOnCreateComponent
         WinTop=0.490000
         WinLeft=0.250000
         OnChange=UTComp_Menu_HitSounds.InternalOnChange
     End Object
     ch_CPMAStyle=moCheckBox'utcompv17a.UTComp_Menu_HitSounds.CPMAstyle'

     Begin Object Class=moCheckBox Name=EnableHit
         Caption="Enable Hitsounds"
         OnCreateComponent=CPMAstyle.InternalOnCreateComponent
         WinTop=0.360000
         WinLeft=0.250000
         OnChange=UTComp_Menu_HitSounds.InternalOnChange
     End Object
     ch_EnableHitSounds=moCheckBox'utcompv17a.UTComp_Menu_HitSounds.EnableHit'

     Begin Object Class=GUIComboBox Name=EnemySound
         WinTop=0.654000
         WinLeft=0.412500
         WinWidth=0.340000
         WinHeight=0.030000
         OnChange=UTComp_Menu_HitSounds.InternalOnChange
         OnKeyEvent=UTComp_Menu_HitSounds.InternalOnKeyEvent
     End Object
     co_EnemySound=GUIComboBox'utcompv17a.UTComp_Menu_HitSounds.EnemySound'

     Begin Object Class=GUIComboBox Name=TeammateSound
         WinTop=0.704000
         WinLeft=0.412500
         WinWidth=0.340000
         WinHeight=0.030000
         OnChange=UTComp_Menu_HitSounds.InternalOnChange
         OnKeyEvent=UTComp_Menu_HitSounds.InternalOnKeyEvent
     End Object
     co_FriendlySound=GUIComboBox'utcompv17a.UTComp_Menu_HitSounds.TeammateSound'

     Begin Object Class=GUILabel Name=VolumeLabel
         Caption="Hitsound Volume"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.390000
         WinLeft=0.250000
     End Object
     l_Volume=GUILabel'utcompv17a.UTComp_Menu_HitSounds.VolumeLabel'

     Begin Object Class=GUILabel Name=PitchLabel
         Caption="CPMA Pitch Modifier"
         TextColor=(B=0,G=200,R=230)
         WinTop=0.540000
         WinLeft=0.250000
     End Object
     l_Pitch=GUILabel'utcompv17a.UTComp_Menu_HitSounds.PitchLabel'

     Begin Object Class=GUILabel Name=EnemySoundLabel
         Caption="Enemy Sound"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.640000
         WinLeft=0.250000
     End Object
     l_EnemySound=GUILabel'utcompv17a.UTComp_Menu_HitSounds.EnemySoundLabel'

     Begin Object Class=GUILabel Name=FriendlySoundLabel
         Caption="Team Sound"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.690000
         WinLeft=0.250000
     End Object
     l_FriendlySound=GUILabel'utcompv17a.UTComp_Menu_HitSounds.FriendlySoundLabel'

}
