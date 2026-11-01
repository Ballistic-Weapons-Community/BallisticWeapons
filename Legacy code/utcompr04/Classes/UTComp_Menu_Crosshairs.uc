class UTComp_Menu_Crosshairs extends UTComp_Menu_MainMenu;

#EXEC TEXTURE IMPORT FILE=Textures\64_4_circle.dds NAME=BigCircle MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\64_3_circle.dds NAME=MedCircle MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\64_2_circle.dds NAME=SmallCircle MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\64_1_circle.dds NAME=UberSmallCircle MIPS=OFF ALPHA=1

#EXEC TEXTURE IMPORT FILE=Textures\32_4_circle.dds NAME=BigCircle_2 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_3_circle.dds NAME=MedCircle_2 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_2_circle.dds NAME=SmallCircle_2 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_1_circle.dds NAME=UberSmallCircle_2 MIPS=OFF ALPHA=1

#EXEC TEXTURE IMPORT FILE=Textures\32_Square_1.dds NAME=BigSquare MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_Square_2.dds NAME=BigSquare_2 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_Square_3.dds NAME=BigSquare_3 MIPS=OFF ALPHA=1

#EXEC TEXTURE IMPORT FILE=Textures\32_diamond_1.dds NAME=Bigdiamond MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_diamond_2.dds NAME=Bigdiamond_2 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_diamond_3.dds NAME=Bigdiamond_3 MIPS=OFF ALPHA=1

#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_0.dds NAME=Bigbracket MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_1.dds NAME=Bigbracket_1 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_2.dds NAME=Bigbracket_2 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_3.dds NAME=Bigbracket_3 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_4.dds NAME=Bigbracket_4 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_5.dds NAME=Bigbracket_5 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_6.dds NAME=Bigbracket_6 MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_bracket_7.dds NAME=Bigbracket_7 MIPS=OFF ALPHA=1


#EXEC TEXTURE IMPORT FILE=Textures\32_VertLine.dds NAME=BigHoriz MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\32_HorizLine.dds NAME=BigVert MIPS=OFF ALPHA=1


#EXEC TEXTURE IMPORT FILE=Textures\64_VertLine.dds NAME=SmallHoriz MIPS=OFF ALPHA=1
#EXEC TEXTURE IMPORT FILE=Textures\64_HorizLine.dds NAME=SmallVert MIPS=OFF ALPHA=1

var automated GUIListBox lb_CrossHairs;
var automated GUIComboBox co_UTCompCrosshairs;
var automated GUIButton bu_MoveUp, bu_MoveDown, bu_AddHair, bu_DeleteHair;
var automated moCheckBox ch_UseFactory, ch_SizeIncrease;

var automated GUISlider sl_SizeHair, sl_OpacityHair, sl_HorizHair, sl_VertHair;
var automated GUISlider sl_RedHair, sl_GreenHair, sl_BlueHair;

var automated GUILabel l_Size, l_Opacity, l_Horiz, l_Vert;
var automated GUILabel l_Red, l_Green, l_Blue;

var automated GUIImage i_CurrentHairBG, i_CurrentHair, i_TotalHairBG;
var automated GUIImage i_ListBoxBG;

var automated array<GUIImage> i_TotalHair;

struct UTCompCrosshair
{
	var string xHairName;
	var texture xHairTexture;
};

