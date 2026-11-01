class UTComp_Menu_OpenedMenu extends UTComp_Menu_MainMenu;

var automated array<GUILabel> l_Mode;
var automated GUIImage i_UTCompLogo;

var color GoldColor;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	l_Mode[3].Caption="UTComp Version" $ class'GameInfo'.Static.MakeColorCode(GoldColor) $ " " $ class'MutUTComp'.default.Version;
	l_Mode[4].Caption=class'Gameinfo'.Static.MakeColorCode(GoldColor)$"Visit www.ldg-gaming.eu for updates.";
	
	Super.InitComponent(MyController, MyOwner);
}

event Opened(GUIComponent Sender)
{
	local UTComp_SRI UTCompSRI;
	
	Super.Opened(Sender);
	UTCompSRI = UTComp_xPlayer(PlayerOwner()).UTCompSRI;
	
	if (UTCompSRI == None)
		return;
	
	if (UTCompSRI.EnableBrightSkinsMode == 1)
		l_Mode[0].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Brightskins Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ "  Brightskins Disabled";
	else if (UTCompSRI.EnableBrightSkinsMode == 2)
		l_Mode[0].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Brightskins Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ "  Bright Epic Style Skins";
	else if (UTCompSRI.EnableBrightSkinsMode == 3)
		l_Mode[0].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Brightskins Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ "  UTComp Style Skins";
	
	if (UTCompSRI.EnableHitSoundsMode == 0)
		l_Mode[1].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Hitsounds Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ "  Disabled";
	else if (UTCompSRI.EnableHitSoundsMode == 1)
		l_Mode[1].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Hitsounds Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ "  Line Of Sight";
	else if (UTCompSRI.EnableHitSoundsMode == 2)
		l_Mode[1].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Hitsounds Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ "  Everywhere";
	
	if(UTCompSRI.bEnableDoubleDamage)
		l_Mode[2].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Double Damage Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ " Enabled";
	else
		l_Mode[2].Caption = class'GameInfo'.Static.MakeColorCode(GoldColor) $ "Double Damage Mode:" $ class'GameInfo'.Static.MakeColorCode(WhiteColor) $ " Disabled";
}

defaultproperties
{
     l_Mode(0)=GUILabel'utcompr04.UTComp_Menu_OpenedMenu.BrightSkinsModeLabel'
     l_Mode(1)=GUILabel'utcompr04.UTComp_Menu_OpenedMenu.HitSoundsModeLabel'
     l_Mode(2)=GUILabel'utcompr04.UTComp_Menu_OpenedMenu.AmpModeLabel'
     l_Mode(3)=GUILabel'utcompr04.UTComp_Menu_OpenedMenu.VersionLabel'
     l_Mode(4)=GUILabel'utcompr04.UTComp_Menu_OpenedMenu.NewVersions'
     l_Mode(5)=GUILabel'utcompr04.UTComp_Menu_OpenedMenu.ServerSetLabel'
     Begin Object Class=GUIImage Name=UTCompLogo
         Image=Texture'utcompr04.UTCompLogo'
         ImageStyle=ISTY_Scaled
         WinTop=0.307000
         WinLeft=0.312500
         WinWidth=0.375000
         WinHeight=0.125000
     End Object
     i_UTCompLogo=GUIImage'utcompr04.UTComp_Menu_OpenedMenu.UTCompLogo'

     GoldColor=(G=200,R=230)
}
