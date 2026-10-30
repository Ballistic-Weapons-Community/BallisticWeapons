//=============================================================================
// ConfigMenu_AdvancedWeaponRules.
//
// The Weapons tab's sub menu: rules for what every weapon does, on/off ones and
// scales. Like the tab's own they are settings of the game style, which the
// server sends to every client with BallisticReplicationInfo.
//
// Opened with the game style's class as its first parameter. OK saves at once.
//=============================================================================
class ConfigMenu_AdvancedWeaponRules extends UT2K4GUIPage;

var automated GUIImage		MyBlack, MyBack;
var automated GUIHeader		MyHeader;
var automated GUILabel		l_Note, l_Movement, l_Handling, l_Damage;
var automated GUIButton		bn_OK, bn_Defaults, bn_Cancel;
var automated moCheckBox	ch_WeaponMove;		//Weapons Affect Movement
var automated moCheckBox	ch_AimMove;			//Aiming Slows Movement
var automated moFloatEdit	fl_AimSpeed;		//Aim Down Sight Speed Scale
var automated moFloatEdit	fl_FireRate;		//Fire Rate Scale
var automated moFloatEdit	fl_Magazine;		//Magazine Size Scale
var automated moFloatEdit	fl_ShotgunSpread;	//Shotgun Spread Scale
var automated moFloatEdit	fl_Headshot;		//Headshot Bonus Scale
var automated moCheckBox	ch_Limb;			//Limb Hits Do Less Damage
var automated moCheckBox	ch_Falloff;			//Damage Falloff Over Distance
var automated moFloatEdit	fl_BlastRadius;		//Explosion Radius Scale
var automated moFloatEdit	fl_Penetration;		//Penetration Scale

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

	ch_WeaponMove.Checked(GameStyle.default.bWeaponsAffectMovement);
	ch_AimMove.Checked(GameStyle.default.bAimingSlowsMovement);
	fl_AimSpeed.SetValue(GameStyle.default.AimSpeedScale);
	fl_FireRate.SetValue(GameStyle.default.FireRateScale);
	fl_Magazine.SetValue(GameStyle.default.MagazineScale);
	fl_ShotgunSpread.SetValue(GameStyle.default.ShotgunSpreadScale);
	fl_Headshot.SetValue(GameStyle.default.HeadshotScale);
	ch_Limb.Checked(GameStyle.default.bLimbDamageReduction);
	ch_Falloff.Checked(GameStyle.default.bDamageFalloff);
	fl_BlastRadius.SetValue(GameStyle.default.BlastRadiusScale);
	fl_Penetration.SetValue(GameStyle.default.PenetrationScale);
}

function SaveSettings()
{
	if (GameStyle == None)
		return;

	GameStyle.default.bWeaponsAffectMovement		= ch_WeaponMove.IsChecked();
	GameStyle.default.bAimingSlowsMovement		= ch_AimMove.IsChecked();
	GameStyle.default.AimSpeedScale				= fl_AimSpeed.GetValue();
	GameStyle.default.FireRateScale				= fl_FireRate.GetValue();
	GameStyle.default.MagazineScale				= fl_Magazine.GetValue();
	GameStyle.default.ShotgunSpreadScale			= fl_ShotgunSpread.GetValue();
	GameStyle.default.HeadshotScale				= fl_Headshot.GetValue();
	GameStyle.default.bLimbDamageReduction		= ch_Limb.IsChecked();
	GameStyle.default.bDamageFalloff				= ch_Falloff.IsChecked();
	GameStyle.default.BlastRadiusScale			= fl_BlastRadius.GetValue();
	GameStyle.default.PenetrationScale			= fl_Penetration.GetValue();
	GameStyle.static.StaticSaveConfig();
}