var array<UTCompCrosshair> UTCompNewHairs;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<CacheManager.CrosshairRecord> CustomCrosshairs;
	local int i;
	
	Super.InitComponent(myController,MyOwner);
	class'CacheManager'.static.GetCrosshairList(CustomCrosshairs);
	
	//Select xHair combobox
	for(i = 0; i < CustomCrosshairs.Length; i++)
		co_UTCompCrosshairs.AddItem(CustomCrosshairs[i].FriendlyName, CustomCrosshairs[i].CrosshairTexture);
		
	for(i = 0; i < UTCompNewHairs.Length; i++)
		co_UTCompCrosshairs.AddItem(UTCompNewHairs[i].xHairName, UTCompNewHairs[i].xHairTexture);
		
	co_UTCompCrosshairs.ReadOnly(true);
	
	//ListBox of current xhairs
	lb_Crosshairs.List.bDropSource = true;
	lb_Crosshairs.List.bDropTarget = true;
	lb_Crosshairs.List.bMultiSelect = false;
	for(i = 0; i < class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i++)
		lb_Crosshairs.List.Add(FindDescriptionFor(class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex), class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex);
	
	ch_UseFactory.Checked(class'UTComp_HudSettings'.default.bEnableUTCompCrosshairs);
	ch_SizeIncrease.Checked(class'UTComp_HudSettings'.default.bEnableCrosshairSizing);
	
	if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length > 0)
	{
		sl_SizeHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossScale);
		sl_OpacityHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.A);
		sl_HorizHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].OffsetX);
		sl_VertHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].OffsetY);
		sl_RedHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.R);
		sl_GreenHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.G);
		sl_BlueHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.B);
	}
	
	i_CurrentHair.WinWidth = (0.10 * class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossScale);
	i_CurrentHair.WinHeight = (0.10 * class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossScale);
	i_CurrentHair.WinTop = 0.480 + (sl_VertHair.Value - 0.50);
	i_CurrentHair.WinLeft = 0.784 + (sl_HorizHair.Value - 0.50);
	
	if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length > 0)
	{
		i_CurrentHair.Image=class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossTex;
		i_CurrentHair.ImageColor=class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor;
	}
	
	RefreshFullCrossHair();
	DisableStuff();
}

function RefreshFullCrossHair()
{
	local int i;
	
	for(i = 0; i < class'UTComp_HudSettings'.default.UTCompCrosshairs.Length && i < 12; i++)
	{
		i_totalhair[i].WinWidth = (0.10 * class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale);
		i_totalhair[i].WinHeight = (0.10 * class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale);
		i_totalhair[i].WinTop = 0.680 + (class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetY - 0.50);
		i_totalhair[i].WinLeft = 0.784 + (class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetX - 0.50);
		i_totalhair[i].Image = class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex;
		i_totalhair[i].ImageColor = class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor;
	}
	
	for(i = class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i < 12; i++)
		i_totalhair[i].Image = None;
}

function string FindDescriptionFor(Texture T)
{
	local array<CacheManager.CrosshairRecord> CustomCrosshairs;
	local int i;
	
	class'CacheManager'.static.GetCrosshairList(CustomCrosshairs);
	
	for(i = 0; i < CustomCrosshairs.Length; i++)
		if(T == CustomCrosshairs[i].CrosshairTexture)
			return CustomCrosshairs[i].FriendlyName;
			
	for(i = 0; i < UTCompNewHairs.Length; i++)
		if(T == UTCompNewHairs[i].xHairTexture)
			return UTCompNewHairs[i].xHairName;
			
	return string(T);
}

function InternalOnChange( GUIComponent C )
{
	switch(C)
	{
		case ch_UseFactory:
			class'UTComp_HudSettings'.default.bEnableUTCompCrosshairs = ch_UseFactory.IsChecked();
			break;
		
		case ch_SizeIncrease:
			class'UTComp_HudSettings'.default.bEnableCrosshairSizing = ch_SizeIncrease.IsChecked();
			break;
	
	  case sl_SizeHair:
	  	if(lb_CrossHairs.List.Index >= 0)
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossScale = sl_SizeHair.Value;
			break;
	  
	  case sl_OpacityHair: 
	  	if(lb_CrossHairs.List.Index >= 0)
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.A = sl_OpacityHair.Value;
			break;
	  
	  case sl_HorizHair:
	  	if(lb_CrossHairs.List.Index >= 0)
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetX = sl_HorizHair.Value;
			break;
	  
	  case sl_VertHair:
	  	if(lb_CrossHairs.List.Index >= 0)
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetY = sl_VertHair.Value;
			break;
	  
	  case sl_RedHair:
	  	if(lb_CrossHairs.List.Index >= 0)
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.R = sl_RedHair.Value;
			break;
	  
	  case sl_GreenHair: 
	  	if(lb_CrossHairs.List.Index >= 0)
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.G = sl_GreenHair.Value;
			break;
			
	  case sl_BlueHair:
	  	if(lb_CrossHairs.List.Index >= 0)
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.B = sl_BlueHair.Value;
			break;
	
		case lb_CrossHairs:
			UpdateSliders();
			co_UTCompCrosshairs.SetIndex(co_UTCompCrosshairs.FindIndex(FindDescriptionFor(Texture(lb_CrossHairs.List.GetObject()))));
			break;
	
		case co_UTCompCrosshairs:
			if(lb_CrossHairs.List.Index >= 0)
			{
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossTex = Texture(co_UTCompCrosshairs.GetObject());
				lb_CrossHairs.List.SetObjectAtIndex(lb_CrossHairs.List.Index,co_UTCompCrosshairs.GetObject());
				lb_CrossHairs.List.SetItemAtIndex(lb_CrossHairs.List.Index,FindDescriptionFor(Texture(co_UTCompCrosshairs.GetObject())));
				break;
			}
	}
	
	class'UTComp_HudSettings'.static.StaticSaveConfig();
	UpdateImages();
	RefreshFullCrossHair();
	DisableStuff();
}

