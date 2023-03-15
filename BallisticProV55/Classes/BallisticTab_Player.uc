//=============================================================================
// BallisticTab_Player.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticTab_Player extends UT2K4TabPanel;

var automated moNumericEdit     ne_playerHealth;			//Starting Health
var automated moNumericEdit     ne_playerHealthCap;			//Health Cap
var automated moNumericEdit     ne_playerSuperHealthCap;	//Super Health Cap
var automated moNumericEdit     ne_iAdrenaline;				//Starting Adrenaline
var automated moNumericEdit     ne_iAdrenalineCap;			//Adrenaline Cap
var automated moNumericEdit     ne_iArmor;					//Starting Armour
var automated moNumericEdit     ne_iArmorCap;	
//var automated moFloatEdit       fe_dieSoundAmplifier;		//Death Sound Amplification
//var automated moFloatEdit       fe_dieSoundRangeAmplifier;	//Death Sound Range Amplification
//var automated moFloatEdit       fe_hitSoundAmplifier;		//Damage Audio Sound Amplification
//var automated moFloatEdit       fe_hitSoundRangeAmplifier;	//Damage Audio Sound Range Amplification
//var automated moFloatEdit       fe_footStepAmplifier;		//Footstep Sound Amplification
//var automated moFloatEdit       fe_jumpDamageAmplifier;		//Jump & Dodge Sound Amplification			//ArmourCap
//var automated moFloatEdit       fe_MaxFallSpeed;			//Max Fall Speed

var BallisticConfigMenuPro         p_Anchor;
var bool                        bInitialized;

//==================================================================
// General Menu Code
//==================================================================

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

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle_Config> style;

	style = class'BallisticGameStyles'.static.GetConfigStyle();

	if (style == None)
	{
		Log("BallisticTab_Player: Couldn't find a configurable style for index " $ class'BallisticGameStyles'.default.CurrentConfigStyle);
		return;
	}

	ne_playerHealth.SetValue(style.default.PlayerHealth);
    ne_playerHealthCap.SetValue(style.default.PlayerHealthMax);
    ne_playerSuperHealthCap.SetValue(style.default.PlayerSuperHealthMax);

    ne_iArmor.SetValue(style.default.PlayerShield);
    ne_iArmorCap.SetValue(style.default.PlayerShieldMax);
}

function DefaultSettings()
{
	ne_playerHealth.SetValue(100);
    ne_playerHealthCap.SetValue(100);
    ne_playerSuperHealthCap.SetValue(200);
    ne_iArmor.SetValue(100);
    ne_iArmorCap.SetValue(200);
    //fe_MaxFallSpeed.SetValue(800);
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> style;

    if (!bInitialized)
        return;

	style = class<BC_GameStyle_Config>(class'BallisticGameStyles'.static.GetConfigStyle());

	if (style == None)
	{
		Log("BallisticTab_Player: Couldn't find a configurable style for index " $ class'BallisticGameStyles'.default.CurrentConfigStyle);
		return;
	}

	style.default.class.default.PlayerHealth    		= ne_playerHealth.GetValue();
    style.default.class.default.PlayerHealthMax 		= ne_playerHealthCap.GetValue();
    style.default.class.default.PlayerSuperHealthMax	= ne_playerSuperHealthCap.GetValue();
    style.default.class.default.PlayerShield 			= ne_iArmor.GetValue();
    style.default.class.default.PlayerShieldMax			= ne_iArmorCap.GetValue();

    style.default.class.default.StaticSaveConfig();
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
         WinTop=0.100000
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
         WinTop=0.150000
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
         WinTop=0.200000
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
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iArmor=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_iArmorC'

     Begin Object Class=moNumericEdit Name=ne_iArmorCapC
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Armour Cap:"
         OnCreateComponent=ne_iArmorCapC.InternalOnCreateComponent
         Hint="The Armour Cap."
         WinTop=0.300000
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
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iAdrenaline=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_iAdrenalineC'

     Begin Object Class=moNumericEdit Name=ne_iAdrenalineCapC
         MinValue=50
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Adrenaline Cap:"
         OnCreateComponent=ne_iAdrenalineCapC.InternalOnCreateComponent
         Hint="The adrenaline cap."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_iAdrenalineCap=moNumericEdit'BallisticProV55.BallisticTab_Player.ne_iAdrenalineCapC'

/*

     Begin Object Class=moFloatEdit Name=fe_dieSoundAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Death Sound Amplifier:"
         OnCreateComponent=fe_dieSoundAmplifierC.InternalOnCreateComponent
         Hint="The Death Sound Amplifier."
         WinTop=0.450000
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
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_dieSoundRangeAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_dieSoundRangeAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_hitSoundAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Hit Sound Amplifier:"
         OnCreateComponent=fe_hitSoundAmplifierC.InternalOnCreateComponent
         Hint="The Hit Sound Amplifier."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_hitSoundAmplifier=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_hitSoundAmplifierC'

     Begin Object Class=moFloatEdit Name=fe_hitSoundRangeAmplifierC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Hit Sound Range Amplifier:"
         OnCreateComponent=fe_hitSoundRangeAmplifierC.InternalOnCreateComponent
         Hint="The Player Hit Sound Range Amplifier."
         WinTop=0.600000
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
         WinTop=0.650000
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
         WinTop=0.700000
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
         WinTop=0.750000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_MaxFallSpeed=moFloatEdit'BallisticProV55.BallisticTab_Player.fe_MaxFallSpeedC'
	*/
}
