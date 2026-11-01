class UTComp_Scoreboard_AM extends AM_Scoreboard;

simulated function string StripColor(string s)
{
	local string EscapeCode;
	local int p;

  EscapeCode = Chr(0x1B);
  p = InStr(s,EscapeCode);
  
	while ( p>=0 )
	{
		s = left(s,p)$mid(S,p+4);
		p = InStr(s,EscapeCode);
	}

	return s;
}

simulated function DrawColoredNameCorrectly(Canvas C, string PlayerName, Color ColorMod, int MaxChars)
{
	local Color Col, OldCol;
	local float OrigY;
	local string Str, CutStr, EscapeCode;
	local int t, nR, nG, nB, Chars;
	
	EscapeCode = Chr(0x1B);
	CutStr = PlayerName;
	OrigY = C.CurY;
	OldCol = C.DrawColor;
	C.DrawColor = ColorMod;
	
	if (MaxChars <= 0)
		MaxChars = Len(PlayerName);
	
	while (true)
	{	
		if (chars >= MaxChars)
			break;
			
		t = InStr(CutStr, EscapeCode);
		
		if (t == -1)
		{
		 	if (CutStr != "")
		 	{
		 		if (Len(CutStr) > MaxChars - Chars)
		 			CutStr = Left(CutStr, MaxChars - Chars);
		 			
		 		C.DrawText(CutStr, false);
		 	}
		 		 	
		 	break;
		}
			
		Str = Mid(CutStr,0,t);
		
		if (Str != "")
		{
			if (Len(Str) > MaxChars - Chars)
				CutStr = Left(Str, MaxChars - Chars);
			
			C.DrawText(Str, false);
			Chars += Len(Str);
			
			//check if we are on the beginning of a new line
			if (C.CurX > 0)
				C.CurY = OrigY;
			else
				OrigY = C.CurY;
		}
		
		nR = Asc(Mid(CutStr,t+1,1)) * ColorMod.R / 255;
		nG = Asc(Mid(CutStr,t+2,1)) * ColorMod.G / 255;
		nB = Asc(Mid(CutStr,t+3,1)) * ColorMod.B / 255;
		
		Col.R = nR;
		Col.G = nG;
		Col.B = nB;
		Col.A = ColorMod.A;
		
		C.DrawColor = Col;
		CutStr = Mid(CutStr, t+4);
	}
	
	C.DrawColor = OldCol;
}

