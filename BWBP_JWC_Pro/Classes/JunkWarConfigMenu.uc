//=============================================================================
// JunkWarConfigMenu.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkWarConfigMenu extends UT2K4GUIPage;

var Automated GUIImage				MyBack, Box_JunkList;
var Automated GUIButton				BDone, BCancel, BFill, BEmpty;
var automated GUIHeader				MyHeader;
var automated BC_GUICheckListBox	lb_JunkList;
var automated moCheckbox			ch_NoWeapons, ch_KeepTrans, ch_MotionBlur;
var automated moNumericEdit			nu_JunkAmount, nu_JunkShields, nu_StartJunk;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<string> JunkNameList;
	local int i;
	local class<JunkObject> JC;
	local class<JunkShield> JS;

	Super.InitComponent(MyController, MyOwner);

	PlayerOwner().GetAllInt("JunkObject", JunkNameList);
	for(i=0;i<JunkNameList.length;i++)
	{
		JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
		if (JC != None)
			lb_JunkList.CheckList.AddCheck(JC.default.FriendlyName, JC, , , JC.default.bListed);
	}
	PlayerOwner().GetAllInt("JunkShield", JunkNameList);
	for(i=0;i<JunkNameList.length;i++)
	{
		JS = class<JunkShield>(DynamicLoadObject(JunkNameList[i], class'Class'));
		if (JS != None)
			lb_JunkList.CheckList.AddCheck(JS.default.ItemName, JS, , , JS.default.bListed);
	}
 	ch_NoWeapons.Checked(class'Mut_JunkWar'.default.bNoOtherWeapons);
 	ch_KeepTrans.Checked(class'Mut_JunkWar'.default.bKeepTranslocators);
	nu_JunkAmount.SetValue(class'Mut_JunkWar'.default.NumJunks);
	nu_JunkShields.SetValue(class'Mut_JunkWar'.default.NumShields);
	nu_StartJunk.SetValue(class'Mut_JunkWar'.default.NumStartJunks);
 	ch_MotionBlur.Checked(class'BallisticMod'.default.bUseMotionBlur);

	lb_JunkList.CheckList.OnClick = InternalOnClick;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(BDone);

	return false;
}

