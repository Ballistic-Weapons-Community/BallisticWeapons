class UTComp_OverlayB extends Interaction;

#exec TEXTURE IMPORT FILE=Textures\weaponicon_assaultrifle.dds 			NAME=AssaultIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_biorifle.dds 					NAME=BioIcon 				MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_linkgun.dds 					NAME=LinkIcon 			MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_flakcannon.dds 				NAME=FlakIcon 			MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_rocketlauncher.dds	 	NAME=RocketIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_minigun.dds 					NAME=MiniIcon 			MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_shockrifle.dds 				NAME=ShockIcon 			MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_lightninggun.dds 			NAME=LightningIcon 	MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_shieldgun.dds 				NAME=ShieldIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_SniperRifle.dds 			NAME=SniperIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_dualassaultrifle.dds 	NAME=DualARIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_GrenadeLauncher.dds 	NAME=GrenadeIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_MineLayer.dds 				NAME=SpiderIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_Avril.dds 						NAME=AvrilIcon 			MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_Redeemer.dds 					NAME=RedeemerIcon 	MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_Painter.dds 					NAME=PainterIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\weaponicon_Translocator.dds 			NAME=TranslocIcon 	MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Manta.dds 								NAME=MantaIcon 			MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Goliath.dds 							NAME=GoliathIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Hellbender.dds 					NAME=HellbenderIcon MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Scorpion.dds 						NAME=ScorpionIcon 	MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Raptor.dds 							NAME=RaptorIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Leviathan.dds 						NAME=LeviathanIcon 	MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Turret.dds 							NAME=TurretIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_SPMA.tga 								NAME=SPMAIcon 			MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Cicada.tga 							NAME=CicadaIcon 		MIPS=OFF ALPHA=1
#exec TEXTURE IMPORT FILE=Textures\vehicle_Paladin.tga 							NAME=PaladinIcon 		MIPS=OFF ALPHA=1

var GameReplicationInfo GRI;
var Font InfoFont, LocationFont;
var float HealthOffset, ArmorOffset, WepIconOffset;
var float OverlayLocX, OverlayLocY;
var float IconScale, InfoFontHeight, LocationFontHeight;
var float OnJoinMessageDrawTime;

var float MinPosY;
var bool bHideOverlay;
var float SwapTime;

var bool bFirstEight;

var color InfoTextColor;
var int NumPlayers;
var int OldScreenWidth, OldFontSize;

event NotifyLevelChange()
{
	Master.RemoveInteraction(self);
}

event Initialized()
{
	foreach ViewportOwner.Actor.DynamicActors(class'GameReplicationInfo', GRI)
	  if (GRI != None)
			Break;
	      
	OnJoinMessageDrawTime = ViewPortOwner.Actor.Level.TimeSeconds + class'UTComp_Overlay'.default.DesiredOnJoinMessageTime;
}

