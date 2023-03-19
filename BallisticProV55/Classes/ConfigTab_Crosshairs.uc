//=============================================================================
// ConfigTab_Crosshairs.
//
// This page is used to configure the Ballistic Weapons crosshairs.
// It includes:
// A list of all weapons that can have their crosshairs changed
// Seperate Sliders for the colors of both inner and outer crosshairs.
// Seperate Scale for both crosshairs
// Combo boxes to select the style of each crosshair
// Checkboxes for Old Crosshairs option and Universal Crosshair option
// Slider for Global Scaling and Crosshair expansion factor
// The crosshairs are visible in their actual in game size
// A changing screenshot is added to show crosshairs against different scenes
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Crosshairs extends ConfigTabBase;

var bool					bLoadInitialized;

var automated moSlider		sl_GlobalScale, sl_CrossGrow;
var automated moSlider		sl_Red1, sl_Green1, sl_Blue1, sl_Alpha1, sl_Size1, sl_Red2, sl_Green2, sl_Blue2, sl_Alpha2, sl_Size2;
var Automated GUIImage		Box_WeapList, Img_Cross1, Img_Cross2, Img_BackShot, Box_Shot, Box_Inner, Box_Outer;
var automated GUILabel   	l_WeaponsList, l_Inner, l_Outer;
var automated GUIListBox	lb_Weapons;
var automated GUIComboBox	cb_CrossList1, cb_CrossList2;

var() array<BallisticWeapon.NonDefCrosshairCfg>		Crosshairs;

