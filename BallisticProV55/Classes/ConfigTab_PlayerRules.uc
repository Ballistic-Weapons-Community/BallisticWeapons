//=============================================================================
// ConfigTab_PlayerRules.
//
// by Paul "Grum" Haack and Azarael
//=============================================================================
class ConfigTab_PlayerRules extends ConfigTabBase;

var automated moNumericEdit     ne_StartingHealth;			//Starting Health
var automated moNumericEdit     ne_PlayerHealthMax;			//Health Cap
var automated moNumericEdit     ne_PlayerSuperHealthMax;	//Super Health Cap
var automated moCheckbox		ch_HealthRegen;					//Enables Health Regen
var automated moNumericEdit		ne_HeathKillReward;		//HP Reward
var automated moNumericEdit		ne_KillRewardHealthMax;			//HP Reward Cap

var automated moNumericEdit     ne_StartingShield;					//Starting Armour
var automated moNumericEdit     ne_PlayerShieldMax;	
var automated moCheckbox		ch_ShieldRegen;				//Enables Shield Regen
var automated moNumericEdit 	ne_ShieldKillReward;				//Armour Reward
var automated moNumericEdit 	ne_KillRewardShieldMax;			//Armour Reward Cap

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle_Config> game_style;

	game_style = BaseMenu.GetConfigStyle();

	if (game_style != None)
	{
		ne_StartingHealth.SetValue(game_style.default.StartingHealth);
		ne_PlayerHealthMax.SetValue(game_style.default.PlayerHealthMax);
		ne_PlayerSuperHealthMax.SetValue(game_style.default.PlayerSuperHealthMax);
		ch_HealthRegen.Checked(game_style.default.bHealthRegeneration);
		ne_HeathKillReward.SetValue(game_style.default.HealthKillReward);
    	ne_KillRewardHealthMax.SetValue(game_style.default.KillRewardHealthMax);

		ne_StartingShield.SetValue(game_style.default.StartingShield);
		ne_PlayerShieldMax.SetValue(game_style.default.PlayerShieldMax);
		ch_ShieldRegen.Checked(game_style.default.bShieldRegeneration);
    	ne_ShieldKillReward.SetValue(game_style.default.ShieldKillReward);
    	ne_KillRewardShieldMax.SetValue(game_style.default.KillRewardShieldMax);
	}
}

function DefaultSettings()
{
	ne_StartingHealth.SetValue(100);
    ne_PlayerHealthMax.SetValue(100);
    ne_PlayerSuperHealthMax.SetValue(199);
	ch_HealthRegen.Checked(false);
	ne_HeathKillReward.SetValue(0);
    ne_KillRewardHealthMax.SetValue(0);

    ne_StartingShield.SetValue(0);
    ne_PlayerShieldMax.SetValue(150);
	ch_ShieldRegen.Checked(false);
    ne_ShieldKillReward.SetValue(0);
    ne_KillRewardShieldMax.SetValue(0);
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> game_style;

    if (!bInitialized)
        return;

	game_style = BaseMenu.GetConfigStyle();

	if (game_style != None)
	{
		game_style.default.StartingHealth    	= ne_StartingHealth.GetValue();
		game_style.default.PlayerHealthMax 		= ne_PlayerHealthMax.GetValue();
		game_style.default.PlayerSuperHealthMax	= ne_PlayerSuperHealthMax.GetValue();
		game_style.default.bHealthRegeneration	= ch_HealthRegen.IsChecked();
		game_style.default.HealthKillReward  	= ne_HeathKillReward.GetValue();
		game_style.default.KillRewardHealthMax 	= ne_KillRewardHealthMax.GetValue();

		game_style.default.StartingShield 		= ne_StartingShield.GetValue();
		game_style.default.PlayerShieldMax		= ne_PlayerShieldMax.GetValue();
		game_style.default.bShieldRegeneration	= ch_ShieldRegen.IsChecked();
		game_style.default.ShieldKillReward 		= ne_ShieldKillReward.GetValue();
		game_style.default.KillRewardShieldMax 	= ne_KillRewardShieldMax.GetValue();

		game_style.static.StaticSaveConfig();
	}
}

