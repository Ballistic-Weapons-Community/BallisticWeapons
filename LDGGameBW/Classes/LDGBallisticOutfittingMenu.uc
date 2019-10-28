class LDGBallisticOutfittingMenu extends BallisticOutfittingMenu;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super(UT2K4GUIPage).Initcomponent(MyController, MyOwner);

	MyHeader.DockedTabs = c_Tabs;
	p_Weapons = BallisticOutfittingWeaponsTab(c_Tabs.AddTab(WeaponsTabLabel, "BallisticProV55.BallisticOutfittingWeaponsTab",,WeaponsTabHint));
	p_Killstreaks = LDGBallisticOutfittingKillstreaksTab(c_Tabs.AddTab(KillstreaksTabLabel, "LDGGameBW.LDGBallisticOutfittingKillstreaksTab",,KillstreaksTabHint));
}

defaultproperties
{
}
