//=============================================================================
// ConfigTab_Blood.
//
// Settings for the Ballistic blood and gore system
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Blood extends ConfigTabBase;

var automated moCheckbox	ch_BloodDrags, ch_BloodImpacts, ch_BloodPools, ch_BloodSplats, ch_BloodExplodes, ch_BloodFX, ch_Stmups, ch_Chunks, ch_ScreenFX;
var automated moFloatEdit	fl_BloodTimeScale;
var automated moSlider		sl_GibMulti;

function LoadSettings()
{
	ch_BloodDrags.Checked(class'BWBloodControl'.default.bUseBloodDrags);
	ch_BloodImpacts.Checked(class'BWBloodControl'.default.bUseBloodImpacts);
	ch_BloodPools.Checked(class'BWBloodControl'.default.bUseBloodPools);
	ch_BloodSplats.Checked(class'BloodManager'.default.bUseBloodSplats);
	ch_BloodExplodes.Checked(class'BloodManager'.default.bUseBloodExplodes);
	fl_BloodTimeScale.SetValue(class'AD_BloodDecal'.default.StayScale);
	ch_BloodFX.Checked(class'BloodManager'.default.bUseBloodEffects);
	ch_Stmups.Checked(class'BloodManager'.default.bUseStumps);
	ch_Chunks.Checked(class'BloodManager'.default.bUseChunks);
	ch_ScreenFX.Checked(class'BloodManager'.default.bUseScreenFX);
	sl_GibMulti.SetValue(class'BloodManager'.default.GibMultiplier);	
	
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'BWBloodControl'.default.bUseBloodDrags 	= ch_BloodDrags.IsChecked();
	class'BWBloodControl'.default.bUseBloodImpacts 	= ch_BloodImpacts.IsChecked();
	class'BWBloodControl'.default.bUseBloodPools 	= ch_BloodPools.IsChecked();
	class'BloodManager'.default.bUseBloodSplats 	= ch_BloodSplats.IsChecked();
	class'BallisticGib'.default.bUseBloodSplats 	= ch_BloodSplats.IsChecked();
	class'BloodManager'.default.bUseBloodExplodes 	= ch_BloodExplodes.IsChecked();
	class'AD_BloodDecal'.default.StayScale			= fl_BloodTimeScale.GetValue();
	class'BloodManager'.default.bUseBloodEffects	= ch_BloodFX.IsChecked();
	class'BloodManager'.default.bUseStumps			= ch_Stmups.IsChecked();
	class'BloodManager'.default.bUseChunks			= ch_Chunks.IsChecked();
	class'BloodManager'.default.bUseScreenFX		= ch_ScreenFX.IsChecked();	
	class'BloodManager'.default.GibMultiplier		= sl_GibMulti.GetValue();

	class'BWBloodControl'.static.StaticSaveConfig();
	class'BloodManager'.static.StaticSaveConfig();
	class'BallisticGib'.static.StaticSaveConfig();
	class'AD_BloodDecal'.static.StaticSaveConfig();
	class'mut_Ballistic'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	ch_BloodDrags.Checked(true);
	ch_BloodImpacts.Checked(true);
	ch_BloodPools.Checked(true);
	ch_BloodSplats.Checked(true);
	ch_BloodExplodes.Checked(true);
	fl_BloodTimeScale.SetValue(1.0);
	//Radeon
	ch_BloodFX.Checked(false);
	ch_Stmups.Checked(true);
	ch_Chunks.Checked(true);
	ch_ScreenFX.Checked(false);
	sl_GibMulti.SetValue(1);
}

defaultproperties
{
	 Begin Object Class=moCheckBox Name=ch_BloodFXCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Blood Particle Effects"
         OnCreateComponent=ch_BloodFXCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles blood effects when damaging players."
         WinTop=0.10000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodFX=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_BloodFXCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_BloodDragsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Cadaver Drag Trails"
         OnCreateComponent=ch_BloodDragsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles dead bodies leaving blood trails when they slide across surfaces."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodDrags=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_BloodDragsCheck'

     Begin Object Class=moCheckBox Name=ch_BloodImpactsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Corpse Impact Blood"
         OnCreateComponent=ch_BloodImpactsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles blood marks caused by bodies impacting with surfaces at high speed."
         WinTop=0.20000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodImpacts=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_BloodImpactsCheck'

     Begin Object Class=moCheckBox Name=ch_BloodPoolsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Blood Pools"
         OnCreateComponent=ch_BloodPoolsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles dead bodies leaving pools when they are stationary."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodPools=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_BloodPoolsCheck'

     Begin Object Class=moCheckBox Name=ch_BloodSplatsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Injury Blood Marks"
         OnCreateComponent=ch_BloodSplatsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles blood spatter marks appearing on surfaces when players are damaged."
         WinTop=0.30000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodSplats=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_BloodSplatsCheck'

     Begin Object Class=moCheckBox Name=ch_BloodExplodesCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Explosion Blood"
         OnCreateComponent=ch_BloodExplodesCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles horrendous blood effects when players are blown up."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodExplodes=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_BloodExplodesCheck'

     Begin Object Class=moCheckBox Name=ch_ChunksCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Gore Chunks"
         OnCreateComponent=ch_ChunksCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles gibs for dismemberment."
         WinTop=0.40000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_Chunks=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_ChunksCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_StmupsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Sever Stumps"
         OnCreateComponent=ch_StmupsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles spawning of stumps on severed limbs."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_Stmups=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_StmupsCheck'

     Begin Object Class=moCheckBox Name=ch_ScreenFXCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Screen Blood"
         OnCreateComponent=ch_ScreenFXCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles blood splashes and effects applied to the screen."
         WinTop=0.50000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ScreenFX=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_ScreenFXCheck'

     Begin Object Class=moFloatEdit Name=fl_BloodTimeScaleFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Blood Stay Scale [!]"
         OnCreateComponent=fl_BloodTimeScaleFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of blood effects. 0 = Forever."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_BloodTimeScale=moFloatEdit'BallisticProV55.ConfigTab_Blood.fl_BloodTimeScaleFloat'

     Begin Object Class=moSlider Name=sl_GibMultiSlider
         MaxValue=20.000000
         bIntSlider=True
         Caption="Gib Multiplier [!]"
         OnCreateComponent=sl_GibMultiSlider.InternalOnCreateComponent
         Hint="Multiplies number of gibs spawned. 1 = Normal, 0 = None. WARNING: Higher than 1 may kill performance!"
         WinTop=0.60000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_GibMulti=moSlider'BallisticProV55.ConfigTab_Blood.sl_GibMultiSlider'

}
