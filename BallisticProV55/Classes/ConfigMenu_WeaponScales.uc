//=============================================================================
// ConfigMenu_WeaponScales.
//
// The Weapons tab's sub menu: scales for more of what a weapon does. Like the
// tab's own they are settings of the game style, which the server sends to
// every client with BallisticReplicationInfo. 1 leaves a weapon as it is made.
//
// Opened with the game style's class as its first parameter. OK saves at once.
//=============================================================================
class ConfigMenu_WeaponScales extends UT2K4GUIPage;

var automated GUIImage		MyBlack, MyBack;
var automated GUIHeader		MyHeader;
var automated GUIButton		bn_OK, bn_Defaults, bn_Cancel;
var automated moFloatEdit	fl_RecoilShot;		//Recoil Per Shot
var automated moFloatEdit	fl_RecoilRecovery;	//Recoil Recovery
var automated moFloatEdit	fl_Spread;			//Shot Spread
var automated moFloatEdit	fl_AimSpeed;		//Aim Speed
var automated moFloatEdit	fl_AimMove;			//Aim Move Penalty
var automated moFloatEdit	fl_WeaponWeight;	//Weapon Weight
var automated moFloatEdit	fl_Magazine;		//Magazine Size
var automated moFloatEdit	fl_Headshot;		//Headshot Bonus
var automated moFloatEdit	fl_Limb;			//Limb Penalty
var automated moFloatEdit	fl_DamageRange;		//Damage Range
var automated moFloatEdit	fl_BlastRadius;		//Blast Radius
var automated moFloatEdit	fl_Penetration;		//Penetration

var class<BC_GameStyle_Config>	GameStyle;

event HandleParameters(string Param1, string Param2)
{
	if (Param1 != "")
		GameStyle = class<BC_GameStyle_Config>(DynamicLoadObject(Param1, class'Class', true));
	LoadSettings();
}

function LoadSettings()
{
	if (GameStyle == None)
		return;

	fl_RecoilShot.SetValue(GameStyle.default.RecoilShotScale);
	fl_RecoilRecovery.SetValue(GameStyle.default.RecoilRecoveryScale);
	fl_Spread.SetValue(GameStyle.default.SpreadScale);
	fl_AimSpeed.SetValue(GameStyle.default.AimSpeedScale);
	fl_AimMove.SetValue(GameStyle.default.AimMoveScale);
	fl_WeaponWeight.SetValue(GameStyle.default.WeaponWeightScale);
	fl_Magazine.SetValue(GameStyle.default.MagazineScale);
	fl_Headshot.SetValue(GameStyle.default.HeadshotScale);
	fl_Limb.SetValue(GameStyle.default.LimbScale);
	fl_DamageRange.SetValue(GameStyle.default.DamageRangeScale);
	fl_BlastRadius.SetValue(GameStyle.default.BlastRadiusScale);
	fl_Penetration.SetValue(GameStyle.default.PenetrationScale);
}

function SaveSettings()
{
	if (GameStyle == None)
		return;

	GameStyle.default.RecoilShotScale			= fl_RecoilShot.GetValue();
	GameStyle.default.RecoilRecoveryScale		= fl_RecoilRecovery.GetValue();
	GameStyle.default.SpreadScale				= fl_Spread.GetValue();
	GameStyle.default.AimSpeedScale			= fl_AimSpeed.GetValue();
	GameStyle.default.AimMoveScale			= fl_AimMove.GetValue();
	GameStyle.default.WeaponWeightScale		= fl_WeaponWeight.GetValue();
	GameStyle.default.MagazineScale			= fl_Magazine.GetValue();
	GameStyle.default.HeadshotScale			= fl_Headshot.GetValue();
	GameStyle.default.LimbScale				= fl_Limb.GetValue();
	GameStyle.default.DamageRangeScale		= fl_DamageRange.GetValue();
	GameStyle.default.BlastRadiusScale		= fl_BlastRadius.GetValue();
	GameStyle.default.PenetrationScale		= fl_Penetration.GetValue();
	GameStyle.static.StaticSaveConfig();
}

function DefaultSettings()
{
	fl_RecoilShot.SetValue(1.0);
	fl_RecoilRecovery.SetValue(1.0);
	fl_Spread.SetValue(1.0);
	fl_AimSpeed.SetValue(1.0);
	fl_AimMove.SetValue(1.0);
	fl_WeaponWeight.SetValue(1.0);
	fl_Magazine.SetValue(1.0);
	fl_Headshot.SetValue(1.0);
	fl_Limb.SetValue(1.0);
	fl_DamageRange.SetValue(1.0);
	fl_BlastRadius.SetValue(1.0);
	fl_Penetration.SetValue(1.0);
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender == bn_OK)
	{
		SaveSettings();
		Controller.CloseMenu(false);
	}
	else if (Sender == bn_Cancel)
		Controller.CloseMenu(true);
	else if (Sender == bn_Defaults)
		DefaultSettings();
	return true;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x1B && State == 3)	// Escape
		return InternalOnClick(bn_Cancel);
	return false;
}