simulated event UpdateScoreBoard(Canvas C)
{
    local PlayerReplicationInfo PRI, OwnerPRI;
    local UTComp_PRI uPRI;
    local float XL, YL;
    local string name;
    local string specs[6];
    local int i;
    local byte Drawn;
    local bool bDrawnOwner;

    local int BarX;
    local int BarY;
    local int BarW;
    local int BarH;

    local int PlayerBoxX;
    local int PlayerBoxY;
    local int PlayerBoxW;
    local int PlayerBoxH;

    local int MiscX;
    local int MiscY;
    local int MiscW;
    local int MiscH;

    local int NameY;
    local int StatY;
    local int NameW;
    local int NameX;
    local int LocationX;
    local int ScoreX;
    local int DeadX;
    local int PingX;
    local int SpecCount;

    OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;

    NameY = C.ClipY * 0.008;
    StatY = C.ClipY * 0.035;
    BarW = C.ClipX * 0.46;
    NameW = C.ClipX * 0.23;
    NameX = C.ClipX * 0.01;
    LocationX = C.ClipX * 0.02;
    ScoreX = C.ClipX * 0.27;
    DeadX = C.ClipX * 0.35;
    PingX = C.ClipX * 0.42; 

    PlayerBoxX = C.ClipX * 0.27;
    PlayerBoxW = C.ClipX * 0.46;
    PlayerBoxH = C.ClipY * 0.404;
    BarH = PlayerBoxH / 6;

    /* draw header */
    C.Style = ERenderStyle.STY_Alpha;
    C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -1);

    // box
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = 222;

    C.SetPos(0, 0);
    C.DrawTile(BaseTex, C.ClipX, C.ClipY * 0.065, 140, 312, 744, 74);
    C.SetPos(0, C.ClipY * 0.06475);
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawTile(BaseTex, C.ClipX, C.ClipY * 0.005, 140, 387, 744, 4);

    // text     
    name = GRI.GameName$MapName$Level.Title;
    C.StrLen(name, XL, YL);
    //C.SetPos(C.ClipX * 0.5 - XL * 0.5, C.ClipY * 0.02 - YL * 0.5 + 2);
    C.SetPos(C.ClipX * 0.01, C.ClipY * 0.02 - YL * 0.5 + 2);
    C.DrawColor = HUDClass.default.WhiteColor * 0.7;
    C.DrawText(name, true);

    name = "www.ldg-gaming.eu";
    C.StrLen(name, XL, YL);
    C.SetPos(C.ClipX * 0.99 - XL, C.ClipY * 0.02 - YL * 0.5 + 2);
    C.DrawText(name, true);


    C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

    // text
    if(UnrealPlayer(Owner).bDisplayLoser)
        name = class'HUDBase'.default.YouveLostTheMatch;
    else if(UnrealPlayer(Owner).bDisplayWinner)
        name = class'HUDBase'.default.YouveWonTheMatch;
    else
    {
        name = class'TAM_Scoreboard'.default.FragLimit@GRI.GoalScore;
        if(GRI.TimeLimit != 0)
            name = name@spacer@TimeLimit@FormatTime(GRI.RemainingTime);
        else
            name = name@spacer@FooterText@FormatTime(GRI.ElapsedTime);
    }

    C.StrLen(name, XL, YL);
    //C.SetPos(C.ClipX * 0.5 - XL * 0.5, C.ClipY * 0.05 - YL * 0.5 + 1);
    C.SetPos(C.ClipX * 0.01, C.ClipY * 0.05 - YL * 0.5 + 1);
    C.DrawColor = HUDClass.default.RedColor * 0.7;
    C.DrawColor.G = 130;
    C.DrawText(name, true);

    // clock
    name = "";
    if(Level.Month < 10)
        name = "0";
    name = name$Level.Month$"/";
    if(Level.Day < 10)
        name = name$"0";
    name = name$Level.Day$"/"$Level.Year@"- ";
    if(Level.Hour < 10)
        name = name$"0";
    name = name$Level.Hour$":";
    if(Level.Minute < 10)
        name = name$"0";
    name = name$Level.Minute$":";
    if(Level.Second < 10)
        name = name$"0";
    name = name$Level.Second;

    C.StrLen(name, XL, YL);
    C.SetPos(C.ClipX * 0.99 - XL, C.ClipY * 0.05 - YL * 0.5 + 1);
    C.DrawText(name, true);
    /* draw header */

    /* draw the background */
    // draw the top and example bar
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = 175;

    MiscX = C.ClipX * 0.26;
    MiscY = C.ClipY * 0.195;
    MiscW = C.ClipX * 0.48;
    MiscH = C.ClipY * 0.1183;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 126, 772, 137);

    MiscX = C.ClipX * 0.26;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.0366;
    MiscW = C.ClipX * 0.0075;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 263, 10, 10);

    MiscX = C.ClipX * 0.26 + MiscW;
    MiscW = C.ClipX * 0.48 - (MiscW * 2);
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 137, 263, 751, 42);

    C.SetPos(MiscX + MiscW, MiscY);
    C.DrawTile(BaseTex, C.ClipX * 0.0069, MiscH, 888, 263, 10, 10);

    MiscX = C.ClipX * 0.26;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.005;
    MiscW = C.ClipX * 0.48;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 306, 772, 4);

    PlayerBoxY = MiscY + MiscH + (C.ClipY * 0.005);

    MiscX = C.ClipX * 0.26;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.005;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 398, 772, 10);

    
    /* draw the background */

    /* draw the player's bars */
    for(i = 0; i < GRI.PRIArray.Length; i++)
    {
        PRI = GRI.PRIArray[i];
		uPRI = class'UTComp_Util'.static.GetUTCompPRI(PRI);
        if(PRI.bOnlySpectator)
        {
            if(!PRI.bOnlySpectator || Caps(Left(PRI.PlayerName,8)) == "WEBADMIN" || SpecCount >= 6)
                continue;

            Specs[SpecCount] = PRI.PlayerName;
            SpecCount++;
            continue;
        }

        if(Level.TimeSeconds - LastUpdateTime > 4)
            Misc_Player(Owner).ServerUpdateStats(TeamPlayerReplicationInfo(PRI));

        if(drawn > 5)
            continue;
        if(drawn == 5 && !bDrawnOwner && PRI != OwnerPRI)
            continue;

        BarX = PlayerBoxX;
        BarY = PlayerBoxY + (BarH * drawn);

        C.DrawColor = HUDClass.default.WhiteColor;
        C.DrawColor.A = 175;
        C.SetPos(int(C.ClipX * 0.26), BarY);
        C.DrawTile(BaseTex, int(C.ClipX * 0.48), BarH, 126, 398, 772, 10);

        if(PRI == OwnerPRI)
        {
            C.DrawColor.R = 50;
            C.DrawColor.G = 175;
            C.DrawColor.B = 255;
            C.DrawColor.A = 175;
        }
        else
        {
            C.DrawColor = HUDClass.default.WhiteColor;
            C.DrawColor.A = 80;
        }

        drawn++;

        if(PRI == OwnerPRI)
            bDrawnOwner = true;

        C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

        // draw background
        C.SetPos(BarX, BarY);
        C.DrawTile(BaseTex, BarW, BarH * 0.95, 140, 312, 744, 74);
        C.SetPos(BarX, BarY + BarH * 0.95);
        C.DrawColor = HUDClass.default.WhiteColor;
        C.DrawTile(BaseTex, BarW, BarH * 0.05, 140, 386, 744, 4);

        // name
        C.SetPos(BarX + NameX, BarY + NameY);
        
        if(PRI.bOutOfLives)
        {
        	C.DrawColor = HUDClass.default.WhiteColor * 0.4;
        	name = PRI.PlayerName;
        	C.StrLen(name, XL, YL);
	        if(XL > NameW)
	            name = Left(name, NameW / XL * len(name));
	        C.DrawText(name);
        }
        else if(class'UTComp_Settings_FREON'.default.bEnableColoredNamesOnScoreboard && uPRI != None && uPRI.ColoredName != "")
        {
        	name = uPRI.ColoredName;
        	C.StrLen(StripColor(name), XL, YL);
        	
        	if(XL > NameW)
        		DrawColoredNameCorrectly(C, name, HUDClass.default.WhiteColor * 0.7, NameW / XL * len(name));
        	else
        		DrawColoredNameCorrectly(C, name, HUDClass.default.WhiteColor * 0.7, -1);
        }
        else
        {
        	C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        	name = PRI.PlayerName;
        	C.StrLen(name, XL, YL);
	        if(XL > NameW)
	            name = Left(name, NameW / XL * len(name));
	        C.DrawText(name);
		}

        // score
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        name = string(int(PRI.Score % 10000));
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + ScoreX - (XL * 0.5), BarY + NameY);
        C.DrawText(name, true);

        // kills
        name = string(int(PRI.Score / 10000));
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + DeadX -(XL * 0.5), BarY + NameY);
        C.DrawText(name, true);

        // ping
        C.DrawColor = HUDClass.default.CyanColor * 0.5;
        C.DrawColor.B = 150;
        C.DrawColor.R = 20;
        name = string(Min(999, PRI.Ping * 4));
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + PingX - (XL * 0.5), BarY + NameY);
        C.DrawText(name, true);

        C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -3);
        name = string(PRI.PacketLoss);
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + PingX - (XL * 0.5), BarY + StatY);
        C.DrawText(name, true);

        // location (ready/not ready/dead)
        if(!GRI.bMatchHasBegun)
        {
            if(PRI.bReadyToPlay)
                name = ReadyText;
            else
                name = NotReadyText;

            if(PRI.bAdmin)
            {
                name = "Admin -"@name;
                C.DrawColor.R = 170;
                C.DrawColor.G = 20;
                C.DrawColor.B = 20;
            }
            else
            {
                C.DrawColor = HUDClass.default.RedColor * 0.7;
                C.DrawColor.G = 130;
            }
        }
        else
        {
            if(!PRI.bAdmin && !PRI.bOutOfLives)
            {
                C.DrawColor = HUDClass.default.RedColor * 0.7;
                C.DrawColor.G = 130;

                if(PRI == OwnerPRI)
                    name = PRI.GetLocationName();
                else
                    name = PRI.StringUnknown;
            }
            else
            {
                C.DrawColor.R = 170;
                C.DrawColor.G = 20;
                C.DrawColor.B = 20;

                if(PRI.bAdmin)
                    name = "Admin";
                else if(PRI.bOutOfLives)
                    name = "Dead";
            }
        }
        C.StrLen(name, XL, YL);
        if(XL > NameW)
            name = left(name, NameW / XL * len(name));
        C.SetPos(BarX + LocationX, BarY + StatY);
        C.DrawText(name, true);

        // points per round
        C.DrawColor = HUDClass.default.WhiteColor * 0.55;

        if(Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound > 0)
            XL = (PRI.Score % 10000) / (Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound);
        else
            XL = (PRI.Score % 10000);

        if(int((XL - int(XL)) * 10) < 0)
        {
            if(int(XL) == 0)
                name = "-"$string(int(XL));
            else
                name = string(int(XL));
            name = name$"."$-int((XL - int(XL)) * 10);
        }
        else
        {
            name = string(int(XL));
            name = name$"."$int((XL - int(XL)) * 10);
        }

        C.StrLen(name, XL, YL);
        C.SetPos(BarX + ScoreX - (XL * 0.5), BarY + StatY);
        C.DrawText(name, true);

        // draw deaths
        C.DrawColor.R = 170;
        C.DrawColor.G = 20;
        C.DrawColor.B = 20;
        name = string(int(PRI.Deaths));
        C.StrLen(name, xl, yl);
        C.SetPos(BarX + DeadX - (XL * 0.5), BarY + StatY);
        C.DrawText(name, true);
    }

    C.DrawColor = HUDClass.default.WhiteColor;

    if(Drawn > 0)
    {
        C.SetPos(PlayerBoxX, PlayerBoxY - (BarH * 0.05));
        C.DrawTile(BaseTex, BarW, BarH * 0.05, 140, 386, 744, 4);
    }

    C.DrawColor.A = 150;

    MiscX = C.ClipX * 0.26;
    MiscY = PlayerBoxY + (BarH * Drawn);
    MiscH = C.ClipY * 0.0633;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 829, 772, 68);
    /* draw the player's bars */

    /* example bar text */
    BarX = C.ClipX * 0.27;
    BarY = C.ClipY * 0.25;

    C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

    C.DrawColor = HUDClass.default.WhiteColor * 0.7;
    C.SetPos(BarX + NameX, BarY + NameY);
    C.DrawText("Name", true);

    // score
    name = "Score";
    C.StrLen(name, XL, YL);
    C.SetPos(BarX + ScoreX - (XL * 0.5), BarY + NameY);
    C.DrawText(name, true);

    // kills
    name = "Won";
    C.StrLen(name, XL, YL);
    C.SetPos(BarX + DeadX -(XL * 0.5), BarY + NameY);
    C.DrawText(name, true);

    // ping
    C.DrawColor = HUDClass.default.CyanColor * 0.5;
    C.DrawColor.B = 150;
    C.DrawColor.R = 20;
    name = "Ping";
    C.StrLen(name, XL, YL);
    C.SetPos(BarX + PingX - (XL * 0.5), BarY + NameY);
    C.DrawText(name, true);

    C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -3);
    name = "P/L";
    C.StrLen(name, XL, YL);
    C.SetPos(BarX + PingX - (XL * 0.5), BarY + StatY);
    C.DrawText(name, true);

    // location (ready/not ready/dead)
    C.DrawColor = HUDClass.default.RedColor * 0.7;
    C.DrawColor.G = 130;
    name = "Location";
    C.SetPos(BarX + LocationX, BarY + StatY);
    C.DrawText(name, true);

    // points per round
    C.DrawColor = HUDClass.default.WhiteColor * 0.55;
    name = "PPR";
    C.StrLen(name, XL, YL);
    C.SetPos(BarX + ScoreX - (XL * 0.5), BarY + StatY);
    C.DrawText(name, true);

    // draw deaths
    C.DrawColor.R = 170;
    C.DrawColor.G = 20;
    C.DrawColor.B = 20;
    name = "Deaths";
    C.StrLen(name, xl, yl);
    C.SetPos(BarX + DeadX - (XL * 0.5), BarY + StatY);
    C.DrawText(name, true);
    /* example bar text */

    /* spec list */
    if(SpecCount > 0)
    {
        MiscX = C.ClipX * 0.8;
        MiscY = C.ClipY - (C.ClipY * 0.17);
        MiscW = C.ClipX * 0.18;
        MiscH = C.ClipY * 0.155 / 7 * (SpecCount + 1);

        C.StrLen("Testy", XL, YL);
        NameY = C.ClipY * 0.155 / 7 * 0.6 - (YL * 0.5);

        C.DrawColor = HUDClass.default.WhiteColor * 0.15;
        C.DrawColor.A = 222;
        C.SetPos(MiscX, MiscY);
        C.DrawRect(Box, MiscW, MiscH);
        
        C.DrawColor = HUDClass.default.WhiteColor * 0.4;
        C.SetPos(MiscX, MiscY);
        C.DrawRect(Box, MiscW, 1);
        C.SetPos(MiscX, MiscY);
        C.DrawRect(Box, 1, MiscH);
        C.SetPos(MiscX + MiscW, MiscY);
        C.DrawRect(Box, 1, MiscH);
        C.SetPos(MiscX, MiscY + MiscH);
        C.DrawRect(Box, MiscW + 1, 1);

        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.SetPos(MiscX + NameX, MiscY + NameY);
        C.DrawText("Spectators");

        C.DrawColor = HUDClass.default.RedColor * 0.7;
        C.DrawColor.G = 130;
        for(i = 0; i < SpecCount; i++)
        {
            name = specs[i];
			C.StrLen(name, XL, YL);
			if(XL > MiscW - (NameX * 4))
		        name = Left(name, (MiscW - (NameX * 4)) / XL * len(name));
            C.SetPos(MiscX + NameX * 2, MiscY + (C.ClipY * 0.16 / 7 * (i + 1)) + NameY);
            C.DrawText(name);
        }
    }
    /* spec list */

    if(Level.TimeSeconds - LastUpdateTime > 4)
		LastUpdateTime = Level.TimeSeconds;

    bDisplayMessages = true;
}

defaultproperties
{
}