function InitializeConfigTab()
{
	local array<CacheManager.WeaponRecord> Recs;
	local class<Weapon> Weap;
	local int i, j;
	local array<string> CHClassNames;
	local class<BallisticCrosshairPack>	CHClass;

	if (bLoadInitialized)
		return;

	class'CacheManager'.static.GetWeaponList(Recs);
	for (i=0;i<Recs.Length;i++)
	{
		Weap = None;
		// Tap into the BW weapon cache system to identify BallisticWeapons before loading them
		if (!class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			continue;
/*		if (!class'BC_WeaponInfoCache'.static.FindWeaponInfo(Recs[i].ClassName, WI))
		{
			Weap = class<Weapon>(DynamicLoadObject(Recs[i].ClassName, class'Class'));
			if (Weap != None)
				WI = class'BC_WeaponInfoCache'.static.AddWeaponInfo(Weap);
			else
				continue;
		}
		if (!WI.bIsBW)
			continue;
*/		if (Weap == None)
			Weap = class<Weapon>(DynamicLoadObject(Recs[i].ClassName, class'Class'));
		if (Weap != None)
			lb_Weapons.List.Add(Recs[i].FriendlyName, Weap);

//		Weap = class<BallisticWeapon>(DynamicLoadObject(Recs[i].ClassName, class'Class'));
//		if (Weap != None)
//			lb_Weapons.List.Add(Recs[i].FriendlyName, Weap);
	}
	class'BC_WeaponInfoCache'.static.EndSession();
	lb_Weapons.List.OnChange = InternalOnChange;

	PlayerOwner().GetAllInt("BCoreProV55.BallisticCrosshairPack", CHClassNames);
    for (i=0;i<CHClassNames.length;i++)
    {
    	CHClass = class<BallisticCrosshairPack>(DynamicLoadObject(CHClassNames[i],class'Class'));
    	if (CHClass != None)
		{
    		for (j=0;j<CHClass.default.Crosshairs.length;j++)
    		{
	    		cb_CrossList1.AddItem(CHClass.default.Crosshairs[j].FriendlyName, CHClass, string(j));
	    		cb_CrossList2.AddItem(CHClass.default.Crosshairs[j].FriendlyName, CHClass, string(j));
	    	}
		}
	}
	LoadSettings();
	bLoadInitialized = true;
}

// Load all settings
function LoadSettings()
{
	local int i;

	sl_GlobalScale.SetValue(class'HUD'.default.CrosshairScale);
	sl_CrossGrow.SetValue(class'BallisticWeapon'.default.NDCrosshairScaleFactor);

	for (i=0;i<lb_Weapons.List.Elements.Length;i++)
		Crosshairs[i] = class<BallisticWeapon>(lb_Weapons.List.Elements[i].ExtraData).default.NDCrosshairCfg;
	Crosshairs[i] = class'BallisticWeapon'.default.NDCrosshairCfg;
	UpdateSettings();
	bInitialized=true;
}
// Save all settings
function SaveSettings()
{
	local int i;

	if (!bLoadInitialized || !bInitialized)
		return;

	class'HUD'.default.CrosshairScale					= sl_GlobalScale.GetValue();
	class'BallisticWeapon'.default.NDCrosshairScaleFactor	= sl_CrossGrow.GetValue();

	class'BallisticWeapon'.default.NDCrosshairCfg	= Crosshairs[lb_Weapons.List.Elements.Length];
	class'HUD'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();

	for (i=0;i<lb_Weapons.List.Elements.Length;i++)
	{
		class<BallisticWeapon>(lb_Weapons.List.Elements[i].ExtraData).default.NDCrosshairCfg = Crosshairs[i];
		class<BallisticWeapon>(lb_Weapons.List.Elements[i].ExtraData).static.StaticSaveConfig();
	}
}
// Reset everything to defaults
function DefaultSettings()
{
	local int i;

	sl_GlobalScale.SetValue(1.0);
	sl_CrossGrow.SetValue(1.0);

	for (i=0;i<lb_Weapons.List.Elements.Length;i++)
	{
		class<BallisticWeapon>(lb_Weapons.List.Elements[i].ExtraData).static.ResetConfig("NDCrosshairCfg");
		Crosshairs[i] = class<BallisticWeapon>(lb_Weapons.List.Elements[i].ExtraData).default.NDCrosshairCfg;
	}
	
	class'BallisticWeapon'.static.ResetConfig("NDCrosshairCfg");
	Crosshairs[i] = class'BallisticWeapon'.default.NDCrosshairCfg;
	UpdateSettings();
}

function InternalOnChange(GUIComponent Sender)
{
	local int CHIndex;

	if (!bInitialized)
		return;

	CHIndex = lb_Weapons.List.Index;

	if (Sender == sl_Red1)				// Cross1 Red
		Crosshairs[CHIndex].Color1.R = sl_Red1.GetValue();
	else if (Sender == sl_Green1)		// Cross1 Green
		Crosshairs[CHIndex].Color1.G = sl_Green1.GetValue();
	else if (Sender == sl_Blue1)		// Cross1 Blue
		Crosshairs[CHIndex].Color1.B = sl_Blue1.GetValue();
	else if (Sender == sl_Alpha1)		// Cross1 Alpha
		Crosshairs[CHIndex].Color1.A = sl_Alpha1.GetValue();
	else if (Sender == sl_Size1)		// Cross1 Size
		Crosshairs[CHIndex].StartSize1 = sl_Size1.GetValue();
	else if (Sender == sl_Red2)			// Cross2 Red
		Crosshairs[CHIndex].Color2.R = sl_Red2.GetValue();
	else if (Sender == sl_Green2)		// Cross2 Green
		Crosshairs[CHIndex].Color2.G = sl_Green2.GetValue();
	else if (Sender == sl_Blue2)		// Cross2 Blue
		Crosshairs[CHIndex].Color2.B = sl_Blue2.GetValue();
	else if (Sender == sl_Alpha2)		// Cross2 Alpha
		Crosshairs[CHIndex].Color2.A = sl_Alpha2.GetValue();
	else if (Sender == sl_Size2)		// Cross2 Size
		Crosshairs[CHIndex].StartSize2 = sl_Size2.GetValue();
	else if (Sender == cb_CrossList1){	// Cross1 Tex
		Crosshairs[CHIndex].Pic1 = class<BallisticCrosshairPack>(cb_CrossList1.GetObject()).default.Crosshairs[int(cb_CrossList1.GetExtra())].Image;
		Crosshairs[CHIndex].USize1 = class<BallisticCrosshairPack>(cb_CrossList1.GetObject()).default.Crosshairs[int(cb_CrossList1.GetExtra())].USize;
		Crosshairs[CHIndex].VSize1 = class<BallisticCrosshairPack>(cb_CrossList1.GetObject()).default.Crosshairs[int(cb_CrossList1.GetExtra())].VSize;
	}
	else if (Sender == cb_CrossList2){	// Cross2 Tex
		Crosshairs[CHIndex].Pic2 = class<BallisticCrosshairPack>(cb_CrossList2.GetObject()).default.Crosshairs[int(cb_CrossList2.GetExtra())].Image;
		Crosshairs[CHIndex].USize2 = class<BallisticCrosshairPack>(cb_CrossList2.GetObject()).default.Crosshairs[int(cb_CrossList2.GetExtra())].USize;
		Crosshairs[CHIndex].VSize2 = class<BallisticCrosshairPack>(cb_CrossList2.GetObject()).default.Crosshairs[int(cb_CrossList2.GetExtra())].VSize;
	}
	else if (Sender == lb_Weapons.List)	// Weapon List
		UpdateSettings();
	UpdateImages();
}

function UpdateImages()
{
	local int CHIndex;

	CHIndex = lb_Weapons.List.Index;
	Img_Cross1.Image 		= Crosshairs[CHIndex].Pic1;
	Img_Cross1.ImageColor 	= Crosshairs[CHIndex].Color1;
	Img_Cross2.Image 		= Crosshairs[CHIndex].Pic2;
	Img_Cross2.ImageColor 	= Crosshairs[CHIndex].Color2;
}
// Set all sliders and options for currently selected crosshair
function UpdateSettings()
{
	local int i, CHIndex;

	CHIndex = lb_Weapons.List.Index;

	sl_Red1.SetValue(	Crosshairs[CHIndex].Color1.R);
	sl_Green1.SetValue(	Crosshairs[CHIndex].Color1.G);
	sl_Blue1.SetValue(	Crosshairs[CHIndex].Color1.B);
	sl_Alpha1.SetValue(	Crosshairs[CHIndex].Color1.A);
	sl_Size1.SetValue(	Crosshairs[CHIndex].StartSize1);
	for (i=0;i<cb_CrossList1.List.Elements.length;i++)
		if (class<BallisticCrosshairPack>(cb_CrossList1.GetItemObject(i)).default.Crosshairs[int(cb_CrossList1.List.Elements[i].ExtraStrData)].Image == Crosshairs[CHIndex].Pic1)	{
			bInitialized=false;	cb_CrossList1.SetText(cb_CrossList1.List.Elements[i].Item);	bInitialized=true;
			break;
	}
	sl_Red2.SetValue(	Crosshairs[CHIndex].Color2.R);
	sl_Green2.SetValue(	Crosshairs[CHIndex].Color2.G);
	sl_Blue2.SetValue(	Crosshairs[CHIndex].Color2.B);
	sl_Alpha2.SetValue(	Crosshairs[CHIndex].Color2.A);
	sl_Size2.SetValue(	Crosshairs[CHIndex].StartSize2);
	for (i=0;i<cb_CrossList2.List.Elements.length;i++)
		if (class<BallisticCrosshairPack>(cb_CrossList2.GetItemObject(i)).default.Crosshairs[int(cb_CrossList2.List.Elements[i].ExtraStrData)].Image == Crosshairs[CHIndex].Pic2)	{
			bInitialized=false;	cb_CrossList2.SetText(cb_CrossList2.List.Elements[i].Item);	bInitialized=true;
			break;
	}
	UpdateImages();
}
// Draw the crosshairs precisely
function bool InternalOnPreDraw(Canvas Canvas)
{
	local float ScaleFactor;
	local int CHIndex;

	if (!bLoadInitialized || !bInitialized)
		return false;

	CHIndex = lb_Weapons.List.Index;

	ScaleFactor = float(Controller.ResX)/1600  * sl_GlobalScale.GetValue()/*class'HUD'.default.CrosshairScale*/;

	Img_Cross1.WinWidth =	ScaleFactor * Crosshairs[CHIndex].StartSize1;
	Img_Cross1.WinLeft =	ActualWidth()*0.75 - Img_Cross1.WinWidth/2;
	Img_Cross1.WinHeight =	ScaleFactor * Crosshairs[CHIndex].StartSize1;
	Img_Cross1.WinTop =		ActualHeight()*0.325 - Img_Cross1.WinHeight/2;

	Img_Cross2.WinWidth =	ScaleFactor * Crosshairs[CHIndex].StartSize2;
	Img_Cross2.WinLeft =	ActualWidth()*0.75 - Img_Cross2.WinWidth/2;
	Img_Cross2.WinHeight =	ScaleFactor * Crosshairs[CHIndex].StartSize2;
	Img_Cross2.WinTop =		ActualHeight()*0.325 - Img_Cross2.WinHeight/2;
	return false;
}

defaultproperties
{
     Begin Object Class=moSlider Name=sl_GlobalScaleSlider
         MaxValue=2.000000
         Caption="Global Size"
         OnCreateComponent=sl_GlobalScaleSlider.InternalOnCreateComponent
         Hint="Scale the size of all crosshairs, including stock UT2004's, but excluding Universal Simple crosshairs."
         WinTop=0.920000
         WinLeft=0.520000
         WinWidth=0.470000
         WinHeight=0.037833
     End Object
     sl_GlobalScale=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_GlobalScaleSlider'

     Begin Object Class=moSlider Name=sl_CrossGrowSlider
         MaxValue=2.000000
         Caption="Crosshair Expansion"
         OnCreateComponent=sl_CrossGrowSlider.InternalOnCreateComponent
         Hint="Scale the degree of expansion to show inaccuracy for image-based crosshairs."
         WinTop=0.920000
         WinLeft=0.010000
         WinWidth=0.470000
         WinHeight=0.037833
     End Object
     sl_CrossGrow=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_CrossGrowSlider'

     Begin Object Class=moSlider Name=sl_Red1Slider
         MaxValue=255.000000
         bIntSlider=True
         CaptionWidth=0.350000
         Caption="Red"
         OnCreateComponent=sl_Red1Slider.InternalOnCreateComponent
         Hint="Adjust the red component of the outer crosshair."
         WinTop=0.690000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Red1=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Red1Slider'

     Begin Object Class=moSlider Name=sl_Green1Slider
         MaxValue=255.000000
         bIntSlider=True
         CaptionWidth=0.350000
         Caption="Green"
         OnCreateComponent=sl_Green1Slider.InternalOnCreateComponent
         Hint="Adjust Green component of Outer crosshair"
         WinTop=0.730000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Green1=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Green1Slider'

     Begin Object Class=moSlider Name=sl_Blue1Slider
         MaxValue=255.000000
         bIntSlider=True
         CaptionWidth=0.350000
         Caption="Blue"
         OnCreateComponent=sl_Blue1Slider.InternalOnCreateComponent
         Hint="Adjust Blue component of Outer crosshair"
         WinTop=0.770000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=10.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Blue1=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Blue1Slider'

     Begin Object Class=moSlider Name=sl_Alpha1Slider
         MaxValue=255.000000
         bIntSlider=True
         bIgnoreChange=True
         CaptionWidth=0.350000
         Caption="Opacity"
         OnCreateComponent=sl_Alpha1Slider.InternalOnCreateComponent
         Hint="Adjust Opactiy of Outer crosshair"
         WinTop=0.810000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Alpha1=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Alpha1Slider'

     Begin Object Class=moSlider Name=sl_Size1Slider
         MaxValue=512.000000
         MinValue=8.000000
         bIntSlider=True
         CaptionWidth=0.250000
         Caption="Scale"
         OnCreateComponent=sl_Size1Slider.InternalOnCreateComponent
         Hint="Adjust the base size of the outer crosshair."
         WinTop=0.850000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Size1=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Size1Slider'

     Begin Object Class=moSlider Name=sl_Red2Slider
         MaxValue=255.000000
         bIntSlider=True
         CaptionWidth=0.350000
         Caption="Red"
         OnCreateComponent=sl_Red2Slider.InternalOnCreateComponent
         Hint="Adjust the red component of the inner crosshair."
         WinTop=0.690000
         WinLeft=0.539000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Red2=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Red2Slider'

     Begin Object Class=moSlider Name=sl_Green2Slider
         MaxValue=255.000000
         bIntSlider=True
         CaptionWidth=0.350000
         Caption="Green"
         OnCreateComponent=sl_Green2Slider.InternalOnCreateComponent
         Hint="Adjust the green component of the inner crosshair."
         WinTop=0.730000
         WinLeft=0.539000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Green2=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Green2Slider'

     Begin Object Class=moSlider Name=sl_Blue2Slider
         MaxValue=255.000000
         bIntSlider=True
         CaptionWidth=0.350000
         Caption="Blue"
         OnCreateComponent=sl_Blue2Slider.InternalOnCreateComponent
         Hint="Adjust the blue component of the inner crosshair."
         WinTop=0.770000
         WinLeft=0.539000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Blue2=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Blue2Slider'

     Begin Object Class=moSlider Name=sl_Alpha2Slider
         MaxValue=255.000000
         bIntSlider=True
         CaptionWidth=0.350000
         Caption="Opacity"
         OnCreateComponent=sl_Alpha2Slider.InternalOnCreateComponent
         Hint="Adjust the opacity of the inner crosshair."
         WinTop=0.810000
         WinLeft=0.539000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Alpha2=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Alpha2Slider'

     Begin Object Class=moSlider Name=sl_Size2Slider
         MaxValue=512.000000
         MinValue=8.000000
         bIntSlider=True
         CaptionWidth=0.250000
         Caption="Scale"
         OnCreateComponent=sl_Size2Slider.InternalOnCreateComponent
         Hint="Adjust the base size of the inner crosshair."
         WinTop=0.850000
         WinLeft=0.539000
         WinWidth=0.400000
         WinHeight=0.038400
         OnChange=ConfigTab_Crosshairs.InternalOnChange
     End Object
     sl_Size2=moSlider'BallisticProV55.ConfigTab_Crosshairs.sl_Size2Slider'

     Begin Object Class=GUIImage Name=Box_WeapListImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.035000
         WinLeft=0.035000
         WinWidth=0.430000
         WinHeight=0.575000
         RenderWeight=0.002000
     End Object
     Box_WeapList=GUIImage'BallisticProV55.ConfigTab_Crosshairs.Box_WeapListImg'

     Begin Object Class=GUIImage Name=Img_Cross1Img
         Image=Texture'BW_Core_WeaponTex.Crosshairs.M50Out'
         ImageStyle=ISTY_Scaled
         WinTop=0.050000
         WinLeft=0.500000
         WinWidth=0.200000
         WinHeight=0.266600
         RenderWeight=0.002000
     End Object
     Img_Cross1=GUIImage'BallisticProV55.ConfigTab_Crosshairs.Img_Cross1Img'

     Begin Object Class=GUIImage Name=Img_Cross2Img
         Image=Texture'BW_Core_WeaponTex.Crosshairs.M50In'
         ImageStyle=ISTY_Scaled
         WinTop=0.050000
         WinLeft=0.500000
         WinWidth=0.200000
         WinHeight=0.266600
         RenderWeight=0.003000
     End Object
     Img_Cross2=GUIImage'BallisticProV55.ConfigTab_Crosshairs.Img_Cross2Img'

     Begin Object Class=GUIImage Name=Img_BackShotImg
         Image=MaterialSequence'BW_Core_WeaponTex.Misc.MenuSequence'
         ImageStyle=ISTY_Scaled
         WinTop=0.050000
         WinLeft=0.500000
         WinWidth=0.475000
         WinHeight=0.550000
         RenderWeight=0.001500
     End Object
     Img_BackShot=GUIImage'BallisticProV55.ConfigTab_Crosshairs.Img_BackShotImg'

     Begin Object Class=GUIImage Name=Box_ShotImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.035000
         WinLeft=0.485000
         WinWidth=0.505000
         WinHeight=0.580000
         RenderWeight=0.001000
     End Object
     Box_Shot=GUIImage'BallisticProV55.ConfigTab_Crosshairs.Box_ShotImg'

     Begin Object Class=GUIImage Name=Box_InnerImg
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.635000
         WinLeft=0.524000
         WinWidth=0.430000
         WinHeight=0.265000
         RenderWeight=0.002000
     End Object
     Box_Inner=GUIImage'BallisticProV55.ConfigTab_Crosshairs.Box_InnerImg'

     Begin Object Class=GUIImage Name=Box_OuterImg
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.635000
         WinLeft=0.035000
         WinWidth=0.430000
         WinHeight=0.265000
         RenderWeight=0.002000
     End Object
     Box_Outer=GUIImage'BallisticProV55.ConfigTab_Crosshairs.Box_OuterImg'

     Begin Object Class=GUILabel Name=l_WeaponsListlabel
         Caption="Weapons"
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.035000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.050000
     End Object
     l_WeaponsList=GUILabel'BallisticProV55.ConfigTab_Crosshairs.l_WeaponsListlabel'

     Begin Object Class=GUILabel Name=l_Innerlab
         Caption="Inner"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         bTransparent=False
         FontScale=FNS_Small
         WinTop=0.620000
         WinLeft=0.631500
         WinWidth=0.215000
         WinHeight=0.030000
     End Object
     l_Inner=GUILabel'BallisticProV55.ConfigTab_Crosshairs.l_Innerlab'

     Begin Object Class=GUILabel Name=l_Outerlab
         Caption="Outer"
         TextAlign=TXTA_Center
         TextColor=(B=0,R=255)
         bTransparent=False
         FontScale=FNS_Small
         WinTop=0.620000
         WinLeft=0.142500
         WinWidth=0.215000
         WinHeight=0.030000
     End Object
     l_Outer=GUILabel'BallisticProV55.ConfigTab_Crosshairs.l_Outerlab'

     Begin Object Class=GUIListBox Name=lb_WeaponsList
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_WeaponsList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Select a weapon to change its crosshair."
         WinTop=0.075000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.500000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_Weapons=GUIListBox'BallisticProV55.ConfigTab_Crosshairs.lb_WeaponsList'

     Begin Object Class=GUIComboBox Name=cb_CrossList1ComBox
         MaxVisibleItems=16
         Hint="Choose the style of the outer crosshair."
         WinTop=0.650000
         WinLeft=0.050000
         WinWidth=0.400000
         WinHeight=0.038400
         TabOrder=0
         OnChange=ConfigTab_Crosshairs.InternalOnChange
         OnKeyEvent=cb_CrossList1ComBox.InternalOnKeyEvent
     End Object
     cb_CrossList1=GUIComboBox'BallisticProV55.ConfigTab_Crosshairs.cb_CrossList1ComBox'

     Begin Object Class=GUIComboBox Name=cb_CrossList2ComBox
         MaxVisibleItems=16
         Hint="Choose the style of the inner crosshair."
         WinTop=0.650000
         WinLeft=0.539000
         WinWidth=0.400000
         WinHeight=0.038400
         TabOrder=0
         OnChange=ConfigTab_Crosshairs.InternalOnChange
         OnKeyEvent=cb_CrossList2ComBox.InternalOnKeyEvent
     End Object
     cb_CrossList2=GUIComboBox'BallisticProV55.ConfigTab_Crosshairs.cb_CrossList2ComBox'

     OnPreDraw=ConfigTab_Crosshairs.InternalOnPreDraw
}