defaultproperties
{ 
	 Begin Object Class=moNumericEdit Name=ne_StartingHealthEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Starting Health"
         OnCreateComponent=ne_StartingHealthEdit.InternalOnCreateComponent
         Hint="Health value assigned to players on spawn."
         WinTop=0.10000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_StartingHealth=moNumericEdit'ne_StartingHealthEdit'

     Begin Object Class=moNumericEdit Name=ne_PlayerHealthMaxEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Health Cap"
         OnCreateComponent=ne_StartingHealthEdit.InternalOnCreateComponent
         Hint="Maximum health a player may have, without overhealing."
         WinTop=0.15000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_PlayerHealthMax=moNumericEdit'ne_PlayerHealthMaxEdit'

     Begin Object Class=moNumericEdit Name=ne_PlayerSuperHealthMaxEdit
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Super Health Cap"
         OnCreateComponent=ne_StartingHealthEdit.InternalOnCreateComponent
         Hint="Maximum health a player may have, with overhealing."
         WinTop=0.20000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_PlayerSuperHealthMax=moNumericEdit'ne_PlayerSuperHealthMaxEdit'

	Begin Object Class=moCheckBox Name=ch_HealthRegenCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Health Regeneration"
         OnCreateComponent=ch_HealthRegenCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables health regeneration."
         WinTop=0.25000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_HealthRegen=moCheckBox'ch_HealthRegenCheck'
	 
	 Begin Object Class=moNumericEdit Name=ne_HeathKillRewardE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Health Kill Reward"
         OnCreateComponent=ne_HeathKillRewardE.InternalOnCreateComponent
         Hint="Health received for killing an enemy."
         WinTop=0.3000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_HeathKillReward=moNumericEdit'ne_HeathKillRewardE'

     Begin Object Class=moNumericEdit Name=ne_KillRewardHealthMaxE
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Health Kill Reward Cap"
         OnCreateComponent=ne_KillRewardHealthMaxE.InternalOnCreateComponent
         Hint="The maximum health value that can be reached through health kill rewards. 0 uses the player's maximum health value."
         WinTop=0.35000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_KillRewardHealthMax=moNumericEdit'ne_KillRewardHealthMaxE'

	 Begin Object Class=moNumericEdit Name=ne_StartingShieldC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Starting Shields"
         OnCreateComponent=ne_StartingShieldC.InternalOnCreateComponent
         Hint="Shield value assigned to players on spawn."
         WinTop=0.45000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_StartingShield=moNumericEdit'ne_StartingShieldC'

     Begin Object Class=moNumericEdit Name=ne_PlayerShieldMaxC
         MinValue=1
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Shield Cap"
         OnCreateComponent=ne_PlayerShieldMaxC.InternalOnCreateComponent
         Hint="Maximum shield value a player may have."
         WinTop=0.5000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_PlayerShieldMax=moNumericEdit'ne_PlayerShieldMaxC'

	Begin Object Class=moCheckBox Name=ch_ShieldRegenCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Shield Regeneration"
         OnCreateComponent=ch_ShieldRegenCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables shield regeneration."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ShieldRegen=moCheckBox'ch_ShieldRegenCheck'

	 Begin Object Class=moNumericEdit Name=ne_ShieldKillRewardC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Shield Kill Reward"
         OnCreateComponent=ne_ShieldKillRewardC.InternalOnCreateComponent
         Hint="Shields received for killing an enemy."
         WinTop=0.60000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_ShieldKillReward=moNumericEdit'ne_ShieldKillRewardC'

     Begin Object Class=moNumericEdit Name=ne_KillRewardShieldMaxC
         MinValue=0
         MaxValue=999
         ComponentWidth=0.175000
         Caption="Shield Kill Reward Cap"
         OnCreateComponent=ne_KillRewardShieldMaxC.InternalOnCreateComponent
         Hint="The maximum shield value that can be reached through shield kill rewards. 0 uses the player's maximum shield value."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_KillRewardShieldMax=moNumericEdit'ne_KillRewardShieldMaxC'
}
