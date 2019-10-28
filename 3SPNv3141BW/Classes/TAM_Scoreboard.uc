class TAM_Scoreboard extends ScoreBoardTeamDeathMatch;

var int LastUpdateTime;

var Texture Box;
var Texture BaseTex;

var float Scale;
var byte  BaseAlpha;

simulated function SetCustomBarColor(out Color C, PlayerReplicationInfo PRI, bool bOwner);
simulated function SetCustomLocationColor(out Color C, PlayerReplicationInfo PRI, bool bOwner);

simulated event UpdateScoreBoard(Canvas C)
{
    local PlayerReplicationInfo PRI, OwnerPRI;
    local float XL, YL;
    local string specs[6];
    local string name;
    local int i;
    local byte reds, blues;
    local byte OwnerTeam;
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

    local int RedPing;
    local int RedScore;
    local int RedKills;

    local int BluePing;
    local int BlueScore;
    local int BlueKills;

    OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;
    if(OwnerPRI.Team != None)
        OwnerTeam = OwnerPRI.Team.TeamIndex;
    else
        OwnerTeam = 255;

    NameY = C.ClipY * 0.0075 * Scale * Scale;
    StatY = C.ClipY * 0.035 * Scale;
    BarW = C.ClipX * 0.46;
    NameW = C.ClipX * 0.23;
    NameX = C.ClipX * 0.01;
    LocationX = C.ClipX * 0.02;
    ScoreX = C.ClipX * 0.27;
    DeadX = C.ClipX * 0.35;
    PingX = C.ClipX * 0.42; 

    PlayerBoxX = C.ClipX * 0.02;
    PlayerBoxW = C.ClipX * 0.46;
    PlayerBoxH = C.ClipY * 0.404;
    BarH = PlayerBoxH / 7.52;

    /* draw header */
    C.Style = ERenderStyle.STY_Alpha;
    C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -1);

    // box
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = BaseAlpha;

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
    C.DrawText(name);

    name = "www.ldg-gaming.eu";
    C.StrLen(name, XL, YL);
    C.SetPos(C.ClipX * 0.99 - XL, C.ClipY * 0.02 - YL * 0.5 + 2);
    C.DrawText(name);


    C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

    // text
    if(UnrealPlayer(Owner).bDisplayLoser)
        name = class'HUDBase'.default.YouveLostTheMatch;
    else if(UnrealPlayer(Owner).bDisplayWinner)
        name = class'HUDBase'.default.YouveWonTheMatch;
    else
    {
        name = FragLimit@GRI.GoalScore;
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
    C.DrawText(name);

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
    C.DrawText(name);
    /* draw header */

    /* draw the two team's score bars */
    MiscW = C.ClipX * 0.48;
    MiscH = C.ClipY * 0.040 * scale;
    MiscX = C.ClipX * 0.01;
    MiscY = C.ClipY * 0.15;

    C.DrawColor = HUDClass.default.RedColor;
    C.DrawColor.A = BaseAlpha;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 73, 772, 50);

    // red team score
    C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -1);
    C.DrawColor = HUDClass.default.WhiteColor * 0.7;
    name = string(int(GRI.Teams[0].Score));
    C.StrLen(name, XL, YL);
    C.SetPos(MiscX + (MiscW * 0.5) - (XL * 0.5), MiscY + (MiscH * 0.6) - (YL * 0.5));
    C.DrawText(name);

    MiscX = C.ClipX * 0.51;
    C.DrawColor = HUDClass.default.TurqColor;
    C.DrawColor.A = BaseAlpha;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 73, 772, 50);

    // blue team score
    C.DrawColor = HUDClass.default.WhiteColor * 0.7;
    name = string(int(GRI.Teams[1].Score));
    C.StrLen(name, XL, YL);
    C.SetPos(MiscX + (MiscW * 0.5) - (XL * 0.5), MiscY + (MiscH * 0.6) - (YL * 0.5));
    C.DrawText(name);
    /* draw the two team's score bars */

    /* draw the team's backgrounds */
    // draw the top and example bar
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = BaseAlpha;

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.1183 * scale;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 126, 772, 137);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 125, 772, 137);

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.03 * scale;
    MiscW = C.ClipX * 0.0075;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 263, 10, 10);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 263, 10, 10);

    MiscX = C.ClipX * 0.01 + MiscW;
    MiscW = C.ClipX * 0.48 - (MiscW * 2);
    C.SetPos(MiscX, MiscY);
    C.DrawColor = HUDClass.default.RedColor;
    C.DrawColor.A = BaseAlpha;
    C.DrawTile(BaseTex, MiscW, MiscH, 137, 263, 751, 42);

    C.SetPos(MiscX + MiscW, MiscY);
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = BaseAlpha;
    C.DrawTile(BaseTex, C.ClipX * 0.0069, MiscH, 888, 263, 10, 10);

    MiscX = MiscX + C.ClipX * 0.5;
    C.SetPos(MiscX, MiscY);
    C.DrawColor = HUDClass.default.TurqColor;
    C.DrawColor.A = BaseAlpha;
    C.DrawTile(BaseTex, MiscW, MiscH, 137, 263, 751, 42);

    C.SetPos(MiscX + MiscW, MiscY);
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = BaseAlpha;
    C.DrawTile(BaseTex, C.ClipX * 0.0069, MiscH, 888, 263, 10, 10);

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.005 * scale;
    MiscW = C.ClipX * 0.48;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 306, 772, 4);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 306, 772, 4);

    PlayerBoxY = (MiscY + MiscH + (C.ClipY * 0.005 * Scale));

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.005 * scale;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 398, 772, 10);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 398, 772, 10);

    /* draw the player's bars */
    for(i = 0; i < GRI.PRIArray.Length; i++)
    {
        PRI = GRI.PRIArray[i];
        if(PRI.Team == None)
        {
            if(!PRI.bOnlySpectator || SpecCount >= 6)
                continue;

            Specs[SpecCount] = PRI.PlayerName;
            SpecCount++;
            continue;
        }

        if(Level.TimeSeconds - LastUpdateTime > 4)
            Misc_Player(Owner).ServerUpdateStats(TeamPlayerReplicationInfo(PRI));

        if(PRI.Team.TeamIndex == 0)
        {
            if(reds > 6)
                continue;
            if(reds == 6 && OwnerTeam == 0 && !bDrawnOwner && PRI != OwnerPRI)
                continue;

            BarX = PlayerBoxX;
            BarY = PlayerBoxY + (BarH * Reds);

            C.DrawColor = HUDClass.default.WhiteColor;
            C.DrawColor.A = BaseAlpha;
            C.SetPos(int(C.ClipX * 0.01), BarY);
            C.DrawTile(BaseTex, int(C.ClipX * 0.48), BarH, 126, 398, 772, 10);

            if(PRI == OwnerPRI)
            {
                C.DrawColor.R = 255;
                C.DrawColor.G = 50;
                C.DrawColor.B = 0;
                C.DrawColor.A = BaseAlpha;
            }
            else
            {
                C.DrawColor = HUDClass.default.WhiteColor;
                C.DrawColor.A = BaseAlpha * 0.5;
            }

            RedPing += PRI.Ping;
            RedScore += PRI.Score;
            RedKills += PRI.Kills;

            reds++;
        }
        else
        {
            if(blues > 6)
                continue;
            if(blues == 6 && OwnerTeam == 1 && !bDrawnOwner && PRI != OwnerPRI)
                continue;

            BarX = C.ClipX * 0.50 + PlayerBoxX;
            BarY = PlayerBoxY + (BarH * Blues);

            C.DrawColor = HUDClass.default.WhiteColor;
            C.DrawColor.A = BaseAlpha;
            C.SetPos(int(C.ClipX * 0.51), BarY);
            C.DrawTile(BaseTex, int(C.ClipX * 0.48), BarH, 126, 398, 772, 10);

            if(PRI == OwnerPRI)
            {
                C.DrawColor.R = 50;
                C.DrawColor.G = 178;
                C.DrawColor.B = 255;
                C.DrawColor.A = BaseAlpha;
            }
            else
            {
                C.DrawColor = HUDClass.default.WhiteColor;
                C.DrawColor.A = BaseAlpha * 0.5;
            }

            BluePing += PRI.Ping;
            BlueScore += PRI.Score;
            BlueKills += PRI.Kills;

            blues++;
        }

        SetCustomBarColor(C.DrawColor, PRI, PRI == OwnerPRI);

        if(PRI == OwnerPRI)
            bDrawnOwner = true;

        C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

        // draw background
        C.SetPos(BarX, BarY);
        C.DrawTile(BaseTex, BarW, BarH * 0.95, 140, 312, 744, 74);
        C.SetPos(BarX, BarY + BarH * 0.95);
        C.DrawColor = HUDClass.default.WhiteColor;
        C.DrawTile(BaseTex, BarW, BarH * 0.05, 140, 387, 744, 3);

        // name
        if(PRI.bOutOfLives)
            C.DrawColor = HUDClass.default.WhiteColor * 0.4;
        else 
            C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.SetPos(BarX + NameX, BarY + NameY);
        name = PRI.PlayerName;
        C.StrLen(name, XL, YL);
        if(XL > NameW)
            name = Left(name, NameW / XL * len(name));
        C.DrawText(name);

        // score
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        name = string(int(PRI.Score));
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + ScoreX - (XL * 0.5), BarY + NameY);
        C.DrawText(name);

        // kills
        name = string(PRI.Kills);
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + DeadX -(XL * 0.5), BarY + NameY);
        C.DrawText(name);

        // ping
        C.DrawColor = HUDClass.default.CyanColor * 0.5;
        C.DrawColor.B = 150;
        C.DrawColor.R = 20;
        name = string(Min(999, PRI.Ping * 4));
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + PingX - (XL * 0.5), BarY + NameY);
        C.DrawText(name);

        C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -3);
        name = string(PRI.PacketLoss);
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + PingX - (XL * 0.5), BarY + StatY);
        C.DrawText(name);

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
            if(!PRI.bAdmin /*&& !PRI.bOutOfLives*/)
            {
                if(!PRI.bOutOfLives)
                {
                    C.DrawColor = HUDClass.default.RedColor * 0.7;
                    C.DrawColor.G = 130;

                    if(PRI.Team.TeamIndex == OwnerTeam)
                        name = PRI.GetLocationName();
                    else
                        name = PRI.StringUnknown;
                }
                else
                {
                    C.DrawColor.R = 170;
                    C.DrawColor.G = 20;
                    C.DrawColor.B = 20;

                    name = PRI.GetLocationName();
                }   

                SetCustomLocationColor(C.DrawColor, PRI, PRI == OwnerPRI);
            }
            else
            {
                C.DrawColor.R = 170;
                C.DrawColor.G = 20;
                C.DrawColor.B = 20;

                //if(PRI.bAdmin)
                    name = "Admin";
                /*else if(PRI.bOutOfLives)
                    name = "Dead";*/
            }
        }
        C.StrLen(name, XL, YL);
        if(XL > NameW)
            name = left(name, NameW / XL * len(name));
        C.SetPos(BarX + LocationX, BarY + StatY);
        C.DrawText(name);

        // points per round
        C.DrawColor = HUDClass.default.WhiteColor * 0.55;

        if(Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound > 0)
            XL = PRI.Score / (Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound);
        else
            XL = PRI.Score;

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
        C.DrawText(name);

        // draw deaths
        C.DrawColor.R = 170;
        C.DrawColor.G = 20;
        C.DrawColor.B = 20;
        name = string(int(PRI.Deaths));
        C.StrLen(name, xl, yl);
        C.SetPos(BarX + DeadX - (XL * 0.5), BarY + StatY);
        C.DrawText(name);
    }

    C.DrawColor = HUDClass.default.WhiteColor;

    if(Reds > 0)
    {
        RedPing /= Reds;

        C.SetPos(PlayerBoxX, PlayerBoxY - (BarH * 0.05));
        C.DrawTile(BaseTex, BarW, BarH * 0.05, 140, 387, 744, 3);

        // draw team totals
        if(Reds >= 2)
        {
            BarX = PlayerBoxX;
            BarY = PlayerBoxY + (BarH * Reds);

            C.DrawColor = HUDClass.default.WhiteColor;
            C.DrawColor.A = BaseAlpha;
            C.SetPos(int(C.ClipX * 0.01), BarY);
            C.DrawTile(BaseTex, int(C.ClipX * 0.48), BarH * 0.6, 126, 398, 772, 10);

            // draw background
            C.DrawColor.R = 255;
            C.DrawColor.G = 50;
            C.DrawColor.B = 0;
            C.DrawColor.A = BaseAlpha * 0.75;

            C.SetPos(BarX, BarY);
            C.DrawTile(BaseTex, BarW, BarH * 0.55, 140, 312, 744, 74);
            C.SetPos(BarX, BarY + BarH * 0.55);
            C.DrawColor = HUDClass.default.WhiteColor;
            C.DrawTile(BaseTex, BarW, BarH * 0.05, 140, 387, 744, 3);

            C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

            C.DrawColor = HUDClass.default.WhiteColor * 0.7;

            // "Red Team"
            C.SetPos(BarX + NameX, BarY + NameY * 0.7);
            C.DrawText("Red Team");

            // score
            name = string(RedScore);
            C.StrLen(name, XL, YL);
            C.SetPos(BarX + ScoreX - XL * 0.5, BarY + NameY * 0.7);
            C.DrawText(name);

            // kills
            name = string(RedKills);
            C.StrLen(name, XL, YL);
            C.SetPos(BarX + DeadX - XL * 0.5, BarY + NameY * 0.7);
            C.DrawText(name);

            // ping
            C.DrawColor = HUDClass.default.CyanColor * 0.5;
            C.DrawColor.B = 150;
            C.DrawColor.R = 20;

            name = string(Min(999, RedPing * 4));
            C.StrLen(name, XL, YL);
            C.SetPos(BarX + PingX - XL * 0.5, BarY + NameY * 0.7);
            C.DrawText(name);
        }
    }
    if(Blues > 0)
    {
        BluePing /= Blues;

        C.SetPos(PlayerBoxX + C.ClipX * 0.5, PlayerBoxY - (BarH * 0.05));
        C.DrawTile(BaseTex, BarW, BarH * 0.05, 140, 387, 744, 3);

        // draw team totals
        if(Blues >= 2)
        {
            BarX = PlayerBoxX + (C.ClipX * 0.5);
            BarY = PlayerBoxY + (BarH * Blues);

            C.DrawColor = HUDClass.default.WhiteColor;
            C.DrawColor.A = BaseAlpha;
            C.SetPos(int(C.ClipX * 0.51), BarY);
            C.DrawTile(BaseTex, int(C.ClipX * 0.48), BarH * 0.6, 126, 398, 772, 10);

            // draw background
            C.DrawColor.R = 50;
            C.DrawColor.G = 178;
            C.DrawColor.B = 255;
            C.DrawColor.A = BaseAlpha * 0.75;

            C.SetPos(BarX, BarY);
            C.DrawTile(BaseTex, BarW, BarH * 0.55, 140, 312, 744, 74);
            C.SetPos(BarX, BarY + BarH * 0.55);
            C.DrawColor = HUDClass.default.WhiteColor;
            C.DrawTile(BaseTex, BarW, BarH * 0.05, 140, 387, 744, 3);

            C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

            C.DrawColor = HUDClass.default.WhiteColor * 0.7;

            // "Red Team"
            C.SetPos(BarX + NameX, BarY + NameY * 0.7);
            C.DrawText("Blue Team");

            // score
            name = string(BlueScore);
            C.StrLen(name, XL, YL);
            C.SetPos(BarX + ScoreX - XL * 0.5, BarY + NameY * 0.7);
            C.DrawText(name);

            // kills
            name = string(BlueKills);
            C.StrLen(name, XL, YL);
            C.SetPos(BarX + DeadX - XL * 0.5, BarY + NameY * 0.7);
            C.DrawText(name);

            // ping
            C.DrawColor = HUDClass.default.CyanColor * 0.5;
            C.DrawColor.B = 150;
            C.DrawColor.R = 20;

            name = string(Min(999, BluePing * 4));
            C.StrLen(name, XL, YL);
            C.SetPos(BarX + PingX - XL * 0.5, BarY + NameY * 0.7);
            C.DrawText(name);
        }
    }

    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = BaseAlpha;
    MiscX = C.ClipX * 0.01;
    MiscY = PlayerBoxY + (BarH * Reds);
    if(Reds > 1)
        MiscY += BarH * 0.6;

    MiscH = C.ClipY * 0.0633 * Scale;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 829, 772, 68);

    MiscX = C.ClipX * 0.51;
    MiscY = PlayerBoxY + (BarH * Blues);
    if(Blues > 1)
        MiscY += BarH * 0.6;

    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 829, 772, 68);
    /* draw the player's bars */

    /* example bar text */
    for(i = 0; i < 2; i++)
    {
        if(i == 0)
            BarX = C.ClipX * 0.02;
        else
            BarX = C.ClipX * 0.52;
        BarY = C.ClipY * 0.26 * Scale;

        C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

        // name  
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.SetPos(BarX + NameX, BarY + NameY);
        C.DrawText("Name", true);

        // score
        name = "Score";
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + ScoreX - (XL * 0.5), BarY + NameY);
        C.DrawText(name, true);

        // kills
        name = "Kills";
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
    }
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
        C.DrawColor.A = BaseAlpha;
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
     Box=Texture'Engine.WhiteSquareTexture'
     BaseTex=Texture'3SPNv3141BW.textures.ScoreBoard'
     Scale=0.900000
     BaseAlpha=150
}
