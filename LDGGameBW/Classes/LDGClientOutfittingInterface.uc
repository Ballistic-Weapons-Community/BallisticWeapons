class LDGClientOutfittingInterface extends ClientOutfittingInterface;

simulated function ClientOpenLoadoutMenu()
{
	if (PC ==None || PC.Player == None)
		return;
	PC.ClientOpenMenu ("LDGGameBW.LDGBallisticOutfittingMenu");
	if (PC.Player.GUIController != None)
		BallisticOutfittingMenu(GUIController(PC.Player.GUIController).ActivePage).SetupCOI(self);		
}

defaultproperties
{
}