function DisableStuff()
{
	if(ch_UseFactory.IsChecked())
	{
		sl_SizeHair.EnableMe();
		sl_OpacityHair.EnableMe();
		sl_HorizHair.EnableMe();
		sl_VertHair.EnableMe();
		sl_RedHair.EnableMe();
		sl_GreenHair.EnableMe();
		sl_BlueHair.EnableMe();
		
		lb_CrossHairs.EnableMe();
		co_UTCompCrosshairs.EnableMe();
		bu_MoveUp.EnableMe();
		bu_MoveDown.EnableMe();
		bu_AddHair.EnableMe();
		bu_DeleteHair.EnableMe();
	}
	else
	{
		sl_SizeHair.DisableMe();
		sl_OpacityHair.DisableMe();
		sl_HorizHair.DisableMe();
		sl_VertHair.DisableMe();
		sl_RedHair.DisableMe();
		sl_GreenHair.DisableMe();
		sl_BlueHair.DisableMe();
		
		lb_CrossHairs.DisableMe();
		co_UTCompCrosshairs.DisableMe();
		bu_MoveUp.DisableMe();
		bu_MoveDown.DisableMe();
		bu_AddHair.DisableMe();
		bu_DeleteHair.DisableMe();
	}
	
	if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length == 0)
	{
		sl_SizeHair.DisableMe();
		sl_OpacityHair.DisableMe();
		sl_HorizHair.DisableMe();
		sl_VertHair.DisableMe();
		sl_RedHair.DisableMe();
		sl_GreenHair.DisableMe();
		sl_BlueHair.DisableMe();
		
		lb_CrossHairs.DisableMe();
		co_UTCompCrosshairs.DisableMe();
		bu_MoveUp.DisableMe();
		bu_MoveDown.DisableMe();
		bu_DeleteHair.DisableMe();
	}
}

function UpdateSliders()
{
	if(lb_CrossHairs.List.Index<0)
		return;
		
	sl_SizeHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossScale);
	sl_OpacityHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.A);
	sl_HorizHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetX);
	sl_VertHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetY);
	sl_RedHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.R);
	sl_GreenHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.G);
	sl_BlueHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.B);
}

function UpdateImages()
{
	if(lb_Crosshairs.List.Index>=0)
	{
		i_CurrentHair.WinWidth = (0.10 * class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossScale);
		i_CurrentHair.WinHeight =(0.10 * class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossScale);
		i_CurrentHair.WinTop = 0.480 + (class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].OffsetY - 0.50);
		i_CurrentHair.WinLeft = 0.784 + (class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].OffsetX - 0.50);
		
		if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>0)
		{
			i_CurrentHair.Image = class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossTex;
			i_CurrentHair.ImageColor = class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossColor;
		}
	}
}

function SetupNewHair(int i)
{
	class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale=1.0;
	class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.A=255;
	class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetX=0.50;
	class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetY=0.50;
	class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.R=255;
	class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.G=255;
	class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.B=255;
}

