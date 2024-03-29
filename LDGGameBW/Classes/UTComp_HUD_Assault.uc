class UTComp_Hud_Assault extends HudWAssault;

//BEGIN_HUD_DECL
var() SpriteWidget HudBorderSprint, HudBorderCharge;
var() SpriteWidget SprintBar;
var bool bOffsetLocalMessages;
//Inserted 3 lines.
//END_HUD_DECL

//AS is overriding this ._.
simulated function DrawTimer(Canvas C);

simulated function ShowTeamScorePassA(Canvas C)
{
	local float	PosY, MinUtCompOverlayY;
	local PlayerController PC;
	local int i;

	if ( ASGRI == None )
		return;

	//only if UTComp TeamOverlay is on
	if (!class'UTComp_Overlay'.default.OverlayEnabled)
	{
		Super.ShowTeamScorePassA(C);
		return;
	}

	
	//
	// HUDBase texture
	//

	MinUtCompOverlayY = 0.005;

	/* Round Time Limit */
	if ( ASGRI.RoundTimeLimit > 0 )
	{
		RoundTimeBackground.Tints[TeamIndex] = HudColorBlack;
		RoundTimeBackground.Tints[TeamIndex].A = 150;
		DrawWidgetAsTile (C, RoundTimeBackground);
		DrawWidgetAsTile (C, RoundTimeBackgroundDisc);
		DrawWidgetAsTile (C, RoundTimeSeparator);
		DrawWidgetAsTile (C, RoundTimeIcon);
		PosY += 0.06 * HUDScale;
		MinUtCompOverlayY += 0.06;
	}
	
	if ( Level.Game == None || !ASGameInfo(Level.Game).bDisableReinforcements )
	{
		ReinforceBackground.PosY		= PosY;
		ReinforceBackgroundDisc.PosY	= PosY;
		ReinforcePulse.PosY				= PosY;
		ReinforceIcon.PosY				= PosY;
		ReinforceSprNum.PosY			= PosY;
		
		/* Reinforcements count down */
		ReinforceBackground.Tints[TeamIndex] = HudColorBlack;
		ReinforceBackground.Tints[TeamIndex].A = 150;
		DrawWidgetAsTile (C, ReinforceBackground);
		DrawWidgetAsTile (C, ReinforceBackgroundDisc);
		ReinforcePulse.Tints[TeamIndex] = HudColorHighLight;
		if ( ASGRI.ReinforcementCountDown < 1 )	// Pulse when reinforcements arrive
			DrawWidgetAsTile( C, ReinforcePulse );
		DrawWidgetAsTile (C, ReinforceIcon);
		
		PosY += 0.06 * HUDScale;
		MinUtCompOverlayY += 0.06;
	}

	
	/* Teleport */
	if ( ASPRI !=None && ASPRI.bTeleportToSpawnArea && TeleportSprNum.Value >= 0 )
	{		
		if ( Level.Game == None || !ASGameInfo(Level.Game).bDisableReinforcements )
		{
			TeleportBackground.PosX		= 0.14;
			TeleportBackgroundDisc.PosX	= 0.14;
			TeleportPulse.PosX			= 0.14;
			TeleportIcon.PosX			= 0.14;
			TeleportSprNum.PosX			= 0.14;
			PosY -= 0.06 * HUDScale;
			MinUtCompOverlayY -= 0.06;
		}
		else
		{
			TeleportBackground.PosX		= 0.0;
			TeleportBackgroundDisc.PosX	= 0.0;
			TeleportPulse.PosX			= 0.0;
			TeleportIcon.PosX			= 0.0;
			TeleportSprNum.PosX			= 0.0;
		}
		
		TeleportBackground.PosY		= PosY;
		TeleportBackgroundDisc.PosY	= PosY;
		TeleportPulse.PosY			= PosY;
		TeleportIcon.PosY			= PosY;
		TeleportSprNum.PosY			= PosY;
			
		TeleportBackground.Tints[TeamIndex] = HudColorBlack;
		TeleportBackground.Tints[TeamIndex].A = 150;
		DrawWidgetAsTile (C, TeleportBackground);
		DrawWidgetAsTile (C, TeleportBackgroundDisc);
		TeleportPulse.Tints[TeamIndex] = HudColorHighLight;
		DrawWidgetAsTile( C, TeleportPulse );
		DrawWidgetAsTile (C, TeleportIcon);
		
		PosY += 0.06 * HUDScale;
		MinUtCompOverlayY += 0.06;
	}
	
	
	/* second attack wave comparison */
	if ( ASGRI != None && (ASGRI.CurrentRound % 2 == 0) && !ASGRI.IsPracticeRound() && IsVSRelevant() )
	{
		VSBackground.PosY		= PosY;
		VSBackgroundDisc.PosY	= PosY;
		VSIcon.PosY				= PosY;
		PosY += 0.06 * HUDScale;
		MinUtCompOverlayY += 0.06;

		VSBackground.Tints[TeamIndex] = HudColorBlack;
		VSBackground.Tints[TeamIndex].A = 150;
		DrawWidgetAsTile (C, VSBackground);
		DrawWidgetAsTile (C, VSBackgroundDisc);
		DrawWidgetAsTile (C, VSIcon);	
	}
	

	//set overlay settings
	//this is a client code only, thus this is purely legit
	PC = PlayerController(Owner);
	
	if (PC != None)
	{
		for (i = 0; i < PC.Player.LocalInteractions.Length; i++)
		{
			if (PC.Player.LocalInteractions[i].IsA('UTComp_OverlayB'))
			{
				UTComp_OverlayB(PC.Player.LocalInteractions[i]).MinPosY = FMax(0.065, MinUtCompOverlayY);
				break;
			}
		}
	}

	//
	// Numeric
	//

	/* Round Time Limit */
	if ( ASGRI.RoundTimeLimit > 0 )
	{
		DrawNumericWidgetAsTiles (C, RoundTimeMinutes, DigitsBig);
		DrawNumericWidgetAsTiles (C, RoundTimeSeconds, DigitsBig);
	}

	/* reinforcements */
	if ( Level.Game == None || !ASGameInfo(Level.Game).bDisableReinforcements )
		DrawNumericWidgetAsTiles (C, ReinforceSprNum, DigitsBig);

	/* second attack wave comparison */
	if ( ASGRI != None && (ASGRI.CurrentRound % 2 == 0) && !ASGRI.IsPracticeRound() && IsVSRelevant() )
		DrawTeamVS( C );

	/* Teleport */
	if ( ASPRI !=None && ASPRI.bTeleportToSpawnArea && TeleportSprNum.Value >= 0 )
		DrawNumericWidgetAsTiles (C, TeleportSprNum, DigitsBig);
}