function InternalOnClose(optional Bool bCanceled)
{
	Super.OnClose(bCanceled);
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;

	if (Sender==BCancel) // CANCEL
		Controller.CloseMenu();
	else if (Sender==BDone) // DONE
	{
		for(i=0;i<lb_junklist.List.Elements.length;i++)
			if (class<JunkObject>(lb_junklist.List.GetObjectAtIndex(i)) != None)
			{
				class<JunkObject>(lb_junklist.List.GetObjectAtIndex(i)).default.bListed = lb_junklist.CheckList.Checks[i] > 0;
				class<JunkObject>(lb_junklist.List.GetObjectAtIndex(i)).static.StaticSaveConfig();
			}
			else if (class<JunkShield>(lb_junklist.List.GetObjectAtIndex(i)) != None)
			{
				class<JunkShield>(lb_junklist.List.GetObjectAtIndex(i)).default.bListed = lb_junklist.CheckList.Checks[i] > 0;
				class<JunkShield>(lb_junklist.List.GetObjectAtIndex(i)).static.StaticSaveConfig();
			}
		class'Mut_JunkWar'.default.bNoOtherWeapons = ch_NoWeapons.IsChecked();
		class'Mut_JunkWar'.default.bKeepTranslocators = ch_KeepTrans.IsChecked();
		class'Mut_JunkWar'.default.NumJunks = nu_JunkAmount.GetValue();
		class'Mut_JunkWar'.default.NumShields = nu_JunkShields.GetValue();
		class'Mut_JunkWar'.default.NumStartJunks = nu_StartJunk.GetValue();
		class'BallisticMod'.default.bUseMotionBlur = ch_MotionBlur.IsChecked();
		class'Mut_JunkWar'.static.StaticSaveConfig();
		class'BallisticMod'.static.StaticSaveConfig();
		Controller.CloseMenu();
	}
	else if (Sender==BFill) // FILL
	{
		for(i=0;i<lb_junklist.List.Elements.length;i++)
			lb_junklist.CheckList.SetChecked(i, true);
	}
	else if (Sender==BEmpty) // EMPTY
	{
		for(i=0;i<lb_junklist.List.Elements.length;i++)
			lb_junklist.CheckList.SetChecked(i, false);
	}
	else if (Sender == lb_junklist.CheckList)
	{
		lb_junklist.CheckList.InternalOnClick(Sender);
//		lb_junklist.CheckList.ToggleChecked(lb_junklist.CheckList.Index);
	}
	return true;
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=1.000000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BWBP_JWC_Pro.JunkWarConfigMenu.BackImage'

     Begin Object Class=GUIImage Name=Box_JunkListImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.040000
         WinLeft=0.300000
         WinWidth=0.400000
         WinHeight=0.625000
         RenderWeight=0.002000
     End Object
     Box_JunkList=GUIImage'BWBP_JWC_Pro.JunkWarConfigMenu.Box_JunkListImg'

     Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.925000
         WinLeft=0.350000
         WinWidth=0.100000
         TabOrder=0
         OnClick=JunkWarConfigMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
     End Object
     bDone=GUIButton'BWBP_JWC_Pro.JunkWarConfigMenu.DoneButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         WinTop=0.925000
         WinLeft=0.550000
         WinWidth=0.100000
         TabOrder=1
         OnClick=JunkWarConfigMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bCancel=GUIButton'BWBP_JWC_Pro.JunkWarConfigMenu.CancelButton'

     Begin Object Class=GUIButton Name=FillButton
         Caption="Fill"
         Hint="Check all junk items"
         WinTop=0.665000
         WinLeft=0.350000
         WinWidth=0.100000
         TabOrder=0
         OnClick=JunkWarConfigMenu.InternalOnClick
         OnKeyEvent=FillButton.InternalOnKeyEvent
     End Object
     BFill=GUIButton'BWBP_JWC_Pro.JunkWarConfigMenu.FillButton'

     Begin Object Class=GUIButton Name=EmptyButton
         Caption="Empty"
         Hint="Uncheck all junk items"
         WinTop=0.665000
         WinLeft=0.550000
         WinWidth=0.100000
         TabOrder=1
         OnClick=JunkWarConfigMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     BEmpty=GUIButton'BWBP_JWC_Pro.JunkWarConfigMenu.EmptyButton'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Junk War Configuration"
         WinLeft=0.050000
         WinWidth=0.600000
         WinHeight=0.700000
     End Object
     MyHeader=GUIHeader'BWBP_JWC_Pro.JunkWarConfigMenu.DaBeegHeader'

     Begin Object Class=BC_GUICheckListBox Name=lb_JunkListList
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_JunkListList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Specify what kind junk you want in the arena."
         WinTop=0.080000
         WinLeft=0.325000
         WinWidth=0.350000
         WinHeight=0.550000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_JunkList=BC_GUICheckListBox'BWBP_JWC_Pro.JunkWarConfigMenu.lb_JunkListList'

     Begin Object Class=moCheckBox Name=ch_NoWeaponsChk
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use Junk Only"
         OnCreateComponent=ch_NoWeaponsChk.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables all normal weapons so players battle with junk only."
         WinTop=0.720000
         WinLeft=0.250000
         WinWidth=0.220000
     End Object
     ch_NoWeapons=moCheckBox'BWBP_JWC_Pro.JunkWarConfigMenu.ch_NoWeaponsChk'

     Begin Object Class=moCheckBox Name=ch_KeepTransChk
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Keep Translocators"
         OnCreateComponent=ch_KeepTransChk.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="If 'Use Junk Only' is on, this will allow translocators in the arena."
         WinTop=0.720000
         WinLeft=0.530000
         WinWidth=0.220000
     End Object
     ch_KeepTrans=moCheckBox'BWBP_JWC_Pro.JunkWarConfigMenu.ch_KeepTransChk'

     Begin Object Class=moCheckBox Name=ch_MotionBlurChk
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Enable Motion BLur"
         OnCreateComponent=ch_MotionBlurChk.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Allow motion blur to be applied to view by some effect."
         WinTop=0.880000
         WinLeft=0.325000
         WinWidth=0.350000
     End Object
     ch_MotionBlur=moCheckBox'BWBP_JWC_Pro.JunkWarConfigMenu.ch_MotionBlurChk'

     Begin Object Class=moNumericEdit Name=nu_JunkAmountEd
         MinValue=0
         MaxValue=600
         Step=5
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Junk Quantity"
         OnCreateComponent=nu_JunkAmountEd.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Specify the quantity of junk items you want lying around the arena."
         WinTop=0.760000
         WinLeft=0.325000
         WinWidth=0.350000
     End Object
     nu_JunkAmount=moNumericEdit'BWBP_JWC_Pro.JunkWarConfigMenu.nu_JunkAmountEd'

     Begin Object Class=moNumericEdit Name=nu_JunkShieldsEd
         MinValue=0
         MaxValue=600
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Shield Quantity"
         OnCreateComponent=nu_JunkShieldsEd.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Specify the quantity of junk shields you want lying around the arena."
         WinTop=0.800000
         WinLeft=0.325000
         WinWidth=0.350000
     End Object
     nu_JunkShields=moNumericEdit'BWBP_JWC_Pro.JunkWarConfigMenu.nu_JunkShieldsEd'

     Begin Object Class=moNumericEdit Name=nu_StartJunkEd
         MinValue=0
         MaxValue=1000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Starting Variety"
         OnCreateComponent=nu_StartJunkEd.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="The variety of junk items players can start with. Players spawn with one of this munber of the lowest ranking items. Set to 0 to use all junk."
         WinTop=0.840000
         WinLeft=0.325000
         WinWidth=0.350000
     End Object
     nu_StartJunk=moNumericEdit'BWBP_JWC_Pro.JunkWarConfigMenu.nu_StartJunkEd'

     bRenderWorld=True
     bAllowedAsLast=True
     OnClose=JunkWarConfigMenu.InternalOnClose
     OnKeyEvent=JunkWarConfigMenu.InternalOnKeyEvent
}
