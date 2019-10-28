class Menu_Menu3SPN_LDG extends Menu_Menu3SPN;

var Menu_TabUTCompAMTAM UTCompTab;
var Menu_TabUTCompJukeboxAMTAM JukeboxTab;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super(UT2k3GUIPage).InitComponent(MyController, MyOwner);
	
	TabC = GUITabControl(Controls[2]);
	UTCompTab = Menu_TabUTCompAMTAM(TabC.AddTab("UTComp", string(class'Menu_TabUTCompAMTAM'),, "UTComp options", true));
	JukeboxTab = Menu_TabUTCompJukeboxAMTAM(TabC.AddTab("Jukebox", string(class'Menu_TabUTCompJukeboxAMTAM'),, "UTComp Jukebox", false));
  MiscTab = Menu_TabMisc(TabC.AddTab("Miscellaneous", "3SPNv3141BW.Menu_TabMisc",, "Miscellaneous player options", false));
  BSTab = Menu_TabBrightskins(TabC.AddTab("Brightskins & Models", "3SPNv3141BW.Menu_TabBrightskins",, "Brightskins configuration", false));

  if(PlayerOwner().Level.GRI.bTeamGame)
		AdminTab = Menu_TabTAMAdmin(TabC.AddTab("Admin", "3SPNv3141BW.Menu_TabTAMAdmin",, "Admin/Server configuration", false));
  else
		AdminTab = Menu_TabAMAdmin(TabC.AddTab("Admin", "3SPNv3141BW.Menu_TabAMAdmin",, "Admin/Server configuration", false));

  if(MiscTab == None)
		log("Could not open tab Menu_TabMisc", '3SPN');
  if(BSTab == None)
  
		log("Could not open tab Menu_TabBrightskins", '3SPN');
		
  if(AdminTab == None)
		log("Could not open tab Menu_TabAdmin", '3SPN');
}

defaultproperties
{
}
