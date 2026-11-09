//=============================================================================
// ConfigTab_Blood.
//
// Settings for the Ballistic blood and gore system
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Blood extends ConfigTabBase;

var automated moCheckbox	ch_BloodDrags, ch_BloodImpacts, ch_BloodPools, ch_BloodSplats, ch_BloodExplodes, ch_BloodFX, ch_Stmups, ch_Chunks, ch_ScreenFX, ch_GibbableCorpses;
var automated moFloatEdit	fl_BloodTimeScale;
var automated moSlider		sl_GibMulti;
var automated BWMenuSection	i_Blood, i_Gore, i_Heavy;	// titled boxes round the rows

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

	SectionRow(i_Blood, ch_BloodFX);
	SectionRow(i_Blood, ch_BloodDrags);
	SectionRow(i_Blood, ch_BloodImpacts);
	SectionRow(i_Blood, ch_BloodPools);
	SectionRow(i_Blood, ch_BloodSplats);
	SectionRow(i_Blood, ch_BloodExplodes);
	SectionRow(i_Blood, ch_ScreenFX);
	SectionRow(i_Gore, ch_Chunks);
	SectionRow(i_Gore, ch_Stmups);
	SectionRow(i_Gore, ch_GibbableCorpses);
	SectionRow(i_Heavy, fl_BloodTimeScale);
	SectionRow(i_Heavy, sl_GibMulti);
}

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
	ch_GibbableCorpses.Checked(class'BloodManager'.default.bGibbableCorpses);
	
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
	class'BloodManager'.default.bGibbableCorpses	= ch_GibbableCorpses.IsChecked();

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
	ch_GibbableCorpses.Checked(true);
}

defaultproperties
{
	Begin Object Class=BWMenuSection Name=BloodSection
		Caption="Blood"
		WinTop=0.030000
		WinLeft=0.015000
		WinWidth=0.475000
		WinHeight=0.556000
	End Object
	i_Blood=BWMenuSection'BallisticProV55.ConfigTab_Blood.BloodSection'

	Begin Object Class=BWMenuSection Name=GoreSection
		Caption="Gore"
		WinTop=0.030000
		WinLeft=0.510000
		WinWidth=0.475000
		WinHeight=0.304000
	End Object
	i_Gore=BWMenuSection'BallisticProV55.ConfigTab_Blood.GoreSection'

	Begin Object Class=BWMenuSection Name=HeavySection
		Caption="Heavy On Performance"
		WinTop=0.360000
		WinLeft=0.510000
		WinWidth=0.475000
		WinHeight=0.241000
	End Object
	i_Heavy=BWMenuSection'BallisticProV55.ConfigTab_Blood.HeavySection'


	 Begin Object Class=moCheckBox Name=ch_BloodFXCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Blood Particle Effects"
         OnCreateComponent=ch_BloodFXCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles blood effects when damaging players."
         WinTop=0.130000
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
         WinTop=0.180000
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
         WinTop=0.230000
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
         WinTop=0.280000
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
         WinTop=0.330000
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
         WinTop=0.380000
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
         WinTop=0.550000
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
         WinTop=0.600000
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
         WinTop=0.430000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ScreenFX=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_ScreenFXCheck'

     Begin Object Class=moFloatEdit Name=fl_BloodTimeScaleFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Blood Stay Time Scale"
         OnCreateComponent=fl_BloodTimeScaleFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of blood effects. 0 = Forever."
         WinTop=0.770000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_BloodTimeScale=moFloatEdit'BallisticProV55.ConfigTab_Blood.fl_BloodTimeScaleFloat'

     Begin Object Class=moCheckBox Name=ch_GibbableCorpsesCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Gibbable Corpses"
         OnCreateComponent=ch_GibbableCorpsesCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles whether corpses can be gibbed."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_GibbableCorpses=moCheckBox'BallisticProV55.ConfigTab_Blood.ch_GibbableCorpsesCheck'

     Begin Object Class=moSlider Name=sl_GibMultiSlider
         MaxValue=20.000000
         bIntSlider=True
         Caption="Gib Amount"
         OnCreateComponent=sl_GibMultiSlider.InternalOnCreateComponent
         Hint="Multiplies number of gibs spawned. 1 = Normal, 0 = None. WARNING: Higher than 1 may kill performance!"
         WinTop=0.820000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_GibMulti=moSlider'BallisticProV55.ConfigTab_Blood.sl_GibMultiSlider'
}