function bool InternalOnClick( GUIComponent Sender )
{
	local int i;
	
	switch (Sender)
	{
		case bu_AddHair:
			i = class'UTComp_HudSettings'.default.UTCompCrosshairs.Length;
			class'UTComp_HudSettings'.default.UTCompCrosshairs.Length = i + 1;
			class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex = Texture(lb_Crosshairs.List.GetObject());
			SetupNewHair(i);
			UpdateSliders();
			lb_Crosshairs.List.Add("New", None);
			break;
			
		case bu_DeleteHair: 
			i = lb_Crosshairs.List.Index;
			if(i < class'UTComp_HudSettings'.default.UTCompCrosshairs.Length && i >= 0)
			{
			  class'UTComp_HudSettings'.default.UTCompCrosshairs.Remove(i, 1);
			  lb_Crosshairs.List.Clear();
			  for(i = 0; i < class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i++)
					lb_Crosshairs.List.Add(FindDescriptionFor(class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex), class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex);
			}
			DisableStuff();
			break;
			
		case bu_MoveUp:
			if(lb_CrossHairs.List.Index>0)
			{
				lb_CrossHairs.List.Swap(lb_CrossHairs.List.Index,lb_CrossHairs.List.Index - 1);
				class'UTComp_HudSettings'.default.TemporaryCrosshair = class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index];
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index] = class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index-1];
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index - 1] = class'UTComp_HudSettings'.default.TemporaryCrosshair;
			}
			break;
			
		case bu_MoveDown: 
			if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>lb_CrossHairs.List.Index+1 && lb_CrossHairs.List.Index>=0)
			{
				lb_CrossHairs.List.Swap(lb_CrossHairs.List.Index,lb_CrossHairs.List.Index + 1);
				class'UTComp_HudSettings'.default.TemporaryCrosshair = class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index];
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index] = class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index+1];
				class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index + 1] = class'UTComp_HudSettings'.default.TemporaryCrosshair;
			}
			break;
	}
	
	UpdateImages();
	RefreshFullCrossHair();
	DisableStuff();
	return Super.InternalOnClick(Sender);
}

