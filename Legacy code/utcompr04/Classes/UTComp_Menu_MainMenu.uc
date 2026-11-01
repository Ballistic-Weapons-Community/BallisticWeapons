class UTComp_Menu_MainMenu extends PopupPageBase;

var automated array<GUIButton> UTCompMenuButtons;
var array<class<UTComp_Menu_MainMenu> > UTCompMenus;
var automated GUITabControl c_Main;
var automated FloatingImage i_FrameBG2;

function bool InternalOnClick(GUIComponent C)
{
	local int i;
	
	for (i = 0; i < UTCompMenuButtons.Length; i++)
	{
		if (C == UTCompMenuButtons[i])
		{
			PlayerOwner().ClientReplaceMenu(string(UTCompMenus[i]));
			break;
		}
	}
	
  return false;
}

function OnClose(optional bool bCancelled)
{
   if(PlayerOwner().IsA('UTComp_xPlayer'))
   {
      UTComp_xPlayer(PlayerOwner()).ReSkinAll();
      UTComp_xPlayer(PlayerOwner()).InitializeScoreboard();
      UTComp_xPlayer(PlayerOwner()).MatchHudColor();
   }
   super.OnClose(bCancelled);
}

defaultproperties
{
     UTCompMenuButtons(0)=GUIButton'utcompr04.UTComp_Menu_MainMenu.SkinModelButton'
     UTCompMenuButtons(1)=GUIButton'utcompr04.UTComp_Menu_MainMenu.ColoredNameButton'
     UTCompMenuButtons(2)=GUIButton'utcompr04.UTComp_Menu_MainMenu.OverlayButton'
     UTCompMenuButtons(3)=GUIButton'utcompr04.UTComp_Menu_MainMenu.CrosshairButton'
     UTCompMenuButtons(4)=GUIButton'utcompr04.UTComp_Menu_MainMenu.HitsoundButton'
     UTCompMenuButtons(5)=GUIButton'utcompr04.UTComp_Menu_MainMenu.AutoDemoButton'
     UTCompMenuButtons(6)=GUIButton'utcompr04.UTComp_Menu_MainMenu.MiscButton'
     UTCompMenuButtons(7)=GUIButton'utcompr04.UTComp_Menu_MainMenu.JukeboxButton'
     UTCompMenus(0)=Class'utcompr04.UTComp_Menu_BrightSkins'
     UTCompMenus(1)=Class'utcompr04.UTComp_Menu_ColorNames'
     UTCompMenus(2)=Class'utcompr04.UTComp_Menu_TeamOverlay'
     UTCompMenus(3)=Class'utcompr04.UTComp_Menu_Crosshairs'
     UTCompMenus(4)=Class'utcompr04.UTComp_Menu_HitSounds'
     UTCompMenus(5)=Class'utcompr04.UTComp_Menu_AutoDemoSS'
     UTCompMenus(6)=Class'utcompr04.UTComp_Menu_Miscellaneous'
     UTCompMenus(7)=Class'utcompr04.UTComp_Menu_Jukebox'
     Begin Object Class=GUITabControl Name=LoginMenuTC
         bFillSpace=True
         bDockPanels=True
         WinTop=0.072718
         WinLeft=0.134782
         WinWidth=0.725325
         WinHeight=0.208177
         bScaleToParent=True
         bAcceptsInput=True
         OnActivate=LoginMenuTC.InternalOnActivate
     End Object
     c_Main=GUITabControl'utcompr04.UTComp_Menu_MainMenu.LoginMenuTC'

     Begin Object Class=FloatingImage Name=FloatingFrameBackground2
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         DropShadowX=0
         DropShadowY=0
         WinTop=0.270000
         WinLeft=0.075000
         WinWidth=0.850000
         WinHeight=0.580000
         RenderWeight=0.020000
         bBoundToParent=False
         bScaleToParent=False
     End Object
     i_FrameBG2=FloatingImage'utcompr04.UTComp_Menu_MainMenu.FloatingFrameBackground2'

     Begin Object Class=FloatingImage Name=FloatingFrameBackground
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         DropShadowX=0
         DropShadowY=0
         WinTop=0.100000
         WinLeft=0.075000
         WinWidth=0.850000
         WinHeight=0.750000
         RenderWeight=0.010000
         bBoundToParent=False
         bScaleToParent=False
     End Object
     i_FrameBG=FloatingImage'utcompr04.UTComp_Menu_MainMenu.FloatingFrameBackground'

     bRequire640x480=True
     bPersistent=True
     bAllowedAsLast=True
     WinTop=0.114990
     WinHeight=0.804690
}