function PostRender(Canvas Canvas)
{
	local int i;
	local string ScreenIDText, CmdText, PressText, ChangeTextA, ChangeTextB;
	local UTComp_PRI uPRI;
	local float XL1, YL1, XL2, YL2, XL3, YL3, XL4, YL4;
	local PlayerReplicationInfo PRI;
	
	if(UTComp_xPlayer(ViewportOwner.Actor) != None)
	{
		if(UTComp_xPlayer(ViewportOwner.Actor).UTCompPRI != None)
			uPRI = UTComp_xPlayer(ViewportOwner.Actor).UTCompPRI;
			
		PRI = ViewportOwner.Actor.PlayerReplicationInfo;
	}
	
	if(uPRI == None || PRI == None || ViewportOwner.Actor.myHUD.bShowScoreBoard || ViewportOwner.Actor.myHUD.bShowLocalStats)
		return;

	OverlayLocX = Canvas.ClipX * class'UTComp_Overlay'.default.HorizPosition;
	
	//check minium offset for the overlay and that it is left
	if (class'UTComp_Overlay'.default.VertPosition > MinPosY || class'UTComp_Overlay'.default.HorizPosition > 0.5)
		OverlayLocY =  Canvas.ClipY * class'UTComp_Overlay'.default.VertPosition;
	else
		OverlayLocY = Canvas.ClipY * MinPosY;	//min
	
	if((Canvas.SizeX != OldScreenWidth) || InfoFont == None || LocationFont == None || OldFontSize != class'UTComp_Overlay'.default.TheFontSize)
	{
		GetFonts(Canvas);
		
		OldFontSize = class'UTComp_Overlay'.default.TheFontSize;
		OldScreenWidth = Canvas.SizeX;
		
		Canvas.Font = InfoFont;
		Canvas.StrLen("X", XL2, YL2);
		InfoFontHeight = YL2;
		
		Canvas.Font = LocationFont;
		Canvas.StrLen("X", XL3, YL3);
		LocationFontHeight = YL3;
		
		IconScale = YL2 / 16.0;
		HealthOffset = 15 * XL2;
		ArmorOffset = 19 * XL2;
		WepIconOffset = 23 * XL2;
	}
	
	if(ViewPortOwner.Actor.Level.TimeSeconds < OnJoinMessageDrawTime)
	{
		Canvas.SetPos(OverlayLocX, OverlayLocY);
		Canvas.Style = 5;
		Canvas.DrawColor = class'UTComp_Overlay'.default.BGColor;
		Canvas.Font = GetFont(AutoPickFont(Canvas.SizeX, -3), 1);
		Canvas.StrLen("This server is running", XL4, YL4);
		Canvas.DrawTileStretched(material'Engine.WhiteTexture',XL4 + 5.0, 6 * (YL4));  
		Canvas.SetPos(OverlayLocX, OverlayLocY);
		Canvas.DrawColor = InfoTextColor;
		Canvas.DrawText("This server is running");
		Canvas.StrLen("W", XL4, YL4);
		Canvas.SetPos(OverlayLocX, OverlayLocY + 1 * (YL4 + 2.0));
		Canvas.DrawText("UTComp " $ MakeColorCode(class'Hud'.Default.GoldColor) $ class'MutUTComp'.default.Version $ MakeColorCode(InfoTextColor) $ ".");
		Canvas.SetPos(OverlayLocX, OverlayLocY + 3 * (YL4 + 2.0));
		
		CmdText =	class'GameInfo'.Static.GetKeyBindName("mymenu", UTComp_xPlayer(ViewportOwner.Actor));
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
		
		Canvas.DrawText(PressText $ MakeColorCode(class'Hud'.Default.GoldColor) $ CmdText $ MakeColorCode(InfoTextColor) $ ChangeTextA);
		Canvas.SetPos(OverlayLocX, OverlayLocY + 4 * (YL4 + 2.0));
		Canvas.DrawText(ChangeTextB);
		return;
	}
	
	if(!class'UTComp_Overlay'.default.OverlayEnabled || PRI.bOnlySpectator || bHideOverlay)
		return;

  // Draw BackGround
  NumPlayers = 0;
    
	for(i = 0; i < 16; i++)
    if(uPRI.OverlayInfo[i].PRI != None)
			NumPlayers++;
         
	if(NumPlayers <= 0)
		return;
		
	if (SwapTime <= 0.0)
	{
		bFirstEight = true;
		SwapTime = ViewportOwner.Actor.Level.TimeSeconds + 5.0;
	}
	else if (ViewportOwner.Actor.Level.TimeSeconds > SwapTime)
	{
		if (NumPlayers > 8)
		{
			bFirstEight = !bFirstEight;
			SwapTime = ViewportOwner.Actor.Level.TimeSeconds + 5.0;
		}
		else
		{
			bFirstEight = true;
			SwapTime = ViewportOwner.Actor.Level.TimeSeconds + 5.0;
		}
	}
	
	Canvas.Style = 5;
	Canvas.SetPos(OverlayLocX, OverlayLocY);
	// Canvas.SetDrawColor(10,10,10,155);
	Canvas.DrawColor = class'UTComp_Overlay'.default.BGColor;
	
	if(class'UTComp_Overlay'.default.bDrawIcons)
	{
		if (!bFirstEight)
			Canvas.DrawTileStretched(Material'Engine.WhiteTexture', WepIconOffset + IconScale * 40.0, 8 * (InfoFontHeight + LocationFontHeight) + 24.0 * IconScale);
		else
			Canvas.DrawTileStretched(Material'Engine.WhiteTexture', WepIconOffset + IconScale * 40.0, Min(NumPlayers, 8) * (InfoFontHeight + LocationFontHeight) + 24.0 * IconScale);
		
		// Draw Health/Armor Icons
		Canvas.SetPos((OverlayLocX + HealthOffset + OverlayLocX + ArmorOffset - 24.0 * IconScale) / 2, OverlayLocY);
		Canvas.SetDrawColor(255, 255, 255, 255);
		Canvas.DrawTile(Material'HudContent.Generic.Hud', 24 * IconScale, 24 * IconScale,75,167,48,48);
		
		Canvas.SetPos((2 * OverlayLocX + ArmorOffset + WepIconOffset - 24.0 * IconScale) / 2, OverlayLocY);
		Canvas.DrawTile(Material'HudContent.Generic.Hud', 24 * IconScale, 25 * IconScale, 1, 248, 66, 66);
		
		if (NumPlayers > 8)
		{
			Canvas.Font = InfoFont;
			
			if (bFirstEight)
				ScreenIDText = "I";		
			else
				ScreenIDText = "II";	
			
			Canvas.StrLen(ScreenIDText, XL1, YL1);
			Canvas.SetPos(OverlayLocX + WepIconOffset + 16 * IconScale - XL1 / 2, OverlayLocY + 12 * IconScale - YL1 / 2);
			Canvas.DrawText(ScreenIDText);
		}
		
		OverlayLocY += 24.0 * IconScale;
	}
	else
		Canvas.DrawTileStretched(Material'Engine.WhiteTexture', WepIconOffset + IconScale * 40.0, NumPlayers * (InfoFontHeight + LocationFontHeight));
        
	DrawPlayerNames(uPRI, Canvas);
	DrawHealth(uPRI, Canvas);
	DrawArmor(uPRI, Canvas);
	DrawIcons(uPRI, Canvas);
	DrawLocation(uPRI, Canvas);
}

