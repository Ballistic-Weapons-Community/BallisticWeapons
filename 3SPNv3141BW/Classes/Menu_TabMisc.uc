class Menu_TabMisc extends UT2k3TabPanel;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local Misc_Player MP;
    local TAM_GRI GRI;

    Super.InitComponent(MyController, MyOwner);

    MP = Misc_Player(PlayerOwner());
    if(MP == None)
        return;

    moCheckBox(Controls[1]).Checked(MP.bDisableSpeed);
	moCheckBox(Controls[2]).Checked(MP.bDisableBooster);
	moCheckBox(Controls[3]).Checked(MP.bDisableBerserk);
	moCheckBox(Controls[4]).Checked(MP.bDisableInvis);
    
    moCheckBox(Controls[5]).Checked(MP.bMatchHUDToSkins);
    moCheckBox(Controls[6]).Checked(!MP.bShowTeamInfo);
    moCheckBox(Controls[7]).Checked(!MP.bShowCombos);    
   // moCheckBox(Controls[14]).Checked(MP.bExtendedInfo);
    moCheckBox(Controls[15]).Checked(MP.bTeamColoredDeathMessages);

    moCheckBox(Controls[16]).Checked(!class'Misc_Pawn'.default.bPlayOwnFootsteps);
    moCheckBox(Controls[17]).Checked(MP.bSlotMode);

	moCheckBox(Controls[8]).Checked(!MP.bUseHitSounds);
    GUISlider(Controls[9]).Value = MP.SoundHitVolume;

    GUISlider(Controls[18]).Value = MP.SoundAloneVolume;

    GRI = TAM_GRI(PlayerOwner().Level.GRI);
    if(GRI != None)
    {
        if(GRI.TimeOuts == 0 && !PlayerOwner().PlayerReplicationInfo.bAdmin)
             GUIButton(Controls[20]).DisableMe();
    }
    else
        GUIButton(Controls[20]).DisableMe();
}

function OnChange(GUIComponent C)
{
    local bool b;
    local Misc_Player MP;
    MP = Misc_Player(PlayerOwner());
    if(MP == None)
        return;

    if(moCheckBox(c) != None)
    {
        b = moCheckBox(c).IsChecked();
        if(c == Controls[1])
        {
            MP.bDisableSpeed = b;
            class'Misc_Player'.default.bDisableSpeed = b;
        }
        else if(c == Controls[2])
        {
            MP.bDisableBooster = b;
            class'Misc_Player'.default.bDisableBooster = b;
        }
        else if(c == Controls[3])
        {
            MP.bDisableBerserk = b;
            class'Misc_Player'.default.bDisableBerserk = b;
        }
        else if(c == Controls[4])
        {
            MP.bDisableInvis = b;
            class'Misc_Player'.default.bDisableInvis = b;
        }

        else if(c == Controls[5])
        {
            MP.bMatchHUDToSkins = b;
            class'Misc_Player'.default.bMatchHUDToSkins = b;
        }
        else if(c == Controls[6])
        {
            MP.bShowTeamInfo = !b;
            class'Misc_Player'.default.bShowTeamInfo = !b;
        }
        else if(c == Controls[7])
        {
            MP.bShowCombos = !b;
            class'Misc_Player'.default.bShowCombos = !b;
        }
        /*else if(c == Controls[14])
        {
            MP.bExtendedInfo = b;
            class'Misc_Player'.default.bExtendedInfo = b;
        }*/
        else if(c == Controls[15])
        {
            MP.bTeamColoredDeathMessages = b;
            class'Misc_Player'.default.bTeamColoredDeathMessages = b;
        }

        else if(c == Controls[16])
        {
            class'UnrealPawn'.default.bPlayOwnFootsteps = !b;
            class'xPawn'.default.bPlayOwnFootsteps = !b;
            class'Misc_Pawn'.default.bPlayOwnFootsteps = !b;
            class'Misc_Pawn'.static.StaticSaveConfig();

            if(xPawn(MP.Pawn) != None)
            {
                xPawn(MP.Pawn).bPlayOwnFootsteps = !b;
                MP.Pawn.SaveConfig();
            }

            return;
        }

        else if(c == Controls[17])
        {
            MP.bSlotMode = b;
            class'Misc_Player'.default.bSlotMode = b;
        }

        else if(c == Controls[8])
        {
            MP.bUseHitSounds = !b;
            class'Misc_Player'.default.bUseHitSounds = !b;

            if(b)
                GUISlider(Controls[9]).DisableMe();
            else
                GUISlider(Controls[9]).EnableMe();
        }
    }
    else if(GUISlider(c) != None)
    {
        switch(c)
        {
            case Controls[9]:
                MP.SoundHitVolume = GUISlider(c).Value;
                class'Misc_Player'.default.SoundHitVolume = GUISlider(c).Value;
            break;

            case Controls[18]:
                MP.SoundAloneVolume = GUISlider(c).Value;
                class'Misc_Player'.default.SoundAloneVolume = GUISlider(c).Value;
            break;
        }
    }

    MP.SetupCombos();
    MP.SaveConfig();
}