simulated function String GetInfoString()
{
	local string InfoString;
	local int	 PTeam;

	if ( ASGRI == None )
		return NoGameReplicationInfoString;

	if ( ASGRI.RoundWinner != ERW_None )
	{
		return ASGRI.GetRoundWinnerString();
		/*
		if ( ASGRI.IsPracticeRound() )
			return 	class'ScoreBoard_Assault'.default.PracticeRoundOver;


		if ( PTeam == ASGRI.RoundWinner )
			InfoString = class'ScoreBoard_Assault'.default.YouWonRound;
		else
			InfoString = class'ScoreBoard_Assault'.default.YouLostRound;

		return InfoString;
		*/
	}

    if ( GUIController(PlayerOwner.Player.GUIController).ActivePage!=None)
   		return AtMenus;

	if ( ASPRI != None && ASPRI.bAutoRespawn )
	{
		InfoString = class'ScoreBoard_Assault'.default.AutoRespawn;
		InfoString = InfoString @ ASGRI.ReinforcementCountDown;
		return InfoString;
	}

	if ( PawnOwner == None )
		PTeam = PlayerOwner.GetTeamNum();
	else
		PTeam = PawnOwner.GetTeamNum();

	if (ASGRI.IsDefender(PTeam) && ASGRI.ReinforcementCountDown > 0 && !PlayerOwner.IsInState('PlayerWaiting') )
	{
		if ( PlayerOwner.IsDead() )
			InfoString = class'ScoreBoard_Assault'.default.WaitForReinforcements;
		else
			InfoString = class'ScoreBoard_Assault'.default.WaitingToSpawnReinforcements;

		InfoString = InfoString @ ASGRI.ReinforcementCountDown;
	}
	else
		InfoString = super(HudCTeamDeathMatch).GetInfoString();

	return InfoString;
}

function DisplayEnemyName(Canvas C, PlayerReplicationInfo PRI)
{
  PlayerOwner.ReceiveLocalizedMessage(Class'UTComp_PlayerNameMessage',0,PRI);
}

simulated function DrawUTCompCrosshair(Canvas C)
{
    local int i;
    local float OldScale,OldW;
	local array<SpriteWidget> CHtexture;

	if ( PawnOwner.bSpecialCrosshair )
	{
		PawnOwner.SpecialDrawCrosshair( C );
		return;
	}

	if (!bCrosshairShow)
        return;

    for(i=0; i<class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i++)
    {
        CHTexture.Length=i+1;
        CHTexture[i].WidgetTexture=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex;
        CHTexture[i].RenderStyle=STY_Alpha;
        CHTexture[i].TextureCoords.X2=64;
        CHTexture[i].TextureCoords.Y2=64;
        CHTexture[i].TextureScale=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale*0.50;
        CHTexture[i].DrawPivot=DP_MiddleMiddle;
        CHTexture[i].PosX=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetX;
        CHTexture[i].PosY=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetY;
        CHTexture[i].ScaleMode = SM_None;
        CHTexture[i].Scale=1.00;
        CHTexture[i].Tints[0]=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor;
        CHTexture[i].Tints[1]=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor;
    }

    if ( class'UTComp_HudSettings'.default.bEnableCrosshairSizing && LastPickupTime > Level.TimeSeconds - 0.4 )
	{
		if ( LastPickupTime > Level.TimeSeconds - 0.2 )
			for(i=0; i<CHTexture.Length; i++)
                CHTexture[i].TextureScale *= (1 + 5 * (Level.TimeSeconds - LastPickupTime));
		else
			for(i=0; i<CHTexture.Length; i++)
                CHTexture[i].TextureScale *= (1 + 5 * (LastPickupTime + 0.4 - Level.TimeSeconds));
	}
    OldScale = HudScale;
    HudScale=1;
    OldW = C.ColorModulate.W;
    C.ColorModulate.W = 1;
    for(i=0; i<CHTexture.Length; i++)
        DrawWidgetAsTile (C, CHTexture[i]);
    C.ColorModulate.W = OldW;
	HudScale=OldScale;

	DrawEnemyName(C);
}


simulated function DrawCrosshair (Canvas C)
{
    if(class'UTComp_HudSettings'.default.bEnableUTCompCrosshairs && class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>0)
        DrawUTCompCrosshair(C);
    else
        OldDrawCrosshair(C);
}