function string MakeColorCode(color aColor)
{
	return Chr(0x1B) $ Chr(Max(aColor.R, 1)) $ Chr(Max(aColor.G, 1)) $ Chr(Max(aColor.B, 1));
}

function DrawPlayerNames(UTComp_PRI uPRI, Canvas Canvas)
{
  local int i, Start;
  local float OldClipX;
  local float LenX, LenY;

  OldClipX = Canvas.ClipX;
  Canvas.ClipX = OverlayLocX + HealthOffset;
  
  if (bFirstEight)
  	Start = 0;
  else
  	Start = Max(0, NumPlayers - 8); //just to be sure
  
    for(i = Start; i < Start + 8; i++)
    {
      if(uPRI.OverlayInfo[i].PRI == None)
				break;
         
			if (uPRI.OverlayInfo[i].PRI.HasFlag != None || (uPRI.OverlayInfo[i].PRI.Team != None && 
				(GRI != None && GRI.FlagHolder[uPRI.OverlayInfo[i].PRI.Team.TeamIndex] == uPRI.OverlayInfo[i].PRI)))
				Canvas.SetDrawColor(255,255,0);
			else if(uPRI.bHasDD[i] == 1)
				Canvas.SetDrawColor(255,0,255);
			else
				Canvas.DrawColor = class'UTComp_Overlay'.default.InfoTextColor;
	
			Canvas.StrLen(uPRI.OverlayInfo[i].PRI.PlayerName, LenX, LenY);
			
			if(LenX > HealthOffset)
				Canvas.Font = LocationFont;
			else
				Canvas.Font = InfoFont;
				
			Canvas.SetPos(OverlayLocX + OldClipX * 0.003, OverlayLocY + (InfoFontHeight + LocationFontHeight) * (i - Start));
			Canvas.DrawTextClipped(uPRI.OverlayInfo[i].PRI.PlayerName);
    }
    
    Canvas.ClipX = OldClipX;
}

function DrawHealth(UTComp_PRI uPRI, Canvas Canvas)
{
	local int i, Start;
	
	Canvas.Font = InfoFont;
	
	if (bFirstEight)
		Start = 0;
	else
		Start = Max(0, NumPlayers - 8); //just to be sure
	
	for(i = Start; i < Start + 8; i++)
	{
		if(uPRI.OverlayInfo[i].PRI == None)
			return;
			
		if(uPRI.OverlayInfo[i].Health >= 100)
			Canvas.SetDrawColor(0, 255, 0, 255);
		else if(uPRI.OverlayInfo[i].Health >= 45 && uPRI.OverlayInfo[i].Health < 100)
			Canvas.SetDrawColor(255, 255, 0, 255);
		else if(uPRI.OverlayInfo[i].Health < 45)
			Canvas.SetDrawColor(255, 0, 0, 255);
			
		if(uPRI.OverlayInfo[i].Health < 1000)
			Canvas.DrawTextJustified(uPRI.OverlayInfo[i].Health, 1, OverlayLocX + HealthOffset, OverlayLocY + (InfoFontHeight + LocationFontHeight) * (i - Start), OverlayLocX + ArmorOffset, OverlayLocY + InfoFontHeight * (i - Start + 1) + LocationFontHeight * (i - Start));
		else
			Canvas.DrawTextJustified(Left(String(uPRI.OverlayInfo[i].Health), Len(uPRI.OverlayInfo[i].Health)-3) $ "K", 1, OverlayLocX + HealthOffset, OverlayLocY + (InfoFontHeight + LocationFontHeight) * (i - Start), OverlayLocX + ArmorOffset, OverlayLocY + InfoFontHeight * (i - Start + 1) + LocationFontHeight * (i - Start));
	}
}

