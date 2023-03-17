class BallisticProInteractions extends Interaction
config(User);

var config bool bShowTabOnInit;

var config EInputKey ADSKey;
var config EInputKey ReloadKey;
var config EInputKey WpnSpcKey;
var config EInputKey SprintKey;
var config EInputKey DualSelectKey;
var config EInputKey FireModeKey;
var config EInputKey LoadoutKey;
var config EInputKey StreakKey;
var config EInputKey MeleeKey;
var config EInputKey PreferencesKey;
var config bool bADSKeyEnabled, bReloadKeyEnabled, bWpnSpcKeyEnabled, bSprintKeyEnabled, bFireModeKeyEnabled, bDualSelectKeyEnabled, bLoadoutKeyEnabled, bStreakKeyEnabled, bMeleeKeyEnabled, bPreferencesKeyEnabled;

var localized string MenuName;
var localized string MenuHelp;
var localized string ConfigBWText;

var bool bScopeIsUp, bSprinting, bReloading, bUsingSpecial, bSwitchingFireMode, bStreakKeyHeld, bMeleeKeyHeld;

// Needed so that we don't call ModifyMenu again even when when it already added the new tab.
var private editconst bool bMenuModified;

event Initialized()
{	
	local UT2K4PlayerLoginMenu Menu;
			
	if (default.bShowTabOnInit)
	{
		if (!GUIController(ViewportOwner.Actor.Player.GUIController).OpenMenu(UnrealPlayer(ViewportOwner.Actor).LoginMenuClass))
			return;
		
		if(!bMenuModified)
			ModifyMenu();
		
		Menu = UT2K4PlayerLoginMenu(GUIController(ViewportOwner.Actor.Player.GUIController).FindPersistentMenuByName( UnrealPlayer(ViewportOwner.Actor).LoginMenuClass ));
		if( Menu != none )
		{
			Menu.c_Main.ActivateTabByName(MenuName, true);
			
			class'BallisticProInteractions'.default.bShowTabOnInit = false;
			class'BallisticProInteractions'.static.StaticSaveConfig();
			
			GUIController(ViewportOwner.Actor.Player.GUIController).OpenMenu("GUI2K4.GUI2K4QuestionPage");
			GUIQuestionPage(GUIController(ViewportOwner.Actor.Player.GUIController).TopPage()).SetupQuestion(ConfigBWText, 1, 1);
		}
	}
}

final private function ModifyMenu()
{
   local UT2K4PlayerLoginMenu Menu;
   local GUITabPanel Panel;

   // Try get the menu, will return none if the menu is not open!.
   Menu = UT2K4PlayerLoginMenu(GUIController(ViewportOwner.Actor.Player.GUIController).FindPersistentMenuByName( UnrealPlayer(ViewportOwner.Actor).LoginMenuClass ));
   if( Menu != none )
   {
		log("BWInteractions3: Menu found");
      // You can use the panel reference to do the modifications to the tab etc.
     Panel = Menu.c_Main.AddTab(MenuName, string( class'BallisticProMenuPanel' ),, MenuHelp);
      bMenuModified = true;

      // Uncomment if tick is not needed for anything else than ModifyMenu.
      Disable('Tick');
      bRequiresTick = false;
   }
}

function Tick( float DeltaTime )
{
   if( !bMenuModified )
      ModifyMenu();
}

