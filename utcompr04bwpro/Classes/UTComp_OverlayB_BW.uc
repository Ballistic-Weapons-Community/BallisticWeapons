class UTComp_OverlayB_BW extends UTComp_OverlayB;

var Combiner wpCombs[16];
var Shader wpShad[16];

var float OnJoinMessageDrawTimeBW;

#exec TEXTURE IMPORT FILE="Textures\BackgroundOverlayBW.bmp" NAME="BackgroundOverlayBW" GROUP="Overlay" DXT=3

event Initialized()
{
	local int i;
	
	foreach ViewportOwner.Actor.DynamicActors(class'GameReplicationInfo', GRI)
		if (GRI != None)
			break;
			
	OnJoinMessageDrawTime = ViewPortOwner.Actor.Level.TimeSeconds+class'UTComp_Overlay'.default.DesiredOnJoinMessageTime;
	OnJoinMessageDrawTimeBW = ViewPortOwner.Actor.Level.TimeSeconds+class'UTComp_Overlay'.default.DesiredOnJoinMessageTime * 2;

	for(i = 0; i < 16; i++)
	{
		wpCombs[i] = new class'Combiner';
		wpCombs[i].Material1 = texture'BackgroundOverlayBW';
		wpCombs[i].CombineOperation = CO_Add_With_Mask_Modulation;
		wpCombs[i].AlphaOperation = AO_Use_Alpha_From_Material2; //wtf?
		
		wpShad[i] = new class'Shader';
		wpShad[i].Diffuse = wpCombs[i];
		wpShad[i].OutputBlending = OB_Masked;
	}
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
	
	if(ViewPortOwner.Actor.Level.TimeSeconds < OnJoinMessageDrawTimeBW)
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
				
		if (ViewPortOwner.Actor.Level.TimeSeconds<OnJoinMessageDrawTime)
		{
			CmdText =	class'GameInfo'.Static.GetKeyBindName("ballistic", UTComp_xPlayer(ViewportOwner.Actor));
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
			Canvas.SetPos(OverlayLocX, OverlayLocY + 3 * (YL4 + 2.0));
			Canvas.DrawText(PressText $ MakeColorCode(class'Hud'.Default.GoldColor) $ CmdText $ MakeColorCode(InfoTextColor) $ ChangeTextA);
			Canvas.SetPos(OverlayLocX, OverlayLocY + 4 * (YL4 + 2.0));
			Canvas.DrawText(ChangeTextB);
		}
		else
		{
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
			
			Canvas.DrawText("UTComp " $ MakeColorCode(class'Hud'.Default.GoldColor) $ class'MutUTComp'.default.Version $ MakeColorCode(InfoTextColor) $ ".");
			Canvas.SetPos(OverlayLocX, OverlayLocY + 3 * (YL4 + 2.0));
			Canvas.DrawText(PressText $ MakeColorCode(class'Hud'.Default.GoldColor) $ CmdText $ MakeColorCode(InfoTextColor) $ ChangeTextA);
			Canvas.SetPos(OverlayLocX, OverlayLocY + 4 * (YL4 + 2.0));
			Canvas.DrawText(ChangeTextB);
		}
		return;
	}
	
	if(!class'UTComp_Overlay'.default.OverlayEnabled || PRI.bOnlySpectator)
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

function DrawIcons(UTComp_PRI uPRI, Canvas Canvas)
{
	local int i,Start;
	local Texture WepIcon;
	local UTComp_PRI_BW uPRI_BW;
	local class<BallisticWeapon> BW;
	
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
			continue;
		}
		
		//BW icons
		uPRI_BW = UTComp_PRI_BW(uPRI);
		
		if (uPRI_BW == None || uPRI_BW.OverlayInfoWeapons[i] == "")
			continue;
			
		BW = class<BallisticWeapon>(DynamicLoadObject(uPRI_BW.OverlayInfoWeapons[i], class'Class'));
		if (BW == None)
			continue;
		
		wpCombs[i].Material2 = BW.default.BigIconMaterial;
		wpShad[i].Opacity = BW.default.BigIconMaterial;

		//512x256 -> 32x16 (divide by 16)
		//move it a bit left
	  Canvas.SetPos(OverlayLocX + WepIconOffset - (IconScale / 16) * 0.1, OverlayLocY + (InfoFontHeight + LocationFontHeight) * (i - Start) - (IconScale / 16) * 0.1);
	  //increase the icon by 20%
	  Canvas.DrawTileScaled(wpShad[i], (IconScale / 16) * 1.2, (IconScale / 16) * 1.2);
	}
}

defaultproperties
{
}