defaultproperties
{
     Begin Object Class=GUIListBox Name=CrosshairListBox
         bVisibleWhenEmpty=True
         OnCreateComponent=CrosshairListBox.InternalOnCreateComponent
         WinTop=0.392917
         WinLeft=0.140000
         WinWidth=0.160000
         WinHeight=0.264375
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
     End Object
     lb_CrossHairs=GUIListBox'utcompr04.UTComp_Menu_Crosshairs.CrosshairListBox'

     Begin Object Class=GUIComboBox Name=CrosshairCombo
         WinTop=0.366666
         WinLeft=0.350001
         WinWidth=0.248444
         WinHeight=0.035000
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=CrosshairCombo.InternalOnKeyEvent
     End Object
     co_UTCompCrosshairs=GUIComboBox'utcompr04.UTComp_Menu_Crosshairs.CrosshairCombo'

     Begin Object Class=GUIButton Name=MoveUpHairButton
         Caption="Up"
         WinTop=0.734384
         WinLeft=0.126562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=MoveUpHairButton.InternalOnKeyEvent
     End Object
     bu_MoveUp=GUIButton'utcompr04.UTComp_Menu_Crosshairs.MoveUpHairButton'

     Begin Object Class=GUIButton Name=MoveDownHairButton
         Caption="Down"
         WinTop=0.734384
         WinLeft=0.206562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=MoveDownHairButton.InternalOnKeyEvent
     End Object
     bu_MoveDown=GUIButton'utcompr04.UTComp_Menu_Crosshairs.MoveDownHairButton'

     Begin Object Class=GUIButton Name=AddHairButton
         Caption="Add"
         WinTop=0.688559
         WinLeft=0.126562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=AddHairButton.InternalOnKeyEvent
     End Object
     bu_AddHair=GUIButton'utcompr04.UTComp_Menu_Crosshairs.AddHairButton'

     Begin Object Class=GUIButton Name=DeleteHairButton
         Caption="Delete"
         WinTop=0.688559
         WinLeft=0.206562
         WinWidth=0.080000
         OnClick=UTComp_Menu_Crosshairs.InternalOnClick
         OnKeyEvent=DeleteHairButton.InternalOnKeyEvent
     End Object
     bu_DeleteHair=GUIButton'utcompr04.UTComp_Menu_Crosshairs.DeleteHairButton'

     Begin Object Class=moCheckBox Name=UseFactoryCheck
         Caption="Use Crosshair Factory"
         OnCreateComponent=UseFactoryCheck.InternalOnCreateComponent
         WinTop=0.324583
         WinLeft=0.126562
         WinWidth=0.350000
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
     End Object
     ch_UseFactory=moCheckBox'utcompr04.UTComp_Menu_Crosshairs.UseFactoryCheck'

     Begin Object Class=moCheckBox Name=SizeIncreaseCheck
         Caption="Crosshair Size Increase"
         OnCreateComponent=SizeIncreaseCheck.InternalOnCreateComponent
         WinTop=0.328750
         WinLeft=0.548751
         WinWidth=0.350000
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
     End Object
     ch_SizeIncrease=moCheckBox'utcompr04.UTComp_Menu_Crosshairs.SizeIncreaseCheck'

     Begin Object Class=GUISlider Name=SizeCrossSlider
         MaxValue=4.000000
         Value=1.000000
         WinTop=0.575000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=SizeCrossSlider.InternalOnClick
         OnMousePressed=SizeCrossSlider.InternalOnMousePressed
         OnMouseRelease=SizeCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=SizeCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=SizeCrossSlider.InternalCapturedMouseMove
     End Object
     sl_SizeHair=GUISlider'utcompr04.UTComp_Menu_Crosshairs.SizeCrossSlider'

     Begin Object Class=GUISlider Name=OpacityCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.535000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=OpacityCrossSlider.InternalOnClick
         OnMousePressed=OpacityCrossSlider.InternalOnMousePressed
         OnMouseRelease=OpacityCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=OpacityCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=OpacityCrossSlider.InternalCapturedMouseMove
     End Object
     sl_OpacityHair=GUISlider'utcompr04.UTComp_Menu_Crosshairs.OpacityCrossSlider'

     Begin Object Class=GUISlider Name=HorizCrossSlider
         MinValue=0.400000
         MaxValue=0.600000
         Value=0.500000
         WinTop=0.615000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=HorizCrossSlider.InternalOnClick
         OnMousePressed=HorizCrossSlider.InternalOnMousePressed
         OnMouseRelease=HorizCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=HorizCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=HorizCrossSlider.InternalCapturedMouseMove
     End Object
     sl_HorizHair=GUISlider'utcompr04.UTComp_Menu_Crosshairs.HorizCrossSlider'

     Begin Object Class=GUISlider Name=VertCrossSlider
         MinValue=0.400000
         MaxValue=0.600000
         Value=0.500000
         WinTop=0.655000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=VertCrossSlider.InternalOnClick
         OnMousePressed=VertCrossSlider.InternalOnMousePressed
         OnMouseRelease=VertCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=VertCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=VertCrossSlider.InternalCapturedMouseMove
     End Object
     sl_VertHair=GUISlider'utcompr04.UTComp_Menu_Crosshairs.VertCrossSlider'

     Begin Object Class=GUISlider Name=RedCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.415000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=RedCrossSlider.InternalOnClick
         OnMousePressed=RedCrossSlider.InternalOnMousePressed
         OnMouseRelease=RedCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=RedCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=RedCrossSlider.InternalCapturedMouseMove
     End Object
     sl_RedHair=GUISlider'utcompr04.UTComp_Menu_Crosshairs.RedCrossSlider'

     Begin Object Class=GUISlider Name=GreenCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.455000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=GreenCrossSlider.InternalOnClick
         OnMousePressed=GreenCrossSlider.InternalOnMousePressed
         OnMouseRelease=GreenCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=GreenCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=GreenCrossSlider.InternalCapturedMouseMove
     End Object
     sl_GreenHair=GUISlider'utcompr04.UTComp_Menu_Crosshairs.GreenCrossSlider'

     Begin Object Class=GUISlider Name=BlueCrossSlider
         MaxValue=255.000000
         Value=255.000000
         bIntSlider=True
         WinTop=0.495000
         WinLeft=0.410000
         WinWidth=0.250000
         OnClick=BlueCrossSlider.InternalOnClick
         OnMousePressed=BlueCrossSlider.InternalOnMousePressed
         OnMouseRelease=BlueCrossSlider.InternalOnMouseRelease
         OnChange=UTComp_Menu_Crosshairs.InternalOnChange
         OnKeyEvent=BlueCrossSlider.InternalOnKeyEvent
         OnCapturedMouseMove=BlueCrossSlider.InternalCapturedMouseMove
     End Object
     sl_BlueHair=GUISlider'utcompr04.UTComp_Menu_Crosshairs.BlueCrossSlider'

     Begin Object Class=GUILabel Name=SizeCrossLabel
         Caption="Size"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.560000
         WinLeft=0.340000
     End Object
     l_Size=GUILabel'utcompr04.UTComp_Menu_Crosshairs.SizeCrossLabel'

     Begin Object Class=GUILabel Name=OpacityCrossLabel
         Caption="Alpha"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.520000
         WinLeft=0.340000
     End Object
     l_Opacity=GUILabel'utcompr04.UTComp_Menu_Crosshairs.OpacityCrossLabel'

     Begin Object Class=GUILabel Name=HorizCrossLabel
         Caption="Left"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.600000
         WinLeft=0.340000
     End Object
     l_Horiz=GUILabel'utcompr04.UTComp_Menu_Crosshairs.HorizCrossLabel'

     Begin Object Class=GUILabel Name=VertCrossLabel
         Caption="Up"
         TextColor=(B=255,G=255,R=255)
         WinTop=0.640000
         WinLeft=0.340000
     End Object
     l_Vert=GUILabel'utcompr04.UTComp_Menu_Crosshairs.VertCrossLabel'

     Begin Object Class=GUILabel Name=RedCrossLabel
         Caption="Red"
         TextColor=(R=255)
         WinTop=0.400000
         WinLeft=0.340000
     End Object
     l_Red=GUILabel'utcompr04.UTComp_Menu_Crosshairs.RedCrossLabel'

     Begin Object Class=GUILabel Name=GreenCrossLabel
         Caption="Green"
         TextColor=(G=255)
         WinTop=0.440000
         WinLeft=0.340000
     End Object
     l_Green=GUILabel'utcompr04.UTComp_Menu_Crosshairs.GreenCrossLabel'

     Begin Object Class=GUILabel Name=BlueCrossLabel
         Caption="Blue"
         TextColor=(B=255)
         WinTop=0.480000
         WinLeft=0.340000
     End Object
     l_Blue=GUILabel'utcompr04.UTComp_Menu_Crosshairs.BlueCrossLabel'

     Begin Object Class=GUIImage Name=CurrentHairBackgroundImage
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.372917
         WinLeft=0.680000
         WinWidth=0.200000
         WinHeight=0.200000
     End Object
     i_CurrentHairBG=GUIImage'utcompr04.UTComp_Menu_Crosshairs.CurrentHairBackgroundImage'

     Begin Object Class=GUIImage Name=CurrentHAirImage
         ImageStyle=ISTY_Scaled
         ImageAlign=IMGA_Center
         X1=0
         Y1=0
         X2=64
         Y2=64
     End Object
     i_CurrentHair=GUIImage'utcompr04.UTComp_Menu_Crosshairs.CurrentHAirImage'

     Begin Object Class=GUIImage Name=TotalHairBackgroundImage
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.583350
         WinLeft=0.680000
         WinWidth=0.200000
         WinHeight=0.200000
     End Object
     i_TotalHairBG=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairBackgroundImage'

     Begin Object Class=GUIImage Name=ListBoxBackgroundImage
         Image=Texture'2K4Menus.Controls.thinpipe_b'
         ImageStyle=ISTY_Stretched
         WinTop=0.372917
         WinLeft=0.120000
         WinWidth=0.200000
         WinHeight=0.304688
     End Object
     i_ListBoxBG=GUIImage'utcompr04.UTComp_Menu_Crosshairs.ListBoxBackgroundImage'

     i_TotalHair(0)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(1)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(2)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(3)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(4)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(5)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(6)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(7)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(8)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(9)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(10)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     i_TotalHair(11)=GUIImage'utcompr04.UTComp_Menu_Crosshairs.TotalHairImage0'
     UTCompNewHairs(0)=(xHairName="Big Circle(0)",xHairTexture=Texture'utcompr04.BigCircle')
     UTCompNewHairs(1)=(xHairName="Big Circle(1)",xHairTexture=Texture'utcompr04.MedCircle')
     UTCompNewHairs(2)=(xHairName="Big Circle(2)",xHairTexture=Texture'utcompr04.SmallCircle')
     UTCompNewHairs(3)=(xHairName="Big Circle(3)",xHairTexture=Texture'utcompr04.UberSmallCircle')
     UTCompNewHairs(4)=(xHairName="Small Circle(0)",xHairTexture=Texture'utcompr04.BigCircle_2')
     UTCompNewHairs(5)=(xHairName="Small Circle(1)",xHairTexture=Texture'utcompr04.MedCircle_2')
     UTCompNewHairs(6)=(xHairName="Small Circle(2)",xHairTexture=Texture'utcompr04.SmallCircle_2')
     UTCompNewHairs(7)=(xHairName="Small Circle(3)",xHairTexture=Texture'utcompr04.UberSmallCircle_2')
     UTCompNewHairs(8)=(xHairName="Big Square(0)",xHairTexture=Texture'utcompr04.BigSquare')
     UTCompNewHairs(9)=(xHairName="Big Square(1)",xHairTexture=Texture'utcompr04.BigSquare_2')
     UTCompNewHairs(10)=(xHairName="Big Square(2)",xHairTexture=Texture'utcompr04.BigSquare_3')
     UTCompNewHairs(11)=(xHairName="Big diamond(0)",xHairTexture=Texture'utcompr04.Bigdiamond')
     UTCompNewHairs(12)=(xHairName="Big Diamond(1)",xHairTexture=Texture'utcompr04.Bigdiamond_2')
     UTCompNewHairs(13)=(xHairName="Big Diamond(2)",xHairTexture=Texture'utcompr04.Bigdiamond_3')
     UTCompNewHairs(14)=(xHairName="Big Horiz",xHairTexture=Texture'utcompr04.SmallVert')
     UTCompNewHairs(15)=(xHairName="Small Horiz",xHairTexture=Texture'utcompr04.BigVert')
     UTCompNewHairs(16)=(xHairName="Big Vert",xHairTexture=Texture'utcompr04.SmallHoriz')
     UTCompNewHairs(17)=(xHairName="Small Vert",xHairTexture=Texture'utcompr04.BigHoriz')
     UTCompNewHairs(18)=(xHairName="Big 'L'(0)",xHairTexture=Texture'utcompr04.Bigbracket')
     UTCompNewHairs(19)=(xHairName="Big 'L'(1)",xHairTexture=Texture'utcompr04.Bigbracket_1')
     UTCompNewHairs(20)=(xHairName="Big 'L'(2)",xHairTexture=Texture'utcompr04.Bigbracket_2')
     UTCompNewHairs(21)=(xHairName="Big 'L'(3)",xHairTexture=Texture'utcompr04.Bigbracket_3')
     UTCompNewHairs(22)=(xHairName="Big 'L'(4)",xHairTexture=Texture'utcompr04.Bigbracket_4')
     UTCompNewHairs(23)=(xHairName="Big 'L'(5)",xHairTexture=Texture'utcompr04.Bigbracket_5')
     UTCompNewHairs(24)=(xHairName="Big 'L'(6)",xHairTexture=Texture'utcompr04.Bigbracket_6')
     UTCompNewHairs(25)=(xHairName="Big 'L'(7)",xHairTexture=Texture'utcompr04.Bigbracket_7')
}