function bool KeyEvent(EInputKey Key, EInputAction Action, FLOAT Delta )
{
   if (ViewPortOwner.Actor.Pawn == None && Key != class'BallisticProInteractions'.default.LoadoutKey)
      return Super.KeyEvent(Key,Action,Delta);
      
   else
   {
      if ((Action == IST_Press) && bADSKeyEnabled && (Key == class'BallisticProInteractions'.default.ADSKey))
	{
	if (bScopeIsUp == False)
		{
        	ConsoleCommand("ScopeView");
		bScopeIsUp=True;
		}
	return true;
	}
	
      else if ((Action == IST_Release) && bADSKeyEnabled && (Key == class'BallisticProInteractions'.default.ADSKey))
	{
		if (bScopeIsUp == True)
		{
			ConsoleCommand("ScopeViewRelease");
			bScopeIsUp=False;
		}
	return true;
	}
	
	else if ((Action == IST_Press) && bReloadKeyEnabled && (Key == class'BallisticProInteractions'.default.ReloadKey))
	{
		if (bReloading == False)
		{
			ConsoleCommand("Reload");
			bReloading = True;
		}
	return true;
	}
	
      else if ((Action == IST_Release) && bReloadKeyEnabled && (Key == class'BallisticProInteractions'.default.ReloadKey))
	{
		if (bReloading == True)
		{
			ConsoleCommand("ReloadRelease");
			bReloading = False;
		}
	return true;
	}
	else if ((Action == IST_Press) && bMeleeKeyEnabled && (Key == class'BallisticProInteractions'.default.MeleeKey))
	{
        if (bMeleeKeyHeld == False)
        {
			ConsoleCommand("MeleeHold");
			bMeleeKeyHeld = True;
		}
	return true;
	}
	
   else if ((Action == IST_Release) && bMeleeKeyEnabled && (Key == class'BallisticProInteractions'.default.MeleeKey))
	{
		if (bMeleeKeyHeld == True)
		{
	        	ConsoleCommand("MeleeRelease");
	        	bMeleeKeyHeld = False;
		}
	return true;
	}
	else if ((Action == IST_Press) && bLoadoutKeyEnabled && (Key == class'BallisticProInteractions'.default.LoadoutKey))
	{
		ConsoleCommand("Mutate Loadout");
		return true;
	}
	else if ((Action == IST_Press) && bPreferencesKeyEnabled && (Key == class'BallisticProInteractions'.default.PreferencesKey))
	{
		ConsoleCommand("Preferences");
		return true;
	}
      else if ((Action == IST_Press) && bDualSelectKeyEnabled && (Key == class'BallisticProInteractions'.default.DualSelectKey))
	{
        	ConsoleCommand("dualselect");
		return true;
	}
      else if ((Action == IST_Press) && bWpnSpcKeyEnabled && (Key == class'BallisticProInteractions'.default.WpnSpcKey))
	{
	if (bUsingSpecial == False)
		{
		ConsoleCommand("WeaponSpecial");
		bUsingSpecial=True;
		}
	return true;
	}
      else if ((Action == IST_Release) && bWpnSpcKeyEnabled && (Key == class'BallisticProInteractions'.default.WpnSpcKey))
	{
	if (bUsingSpecial == True)
		{
        	ConsoleCommand("WeaponSpecialRelease");
		bUsingSpecial=False;
		}
	return true;
	}
    else if ((Action == IST_Press) && bSprintKeyEnabled && (Key == class'BallisticProInteractions'.default.SprintKey))
	{
		if (bSprinting == False)
			{
	        	ConsoleCommand("Mutate BStartSprint");
			bSprinting=True;
			}
		return true;
	}
	
    else if ((Action == IST_Release) && bSprintKeyEnabled && (Key == class'BallisticProInteractions'.default.SprintKey))
	{
		if (bSprinting == True)
			{
			ConsoleCommand("Mutate BStopSprint");
			bSprinting=False;
			}
		return true;
	}

      else if ((Action == IST_Press) && bFireModeKeyEnabled && (Key == class'BallisticProInteractions'.default.FireModeKey))
	{
		if (bSwitchingFireMode == False)
		{
	        ConsoleCommand("SwitchWeaponMode");
			bSwitchingFireMode=True;
		}
		return true;
	}
    else if ((Action == IST_Release) && bFireModeKeyEnabled && (Key == class'BallisticProInteractions'.default.FireModeKey))
	{
		if (bSwitchingFireMode == True)
		{
			ConsoleCommand("WeaponModeRelease");
			bSwitchingFireMode=False;
		}
		return true;
	}
	
	else if ((Action == IST_Press) && bStreakKeyEnabled && (Key == class'BallisticProInteractions'.default.StreakKey))
	{
		if (bStreakKeyHeld == False)
		{
			ConsoleCommand("mutate Killstreak");
			bStreakKeyHeld = True;
		}
		return true;
	}
	
	else if ((Action == IST_Release) && bStreakKeyEnabled && (Key == class'BallisticProInteractions'.default.StreakKey))
	{
		bStreakKeyHeld = False;
		return true;
	}
   }
      
	return Super.KeyEvent(Key,Action,Delta);

}

//remove myself if level changed
event NotifyLevelChange()
{
	local UT2K4PlayerLoginMenu LoginMenu;
	
	//remove the tab
	foreach AllObjects(class'UT2K4PlayerLoginMenu', LoginMenu)
		LoginMenu.c_Main.RemoveTab(MenuName);

   Master.RemoveInteraction(self);
}

defaultproperties
{
     bShowTabOnInit=True
     ADSKey=IK_Shift
     ReloadKey=IK_J
     WpnSpcKey=IK_K
     SprintKey=IK_H
     DualSelectKey=IK_L
     FireModeKey=IK_P
     LoadoutKey=IK_O
     StreakKey=IK_I
     MeleeKey=IK_N
	 PreferencesKey=IK_M
     bADSKeyEnabled=True
     bReloadKeyEnabled=True
     bWpnSpcKeyEnabled=True
     bSprintKeyEnabled=True
     bFireModeKeyEnabled=True
     bDualSelectKeyEnabled=True
     bLoadoutKeyEnabled=True
     bStreakKeyEnabled=True
     bMeleeKeyEnabled=True
	 bPreferencesKeyEnabled=True
     MenuName="Ballistic Binds"
     MenuHelp="Ballistic Bind Menu"
     ConfigBWText="Please set Ballistic Weapons keys. Keys set affect this server only and do not overwrite."
     bVisible=True
     bRequiresTick=True
}