simulated function OldDrawCrosshair(Canvas C)
{
    local float NormalScale;
    local int i, CurrentCrosshair;
    local float OldScale,OldW, CurrentCrosshairScale;
    local color CurrentCrosshairColor;
	local SpriteWidget CHtexture;

	if ( PawnOwner.bSpecialCrosshair )
	{
		PawnOwner.SpecialDrawCrosshair( C );
		return;
	}

	if (!bCrosshairShow)
        return;

	if ( bUseCustomWeaponCrosshairs && (PawnOwner != None) && (PawnOwner.Weapon != None) )
	{
		CurrentCrosshair = PawnOwner.Weapon.CustomCrosshair;
		if (CurrentCrosshair == -1 || CurrentCrosshair == Crosshairs.Length)
		{
			CurrentCrosshair = CrosshairStyle;
			CurrentCrosshairColor = CrosshairColor;
			CurrentCrosshairScale = CrosshairScale;
		}
		else
		{
			CurrentCrosshairColor = PawnOwner.Weapon.CustomCrosshairColor;
			CurrentCrosshairScale = PawnOwner.Weapon.CustomCrosshairScale;
			if ( PawnOwner.Weapon.CustomCrosshairTextureName != "" )
			{
				if ( PawnOwner.Weapon.CustomCrosshairTexture == None )
				{
					PawnOwner.Weapon.CustomCrosshairTexture = Texture(DynamicLoadObject(PawnOwner.Weapon.CustomCrosshairTextureName,class'Texture'));
					if ( PawnOwner.Weapon.CustomCrosshairTexture == None )
					{
						log(PawnOwner.Weapon$" custom crosshair texture not found!");
						PawnOwner.Weapon.CustomCrosshairTextureName = "";
					}
				}
				CHTexture = Crosshairs[0];
				CHTexture.WidgetTexture = PawnOwner.Weapon.CustomCrosshairTexture;
			}
		}
	}
	else
	{
		CurrentCrosshair = CrosshairStyle;
		CurrentCrosshairColor = CrosshairColor;
		CurrentCrosshairScale = CrosshairScale;
	}

	CurrentCrosshair = Clamp(CurrentCrosshair, 0, Crosshairs.Length - 1);

    NormalScale = Crosshairs[CurrentCrosshair].TextureScale;
	if ( CHTexture.WidgetTexture == None )
		CHTexture = Crosshairs[CurrentCrosshair];
    CHTexture.TextureScale *= 0.5 * CurrentCrosshairScale;

    for( i = 0; i < ArrayCount(CHTexture.Tints); i++ )
        CHTexture.Tints[i] = CurrentCrossHairColor;

	if (  class'UTComp_HudSettings'.default.bEnableCrosshairSizing && LastPickupTime > Level.TimeSeconds - 0.4 )
	{
		if ( LastPickupTime > Level.TimeSeconds - 0.2 )
			CHTexture.TextureScale *= (1 + 5 * (Level.TimeSeconds - LastPickupTime));
		else
			CHTexture.TextureScale *= (1 + 5 * (LastPickupTime + 0.4 - Level.TimeSeconds));
	}
    OldScale = HudScale;
    HudScale=1;
    OldW = C.ColorModulate.W;
    C.ColorModulate.W = 1;
    DrawWidgetAsTile (C, CHTexture);
    C.ColorModulate.W = OldW;
	HudScale=OldScale;
    CHTexture.TextureScale = NormalScale;

	DrawEnemyName(C);
}

/* =========================================================================================================================
   HUD REVAMP!!!
========================================================================================================================= */

simulated function DrawHudPassA(Canvas C)
{
	DrawHudPassACore(C);
	UpdateRankAndSpread(C);
	ShowTeamScorePassA(C);
	
	if ( Links >0 )
	{
		DrawWidgetAsTile (C, LinkIcon);
		DrawNumericWidgetAsTiles (C, totalLinks, DigitsBigPulse);
	}
	totalLinks.value = Links;
}

//#define HUD_PASS_A_CORE
//BEGIN_HUD_IMPL
simulated function DisplayMessages(Canvas C)
{
	local int i, j, MessageCount;
	local float XL, YL, XPos, YPos;

	for( i = 0; i < ConsoleMessageCount; i++ )
	{
		if ( TextMessages[i].Text == "" )
			break;
		else if( TextMessages[i].MessageLife < Level.TimeSeconds )
		{
			TextMessages[i].Text = "";

			if( i < ConsoleMessageCount - 1 )
			{
				for( j=i; j<ConsoleMessageCount-1; j++ )
	  			TextMessages[j] = TextMessages[j+1];
			}
			TextMessages[j].Text = "";
			break;
		}
		else
			MessageCount++;
	}

	XPos = (ConsoleMessagePosX * HudCanvasScale * C.SizeX) + (((1.0 - HudCanvasScale) / 2.0) * C.SizeX);

	if (bOffsetLocalMessages)
		YPos = ((ConsoleMessagePosY - 0.10) * HudCanvasScale * C.SizeY) + (((1.0 - HudCanvasScale) / 2.0) * C.SizeY);
	else
		YPos = (ConsoleMessagePosY * HudCanvasScale * C.SizeY) + (((1.0 - HudCanvasScale) / 2.0) * C.SizeY);

	C.Font = GetConsoleFont(C);
	C.DrawColor = ConsoleColor;

	C.TextSize ("A", XL, YL);

	YPos -= YL * MessageCount+1; // DP_LowerLeft
	YPos -= YL; // Room for typing prompt

	for( i=0; i<MessageCount; i++ )
	{
		if ( TextMessages[i].Text == "" )
			break;

		C.StrLen( TextMessages[i].Text, XL, YL );
		C.SetPos( XPos, YPos );
		C.DrawColor = TextMessages[i].TextColor;
		C.DrawText( TextMessages[i].Text, false );
		YPos += YL;
	}
}

