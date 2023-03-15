//=====================================
// Additional Rules tab.
//
// Contains additional game rules for BallisticPro.
//=====================================

class BallisticTab_ProSettings extends UT2K4TabPanel;

var automated moFloatEdit 		fl_NadePct;
var automated moNumericEdit 	int_MaxInventoryCapacity;

var BallisticConfigMenuPro 		p_Anchor;

var bool 						bInitialized;

function InitComponent(GUIController myController, GUIComponent myOwner)
{
	Super.InitComponent(myController, myOwner);

	if(BallisticConfigMenuPro(Controller.ActivePage) != None)
		p_Anchor = BallisticConfigMenuPro(Controller.ActivePage);
}

function ShowPanel (bool bShow)
{
	super.ShowPanel(bShow);
	
	if(bInitialized)
		return;

	LoadSettings();

	bInitialized=True;
}

function LoadSettings()
{
	fl_NadePct.SetValue(class'Mut_BallisticSwap'.default.NadeReplacePercent);
	int_MaxInventoryCapacity.SetValue(class'BallisticWeapon'.default.MaxInventoryCapacity);
}

function SaveSettings()
{
	if(!bInitialized)
		return;

	class'Mut_BallisticSwap'.default.NadeReplacePercent = fl_NadePct.GetValue();
	class'BallisticWeapon'.default.MaxInventoryCapacity = int_MaxInventoryCapacity.GetValue();	

	class'Mut_BallisticSwap'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	fl_NadePct.SetValue(15);
	int_MaxInventoryCapacity.SetValue(0);	
}

defaultproperties
{
     Begin Object Class=moFloatEdit Name=fl_NadePctFloat
         MinValue=1.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Ammo to Grenades Swap %"
         OnCreateComponent=fl_NadePctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Percentage chance of replacing an ammo pickup with a grenade."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_NadePct=moFloatEdit'BallisticProV55.BallisticTab_ProSettings.fl_NadePctFloat'

     Begin Object Class=moNumericEdit Name=int_MaxWepsInt
         MinValue=0
         MaxValue=999
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Player Inventory Capacity"
         OnCreateComponent=int_MaxWepsInt.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the player's maximum inventory capacity. 0 is infinite."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     int_MaxInventoryCapacity=moNumericEdit'BallisticProV55.BallisticTab_ProSettings.int_MaxWepsInt'
}
