class BallisticTeamOutfittingWeaponSelect extends FloatingWindow;

var automated GUIListBox	    lb_Weapons;
var automated GUIImage		    Box_WeapList, Box_Inventory, Pic_Weapon, Box_WeapIcon;
var automated GUILabel   	    l_WeapTitle;
var automated GUIScrollTextBox	tb_Desc;
var automated GUIButton         b_Cancel, b_OK;
var() float                     EdgeBorder[4];

function AlignButtons()
{
	local float X,Y,Xs,Ys;
	local float WIP,HIP;

	WIP = ActualWidth();
	HIP = ActualHeight();

	Xs = b_Ok.ActualWidth() * 0.1;
	Ys = b_Ok.ActualHeight() * 0.1;

	X = 1 - ( (b_Ok.ActualWidth()  + Xs) / WIP) - (EdgeBorder[2] / WIP);
	Y = 1 - ( (b_Ok.ActualHeight() + Ys) / HIP) - (EdgeBorder[3] / WIP);

	b_Ok.WinLeft = X;
	b_Ok.WinTop = Y;

	X = 1 -( (b_Ok.ActualWidth() + b_Cancel.ActualWidth() + Xs) / WIP) - (EdgeBorder[2] / WIP);

	b_Cancel.WinLeft = X;
	b_Cancel.WinTop = Y;
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Log("BallisticTeamOutfittingWeaponSelect::InitComponent");

	Super.InitComponent(MyController, MyOwner);

    AlignButtons();
    lb_Weapons.List.OnChange = InternalOnChange;
}

//======================================================================
// InitWeaponLists
//
// Sets up the weapon list with the dividers, then adds weapons in after 
// them by incrementing indices to get the new position.
//
// Azarael: Uses Cache instead of DynamicLoadObject on the entire list, 
// which caused severe load lag.
//======================================================================
function LoadWeapons(ClientTeamOutfittingInterface COI, int group)
{
	local int i, lastIndex;
	local BC_WeaponInfoCache.WeaponInfo WI;
	
    Log("BallisticTeamOutfittingWeaponSelect::LoadWeapons");

	lb_Weapons.List.Clear();

	lastIndex = -1;
	
	//Weapons here will be loaded explicitly if they're selected in the list, via the Extra string data.
	// The COI list is already sorted by inventory group.
	for (i=0; i < COI.GroupLength(group); i++)
	{
        if (LoadWIFromCache(COI.GetGroupItem(group, i), WI))
        {
            Log("Group "$group$", index "$i$" is "$COI.GetGroupItem(group, i));

            if (WI.InventoryGroup != lastIndex)
            {
                lastIndex = WI.InventoryGroup;
                lb_Weapons.List.Add(class'BallisticWeaponClassInfo'.static.GetHeading(lastIndex),, "Weapon Category", true);
            }
            
            lb_Weapons.List.Add(WI.ItemName, , COI.GetGroupItem(group, i), false); // not a section
        }
	}

    UpdateWeaponIconAndDesc();
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool LoadWIFromCache(string ClassStr, out BC_WeaponInfoCache.WeaponInfo WepInfo)
{
	local int i;

	WepInfo = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ClassStr, i);

	if (i==-1)
	{
		log("BallisticTeamOutfittingWeaponSelect::LoadWIFromCache: Error loading item: "$ClassStr, 'Warning');
		return false;
	}

	return true;
}

//===========================================================================
// Update the boxes when the weapon list changes
//
// Azarael: Uses Cache.
//===========================================================================
function UpdateWeaponIconAndDesc()
{
	local class<BallisticWeapon> BW;
	
    l_WeapTitle.Caption = lb_Weapons.List.SelectedText();
    
    //Section header.
    if (lb_Weapons.List.IsSection())
    {
        tb_Desc.SetContent(class'BallisticWeaponClassInfo'.static.GetClassDescription(lb_Weapons.List.SelectedText()));
        Pic_Weapon.Image = None;
        return;
    }

    //Check for items which have already been loaded.
    if (lb_Weapons.List.GetObject() != None)
    {
        if (class<BallisticWeapon>(lb_Weapons.List.GetObject()) != None)
        {
            Pic_Weapon.Image = class<BallisticWeapon>(lb_Weapons.List.GetObject()).default.BigIconMaterial;
            tb_Desc.SetContent(class<BallisticWeapon>(lb_Weapons.List.GetObject()).static.GetShortManual());
            return;
        }
        if (class<ConflictItem>(lb_Weapons.List.GetObject()) != None)
        {
            Pic_Weapon.Image = class<ConflictItem>(lb_Weapons.List.GetObject()).default.Icon;
            tb_Desc.SetContent(class<ConflictItem>(lb_Weapons.List.GetObject()).default.Description);
            return;
        }
        return;
    }
    
    //Item not loaded. Load it and add it as the Object for the weapons list's current position.
    if (lb_Weapons.List.GetExtra() != "")
    {
        BW = class<BallisticWeapon>(DynamicLoadObject(lb_Weapons.List.GetExtra(), class'Class'));
        if (BW != None)
        {
            Pic_Weapon.Image = BW.default.BigIconMaterial;
            tb_Desc.SetContent(BW.static.GetShortManual());
            lb_Weapons.List.SetObjectAtIndex(lb_Weapons.List.Index, BW);
        }
    }	
}

