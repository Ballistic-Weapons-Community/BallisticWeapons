class UTComp_Overlay_BW_FR extends Interaction;

var Font InfoFont;
var Font LocationFont;

var int OldScreenWidth, OldFontSize;

var float OnJoinMessageDrawTime;
var float OnJoinMessageDrawTimeBW;

var float OverlayLocX, OverlayLocY;

var color InfoTextColor;

event NotifyLevelChange()
{
	Master.RemoveInteraction(self);
}

event Initialized()
{				
	OnJoinMessageDrawTime = ViewPortOwner.Actor.Level.TimeSeconds+class'UTComp_Overlay'.default.DesiredOnJoinMessageTime;
	OnJoinMessageDrawTimeBW = ViewPortOwner.Actor.Level.TimeSeconds+class'UTComp_Overlay'.default.DesiredOnJoinMessageTime * 2;
}

function PostRender(Canvas Canvas)
{
	local string CmdText, PressText, ChangeTextA, ChangeTextB;
	local UTComp_PRI_BW_FR_LDG uPRI;
	local float XL, YL;
	local PlayerReplicationInfo PRI;
	
	if(Freon_Player_UTComp_LDG(ViewportOwner.Actor) != None)
	{
		if(Freon_Player_UTComp_LDG(ViewportOwner.Actor).UTCompPRI != None)
			uPRI = Freon_Player_UTComp_LDG(ViewportOwner.Actor).UTCompPRI;
			
		PRI = ViewportOwner.Actor.PlayerReplicationInfo;
	}
	
	if(uPRI == None || PRI == None || ViewportOwner.Actor.myHUD.bShowScoreBoard || ViewportOwner.Actor.myHUD.bShowLocalStats)
		return;

	OverlayLocX = Canvas.ClipX * class'UTComp_Overlay'.default.HorizPosition;
	OverlayLocY =  Canvas.ClipY * class'UTComp_Overlay'.default.VertPosition;

	if((Canvas.SizeX != OldScreenWidth) || InfoFont == None || LocationFont == None || OldFontSize != class'UTComp_Overlay'.default.TheFontSize)
	{
		GetFonts(Canvas);
		
		OldFontSize = class'UTComp_Overlay'.default.TheFontSize;
		OldScreenWidth = Canvas.SizeX;
	}
	
	if(ViewPortOwner.Actor.Level.TimeSeconds < OnJoinMessageDrawTimeBW)
	{
		Canvas.SetPos(OverlayLocX, OverlayLocY);
		Canvas.Style = 5;
		Canvas.DrawColor = class'UTComp_Overlay'.default.BGColor;
		Canvas.Font = GetFont(AutoPickFont(Canvas.SizeX, -3), 1);
		Canvas.StrLen("This server is running", XL, YL);
		Canvas.DrawTileStretched(material'Engine.WhiteTexture',XL + 5.0, 6 * (YL));  
		Canvas.SetPos(OverlayLocX, OverlayLocY);
		Canvas.DrawColor = InfoTextColor;
		Canvas.DrawText("This server is running");
		Canvas.StrLen("W", XL, YL);
		Canvas.SetPos(OverlayLocX, OverlayLocY + 1 * (YL + 2.0));
				
		if (ViewPortOwner.Actor.Level.TimeSeconds < OnJoinMessageDrawTime)
		{
			CmdText =	class'GameInfo'.Static.GetKeyBindName("ballistic", Freon_Player_UTComp_LDG(ViewportOwner.Actor));
			if (CmdText ~= "ballistic")
			{
				PressText = "Type ";
				ChangeTextA = " to";
				ChangeTextB = "change your settings.";
			}
			else
			{
				PressText = "Press ";
				ChangeTextA = " to change";
				ChangeTextB = "your settings.";
			}	
		
			Canvas.DrawText("BW Version 2.5 " $ MakeColorCode(class'Hud'.Default.GoldColor) $ "PRO" $ MakeColorCode(InfoTextColor) $ ".");
			Canvas.SetPos(OverlayLocX, OverlayLocY + 3 * (YL + 2.0));
			Canvas.DrawText(PressText $ MakeColorCode(class'Hud'.Default.GoldColor) $ CmdText $ MakeColorCode(InfoTextColor) $ ChangeTextA);
			Canvas.SetPos(OverlayLocX, OverlayLocY + 4 * (YL + 2.0));
			Canvas.DrawText(ChangeTextB);
		}
		else
		{
			CmdText =	class'GameInfo'.Static.GetKeyBindName("mymenu", Freon_Player_UTComp_LDG(ViewportOwner.Actor));
	 		if (CmdText ~= "mymenu")
	 		{
	 			PressText = "Type ";
	 			ChangeTextA = " to";
				ChangeTextB = "change your settings.";
			}
	 		else
	 		{
	 			PressText = "Press ";
	 			ChangeTextA = " to change";
				ChangeTextB = "your settings.";
	 		}
			
			Canvas.DrawText("UTComp " $ MakeColorCode(class'Hud'.Default.GoldColor) $ "FREON BW" $ MakeColorCode(InfoTextColor) $ ".");
			Canvas.SetPos(OverlayLocX, OverlayLocY + 3 * (YL + 2.0));
			Canvas.DrawText(PressText $ MakeColorCode(class'Hud'.Default.GoldColor) $ CmdText $ MakeColorCode(InfoTextColor) $ ChangeTextA);
			Canvas.SetPos(OverlayLocX, OverlayLocY + 4 * (YL + 2.0));
			Canvas.DrawText(ChangeTextB);
		}
	}
}

