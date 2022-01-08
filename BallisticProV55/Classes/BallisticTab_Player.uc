//=============================================================================
// BallisticTab_Player.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticTab_Player extends UT2K4TabPanel;

var automated moNumericEdit     ne_playerHealth;
var automated moNumericEdit     ne_playerHealthCap;
var automated moNumericEdit     ne_playerSuperHealthCap;
var automated moNumericEdit     ne_iAdrenaline;
var automated moNumericEdit     ne_iAdrenalineCap;
var automated moFloatEdit       fe_dieSoundAmplifier;
var automated moFloatEdit       fe_dieSoundRangeAmplifier;
var automated moFloatEdit       fe_hitSoundAmplifier;
var automated moFloatEdit       fe_hitSoundRangeAmplifier;
var automated moFloatEdit       fe_footStepAmplifier;
var automated moFloatEdit       fe_jumpDamageAmplifier;

var automated moNumericEdit     ne_iArmor;
var automated moNumericEdit     ne_iArmorCap;

var automated moFloatEdit       fe_MaxFallSpeed;

var BallisticConfigMenuPro         p_Anchor;
var bool                        bInitialized;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    if (BallisticConfigMenuPro(Controller.ActivePage) != None)
        p_Anchor = BallisticConfigMenuPro(Controller.ActivePage);

}

function ShowPanel(bool bShow)
{
    super.ShowPanel(bShow);
    if (bInitialized)
        return;
    LoadSettings();
    bInitialized = true;
}

function LoadSettings()
{
    ne_playerHealth.SetValue(class'BallisticReplicationInfo'.default.playerHealth);
    ne_playerHealthCap.SetValue(class'BallisticReplicationInfo'.default.playerHealthCap);
    ne_playerSuperHealthCap.SetValue(class'BallisticReplicationInfo'.default.playerSuperHealthCap);
    ne_iAdrenaline.SetValue(class'BallisticReplicationInfo'.default.iAdrenaline);
    ne_iAdrenalineCap.SetValue(class'BallisticReplicationInfo'.default.iAdrenalineCap);
    fe_dieSoundAmplifier.SetValue(class'BallisticReplicationInfo'.default.dieSoundAmplifier);
    fe_dieSoundRangeAmplifier.SetValue(class'BallisticReplicationInfo'.default.dieSoundRangeAmplifier);
    fe_hitSoundAmplifier.SetValue(class'BallisticReplicationInfo'.default.hitSoundAmplifier);
    fe_hitSoundRangeAmplifier.SetValue(class'BallisticReplicationInfo'.default.hitSoundRangeAmplifier);
    fe_jumpDamageAmplifier.SetValue(class'BallisticReplicationInfo'.default.jumpDamageAmplifier);
    fe_footStepAmplifier.SetValue(class'Mut_Ballistic'.default.footstepAmplifier);

    ne_iArmor.SetValue(class'BallisticReplicationInfo'.default.iArmor);
    ne_iArmorCap.SetValue(class'BallisticReplicationInfo'.default.iArmorCap);
    fe_MaxFallSpeed.SetValue(class'BallisticReplicationInfo'.default.MaxFallSpeed);
}

function DefaultSettings()
{
    ne_playerHealth.SetValue(100);
    ne_playerHealthCap.SetValue(100);
    ne_playerSuperHealthCap.SetValue(150);
    ne_iAdrenaline.SetValue(0);
    ne_iAdrenalineCap.SetValue(100);
    fe_dieSoundAmplifier.SetValue(6.5);
    fe_dieSoundRangeAmplifier.SetValue(1.0);
    fe_hitSoundAmplifier.SetValue(8.0);
    fe_hitSoundRangeAmplifier.SetValue(1.5);
    fe_jumpDamageAmplifier.SetValue(80);
    fe_footStepAmplifier.SetValue(1.5);
    ne_iArmor.SetValue(100);
    ne_iArmorCap.SetValue(100);
    fe_MaxFallSpeed.SetValue(800);
}