//===========================================================================
// InternalOnChange
//
// Dynamically load weapons we haven't yet selected.
//===========================================================================
function InternalOnChange(GUIComponent Sender)
{
	if (Sender==lb_Weapons.List)
	{
        UpdateWeaponIconAndDesc();
	}	
}

function bool InternalOnClick(GUIComponent Sender)
{
    if ( Sender == b_OK )
	{
		Controller.CloseMenu(false);
		return true;
	}

	if ( Sender == b_Cancel )
	{
		Controller.CloseMenu(true);
		return true;
	}
}

function string GetDataString()
{
	return lb_Weapons.List.GetExtra();
}

defaultproperties
{
	InactiveFadeColor=(R=60,G=60,B=60,A=255)
	bResizeWidthAllowed=False
	bResizeHeightAllowed=False
	bAllowedAsLast=false
	bCaptureInput=True

	DefaultLeft=0.125
	DefaultTop=0.15
	DefaultWidth=0.74
	DefaultHeight=0.7

	WinLeft=0.125
	WinTop=0.15
	WinWidth=0.74
	WinHeight=0.7

    WindowName="Select Weapon"

    EdgeBorder(0)=16
    EdgeBorder(1)=24
    EdgeBorder(2)=16
    EdgeBorder(3)=24

	Begin Object Class=GUIButton Name=LockedCancelButton
        bBoundToParent=true
		WinWidth=0.16
		WinLeft=0.51
		WinTop=0.85
        Caption="Cancel"
        TabOrder=99
        OnClick=InternalOnClick
        bAutoShrink=False
    End Object
    b_Cancel=LockedCancelButton

	Begin Object Class=GUIButton Name=LockedOKButton
        bBoundToParent=true
		WinWidth=0.16
		WinLeft=0.743
		WinTop=0.85
        Caption="OK"
        OnClick=InternalOnClick
        TabOrder=100
        bAutoShrink=False
    End Object
    b_OK=LockedOKButton

    Begin Object Class=GUIListBox Name=lb_WeaponsList
        bBoundToParent=true
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_WeaponsList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Available items. Double-click to add them to your inventory."
         WinTop=0.095000
         WinLeft=0.0150000
         WinWidth=0.400000
         WinHeight=0.750000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_Weapons=GUIListBox'lb_WeaponsList'

     Begin Object Class=GUIImage Name=Box_WeapListImg
        bBoundToParent=true
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.05000
         WinWidth=0.430000
         WinHeight=0.8500
         RenderWeight=0.002000
     End Object
     Box_WeapList=GUIImage'Box_WeapListImg'

     Begin Object Class=GUIImage Name=Pic_WeaponImg
        bBoundToParent=true
         //Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Justified
         ImageAlign=IMGA_Center
         WinTop=0.095
         WinLeft=0.515000
         WinWidth=0.40000
         WinHeight=0.226000
         RenderWeight=0.004000
     End Object
     Pic_Weapon=GUIImage'Pic_WeaponImg'

     Begin Object Class=GUIImage Name=Box_WeapIconImg
        bBoundToParent=true
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.450000
         WinWidth=0.540000
         WinHeight=0.85000
         RenderWeight=0.002000
     End Object
     Box_WeapIcon=GUIImage'Box_WeapIconImg'

     Begin Object Class=GUILabel Name=l_WeapTitlelabel
        bBoundToParent=true
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.0464
         WinLeft=0.51000
         WinWidth=0.430000
         WinHeight=0.050000
     End Object
     l_WeapTitle=GUILabel'l_WeapTitlelabel'

     Begin Object Class=GUIScrollTextBox Name=WeaponDescription
        bBoundToParent=true
         CharDelay=0.001500
         EOLDelay=0.250000
         bVisibleWhenEmpty=True
         OnCreateComponent=WeaponDescription.InternalOnCreateComponent
         FontScale=FNS_Small
         WinTop=0.330000
         WinLeft=0.480000
         WinWidth=0.500000
         WinHeight=0.50000
         RenderWeight=0.510000
         TabOrder=0
         bAcceptsInput=False
         bNeverFocus=True
     End Object
     tb_Desc=GUIScrollTextBox'WeaponDescription'
}