simulated function DrawTypingPrompt (Canvas C, String Text, optional int Pos)
{
	local float XPos, YPos;
	local float XL, YL;

	C.Font = GetConsoleFont(C);
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = ConsoleColor;

	C.TextSize ("A", XL, YL);

	XPos = (ConsoleMessagePosX * HudCanvasScale * C.SizeX) + (((1.0 - HudCanvasScale) * 0.5) * C.SizeX);
	if (bOffsetLocalMessages)
		YPos = ((ConsoleMessagePosY - 0.10) * HudCanvasScale * C.SizeY) + (((1.0 - HudCanvasScale) * 0.5) * C.SizeY) - YL;
	else
		YPos = (ConsoleMessagePosY * HudCanvasScale * C.SizeY) + (((1.0 - HudCanvasScale) * 0.5) * C.SizeY) - YL;

	C.SetPos (XPos, YPos);
	//C.DrawTextClipped ("(>"@Left(Text, Pos)$"_"$Right(Text, Len(Text) - Pos), false);
	C.DrawTextClipped("(>"@Left(Text, Pos)$chr(4)$Eval(Pos < Len(Text), Mid(Text, Pos), "_"), true);
}

simulated function GetSuitableFontForHeight(Canvas C, float maxHeight, out Font F, out float fontHeight, out int Type)
{
	local int i;
	local Font F2, Orig;
	local float XL,YL;

	Orig = C.Font;

	for (i = 8; i >= 0; i--)
	{
		F2 = class'HudBase'.static.LoadFontStatic(i);
		C.Font = F2;
		C.StrLen("X", XL, YL);

		if (YL >= maxHeight)
			break;

		F = F2;
		fontHeight = YL;
		Type = i;
	}

	C.Font = Orig;
}

