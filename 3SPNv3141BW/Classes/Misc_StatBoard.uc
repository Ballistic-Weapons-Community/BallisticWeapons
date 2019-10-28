class Misc_StatBoard extends DMStatsScreen;

var Texture Box;
var Texture BaseTex;

var int KillsX;
var int DamageX;
var int FiredX;
var int AccX;

var Misc_PRI OwnerPRI;
var Misc_PRI ViewPRI;

var Color CurrentColor;

struct StatItem
{
	var class<Weapon> WeaponClass;
	var string WeaponName;
};

var StatItem StatData[10];

static function float GetPercentage(float f1, float f2)
{
    if(f1 == 0.0)
        return 0.0;
    return FMin(100.0, ((f2 / f1) * 100.0));
}

function GetStatsFor(class<Weapon> weaponClass, TeamPlayerReplicationInfo ThePRI, out int killsw)
{
    local int i;

    killsw = 0;
    for(i = 0; i < ThePRI.WeaponStatsArray.Length; i++)
    {
        if(ThePRI.WeaponStatsArray[i].WeaponClass == weaponClass)
        {
            killsw = ThePRI.WeaponStatsArray[i].Kills;
            break;
        }
    }
}

simulated function DrawBars(Canvas C, int num, int x, int y, int w, int h)
{
    // background
    C.SetPos(x, y);
    C.DrawColor = CurrentColor; //HUDClass.default.WhiteColor * 0.15;
    //C.DrawColor.A = 128;
    C.DrawRect(Box, w, h * num);

    // outline
    C.DrawColor = HUDClass.default.WhiteColor * 0.4;
    C.SetPos(x, y);
    C.DrawRect(Box, w, 1);
    C.SetPos(x, y);
    C.DrawRect(Box, 1, h * num);
    C.SetPos(x + w, y);
    C.DrawRect(Box, 1, h * num);
    C.SetPos(x, y + h * num);
    C.DrawRect(Box, w + 1, 1);
}

simulated function DrawHitStat(Canvas C, int fired, int hit, int dam, int killsw, string WeaponName, int x, int y, int w, int h, int TextX, int TextY)
{
    local int Acc;
    local float XL, YL;

    DrawBars(C, 1, x, y, w, h);

    Acc = GetPercentage(fired, hit);

    C.SetPos(x + TextX, y + TextY);
    
    C.DrawColor = HUDClass.default.WhiteColor * 0.7;

    C.DrawText(WeaponName, true);
    C.StrLen(killsw, XL, YL);
    C.SetPos(x + KillsX - XL, y + TextY);
    C.DrawText(killsw, true);

    C.StrLen(Fired@":", XL, YL);
    C.SetPos(x + FiredX - XL, y + TextY);
    C.DrawText(Fired@":", true);

    C.StrLen(Acc, XL, YL);
    C.SetPos(x + AccX - XL, y + TextY);
    C.DrawText(Acc$"%", true);

    C.StrLen(Dam, XL, YL);
    C.SetPos(x + DamageX - XL, y + TextY);
    C.DrawText(dam, true);
}