function SaveSettings()
{
    if (!bInitialized)
        return;

    class'BallisticReplicationInfo'.default.playerHealth    = ne_playerHealth.GetValue();
    class'BallisticReplicationInfo'.default.playerHealthCap = ne_playerHealthCap.GetValue();
    class'BallisticReplicationInfo'.default.playerSuperHealthCap = ne_playerSuperHealthCap.GetValue();
    class'BallisticReplicationInfo'.default.iAdrenaline = ne_iAdrenaline.GetValue();
    class'BallisticReplicationInfo'.default.iAdrenalineCap = ne_iAdrenalineCap.GetValue();
    class'BallisticReplicationInfo'.default.dieSoundAmplifier = fe_dieSoundAmplifier.GetValue();
    class'BallisticReplicationInfo'.default.dieSoundRangeAmplifier = fe_dieSoundRangeAmplifier.GetValue();
    class'BallisticReplicationInfo'.default.hitSoundAmplifier = fe_hitSoundAmplifier.GetValue();
    class'BallisticReplicationInfo'.default.hitSoundRangeAmplifier = fe_hitSoundRangeAmplifier.GetValue();
    class'BallisticReplicationInfo'.default.jumpDamageAmplifier = fe_jumpDamageAmplifier.GetValue();
    class'BallisticReplicationInfo'.default.iArmor = ne_iArmor.GetValue();
    class'BallisticReplicationInfo'.default.iArmorCap = ne_iArmorCap.GetValue();
    class'BallisticReplicationInfo'.default.MaxFallSpeed = fe_MaxFallSpeed.GetValue();
    class'Mut_Ballistic'.default.footstepAmplifier = fe_footStepAmplifier.GetValue();

    class'BallisticReplicationInfo'.static.StaticSaveConfig();
    class'Mut_Ballistic'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moNumericEdit Name=ne_playerHealthEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Starting Health:"
         OnCreateComponent=ne_playerHealthEdit.InternalOnCreateComponent
         Hint="The Health Players spawn with."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_playerHealth=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_playerHealthEdit'

     Begin Object Class=moNumericEdit Name=ne_playerHealthCapEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Health Cap:"
         OnCreateComponent=ne_playerHealthEdit.InternalOnCreateComponent
         Hint="The Players Health cap."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_playerHealthCap=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_playerHealthCapEdit'

     Begin Object Class=moNumericEdit Name=ne_playerSuperHealthCapEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Super Health Cap:"
         OnCreateComponent=ne_playerHealthEdit.InternalOnCreateComponent
         Hint="The Super Health cap."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_playerSuperHealthCap=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_playerSuperHealthCapEdit'

	 Begin Object Class=moNumericEdit Name=ne_iArmorC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Starting Armour:"
         OnCreateComponent=ne_iArmorC.InternalOnCreateComponent
         Hint="The Armour Players Spawn with."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iArmor=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_iArmorC'

     Begin Object Class=moNumericEdit Name=ne_iArmorCapC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Armour Cap:"
         OnCreateComponent=ne_iArmorCapC.InternalOnCreateComponent
         Hint="The Armour Cap."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iArmorCap=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_iArmorCapC'

     Begin Object Class=moNumericEdit Name=ne_iAdrenalineC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Starting Adrenaline:"
         OnCreateComponent=ne_iAdrenalineC.InternalOnCreateComponent
         Hint="The adrenaline players spawn with."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iAdrenaline=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_iAdrenalineC'

     Begin Object Class=moNumericEdit Name=ne_iAdrenalineCapC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline Cap:"
         OnCreateComponent=ne_iAdrenalineCapC.InternalOnCreateComponent
         Hint="The adrenaline cap."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iAdrenalineCap=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_iAdrenalineCapC'

     Begin Object Class=moFloatEdit Name=fe_dieSoundAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Death Sound Amplifier:"
         OnCreateComponent=fe_dieSoundAmplifierC.InternalOnCreateComponent
         Hint="The Death Sound Amplifier."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_dieSoundAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_dieSoundAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_dieSoundRangeAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Death Sound Range Amplifier:"
         OnCreateComponent=fe_dieSoundRangeAmplifierC.InternalOnCreateComponent
         Hint="The Death Sound Range Amplifier."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_dieSoundRangeAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_dieSoundRangeAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_hitSoundAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Player Impact Sound Amplifier:"
         OnCreateComponent=fe_hitSoundAmplifierC.InternalOnCreateComponent
         Hint="The Hit Sound Amplifier."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_hitSoundAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_hitSoundAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_hitSoundRangeAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Player Impact Sound Range Amplifier:"
         OnCreateComponent=fe_hitSoundRangeAmplifierC.InternalOnCreateComponent
         Hint="The Hit Sound Range Amplifier."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_hitSoundRangeAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_hitSoundRangeAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_footStepAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Footstep sound Amplifier:"
         OnCreateComponent=fe_footStepAmplifierC.InternalOnCreateComponent
         Hint="The Footstep Sound Amplifier."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_footStepAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_footStepAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_jumpDamageAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Jump Damage Amplifier:"
         OnCreateComponent=fe_jumpDamageAmplifierC.InternalOnCreateComponent
         Hint="The damage amplifier when you jump on other players or actors."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_jumpDamageAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_jumpDamageAmplifierC'


     Begin Object Class=moFloatEdit Name=fe_MaxFallSpeedC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Falling damage beyond speed:"
         OnCreateComponent=fe_MaxFallSpeedC.InternalOnCreateComponent
         Hint="Max speed players can land without taking damage (also limits what paths bots can use!)."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_MaxFallSpeed=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_MaxFallSpeedC'

}