function DrawArmor(UTComp_PRI uPRI, Canvas Canvas)
{
	local int i,Start;
	
	if (bFirstEight)
		Start = 0;
	else
		Start = Max(0, NumPlayers - 8); //just to be sure
	
	Canvas.SetDrawColor(255,255,255,255);
	for(i = Start; i < Start + 8; i++)
	{
		if(uPRI.OverlayInfo[i].PRI == None)
			return;
			
		Canvas.DrawTextJustified(uPRI.OverlayInfo[i].Armor, 1, OverlayLocX + ArmorOffset, OverlayLocY + (InfoFontHeight + LocationFontHeight) * (i - Start), OverlayLocX + WepIconOffset, OverlayLocY + InfoFontHeight * (i - Start + 1) + LocationFontHeight * (i - Start));
	}
}

function DrawIcons(UTComp_PRI uPRI, Canvas Canvas)
{
	local int i,Start;
	local Texture WepIcon;
	
	Canvas.SetDrawColor(255,255,255,255);
	
	if (bFirstEight)
		Start = 0;
	else
		Start = Max(0, NumPlayers - 8); //just to be sure

	for(i = Start; i < Start + 8; i++)
	{
		if(uPRI.OverlayInfo[i].PRI == None)
			break;
			
		switch(uPRI.OverlayInfo[i].Weapon)
		{
			case 1:
				WepIcon = Texture'shieldIcon'; 
				break;
			
			case 2:
				WepIcon = Texture'AssaultIcon'; 
				break;
				
			case 3:
				WepIcon = Texture'BioIcon';
				break;
				
			case 4:
				WepIcon = Texture'ShockIcon';
				break;
				
			case 5:
				WepIcon = Texture'LinkIcon';
				break;
				
			case 6:
				WepIcon = Texture'MiniIcon';
				break;
				
			case 7:
				WepIcon = Texture'FlakIcon';
				break;
				
			case 8:
				WepIcon = Texture'RocketIcon';
				break;
				
			case 9:
				WepIcon = Texture'LightningIcon';
				break;
				
			case 10:
				WepIcon = Texture'SniperIcon';
				break;
				
			case 11:
				WepIcon = Texture'DualARIcon';
				break;
				
			case 12:
				WepIcon = Texture'SpiderIcon';
				break;
				
			case 13:
				WepIcon = Texture'GrenadeIcon';
				break;
				
			case 14:
				WepIcon = Texture'AvrilIcon';
				break;
				
			case 15:
				WepIcon = Texture'RedeemerIcon';
				break;
				
			case 16:
				WepIcon = Texture'PainterIcon';
				break;
				
			case 17:
				WepIcon = Texture'translocicon';
				break;
				
			case 21:
				WepIcon = Texture'MantaIcon';
				break;
				
			case 22:
				WepIcon = Texture'GoliathIcon';
				break;
				
			case 23:
				WepIcon = Texture'ScorpionIcon';
				break;
				
			case 24:
				WepIcon = Texture'HellbenderIcon';
				break;
				
			case 25:
				WepIcon = Texture'LeviathanIcon';
				break;
				
			case 26:
				WepIcon = Texture'RaptorIcon';
				break;
				
			case 27:
				WepIcon = Texture'CicadaIcon';
				break;
				
			case 28:
				WepIcon = Texture'PaladinIcon';
				break;
				
			case 29:
				WepIcon = Texture'SPMAIcon';
				break;
				
			default:
				WepIcon = None;
		}
		
		if(WepIcon != None)
		{
			Canvas.SetPos(OverlayLocX + WepIconOffset, OverlayLocY + (InfoFontHeight + LocationFontHeight) * (i - Start));
			Canvas.DrawIcon(WepIcon, IconScale);
		}
	}
}

function DrawLocation(UTComp_PRI uPRI, Canvas Canvas)
{
	local int i, Start;
	local float OldClipX;
	
	if (bFirstEight)
		Start = 0;
	else
		Start = Max(0, NumPlayers - 8); //just to be sure
	
	Canvas.DrawColor = class'UTComp_Overlay'.default.LocTextColor;
	Canvas.Font = LocationFont;
	OldClipX = Canvas.ClipX;
	Canvas.ClipX = OverlayLocX + WepIconOffset + 40.0 * IconScale;
	
	for(i = Start; i < Start + 8; i++)
	{
		if(uPRI.OverlayInfo[i].PRI == None)
			break;
			
		Canvas.SetPos(OverlayLocX + OldClipX * 0.003, OverlayLocY + InfoFontHeight * (i - Start + 1) + LocationFontHeight * (i - Start));
		Canvas.DrawTextClipped(uPRI.OverlayInfo[i].PRI.GetLocationName());
	}
	
	Canvas.ClipX = OldClipX;
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
		UTComp_xPlayer(ViewportOwner.Actor).SetColoredNameOldStyleCustom(,i);		
    class'UTComp_xPlayer'.static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();
  }
}

defaultproperties
{
     MinPosY=0.065000
     InfoTextColor=(B=255,G=255,R=255,A=255)
     bVisible=True
}