function string MakeColorCode (Color aColor)
{
  return Chr(0x1B) $ Chr(Max(aColor.R,1)) $ Chr(Max(aColor.G,1)) $ Chr(Max(aColor.B,1));
}

function GetFonts(Canvas Canvas)
{
	InfoFont = GetFont(AutoPickFont(Canvas.SizeX, class'UTComp_Overlay'.default.TheFontSize), 1);
	LocationFont = GetFont(AutoPickFont(Canvas.SizeX, class'UTComp_Overlay'.default.TheFontSize - 1), 1);
}

// Picks an appropriate font based on SrcWidth
function string AutoPickFont(int SrcWidth, int SizeModifier)
{
	local string FontArrayNames[9];
	local int FontScreenWidthMedium[9], i, Rec;
	
	// ScreenWidths to look at
	FontScreenWidthMedium[0] = 2048;
	FontScreenWidthMedium[1] = 1600;
	FontScreenWidthMedium[2] = 1280;
	FontScreenWidthMedium[3] = 1024;
	FontScreenWidthMedium[4] = 800;
	FontScreenWidthMedium[5] = 640;
	FontScreenWidthMedium[6] = 512;
	FontScreenWidthMedium[7] = 400;
	FontScreenWidthMedium[8] = 320;
	
	FontArrayNames[0] = "2K4Fonts.Verdana34";
	FontArrayNames[1] = "2K4Fonts.Verdana28";
	FontArrayNames[2] = "2K4Fonts.Verdana24";
	FontArrayNames[3] = "2K4Fonts.Verdana20";
	FontArrayNames[4] = "2K4Fonts.Verdana16";
	FontArrayNames[5] = "2K4Fonts.Verdana14";
	FontArrayNames[6] = "2K4Fonts.Verdana12";
	FontArrayNames[7] = "2K4Fonts.Verdana8";
	FontArrayNames[8] = "2K4Fonts.FontSmallText";
	
	for(i = 1; i < 9; i++)
	{
		if(FontScreenWidthMedium[i] < SrcWidth)
		{
			Rec = FClamp((i - 1 - SizeModifier), 0, 8);
			break;
		}
	}
	
	if(Rec == 9)
		log ("Font selection error");

	return FontArrayNames[Rec];
}

function Font GetFont(string FontClassName, float ResX)
{
	local Font fnt;
	
	fnt = GetGUIFont(FontClassName, ResX);
	if ( fnt == None )
		fnt = Font(DynamicLoadObject(FontClassName, class'Font'));
	
	if ( fnt == None )
		log(Name$" - FONT NOT FOUND '"$FontClassName$"'",'Error');
	
	return fnt;
}

// Copied from XInterface.DrawOpBase
function Font GetGUIFont( string FontClassName, float ResX )
{
	local class<GUIFont> FntCls;
	local GUIFont Fnt;

	FntCls = class<GUIFont>(DynamicLoadObject(FontClassName, class'Class',True));
	if (FntCls != None)
		Fnt = new(None) FntCls;
	
	if ( Fnt == None )
		return None;
	
	return Fnt.GetFont(ResX);
}

exec function SetCurrentColoredName(int i)
{
	if (i >= 0 && i < class'UTComp_Settings'.default.ColoredName.Length)
	{
		class'UTComp_Settings'.default.CurrentSelectedColoredName = i;
		Freon_Player_UTComp_LDG(ViewportOwner.Actor).SetColoredNameOldStyleCustom(,i);		
    class'UTComp_xPlayer'.static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();
  }
}

defaultproperties
{
     InfoTextColor=(B=255,G=255,R=255,A=255)
     bVisible=True
}