defaultproperties
{
     // the tab underneath would show through the panel
     Begin Object Class=GUIImage Name=BlackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.070000
         WinLeft=0.215000
         WinWidth=0.570000
         WinHeight=0.860000
         RenderWeight=0.000500
     End Object
     MyBlack=GUIImage'BallisticProV55.ConfigMenu_WeaponScales.BlackImage'

     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.900000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.ConfigMenu_WeaponScales.BackImage'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="More Weapon Settings"
         WinTop=0.075000
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.031250
     End Object
     MyHeader=GUIHeader'BallisticProV55.ConfigMenu_WeaponScales.DaBeegHeader'

     Begin Object Class=moFloatEdit Name=fl_RecoilShotFloat
         MinValue=0.000000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Recoil Per Shot"
         OnCreateComponent=fl_RecoilShotFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the recoil that each shot adds."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=0
     End Object
     fl_RecoilShot=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_RecoilShotFloat'

     Begin Object Class=moFloatEdit Name=fl_RecoilRecoveryFloat
         MinValue=0.500000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Recoil Recovery"
         OnCreateComponent=fl_RecoilRecoveryFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales how fast recoil settles after firing. 2 is twice as fast."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=1
     End Object
     fl_RecoilRecovery=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_RecoilRecoveryFloat'

     Begin Object Class=moFloatEdit Name=fl_SpreadFloat
         MinValue=0.000000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Shot Spread"
         OnCreateComponent=fl_SpreadFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the spread of shots, shotgun pellets included."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=2
     End Object
     fl_Spread=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_SpreadFloat'

     Begin Object Class=moFloatEdit Name=fl_AimSpeedFloat
         MinValue=0.500000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Aim Speed"
         OnCreateComponent=fl_AimSpeedFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales how fast sights are raised and lowered. 2 is twice as fast. The same for every player."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=3
     End Object
     fl_AimSpeed=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_AimSpeedFloat'

     Begin Object Class=moFloatEdit Name=fl_AimMoveFloat
         MinValue=0.000000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Aim Move Penalty"
         OnCreateComponent=fl_AimMoveFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the extra slowdown while aiming down sights. 0 is none."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=4
     End Object
     fl_AimMove=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_AimMoveFloat'

     Begin Object Class=moFloatEdit Name=fl_WeaponWeightFloat
         MinValue=0.000000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Weapon Weight"
         OnCreateComponent=fl_WeaponWeightFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales how much a weapon slows or speeds up its holder. 0 is not at all."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=5
     End Object
     fl_WeaponWeight=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_WeaponWeightFloat'

     Begin Object Class=moFloatEdit Name=fl_MagazineFloat
         MinValue=0.500000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Magazine Size"
         OnCreateComponent=fl_MagazineFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales how many rounds a magazine holds."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=6
     End Object
     fl_Magazine=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_MagazineFloat'

     Begin Object Class=moFloatEdit Name=fl_HeadshotFloat
         MinValue=0.000000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Headshot Bonus"
         OnCreateComponent=fl_HeadshotFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the extra damage of a head hit. 0 is none: a head hit does body damage."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=7
     End Object
     fl_Headshot=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_HeadshotFloat'

     Begin Object Class=moFloatEdit Name=fl_LimbFloat
         MinValue=0.000000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Limb Penalty"
         OnCreateComponent=fl_LimbFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the damage lost on a limb hit. 0 is none: a limb hit does body damage."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=8
     End Object
     fl_Limb=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_LimbFloat'

     Begin Object Class=moFloatEdit Name=fl_DamageRangeFloat
         MinValue=0.500000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Damage Range"
         OnCreateComponent=fl_DamageRangeFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the distances over which a bullet's damage falls off."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=9
     End Object
     fl_DamageRange=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_DamageRangeFloat'

     Begin Object Class=moFloatEdit Name=fl_BlastRadiusFloat
         MinValue=0.500000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Blast Radius"
         OnCreateComponent=fl_BlastRadiusFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the damage radius of explosives."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=10
     End Object
     fl_BlastRadius=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_BlastRadiusFloat'

     Begin Object Class=moFloatEdit Name=fl_PenetrationFloat
         MinValue=0.000000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Penetration"
         OnCreateComponent=fl_PenetrationFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales how much wall, and how many players, a shot goes through."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.040000
         TabOrder=11
     End Object
     fl_Penetration=moFloatEdit'BallisticProV55.ConfigMenu_WeaponScales.fl_PenetrationFloat'

     Begin Object Class=GUIButton Name=OKButton
         Caption="OK"
         Hint="Save these settings."
         WinTop=0.860000
         WinLeft=0.250000
         WinWidth=0.150000
         TabOrder=12
         OnClick=ConfigMenu_WeaponScales.InternalOnClick
         OnKeyEvent=OKButton.InternalOnKeyEvent
     End Object
     bn_OK=GUIButton'BallisticProV55.ConfigMenu_WeaponScales.OKButton'

     Begin Object Class=GUIButton Name=DefaultsButton
         Caption="DEFAULTS"
         Hint="Set every scale back to 1."
         WinTop=0.860000
         WinLeft=0.425000
         WinWidth=0.150000
         TabOrder=13
         OnClick=ConfigMenu_WeaponScales.InternalOnClick
         OnKeyEvent=DefaultsButton.InternalOnKeyEvent
     End Object
     bn_Defaults=GUIButton'BallisticProV55.ConfigMenu_WeaponScales.DefaultsButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         Hint="Leave without saving."
         WinTop=0.860000
         WinLeft=0.600000
         WinWidth=0.150000
         TabOrder=14
         OnClick=ConfigMenu_WeaponScales.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bn_Cancel=GUIButton'BallisticProV55.ConfigMenu_WeaponScales.CancelButton'

     bRenderWorld=True
     bAllowedAsLast=True
     OnKeyEvent=ConfigMenu_WeaponScales.InternalOnKeyEvent
}