//#ifdef HUD_PASS_A_CORE
simulated function DrawHudPassACore(Canvas C)
//#else
//simulated function DrawHudPassA(Canvas C)
//#endif
{
	local Pawn RealPawnOwner;
	local float BarXLen, BarYLen, BarYOffset, MyBarBorder, XL, XL2, YL, MyFontOffset;
	local float MaxAmmoSecondary, CurAmmoSecondary;
	local Font AmmoFont;
	local float AmmoFontHeight;
	local int AmmoFontType;
	local BallisticWeapon BWWep;
	local string ModeStr;

	ZoomFadeOut(C);

	if ( PawnOwner != None )
	{
		if( bShowWeaponInfo && (PawnOwner.Weapon != None) )
		{
			DrawSprintChargeBar(C);

			if (PawnOwner.Weapon.bShowChargingBar)
				DrawChargeBar(C);

			// Draw a simple panel telling: 
			// Fire Mode
			// Current Ammo / Total Ammo (the distance of / is fixed!) - Secondary ammo on the right side

			/* Background panel */
			MyBarBorder = 0.004 * C.ClipY;
			MyFontOffset = 0.004 * C.ClipY;
			BarYOffset = (ResScaleY * 60 * HUDScale) - MyBarBorder;
			BarXLen = (ResScaleY * 84 * HUDScale) + (2 * MyBarBorder); //use ResScaleY so they match
			BarYLen = (ResScaleY * 34 * HUDScale) + (3 * MyBarBorder);
			if (bCorrectAspectRatio)
				BarYLen *= 0.870; /* Prefer smaller font with HUD fix */
			GetSuitableFontForHeight(C, BarYLen / 2.0, AmmoFont, AmmoFontHeight, AmmoFontType);
			C.Font = AmmoFont;

			if ( (PawnOwner.PlayerReplicationInfo == None) || (PawnOwner.PlayerReplicationInfo.Team == None)
				|| (PawnOwner.PlayerReplicationInfo.Team.TeamIndex == 1) )
				C.DrawColor = HudColorBlue;
			else
				C.DrawColor = HudColorRed;

			C.SetPos(C.ClipX - BarXLen, C.ClipY - BarYLen - BarYOffset);
			C.DrawColor = C.MakeColor(0,0,0,150);
			C.DrawTile( Texture'HudContent.Generic.HUD',  BarXLen, BarYLen, 251, 211, 0, 0);
			//C.DrawTile(Texture'LDGGameBW_rc.new_hud', BarXLen, BarYLen, 0, 151, 256, 105);
			C.DrawColor = class'HUD'.default.WhiteColor;

						if (BallisticWeapon(PawnOwner.Weapon) != None)
			{
				BWWep = BallisticWeapon(PawnOwner.Weapon);
				if (BWWep.bAllowWeaponInfoOverride)
				{
					// Make sure the weapon will not render anything
					BallisticWeapon(PawnOwner.Weapon).bSkipDrawWeaponInfo = true;
					
					C.StrLen(int(MaxAmmoPrimary), XL, YL);
					C.StrLen(int(CurAmmoPrimary), XL2, YL);
					
					C.DrawColor = C.MakeColor(255,255,64,255);
					C.SetPos(C.ClipX - BarXLen + MyBarBorder + XL - XL2, C.ClipY - (BarYLen / 2.0) - BarYOffset + (0.5 *MyBarBorder) - MyFontOffset);
					C.DrawText(int(CurAmmoPrimary));
					
					C.DrawColor = class'HUD'.default.WhiteColor;
					if (!BWWep.bNoMag && BWWep.GetHUDAmmoText(0) != "")
					{
						C.SetPos(C.ClipX - BarXLen + MyBarBorder + XL, C.ClipY - (BarYLen / 2.0) - BarYOffset + (0.5 *MyBarBorder) - MyFontOffset);
						C.DrawText("/" $ BWWep.GetHUDAmmoText(0));
					}
						
					if (BWWep.HasSecondaryAmmo() && BWWep.GetHUDAmmoText(1) != "")
					{
						if (BWWep.GetHUDAmmoText(1) == "0")
							C.DrawColor = class'HUD'.default.RedColor;
						else
							C.DrawColor = class'HUD'.default.WhiteColor;

						C.StrLen(BWWep.GetHUDAmmoText(1), XL, YL);
						C.SetPos(C.ClipX - XL - MyBarBorder, C.ClipY - (BarYLen / 2.0) - BarYOffset + (0.5 *MyBarBorder) - MyFontOffset);
						C.DrawText(BWWep.GetHUDAmmoText(1), false);
						C.DrawColor = class'HUD'.default.WhiteColor;
					}
					
					if (BWWep.bRedirectSwitchToFiremode && BWWep.PendingMode < BWWep.WeaponModes.length)
						ModeStr = BWWep.WeaponModes[BWWep.PendingMode].ModeName;
					else if (BWWep.CurrentWeaponMode < BWWep.WeaponModes.length && !BWWep.WeaponModes[BWWep.CurrentWeaponMode].bUnavailable 
							&& BWWep.WeaponModes[BWWep.CurrentWeaponMode].ModeName != "")
						ModeStr = BWWep.WeaponModes[BWWep.CurrentWeaponMode].ModeName;
					else
						ModeStr = "Default";

					C.Font = class'HudBase'.static.LoadFontStatic(Min(AmmoFontType + 2, 8));
					C.StrLen(ModeStr , XL, YL);
					C.SetPos(C.ClipX - XL - MyBarBorder, C.ClipY - BarYLen - BarYOffset + MyBarBorder + MyFontOffset);
					if (BWWep.bRedirectSwitchToFiremode)
						C.DrawColor = class'HUD'.default.GoldColor;
					else	
						C.DrawColor = class'HUD'.default.WhiteColor;
					C.DrawText(ModeStr);
					if (BWWep.bRedirectSwitchToFiremode)
						C.DrawColor = class'HUD'.default.WhiteColor;
					
					// Dual Wield
					if (BallisticHandgun(BWWep) != None && BallisticHandgun(BWWep).OtherGun != None)
					{
						bOffsetLocalMessages = true;
						BWWep = BallisticHandgun(BWWep).OtherGun;
						BWWep.GetAmmoCount(MaxAmmoSecondary, CurAmmoSecondary);
						C.Font = AmmoFont;
				
						if ( (PawnOwner.PlayerReplicationInfo == None) || (PawnOwner.PlayerReplicationInfo.Team == None)
							|| (PawnOwner.PlayerReplicationInfo.Team.TeamIndex == 1) )
							C.DrawColor = HudColorBlue;
						else
							C.DrawColor = HudColorRed;
			
						C.SetPos(0, C.ClipY - BarYLen - BarYOffset);
						C.DrawColor = C.MakeColor(0,0,0,150);
						C.DrawTile( Texture'HudContent.Generic.HUD',  BarXLen, BarYLen, 251, 211, 0, 0);
						//C.DrawTile(Texture'LDGGameBW_rc.new_hud', BarXLen, BarYLen, 0, 151, 256, 105);
						C.DrawColor = class'HUD'.default.WhiteColor;
						
						C.StrLen(int(MaxAmmoSecondary), XL, YL);
						
						C.DrawColor = C.MakeColor(255,255,64,255);
						C.SetPos(BarXLen - MyBarBorder - XL, C.ClipY - (BarYLen / 2.0) - BarYOffset + (0.5 *MyBarBorder) - MyFontOffset);
						C.DrawText(int(CurAmmoSecondary));
						
						C.DrawColor = class'HUD'.default.WhiteColor;
						if (!BWWep.bNoMag && BWWep.GetHUDAmmoText(0) != "")
						{
							C.StrLen(BWWep.GetHUDAmmoText(0) $ "/", XL2, YL);
							C.SetPos(BarXLen + MyBarBorder - XL2 - XL, C.ClipY - (BarYLen / 2.0) - BarYOffset + (0.5 *MyBarBorder) - MyFontOffset);
							C.DrawText(BWWep.GetHUDAmmoText(0) $ "/");
						}
						
						if (BWWep.HasSecondaryAmmo() && BWWep.GetHUDAmmoText(1) != "")
						{
							if (BWWep.GetHUDAmmoText(1) == "0")
								C.DrawColor = class'HUD'.default.RedColor;
							else
								C.DrawColor = class'HUD'.default.WhiteColor;
		
							C.SetPos(MyBarBorder, C.ClipY - (BarYLen / 2.0) - BarYOffset + (0.5 *MyBarBorder) - MyFontOffset);
							C.DrawText(BWWep.GetHUDAmmoText(1), false);
							C.DrawColor = class'HUD'.default.WhiteColor;
						}
						
						if (BWWep.CurrentWeaponMode < BWWep.WeaponModes.length && !BWWep.WeaponModes[BWWep.CurrentWeaponMode].bUnavailable 
							&& BWWep.WeaponModes[BWWep.CurrentWeaponMode].ModeName != "")
							ModeStr = BWWep.WeaponModes[BWWep.CurrentWeaponMode].ModeName;
						else
							ModeStr = "Default";
							
						C.Font = class'HudBase'.static.LoadFontStatic(Min(AmmoFontType + 2, 8));
						C.SetPos(MyBarBorder, C.ClipY - BarYLen - BarYOffset + MyBarBorder + MyFontOffset);
						C.DrawColor = class'HUD'.default.WhiteColor;
						C.DrawText(ModeStr);
					}
					else
						bOffsetLocalMessages = false;
				}
			}
			else
			{
				C.SetPos(C.ClipX - BarXLen + MyBarBorder, C.ClipY - (BarYLen / 2.0) - BarYOffset + (0.5 *MyBarBorder) - MyFontOffset);
				C.DrawColor = class'HUD'.default.GoldColor;
				C.Strlen(int(CurAmmoPrimary), XL, YL);
				C.DrawText(int(CurAmmoPrimary));

				C.Font = class'HudBase'.static.LoadFontStatic(Max(AmmoFontType + 2, 0));
				C.StrLen("Default", XL, YL);
				C.SetPos(C.ClipX - XL - MyBarBorder, C.ClipY - BarYLen - BarYOffset + MyBarBorder + MyFontOffset);
				C.DrawColor = class'HUD'.default.WhiteColor;
				C.DrawText("Default");
			}
		}

		if ( bShowWeaponBar && (PawnOwner.Weapon != None) )
			DrawWeaponBar(C);

		if( bShowPersonalInfo )
		{
			if ( Vehicle(PawnOwner) != None && Vehicle(PawnOwner).Driver != None )
			{
				if (Vehicle(PawnOwner).bShowChargingBar)
					DrawVehicleChargeBar(C);
				RealPawnOwner = PawnOwner;
				PawnOwner = Vehicle(PawnOwner).Driver;
			}

			DrawHUDAnimWidget( HudBorderHealthIcon, default.HudBorderHealthIcon.TextureScale, LastHealthPickupTime, 0.6, 0.6);
			DrawWidgetAsTile( C, HudBorderHealth );

			if(CurHealth/PawnOwner.HealthMax < 0.26)
			{
				HudHealthALERT.Tints[TeamIndex] = HudColorTeam[TeamIndex];
				DrawWidgetAsTile( C, HudHealthALERT);
				HudBorderHealthIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
			}
			else
				HudBorderHealthIcon.WidgetTexture = Material'HudContent.Generic.HUD';

			DrawWidgetAsTile( C, HudBorderHealthIcon);

			if( CurHealth < LastHealth )
				LastDamagedHealth = Level.TimeSeconds;

			DrawHUDAnimDigit( DigitsHealth, default.DigitsHealth.TextureScale, LastDamagedHealth, 0.8, default.DigitsHealth.Tints[TeamIndex], HudColorHighLight);
			DrawNumericWidgetAsTiles( C, DigitsHealth, DigitsBig);

			if(CurHealth > 999)
			{
				DigitsHealth.OffsetX=220;
				DigitsHealth.OffsetY=-35;
				DigitsHealth.TextureScale=0.39;
			}
			else
			{
				DigitsHealth.OffsetX = default.DigitsHealth.OffsetX;
				DigitsHealth.OffsetY = default.DigitsHealth.OffsetY;
				DigitsHealth.TextureScale = default.DigitsHealth.TextureScale;
			}

			if (RealPawnOwner != None)
			{
				PawnOwner = RealPawnOwner;

				DrawWidgetAsTile( C, HudBorderVehicleHealth );

				if (CurVehicleHealth/PawnOwner.HealthMax < 0.26)
				{
					HudVehicleHealthALERT.Tints[TeamIndex] = HudColorTeam[TeamIndex];
					DrawWidgetAsTile(C, HudVehicleHealthALERT);
					HudBorderVehicleHealthIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
				}
				else
					HudBorderVehicleHealthIcon.WidgetTexture = Material'HudContent.Generic.HUD';

				DrawWidgetAsTile(C, HudBorderVehicleHealthIcon);

				if (CurVehicleHealth < LastVehicleHealth )
					LastDamagedVehicleHealth = Level.TimeSeconds;

				DrawHUDAnimDigit(DigitsVehicleHealth, default.DigitsVehicleHealth.TextureScale, LastDamagedVehicleHealth, 0.8, default.DigitsVehicleHealth.Tints[TeamIndex], HudColorHighLight);
				DrawNumericWidgetAsTiles(C, DigitsVehicleHealth, DigitsBig);

				if (CurVehicleHealth > 999)
				{
					DigitsVehicleHealth.OffsetX = 445;
					DigitsVehicleHealth.OffsetY = -35;
					DigitsVehicleHealth.TextureScale = 0.39;
				}
				else
				{
					DigitsVehicleHealth.OffsetX = default.DigitsVehicleHealth.OffsetX;
					DigitsVehicleHealth.OffsetY = default.DigitsVehicleHealth.OffsetY;
					DigitsVehicleHealth.TextureScale = default.DigitsVehicleHealth.TextureScale;
				}
			}

			DrawAdrenaline(C);
		}
	}

	UpdateRankAndSpread(C);
	DrawUDamage(C);

	if(bDrawTimer)
		DrawTimer(C);

	// Temp Drawwwith Hud Colors
	HudBorderShield.Tints[0] = HudColorRed;
	HudBorderShield.Tints[1] = HudColorBlue;
	HudBorderHealth.Tints[0] = HudColorRed;
	HudBorderHealth.Tints[1] = HudColorBlue;
	HudBorderVehicleHealth.Tints[0] = HudColorRed;
	HudBorderVehicleHealth.Tints[1] = HudColorBlue;
	HudBorderSprint.Tints[0] = HudColorRed;
	HudBorderSprint.Tints[1] = HudColorBlue;
	HudBorderCharge.Tints[0] = HudColorRed;
	HudBorderCharge.Tints[1] = HudColorBlue;

	if( bShowPersonalInfo && (CurShield > 0) )
	{
		DrawWidgetAsTile( C, HudBorderShield );
		DrawWidgetAsTile( C, HudBorderShieldIcon);
		DrawNumericWidgetAsTiles( C, DigitsShield, DigitsBig);
		DrawHUDAnimWidget( HudBorderShieldIcon, default.HudBorderShieldIcon.TextureScale, LastArmorPickupTime, 0.6, 0.6);
	}

	if( Level.TimeSeconds - LastVoiceGainTime < 0.333 )
		DisplayVoiceGain(C);

	DisplayLocalMessages (C);
}

