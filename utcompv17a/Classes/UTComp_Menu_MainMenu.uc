

defaultproperties
{
     UTCompMenuButtons(0)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.SkinModelButton'
     UTCompMenuButtons(1)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.ColoredNameButton'
     UTCompMenuButtons(2)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.OverlayButton'
     UTCompMenuButtons(3)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.CrosshairButton'
     UTCompMenuButtons(4)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.HitsoundButton'
     UTCompMenuButtons(5)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.VotingButton'
     UTCompMenuButtons(6)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.AutoDemoButton'
     UTCompMenuButtons(7)=GUIButton'utcompv17a.UTComp_Menu_MainMenu.MiscButton'
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
     c_Main=GUITabControl'utcompv17a.UTComp_Menu_MainMenu.LoginMenuTC'

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
     i_FrameBG2=FloatingImage'utcompv17a.UTComp_Menu_MainMenu.FloatingFrameBackground2'

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
     i_FrameBG=FloatingImage'utcompv17a.UTComp_Menu_MainMenu.FloatingFrameBackground'

     bRequire640x480=True
     bPersistent=True
     bAllowedAsLast=True
     WinTop=0.114990
     WinHeight=0.804690
}