function bool OnClick(GUIComponent C)
{
    if(C == Controls[20])
    {
        Misc_Player(PlayerOwner()).CallTimeout();
        Controller.CloseMenu();
    }

	return true;
}

defaultproperties
{
     Begin Object Class=GUIImage Name=TabBackground
         Image=Texture'InterfaceContent.Menu.ScoreBoxA'
         ImageColor=(B=0,G=0,R=0)
         ImageStyle=ISTY_Stretched
         WinHeight=1.000000
         bNeverFocus=True
     End Object
     Controls(0)=GUIImage'3SPNv3141BW.Menu_TabMisc.TabBackground'

     Begin Object Class=moCheckBox Name=SpeedCheck
         Caption="Disable Speed."
         OnCreateComponent=SpeedCheck.InternalOnCreateComponent
         Hint="Disables the Speed adrenaline combo if checked."
         WinTop=0.250000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(1)=moCheckBox'3SPNv3141BW.Menu_TabMisc.SpeedCheck'

     Begin Object Class=moCheckBox Name=BoosterCheck
         Caption="Disable Booster."
         OnCreateComponent=BoosterCheck.InternalOnCreateComponent
         Hint="Disables the Booster adrenaline combo if checked."
         WinTop=0.300000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(2)=moCheckBox'3SPNv3141BW.Menu_TabMisc.BoosterCheck'

     Begin Object Class=moCheckBox Name=BerserkCheck
         Caption="Disable Berserk."
         OnCreateComponent=BerserkCheck.InternalOnCreateComponent
         Hint="Disables the Berserk adrenaline combo if checked."
         WinTop=0.350000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(3)=moCheckBox'3SPNv3141BW.Menu_TabMisc.BerserkCheck'

     Begin Object Class=moCheckBox Name=InvisCheck
         Caption="Disable Invisibility."
         OnCreateComponent=InvisCheck.InternalOnCreateComponent
         Hint="Disables the Invisibility adrenaline combo if checked."
         WinTop=0.400000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(4)=moCheckBox'3SPNv3141BW.Menu_TabMisc.InvisCheck'

     Begin Object Class=moCheckBox Name=MatchCheck
         Caption="Match HUD color to brightskins."
         OnCreateComponent=MatchCheck.InternalOnCreateComponent
         WinTop=0.600000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(5)=moCheckBox'3SPNv3141BW.Menu_TabMisc.MatchCheck'

     Begin Object Class=moCheckBox Name=TeamCheck
         Caption="Disable Team Info."
         OnCreateComponent=TeamCheck.InternalOnCreateComponent
         Hint="Disables showing team members and enemies on the HUD."
         WinTop=0.500000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(6)=moCheckBox'3SPNv3141BW.Menu_TabMisc.TeamCheck'

     Begin Object Class=moCheckBox Name=ComboCheck
         Caption="Disable Combo List."
         OnCreateComponent=ComboCheck.InternalOnCreateComponent
         Hint="Disables showing combo info on the lower right portion of the HUD."
         WinTop=0.550000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(7)=moCheckBox'3SPNv3141BW.Menu_TabMisc.ComboCheck'

     Begin Object Class=moCheckBox Name=HitsoundsCheck
         Caption="Disable Hitsounds."
         OnCreateComponent=HitsoundsCheck.InternalOnCreateComponent
         Hint="Disables damage-dependant hitsounds (the lower the pitch, the greater the damage)."
         WinTop=0.750000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(8)=moCheckBox'3SPNv3141BW.Menu_TabMisc.HitsoundsCheck'

     Begin Object Class=GUISlider Name=HitVolumeSlider
         MaxValue=2.000000
         WinTop=0.805000
         WinLeft=0.500000
         WinWidth=0.400000
         OnClick=HitVolumeSlider.InternalOnClick
         OnMousePressed=HitVolumeSlider.InternalOnMousePressed
         OnMouseRelease=HitVolumeSlider.InternalOnMouseRelease
         OnChange=Menu_TabMisc.OnChange
         OnKeyEvent=HitVolumeSlider.InternalOnKeyEvent
         OnCapturedMouseMove=HitVolumeSlider.InternalCapturedMouseMove
     End Object
     Controls(9)=GUISlider'3SPNv3141BW.Menu_TabMisc.HitVolumeSlider'

     Begin Object Class=GUILabel Name=HitVolumeLabel
         Caption="Hitsound Volume:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.790000
         WinLeft=0.100000
     End Object
     Controls(10)=GUILabel'3SPNv3141BW.Menu_TabMisc.HitVolumeLabel'

     Begin Object Class=GUILabel Name=HitSoundsLabel
         Caption="Sounds:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.700000
         WinLeft=0.050000
     End Object
     Controls(11)=GUILabel'3SPNv3141BW.Menu_TabMisc.HitSoundsLabel'

     Begin Object Class=GUILabel Name=ComboLabel
         Caption="Combos:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.200000
         WinLeft=0.050000
     End Object
     Controls(12)=GUILabel'3SPNv3141BW.Menu_TabMisc.ComboLabel'

     Begin Object Class=GUILabel Name=HUDLabel
         Caption="HUD:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.450000
         WinLeft=0.050000
     End Object
     Controls(13)=GUILabel'3SPNv3141BW.Menu_TabMisc.HUDLabel'

     Begin Object Class=GUILabel Name=ExtraLabel
         Caption="Miscellaneous:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.050000
         WinLeft=0.050000
     End Object
     Controls(14)=GUILabel'3SPNv3141BW.Menu_TabMisc.ExtraLabel'

     Begin Object Class=moCheckBox Name=DeathsCheck
         Caption="Team-colored death messages."
         OnCreateComponent=DeathsCheck.InternalOnCreateComponent
         Hint="Colors player names in death messages based on team."
         WinTop=0.650000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(15)=moCheckBox'3SPNv3141BW.Menu_TabMisc.DeathsCheck'

     Begin Object Class=moCheckBox Name=StepsCheck
         Caption="Disable own footsteps."
         OnCreateComponent=StepsCheck.InternalOnCreateComponent
         WinTop=0.100000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(16)=moCheckBox'3SPNv3141BW.Menu_TabMisc.StepsCheck'

     Begin Object Class=moCheckBox Name=SlotSwitch
         Caption="Redirect weapon switch keys to Loadout slots."
         OnCreateComponent=SlotSwitch.InternalOnCreateComponent
         WinTop=0.150000
         WinLeft=0.100000
         WinWidth=0.800000
         OnChange=Menu_TabMisc.OnChange
     End Object
     Controls(17)=moCheckBox'3SPNv3141BW.Menu_TabMisc.SlotSwitch'

     Begin Object Class=GUISlider Name=AloneVolumeSlider
         MaxValue=2.000000
         WinTop=0.855000
         WinLeft=0.500000
         WinWidth=0.400000
         OnClick=AloneVolumeSlider.InternalOnClick
         OnMousePressed=AloneVolumeSlider.InternalOnMousePressed
         OnMouseRelease=AloneVolumeSlider.InternalOnMouseRelease
         OnChange=Menu_TabMisc.OnChange
         OnKeyEvent=AloneVolumeSlider.InternalOnKeyEvent
         OnCapturedMouseMove=AloneVolumeSlider.InternalCapturedMouseMove
     End Object
     Controls(18)=GUISlider'3SPNv3141BW.Menu_TabMisc.AloneVolumeSlider'

     Begin Object Class=GUILabel Name=AloneVolumeLabel
         Caption="Alone Volume:"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.840000
         WinLeft=0.100000
     End Object
     Controls(19)=GUILabel'3SPNv3141BW.Menu_TabMisc.AloneVolumeLabel'

     Begin Object Class=GUIButton Name=TimeoutButton
         Caption="Attempt Timeout"
         StyleName="SquareMenuButton"
         WinTop=0.910000
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.080000
         OnClick=Menu_TabMisc.OnClick
         OnKeyEvent=DefaultButton.InternalOnKeyEvent
     End Object
     Controls(20)=GUIButton'3SPNv3141BW.Menu_TabMisc.TimeoutButton'

}