simulated function ShowReloadingPulse( float hold )
{
	if( hold==1.0 )
		RechargeBar.WidgetTexture = FinalBlend'LDGGameBW_rc.new_hud_pulse';
	else
		RechargeBar.WidgetTexture = Texture'LDGGameBW_rc.new_hud';
}

simulated function BCSprintControl GetSprintControl()
{
	local Inventory Inv;

	if (PlayerController(Owner).Pawn == None)
		return None;

	for (Inv = PlayerController(Owner).Pawn.Inventory; Inv != None; Inv = Inv.Inventory)
		if (BCSprintControl(Inv) != None)
		{
			return BCSprintControl(Inv);
			break;
		}

	return None;
}

simulated function DrawChargeBar( Canvas C)
{
	DrawWidgetAsTile(C, HudBorderCharge);
	RechargeBar.Scale = FMin(PawnOwner.Weapon.ChargeBar(), 1);
	if (RechargeBar.Scale > 0)
	{
		ShowReloadingPulse(RechargeBar.Scale);
		DrawWidgetAsTile(C, RechargeBar);
	}
}

simulated function DrawVehicleChargeBar(Canvas C)
{
	DrawWidgetAsTile(C, HudBorderCharge);
	RechargeBar.Scale = Vehicle(PawnOwner).ChargeBar();

	if (RechargeBar.Scale > 0)
	{
		ShowReloadingPulse(RechargeBar.Scale);
		DrawWidgetAsTile(C, RechargeBar);
	}
}