simulated event DrawScoreBoard(Canvas C)
{
    
    local Misc_PRI TmpPRI;
    local BallisticPlayerReplicationInfo BWPRI;

    local int Awards, Combos;
    local int TextX, TextY;
    local int Dam, killsw;
    local int i, j;
    local float XL, YL;
    local Color Red;
    local Color Blue;
    local Color OwnerColor;
    local Color ViewedColor;
    local string name;
    local byte OwnerTeam, ViewTeam;

    local int BarX;
    local int BarY;
    local int BarW;
    local int BarH;

    local int MiscX;
    local int MiscY;
    local int MiscW;
    local int MiscH;

    local int PlayerBoxX;
    local int PlayerBoxY;
    local int PlayerBoxW;
    local int PlayerBoxH;

    if(PlayerOwner == None)
	{
		PlayerOwner = UnrealPlayer(Owner);
		if(PlayerOwner == None)
		{
			Super.DrawScoreboard(C);
			return;
		}
	}

    if(PRI == None)
    {
        PRI = TeamPlayerReplicationInfo(PlayerOwner.PlayerReplicationInfo);

        if(PRI.bOnlySpectator || PRI.bOutOfLives)
        {
            if(Pawn(PlayerOwner.ViewTarget) != None)
                PRI = TeamPlayerReplicationInfo(Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo);
            else
                NextStats();
        }
    }

    ViewPRI = Misc_PRI(PRI);
    if(OwnerPRI == None || Misc_Player(PlayerOwner).bFirstOpen )
    {    
        OwnerPRI = Misc_PRI(PlayerOwner.PlayerReplicationInfo);
        if(PlayerOwner.PlayerReplicationInfo.bOnlySpectator && Pawn(PlayerOwner.ViewTarget) != None)
        {
            OwnerPRI = Misc_PRI(Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo);
            if(OwnerPRI == None)
            {
                if(ViewPRI != None)
                    OwnerPRI = ViewPRI;
                else
                {
                    Super.DrawScoreboard(C);
                    return;
                }
            }
        }

        Misc_Player(PlayerOwner).bFirstOpen = false;
    }

    Red = HUDClass.default.RedColor;
    Red.A = 200;
    Blue = HUDClass.default.TurqColor;
    Blue.A = 200;

    if(OwnerPRI.Team == None)
        OwnerTeam = 255;
    else
        OwnerTeam = OwnerPRI.Team.TeamIndex;

    if(ViewPRI.Team == None)
        ViewTeam = 255;
    else
        ViewTeam = ViewPRI.Team.TeamIndex;

    if(OwnerTeam == 255 || OwnerTeam == 1)
        OwnerColor = Blue;
    else
        OwnerColor = Red;

    if(ViewTeam == 255 || ViewTeam == 1)
        ViewedColor = Blue;
    else
        ViewedColor = Red;

    if(Level.TimeSeconds - LastUpdateTime > 5)
    {
        LastUpdateTime = Level.TimeSeconds;
        PlayerOwner.ServerUpdateStats(OwnerPRI);
        PlayerOwner.ServerUpdateStats(ViewPRI);
    }

    MiscW = C.ClipX * 0.48;

    PlayerBoxX = C.ClipX * 0.02;
    PlayerBoxW = C.ClipX * 0.46;
    PlayerBoxH = C.ClipY * 0.5174;

    BarH = PlayerBoxH / 15;
    BarW = C.ClipX * 0.46;

    TextX = 0.005 * C.ClipX;
    TextY = 0.0036 * C.ClipY;

    KillsX = (PlayerBoxW * 0.69) * 0.4;
    AccX = (PlayerBoxW * 0.69) * 0.75;
    DamageX = (PlayerBoxW * 0.69) - TextX;

    /* draw the player's backgrounds */
    // draw the top and example bar
    C.Style = ERenderStyle.STY_Alpha;
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = 175;

    MiscX = C.ClipX * 0.01;
    MiscY = C.ClipY * 0.1;
    MiscH = C.ClipY * 0.1183;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 126, 772, 137);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 125, 772, 137);

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.0366;
    MiscW = C.ClipX * 0.0075;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 263, 10, 10);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 263, 10, 10);

    MiscX = C.ClipX * 0.01 + MiscW;
    MiscW = C.ClipX * 0.48 - (MiscW * 2);
    C.SetPos(MiscX, MiscY);
    C.DrawColor = OwnerColor;
    C.DrawTile(BaseTex, MiscW, MiscH, 137, 263, 751, 42);

    C.SetPos(MiscX + MiscW, MiscY);
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = 175;
    C.DrawTile(BaseTex, C.ClipX * 0.0069, MiscH, 888, 263, 10, 10);

    MiscX = MiscX + C.ClipX * 0.5;
    C.SetPos(MiscX, MiscY);
    C.DrawColor = ViewedColor;
    C.DrawTile(BaseTex, MiscW, MiscH, 137, 263, 751, 42);

    C.SetPos(MiscX + MiscW, MiscY);
    C.DrawColor = HUDClass.default.WhiteColor;
    C.DrawColor.A = 175;
    C.DrawTile(BaseTex, C.ClipX * 0.0069, MiscH, 888, 263, 10, 10);

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.005;
    MiscW = C.ClipX * 0.48;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 306, 772, 4);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 306, 772, 4);

    PlayerBoxY = MiscY + MiscH + (C.ClipY * 0.005);

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.5175;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 398, 772, 10);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 398, 772, 10);

    MiscX = C.ClipX * 0.01;
    MiscY = MiscY + MiscH;
    MiscH = C.ClipY * 0.0633;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 829, 772, 68);

    MiscX = C.ClipX * 0.51;
    C.SetPos(MiscX, MiscY);
    C.DrawTile(BaseTex, MiscW, MiscH, 126, 829, 772, 68);
    /* draw the player's backgrounds */

    /* draw name, score, kills, etc... in the top */
    for(i = 0; i < 2; i++)
    {
        if(i == 0)
        {
            TmpPRI = OwnerPRI;
            BarX = C.ClipX * 0.02;
        }
        else
        {
            BarX = C.ClipX * 0.52;
            TmpPRI = ViewPRI;
        }

        BarY = C.ClipY * 0.155;

        C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -2);

        // name  
        if(TmpPRI.bOutOfLives)
            C.DrawColor = HUDClass.default.WhiteColor * 0.5;
        else 
            C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.SetPos(BarX + (C.ClipX * 0.01), BarY + (C.ClipY * 0.008));
        name = TmpPRI.PlayerName;
        C.StrLen(name, XL, YL);
        if(XL > C.ClipX * 0.23)
            name = Left(name, C.ClipX * 0.23 / XL * len(name));
        C.DrawText(name, true);

        // score
        name = string(int(TmpPRI.Score % 10000));
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + (C.ClipX * 0.27) - (XL * 0.5), BarY + (C.ClipY * 0.008));
        C.DrawText(name, true);

        // kills
        if(!PlayerController(Owner).GameReplicationInfo.bTeamGame)
            name = string(int(TmpPRI.Score / 10000));
        else
            name = string(TmpPRI.Kills);

        C.StrLen(name, XL, YL);
        C.SetPos(BarX + (C.ClipX * 0.35) - (XL * 0.5), BarY + (C.ClipY * 0.008));
        C.DrawText(name, true);

        // ping
        C.DrawColor = HUDClass.default.CyanColor * 0.5;
        C.DrawColor.B = 150;
        C.DrawColor.R = 20;
        name = string(Min(999, TmpPRI.Ping * 4));
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + (C.ClipX * 0.42) - (XL * 0.5), BarY + (C.ClipY * 0.008));
        C.DrawText(name, true);

        C.Font = PlayerController(Owner).MyHUD.GetFontSizeIndex(C, -3);
        name = string(TmpPRI.PacketLoss);
        C.StrLen(name, XL, YL);
        C.SetPos(BarX + (C.ClipX * 0.42) - (XL * 0.5), BarY + (C.ClipY * 0.035));
        C.DrawText(name, true);

        // location (ready/not ready/dead)
        // location (ready/not ready/dead)
        if(!GRI.bMatchHasBegun)
        {
            if(TmpPRI.bReadyToPlay)
                name = class'TAM_Scoreboard'.default.ReadyText;
            else
                name = class'TAM_Scoreboard'.default.NotReadyText;

            if(TmpPRI.bAdmin)
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
            if(!TmpPRI.bAdmin && !TmpPRI.bOutOfLives)
            {
                C.DrawColor = HUDClass.default.RedColor * 0.7;
                C.DrawColor.G = 130;

                if((TmpPRI.Team != None && TmpPRI.Team.TeamIndex == OwnerTeam) || TmpPRI == OwnerPRI)
                    name = TmpPRI.GetLocationName();
                else
                    name = TmpPRI.StringUnknown;
            }
            else
            {
                C.DrawColor.R = 170;
                C.DrawColor.G = 20;
                C.DrawColor.B = 20;

                if(TmpPRI.bAdmin)
                    name = "Admin";
                else if(TmpPRI.bOutOfLives)
                    name = "Dead";
            }
        }
        C.StrLen(name, XL, YL);
        if(XL > C.ClipX * 0.23)
            name = left(name, C.ClipX * 0.23 / XL * len(name));
        C.SetPos(BarX + (C.ClipX * 0.02), BarY + (C.ClipY * 0.035));
        C.DrawText(name, true);

        // points per round
        C.DrawColor = HUDClass.default.WhiteColor * 0.55;
        
        if(Misc_BaseGRI(GRI).CurrentRound - TmpPRI.JoinRound > 0)
            XL = (TmpPRI.Score % 10000) / (Misc_BaseGRI(GRI).CurrentRound - TmpPRI.JoinRound);
        else
            XL = (TmpPRI.Score % 10000);

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
        C.SetPos(BarX + (C.ClipX * 0.27) - (XL * 0.5), BarY + (C.ClipY * 0.035));
        C.DrawText(name, true);

        // draw deaths
        C.DrawColor.R = 170;
        C.DrawColor.G = 20;
        C.DrawColor.B = 20;
        name = string(int(TmpPRI.Deaths));
        C.StrLen(name, xl, yl);
        C.SetPos(BarX + (C.ClipX * 0.35) - (XL * 0.5), BarY + (C.ClipY * 0.035));
        C.DrawText(name, true);
    }
    /* draw name, score, etc... in top */

    for(j = 0; j < 2; j++)
    {
        if(j == 0)
        {
            TmpPRI = OwnerPRI;
            PlayerBoxX = C.ClipX * 0.02;

            CurrentColor = OwnerColor * 0.35;
            CurrentColor.A = 75;
        }
        else
        {
            TmpPRI = ViewPRI;
            PlayerBoxX = C.ClipX * 0.52;

            CurrentColor = ViewedColor * 0.35;
            CurrentColor.A = 75;
        }

        /* awards */
        MiscX = PlayerBoxX + (PlayerBoxW * 0.7);
        MiscY = PlayerBoxY;
        MiscW = PlayerBoxW * 0.295;
        MiscH = C.ClipY * 0.02;
        C.StrLen("Test", XL, YL);
        TextY = (MiscH * 0.6 - YL * 0.5);

        Awards = 1;
        if(TmpPRI.bFirstBlood)
            Awards++;

        for(i = 0; i < 6; i++)
            if(TmpPRI.Spree[i] > 0)
                Awards++;

        for(i = 0; i < 7; i++)
            if(TmpPRI.MultiKills[i] > 0)
                Awards++;

        if(TmpPRI.FlakCount > 4)
            Awards++;
        if(TmpPRI.ComboCount > 4)
            Awards++;
        if(TmpPRI.HeadCount > 2)
            Awards++;
        if(TmpPRI.GoalsScored > 2)
            Awards++;
        if(TmpPRI.GoalsScored > 0)
            Awards++;
        if(TmpPRI.FlawlessCount > 0)
            Awards++;
        if(TmpPRI.OverkillCount > 0)
            Awards++;
        if(TmpPRI.DarkHorseCount > 0)
            Awards++;
        if(TmpPRI.ranovercount > 4)
            Awards++;
        if(TmpPRI.CampCount > 1)
            Awards++;
        if(TmpPRI.Suicides > 2)
            Awards++;

        DrawBars(C, Awards, MiscX, MiscY, MiscW, MiscH);
        C.SetPos(MiscX + TextX, MiscY + TextY);
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.DrawText("Awards", true);

        if(Awards > 1)
        {
            MiscX += TextX;
            MiscY += MiscH;

            if(TmpPRI.bFirstBlood)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText(FirstBloodString);
                MiscY += MiscH;
            }

            for(i = 0; i < 6; i++)
            {
                if(TmpPRI.Spree[i] > 0)
                {
                    C.SetPos(MiscX + TextX, MiscY + TextY);
                    C.DrawText(class'KillingSpreeMessage'.default.SelfSpreeNote[i]$MakeColorCode(HUDClass.default.GoldColor * 0.7)$"x"$TmpPRI.Spree[i]);
                    MiscY += MiscH;
                }
            }

            for(i = 0; i < 7; i++)
            {
                if(TmpPRI.MultiKills[i] > 0)
                {
                    C.SetPos(MiscX + TextX, MiscY + TextY);
                    C.DrawText(KillString[i]$MakeColorCode(HUDClass.default.GoldColor * 0.7)$"x"$TmpPRI.MultiKills[i]);
                    MiscY += MiscH;
                }
            }

            if(TmpPRI.FlakCount > 4)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText(FlakMonkey);
                MiscY += MiscH;
            }

            if(TmpPRI.ranovercount > 4)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText("Bukkake!");
                MiscY += MiscH;
            }

            if(TmpPRI.ComboCount > 4)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText(ComboWhore);
                MiscY += MiscH;
            }

            if(TmpPRI.HeadCount > 2)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText(HeadHunter);
                MiscY += MiscH;
            }

            if(TmpPRI.GoalsScored > 0)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText("Final Kill!"$MakeColorCode(HUDClass.default.GoldColor * 0.7)$"x"$TmpPRI.GoalsScored);
                MiscY += MiscH;
            }

            if(TmpPRI.GoalsScored > 2)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText(HatTrick);
                MiscY += MiscH;
            }

            if(TmpPRI.FlawlessCount > 0)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText("Flawless!"$MakeColorCode(HUDClass.default.GoldColor * 0.7)$"x"$TmpPRI.FlawlessCount);
                MiscY += MiscH;
            }

            if(TmpPRI.OverkillCount > 0)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText("Overkill!"$MakeColorCode(HUDClass.default.GoldColor * 0.7)$"x"$TmpPRI.OverkillCount);
                MiscY += MiscH;
            }

            if(TmpPRI.DarkHorseCount > 0)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText("Dark Horse!"$MakeColorCode(HUDClass.default.GoldColor * 0.7)$"x"$TmpPRI.DarkHorseCount);
                MiscY += MiscH;
            }

            if(TmpPRI.CampCount > 1)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText("Campy Bastard!", true);
                MiscY += MiscH;
            }

            if(TmpPRI.Suicides > 2)
            {
                C.SetPos(MiscX + TextX, MiscY + TextY);
                C.DrawText("Emo!", true);
                MiscY += MiscH;
            }

            MiscX -= TextX;
        }
        /* awards */

        /* combos */  
        if(Awards == 1)
            MiscY += MiscH * 1.275;
        else
            MiscY += MiscH * 0.275;

        Combos = 1;
        for(i = 0; i < 5; i++)
            if(TmpPRI.Combos[i] > 0)
                Combos++;

        DrawBars(C, Combos, MiscX, MiscY, MiscW, MiscH);
        C.SetPos(MiscX + TextX, MiscY + TextY);
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.DrawText("Combos", true);

        if(Combos > 1)
        {
            MiscX += TextX;
            for(i = 0; i < 5; i++)
            {
                if(TmpPRI.Combos[i] > 0)
                {
                    MiscY += MiscH;
                    C.SetPos(MiscX + TextX, MiscY + TextY);
                    C.DrawText(ComboNames[i]$MakeColorCode(HUDClass.default.GoldColor * 0.7)$"x"$TmpPRI.Combos[i]);
                }
            }
            MiscX -= TextX;
        }
        /* combo */

        /* efficiency */
        MiscY += MiscH * 1.275;

        DrawBars(C, 1, MiscX, MiscY, MiscW, MiscH);
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        
        C.SetPos(MiscX + TextX, MiscY + TextY);
        C.DrawText("Efficiency:", true);

        name = string(int(GetPercentage(TmpPRI.Deaths + TmpPRI.Kills, TmpPRI.Kills))) $ "%";
        C.StrLen(name, XL, YL);
        C.SetPos(MiscX + MiscW - TextX - XL, MiscY + TextY);
        C.DrawText(name, true);
        /* efficiency */

        /* RFF */
        if(PlayerController(Owner).GameReplicationInfo.bTeamGame)
        {
            MiscY += MiscH * 1.275;

            DrawBars(C, 1, MiscX, MiscY, MiscW, MiscH);
            C.DrawColor = HUDClass.default.WhiteColor * 0.7;
            
            C.SetPos(MiscX + TextX, MiscY + TextY);
            C.DrawText("ReverseFF:", true);

            name = string(int(TmpPRI.ReverseFF * 100)) $ "%";
            C.StrLen(name, XL, YL);
            C.SetPos(MiscX + MiscW - TextX - XL, MiscY + TextY);
            C.DrawText(name, true);
        }
        /* RFF */

        /* weapons */
        // show 'Weapon'...'Kills'...etc. bar
        MiscX = PlayerBoxX + (PlayerBoxW * 0.005);
        MiscY = PlayerBoxY;
        MiscW = PlayerBoxW * 0.69;

        DrawBars(C, 1, MiscX, MiscY, MiscW, MiscH);
        C.SetPos(MiscX + TextX, MiscY + TextY);
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.DrawText("Weapon", true);
        C.StrLen("Kills", XL, YL);
        C.SetPos(MiscX + KillsX - XL, MiscY + TextY);
        C.DrawText("Kills", true);
        C.StrLen("Fired : Acc", XL, YL);
        C.SetPos(MiscX + AccX - XL, MiscY + TextY);
        C.DrawText("Fired : Acc%", true);
        C.StrLen("Dam.", XL, YL);
        C.SetPos(MiscX + DamageX - XL, MiscY + TextY);
        C.DrawText("Dam.", true);
        MiscY += MiscH * 2;

        C.StrLen(" Acc", XL, YL);
        FiredX = AccX - XL;


				BWPRI = class'Mut_Ballistic'.static.GetBPRI(TmpPRI);

        // SG
        if (BWPRI != None)
				{
	        if(BWPRI.SGDamage > 0)
	        {
	            DrawBars(C, 1, MiscX, MiscY, MiscW, MiscH);
	
	            dam = BWPRI.SGDamage;
	            if(dam > 0)
	                C.DrawColor = HUDClass.default.WhiteColor * 0.7;
	            else
	                C.DrawColor = HUDClass.default.WhiteColor * 0.3;
	            C.SetPos(MiscX + TextX, MiscY + TextY);
	            C.DrawText("Mêlée", true);
	            C.StrLen(dam, XL, YL);
	            C.SetPos(MiscX + DamageX - XL, MiscY + TextY);
	            C.DrawText(dam, true);
	
	            GetStatsFor(class'ShieldGun', TmpPRI, killsw);
	            C.StrLen(killsw, XL, YL);
	            C.SetPos(MiscX + KillsX - XL, MiscY + TextY);
	            C.DrawText(killsw, true);
	        }
	        MiscY += MiscH * 2;
				
					for (i = 2; i < 10; i++)
					{
						if (BWPRI.HitStats[i].Fired > 0)
						{
							GetStatsFor(StatData[i].WeaponClass, TmpPRI, killsw);
							DrawHitStat(C, BWPRI.HitStats[i].Fired, BWPRI.HitStats[i].Hit, BWPRI.HitStats[i].Damage, BWPRI.HitStats[i].Kills, StatData[i].WeaponName, MiscX, MiscY, MiscW, MiscH, TextX, TextY);
						}
						
						MiscY += MiscH * 2;
					}

	        if(BWPRI.HitStats[0].Fired > 0)
						DrawHitStat(C, BWPRI.HitStats[0].Fired, BWPRI.HitStats[0].Hit, BWPRI.HitStats[0].Damage, TmpPRI.ComboCount, StatData[0].WeaponName, MiscX, MiscY, MiscW, MiscH, TextX, TextY);
	        
	        MiscY += MiscH * 2;
	
	        if(BWPRI.HitStats[1].Fired > 0)
						DrawHitStat(C, BWPRI.HitStats[1].Fired, BWPRI.HitStats[1].Hit, BWPRI.HitStats[1].Damage, 0, StatData[1].WeaponName, MiscX, MiscY, MiscW, MiscH, TextX, TextY);
	            
	        MiscY += MiscH * 2;
	      }
	      else
	      	MiscY += MiscH * 22;

        // total
        DrawBars(C, 1, MiscX, MiscY, MiscW, MiscH);
        C.DrawColor = HUDClass.default.WhiteColor * 0.7;
        C.SetPos(MiscX + TextX, MiscY + TextY);
        C.DrawText("Total", true);
        dam = TmpPRI.EnemyDamage;
        C.StrLen(dam, XL, YL);
        C.SetPos(MiscX + DamageX - XL, MiscY + TextY);
        C.DrawText(dam, true);

        killsw = TmpPRI.Kills;
        C.StrLen(killsw, XL, YL);
        C.SetPos(MiscX + KillsX - XL, MiscY + TextY);
        C.DrawText(killsw, true);

        MiscY += MiscH * 1.275;
        /* weapons */
    }

    bDisplayMessages = true;
}

defaultproperties
{
     Box=Texture'Engine.WhiteSquareTexture'
     BaseTex=Texture'3SPNv3141BW.textures.ScoreBoard'
     StatData(0)=(WeaponName="Grenades")
     StatData(1)=(WeaponName="Killstreak")
     StatData(2)=(WeaponClass=Class'XWeapons.AssaultRifle',WeaponName="Sidearm")
     StatData(3)=(WeaponClass=Class'XWeapons.BioRifle',WeaponName="Submachine Gun")
     StatData(4)=(WeaponClass=Class'XWeapons.ShockRifle',WeaponName="Assault Rifle")
     StatData(5)=(WeaponClass=Class'XWeapons.LinkGun',WeaponName="Energy")
     StatData(6)=(WeaponClass=Class'XWeapons.Minigun',WeaponName="Machine Gun")
     StatData(7)=(WeaponClass=Class'XWeapons.FlakCannon',WeaponName="Shotgun")
     StatData(8)=(WeaponClass=Class'XWeapons.RocketLauncher',WeaponName="Ordnance")
     StatData(9)=(WeaponClass=Class'XWeapons.SniperRifle',WeaponName="Sniper Rifle")
}