function DefaultSettings()
{
	ch_WeaponMove.Checked(true);
	ch_AimMove.Checked(true);
	fl_AimSpeed.SetValue(1.0);
	fl_FireRate.SetValue(1.0);
	fl_Magazine.SetValue(1.0);
	fl_ShotgunSpread.SetValue(1.0);
	fl_Headshot.SetValue(1.0);
	ch_Limb.Checked(true);
	ch_Falloff.Checked(true);
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
     MyBlack=GUIImage'BallisticProV55.ConfigMenu_AdvancedWeaponRules.BlackImage'

     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.900000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.ConfigMenu_AdvancedWeaponRules.BackImage'

     Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Advanced Weapon Rules"
         WinTop=0.075000
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.031250
     End Object
     MyHeader=GUIHeader'BallisticProV55.ConfigMenu_AdvancedWeaponRules.DaBeegHeader'

     Begin Object Class=GUILabel Name=NoteLabel
         Caption="For every weapon and every player. A scale of 1.00 leaves a weapon as it is made."
         TextAlign=TXTA_Center
         StyleName="TextLabel"
         FontScale=FNS_Small
         bMultiLine=True
         WinTop=0.127000
         WinLeft=0.240000
         WinWidth=0.520000
         WinHeight=0.050000
     End Object
     l_Note=GUILabel'BallisticProV55.ConfigMenu_AdvancedWeaponRules.NoteLabel'

     Begin Object Class=GUILabel Name=MovementLabel
         Caption="Movement"
         TextAlign=TXTA_Left
         TextColor=(B=0,G=180,R=255,A=255)
         TextFont="UT2MenuFont"
         WinTop=0.185000
         WinLeft=0.240000
         WinWidth=0.520000
         WinHeight=0.040000
     End Object
     l_Movement=GUILabel'BallisticProV55.ConfigMenu_AdvancedWeaponRules.MovementLabel'

     Begin Object Class=moCheckBox Name=ch_WeaponMoveCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Weapons Affect Movement"
         OnCreateComponent=ch_WeaponMoveCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Off: players move and jump the same with every weapon. No weapon slows them down or speeds them up."
         WinTop=0.227500
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=0
     End Object
     ch_WeaponMove=moCheckBox'BallisticProV55.ConfigMenu_AdvancedWeaponRules.ch_WeaponMoveCheck'

     Begin Object Class=moCheckBox Name=ch_AimMoveCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Aiming Slows Movement"
         OnCreateComponent=ch_AimMoveCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Off: no slowdown while aiming down sights."
         WinTop=0.270000
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=1
     End Object
     ch_AimMove=moCheckBox'BallisticProV55.ConfigMenu_AdvancedWeaponRules.ch_AimMoveCheck'

     Begin Object Class=GUILabel Name=HandlingLabel
         Caption="Handling"
         TextAlign=TXTA_Left
         TextColor=(B=0,G=180,R=255,A=255)
         TextFont="UT2MenuFont"
         WinTop=0.326500
         WinLeft=0.240000
         WinWidth=0.520000
         WinHeight=0.040000
     End Object
     l_Handling=GUILabel'BallisticProV55.ConfigMenu_AdvancedWeaponRules.HandlingLabel'

     Begin Object Class=moFloatEdit Name=fl_AimSpeedFloat
         MinValue=0.500000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Aim Down Sight Speed Scale"
         OnCreateComponent=fl_AimSpeedFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How fast sights are raised and lowered, the same for every player. 2: twice as fast."
         WinTop=0.369000
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=2
     End Object
     fl_AimSpeed=moFloatEdit'BallisticProV55.ConfigMenu_AdvancedWeaponRules.fl_AimSpeedFloat'

     Begin Object Class=moFloatEdit Name=fl_FireRateFloat
         MinValue=0.500000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Fire Rate Scale"
         OnCreateComponent=fl_FireRateFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How fast guns fire, pump and bolt actions included. 1.5: half as fast again."
         WinTop=0.411500
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=3
     End Object
     fl_FireRate=moFloatEdit'BallisticProV55.ConfigMenu_AdvancedWeaponRules.fl_FireRateFloat'

     Begin Object Class=moFloatEdit Name=fl_MagazineFloat
         MinValue=0.500000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Magazine Size Scale"
         OnCreateComponent=fl_MagazineFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How many rounds a magazine holds. 1.5: a magazine of 30 holds 45, and a plasma or lightning gun 1.5 times its cells."
         WinTop=0.454000
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=4
     End Object
     fl_Magazine=moFloatEdit'BallisticProV55.ConfigMenu_AdvancedWeaponRules.fl_MagazineFloat'

     Begin Object Class=moFloatEdit Name=fl_ShotgunSpreadFloat
         MinValue=0.000000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Shotgun Spread Scale"
         OnCreateComponent=fl_ShotgunSpreadFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How far a shotgun's pellets spread. 0.5: half as wide."
         WinTop=0.496500
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=5
     End Object
     fl_ShotgunSpread=moFloatEdit'BallisticProV55.ConfigMenu_AdvancedWeaponRules.fl_ShotgunSpreadFloat'

     Begin Object Class=GUILabel Name=DamageLabel
         Caption="Damage"
         TextAlign=TXTA_Left
         TextColor=(B=0,G=180,R=255,A=255)
         TextFont="UT2MenuFont"
         WinTop=0.553000
         WinLeft=0.240000
         WinWidth=0.520000
         WinHeight=0.040000
     End Object
     l_Damage=GUILabel'BallisticProV55.ConfigMenu_AdvancedWeaponRules.DamageLabel'

     Begin Object Class=moFloatEdit Name=fl_HeadshotFloat
         MinValue=0.000000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Headshot Bonus Scale"
         OnCreateComponent=fl_HeadshotFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="The extra damage of a head hit. 0: a head hit does body damage. 2: twice the bonus."
         WinTop=0.595500
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=6
     End Object
     fl_Headshot=moFloatEdit'BallisticProV55.ConfigMenu_AdvancedWeaponRules.fl_HeadshotFloat'

     Begin Object Class=moCheckBox Name=ch_LimbCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Limb Hits Do Less Damage"
         OnCreateComponent=ch_LimbCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Off: a hit on an arm or a leg does the damage of a body hit."
         WinTop=0.638000
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=7
     End Object
     ch_Limb=moCheckBox'BallisticProV55.ConfigMenu_AdvancedWeaponRules.ch_LimbCheck'

     Begin Object Class=moCheckBox Name=ch_FalloffCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Damage Falloff Over Distance"
         OnCreateComponent=ch_FalloffCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Off: bullets do their full damage at any range."
         WinTop=0.680500
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=8
     End Object
     ch_Falloff=moCheckBox'BallisticProV55.ConfigMenu_AdvancedWeaponRules.ch_FalloffCheck'

     Begin Object Class=moFloatEdit Name=fl_BlastRadiusFloat
         MinValue=0.500000
         MaxValue=2.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Explosion Radius Scale"
         OnCreateComponent=fl_BlastRadiusFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="The damage radius of rockets, grenades and other explosives. 0.5: half as far."
         WinTop=0.723000
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=9
     End Object
     fl_BlastRadius=moFloatEdit'BallisticProV55.ConfigMenu_AdvancedWeaponRules.fl_BlastRadiusFloat'

     Begin Object Class=moFloatEdit Name=fl_PenetrationFloat
         MinValue=0.000000
         MaxValue=3.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Penetration Scale"
         OnCreateComponent=fl_PenetrationFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How much wall and how many players a bullet goes through. 0: it stops at the first wall or player."
         WinTop=0.765500
         WinLeft=0.265000
         WinWidth=0.485000
         WinHeight=0.040000
         TabOrder=10
     End Object
     fl_Penetration=moFloatEdit'BallisticProV55.ConfigMenu_AdvancedWeaponRules.fl_PenetrationFloat'

     Begin Object Class=GUIButton Name=OKButton
         Caption="OK"
         Hint="Save these settings."
         WinTop=0.860000
         WinLeft=0.250000
         WinWidth=0.150000
         TabOrder=11
         OnClick=ConfigMenu_AdvancedWeaponRules.InternalOnClick
         OnKeyEvent=OKButton.InternalOnKeyEvent
     End Object
     bn_OK=GUIButton'BallisticProV55.ConfigMenu_AdvancedWeaponRules.OKButton'

     Begin Object Class=GUIButton Name=DefaultsButton
         Caption="DEFAULTS"
         Hint="Set everything on this page back to how the weapons are made."
         WinTop=0.860000
         WinLeft=0.425000
         WinWidth=0.150000
         TabOrder=12
         OnClick=ConfigMenu_AdvancedWeaponRules.InternalOnClick
         OnKeyEvent=DefaultsButton.InternalOnKeyEvent
     End Object
     bn_Defaults=GUIButton'BallisticProV55.ConfigMenu_AdvancedWeaponRules.DefaultsButton'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         Hint="Leave without saving."
         WinTop=0.860000
         WinLeft=0.600000
         WinWidth=0.150000
         TabOrder=13
         OnClick=ConfigMenu_AdvancedWeaponRules.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bn_Cancel=GUIButton'BallisticProV55.ConfigMenu_AdvancedWeaponRules.CancelButton'

     bRenderWorld=True
     bAllowedAsLast=True
     OnKeyEvent=ConfigMenu_AdvancedWeaponRules.InternalOnKeyEvent
}