simulated function DrawSprintChargeBar(Canvas C)
{
	local BCSprintControl SprintControl;

	DrawWidgetAsTile(C, HudBorderSprint);
	SprintControl = GetSprintControl();

	if (SprintControl != None)
		SprintBar.Scale = SprintControl.Stamina / SprintControl.MaxStamina;
	else
		SprintBar.Scale = 0;

	if (SprintBar.Scale > 0)
		DrawWidgetAsTile(C, SprintBar);
}

simulated function DrawWeaponBar( Canvas C )
{
	local int i, Count, Pos;
	local float IconOffset;
	local float HudScaleOffset, HudMinScale;

	local Weapon Weapons[WEAPON_BAR_SIZE];
	local byte ExtraWeapon[WEAPON_BAR_SIZE];
	local Inventory Inv;
	local Weapon W, PendingWeapon;

	HudMinScale=0.5;
	//no weaponbar for vehicles
	if (Vehicle(PawnOwner) != None)
		return;

	if (PawnOwner.PendingWeapon != None)
		PendingWeapon = PawnOwner.PendingWeapon;
	else
		PendingWeapon = PawnOwner.Weapon;

	// fill:
	for( Inv=PawnOwner.Inventory; Inv!=None; Inv=Inv.Inventory )
	{
		W = Weapon( Inv );
		Count++;
		if ( Count > 100 )
			break;

		if( (W == None) || (W.IconMaterial == None) )
			continue;

		if ( W.InventoryGroup == 0 )
			Pos = 8;
		else if ( W.InventoryGroup < 10 )
			Pos = W.InventoryGroup-1;
		else
			continue;

		if ( Weapons[Pos] != None )
			ExtraWeapon[Pos] = 1;
		else
			Weapons[Pos] = W;
	}

	if ( PendingWeapon != None )
	{
		if ( PendingWeapon.InventoryGroup == 0 )
			Weapons[8] = PendingWeapon;
		else if ( PendingWeapon.InventoryGroup < 10 )
			Weapons[PendingWeapon.InventoryGroup-1] = PendingWeapon;
	}

	// Draw:
	for( i=0; i<WEAPON_BAR_SIZE; i++ )
	{
		W = Weapons[i];

		// Keep weaponbar organized when scaled
		HudScaleOffset= 1-(HudScale-HudMinScale)/HudMinScale;
		if (!bCorrectAspectRatio)
			BarBorder[i].PosX =  default.BarBorder[i].PosX +( BarBorderScaledPosition[i] - default.BarBorder[i].PosX) *HudScaleOffset;
		else
			BarBorder[i].PosX = 0.5 - ((0.5 - default.BarBorder[i].PosX) * (ResScaleY / ResScaleX) * HUDScale); 
		BarWeaponIcon[i].PosX = BarBorder[i].PosX;

		IconOffset = (default.BarBorder[i].TextureCoords.X2 - default.BarBorder[i].TextureCoords.X1) * 0.5;

		BarBorder[i].Tints[0] = HudColorRed;
		BarBorder[i].Tints[1] = HudColorBlue;
		BarBorder[i].OffsetY = 0;
		BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;

		if( W == none )
		{
			BarWeaponStates[i].HasWeapon = false;
			if ( bShowMissingWeaponInfo )
			{
				BarWeaponIcon[i].OffsetX =  IconOffset;

				if ( BarWeaponIcon[i].Tints[TeamIndex] != HudColorBlack )
				{
					BarWeaponIcon[i].WidgetTexture = default.BarWeaponIcon[i].WidgetTexture;
					BarWeaponIcon[i].TextureCoords = default.BarWeaponIcon[i].TextureCoords;
					BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
					BarWeaponIcon[i].Tints[TeamIndex] = HudColorBlack;
					BarWeaponIconAnim[i] = 0;
				}
				DrawWidgetAsTile( C, BarBorder[i] );
				//DrawWidgetAsTile( C, BarWeaponIcon[i] ); // FIXME- have combined version
			}
		}
		else
		{
			if( !BarWeaponStates[i].HasWeapon )
			{
				// just picked this weapon up!
				BarWeaponStates[i].PickupTimer = Level.TimeSeconds;
				BarWeaponStates[i].HasWeapon = true;
			}

			BarBorderAmmoIndicator[i].PosX = BarBorder[i].PosX;
			BarBorderAmmoIndicator[i].OffsetY = 0;

			BarWeaponIcon[i].WidgetTexture = W.IconMaterial;
			BarWeaponIcon[i].TextureCoords = W.IconCoords;

			//Cheese for drawing icons larger than default sizes correctly
			if (Abs(W.IconCoords.Y1 - W.IconCoords.Y2) > 64)
			{
				BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale / ((Abs(W.IconCoords.Y1 - W.IconCoords.Y2) + 1)/ 32);
				IconOffset *= (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
				BarWeaponIcon[i].OffsetY = -30 * (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
			}
			else
			{
				BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
				BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;
			}

			BarWeaponIcon[i].OffsetX =  IconOffset;

			BarBorderAmmoIndicator[i].Scale = FMin(W.AmmoStatus(), 1);
			BarWeaponIcon[i].Tints[TeamIndex] = HudColorNormal;

			if( BarWeaponIconAnim[i] == 0 )
            {
                if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.6 )
	            {
		           if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.3 )
	               {
					   	BarWeaponIcon[i].TextureScale = BarWeaponIcon[i].TextureScale * (1 + 1.3 * (Level.TimeSeconds - BarWeaponStates[i].PickupTimer));
                        BarWeaponIcon[i].OffsetX =  IconOffset - IconOffset * ( Level.TimeSeconds - BarWeaponStates[i].PickupTimer );
                   }
                   else
                   {
					    BarWeaponIcon[i].TextureScale = BarWeaponIcon[i].TextureScale * (1 + 1.3 * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds));
                        BarWeaponIcon[i].OffsetX = IconOffset - IconOffset * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds);
                   }
                }
                else
                    BarWeaponIconAnim[i] = 1;
			}

			if (W == PendingWeapon)
			{
				// Change color to highlight and possibly changeTexture or animate it
				BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
				BarBorder[i].OffsetY = -10;
				BarBorderAmmoIndicator[i].OffsetY = -10;
				BarWeaponIcon[i].OffsetY += -10 * (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
			}

			if ( ExtraWeapon[i] == 1 )
			{
				if ( W == PendingWeapon )
				{
					BarBorder[i].Tints[0] = HudColorRed;
					BarBorder[i].Tints[1] = HudColorBlue;
					BarBorder[i].OffsetY = 0;
					BarBorder[i].TextureCoords.Y1 = 41;
					DrawWidgetAsTile( C, BarBorder[i] );
					BarBorder[i].TextureCoords.Y1 = 0;
					BarBorder[i].OffsetY = -10;
					BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
				}
				else
				{
					BarBorder[i].OffsetY = -52;
					BarBorder[i].TextureCoords.Y2 = 9;
					DrawWidgetAsTile( C, BarBorder[i] );
					BarBorder[i].TextureCoords.Y2 = 54;
					BarBorder[i].OffsetY = 0;
				}
			}
			DrawWidgetAsTile( C, BarBorder[i] );
			DrawWidgetAsTile( C, BarBorderAmmoIndicator[i] );
			DrawWidgetAsTile( C, BarWeaponIcon[i] );
		}
	}
}

