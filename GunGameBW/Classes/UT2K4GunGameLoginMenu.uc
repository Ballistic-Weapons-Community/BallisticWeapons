class UT2K4GunGameLoginMenu extends UT2K4PlayerLoginMenu;

function AddPanels()
{
	Panels[0].ClassName = "GunGameBW.UT2K4Tab_PlayerLoginControlsGunGame";
	Super.AddPanels();
}

defaultproperties
{
}