simulated function DrawHudPassC(Canvas C)
{
	if (bOffsetLocalMessages)
	{
		Portrait = None;
		PortraitPRI = None;
	}

	Super.DrawHudPassC(C);
}

simulated function DrawSpectatingHud (Canvas C)
{
	bOffsetLocalMessages = false;
	Super.DrawSpectatingHud(C);
}
//Inserted 655 lines.
//END_HUD_IMPL

defaultproperties
{
     HudBorderSprint=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',RenderStyle=STY_Alpha,TextureCoords=(Y1=55,X2=166,Y2=108),TextureScale=0.530000,DrawPivot=DP_LowerRight,PosX=1.000000,PosY=1.000000,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     HudBorderCharge=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',RenderStyle=STY_Alpha,TextureCoords=(Y1=55,X2=166,Y2=108),TextureScale=0.530000,DrawPivot=DP_LowerRight,PosX=1.000000,PosY=1.000000,OffsetY=-54,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     SprintBar=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',RenderStyle=STY_Alpha,TextureCoords=(Y1=109,X2=155,Y2=150),TextureScale=0.530000,DrawPivot=DP_LowerRight,PosX=1.000000,PosY=1.000000,OffsetX=-5,OffsetY=-6,ScaleMode=SM_Left,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=220),Tints[1]=(B=255,G=255,R=255,A=220))
     HudBorderShield=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=55,Y2=108))
     HudBorderHealth=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=55,Y2=108))
     HudBorderVehicleHealth=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=55,Y2=108))
     BarBorder(0)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(1)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(2)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(3)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(4)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(5)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(6)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(7)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     BarBorder(8)=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=0,Y2=54))
     RechargeBar=(WidgetTexture=Texture'LDGGameBW_rc.HUD.new_hud',TextureCoords=(Y1=109,X2=155,Y2=150),TextureScale=0.530000,DrawPivot=DP_LowerRight,OffsetX=-5,OffsetY=-60)
}
