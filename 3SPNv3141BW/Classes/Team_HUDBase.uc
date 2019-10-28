class Team_HUDBase extends HudWTeamDeathmatch
    abstract;

#exec TEXTURE IMPORT NAME=Chair FILE=Textures\Chair.tga GROUP=Textures MIPS=Off ALPHA=1 DXT=3 LODSET=5
#exec TEXTURE IMPORT NAME=Flake FILE=Textures\Flake.tga GROUP=Textures MIPS=Off ALPHA=1 DXT=3 LODSET=5
#exec TEXTURE IMPORT NAME=FrostedScoreboard FILE=Textures\FrostedScoreboard.tga GROUP=Textures MIPS=Off ALPHA=1 DXT=3 LODSET=5
#exec TEXTURE IMPORT NAME=ScoreBoard FILE=Textures\ScoreBoard.tga GROUP=Textures MIPS=Off ALPHA=1 DXT=3 LODSET=5
#exec TEXTURE IMPORT NAME=Icons FILE=Textures\Icons.tga GROUP=Textures MIPS=Off ALPHA=1 DXT=3 LODSET=5

var Texture TeamTex;
var Material TrackedPlayer;
var int OldRoundTime;
var Misc_Player myOwner;

var Color FullHealthColor;
var Color NameColor;
var Color LocationColor;
var float	fBlink, fPulse;

var localized string PracticeRoundString;
var localized string PracticeRoundEndedString;

exec function ShowStats()
{
	bShowLocalStats = !bShowLocalStats;
    Misc_Player(PlayerOwner).bFirstOpen = bShowLocalStats;
}

function Draw2DLocationDot(Canvas C, vector Loc, float OffsetX, float OffsetY, float ScaleX, float ScaleY)
{
	local rotator Dir;
	local float Angle, Scaling;
	local Actor Start;

	if(PlayerOwner.Pawn == None)
    {
        if(PlayerOwner.ViewTarget != None)
            Start = PlayerOwner.ViewTarget;
        else
		    Start = PlayerOwner;
    }
	else
		Start = PlayerOwner.Pawn;

	Dir = rotator(Loc - Start.Location);
	Angle = ((Dir.Yaw - PlayerOwner.Rotation.Yaw) & 65535) * 6.2832 / 65536;
	C.Style = ERenderStyle.STY_Alpha;
	C.SetPos(OffsetX * C.ClipX + ScaleX * C.ClipX * sin(Angle),
			OffsetY * C.ClipY - ScaleY * C.ClipY * cos(Angle));

	Scaling = 24 * C.ClipX * (0.45 * HUDScale) / 1600;

	C.DrawTile(LocationDot, Scaling, Scaling, 340, 432, 78, 78);
}

simulated function bool ShouldDrawPlayer(Misc_PRI PRI)
{
    if(PRI == None || PRI.bOutOfLives || PRI.Team == None || PRI == PlayerOwner.PlayerReplicationInfo)
        return false;
    return true;
}

simulated function DrawPlayers(Canvas C)
{
    local int i;
    local int Team;
    local float xl;
    local float yl;
    local float MaxNamePos;
    local int posx;
    local int posy;
    local float scale;
    local string name;
    local int listy;
    local int space;
    local int namey;
    local int namex;
    local int height;
    local int width;
    local Misc_PRI pri;
    local int health;
    local int starthealth;

    local int allies;
    local int enemies;

    if(myOwner == None)
        return;

    if(PlayerOwner.PlayerReplicationInfo.Team != None)
        Team = PlayerOwner.GetTeamNum();
    else
    {
        if(Pawn(PlayerOwner.ViewTarget) == None || Pawn(PlayerOwner.ViewTarget).GetTeamNum() == 255)
            return;
        Team = Pawn(PlayerOwner.ViewTarget).GetTeamNum();
    }

    listy = 0.08 * HUDScale * C.ClipY;
    scale = 0.75;
    height = C.ClipY * 0.02;
    space = height + (0.0075 * C.ClipY);
    namex = C.ClipX * 0.02; 
    
    C.Font = GetFontSizeIndex(C, -3);
    C.StrLen("Test", xl, yl);
    namey = (height * 0.6) - (yl * 0.5);

    for(i = 0; i < MyOwner.GameReplicationInfo.PRIArray.Length; i++)
    {
        PRI = Misc_PRI(myOwner.GameReplicationInfo.PRIArray[i]);
        if(!ShouldDrawPlayer(PRI))
            continue;

        if(!myOwner.bShowTeamInfo)
            continue;

        if(PRI.Team.TeamIndex == Team)
        {
            space = (0.005 * C.ClipY);
            width = C.ClipX * 0.14;
            MaxNamePos = 0.99 * (width - namex);

            posy = listy + ((height + space) * allies);
            posx = C.ClipX * 0.01;
            
            // draw backgrounds
            C.SetPos(posx, posy);
            C.DrawColor = default.BlackColor;
            C.DrawColor.A = 100;
            C.DrawTile(TeamTex, width + posx, height, 168, 211, 166, 44);

            // draw disc
            C.SetPos(posx, posy);
            C.DrawColor = default.WhiteColor;
            C.DrawTile(TeamTex, C.ClipX * 0.0195 * Scale, C.ClipY * 0.026 * Scale, 119, 258, 54, 55);

			// draw health dot
            health = PRI.PawnReplicationInfo.Health + PRI.PawnReplicationInfo.Shield;
            if(TAM_TeamInfo(PRI.Team) != None)
                starthealth = TAM_TeamInfo(PRI.Team).StartingHealth;
            else if(TAM_TeamInfoRed(PRI.Team) != None)
                starthealth = TAM_TeamInfoRed(PRI.Team).StartingHealth;
            else if(TAM_TeamInfoBlue(PRI.Team) != None)
                starthealth = TAM_TeamInfoBlue(PRI.Team).StartingHealth;
            else
                starthealth = 200;

            if(health < starthealth)
            {
                C.DrawColor.B = 0;
                C.DrawColor.R = Min(200, (400 * (float(StartHealth - Health) / float(StartHealth))));

                if(C.DrawColor.R == 200)
		        C.DrawColor.G = Min(200, (400 * (float(Health) / float(StartHealth))));
                else
                    C.DrawColor.G = 200;
            }
            else
                C.DrawColor = FullHealthColor;
            

            C.SetPos(posx + (0.0022 * Scale * C.ClipX), posy + (0.0035 * Scale * C.ClipY));
            C.DrawTile(TeamTex, C.ClipX * 0.0165 * Scale, C.ClipY * 0.0185 * Scale, 340, 432, 78, 78);
                   
			// draw health
            name = string(health);
            C.SetPos(posx + namex, posy + namey);       
            C.DrawText(name);

            // draw name
            name = PRI.PlayerName;
            C.StrLen(name, xl, yl);
            if(xl > MaxNamePos)
                name = left(name, MaxNamePos / xl * len(name));
                
            C.DrawColor = NameColor;
            C.StrLen("0000", xl, yl);
            C.SetPos(posx + namex + xl, posy + namey);   
            C.DrawText(name);

            // draw location dot
            C.DrawColor = WhiteColor;
            Draw2DLocationDot(C, PRI.PawnReplicationInfo.Position, (posx / C.ClipX) + (0.006 * Scale), (posy / C.ClipY) + (0.008 * Scale), 0.008 * Scale, 0.01 * Scale);

            
            // allies shown
            allies++;

        }
        else
        {
            space = (0.005 * C.ClipY);
            width = C.ClipX * 0.11;
            MaxNamePos = 0.99 * (width - namex);

            posy = listy + ((height + space) * enemies);
            posx = C.ClipX * 0.99;

            // draw background
            C.SetPos(posx - width, posy);
            C.DrawColor = default.BlackColor;
            C.DrawColor.A = 100;
            C.DrawTile(TeamTex, width, height, 168, 211, 166, 44);

            // draw disc
            C.SetPos(posx - (C.ClipX * 0.0195 * Scale), posy);
            C.DrawColor = default.WhiteColor;
            C.DrawTile(TeamTex, C.ClipX * 0.0195 * Scale, C.ClipY * 0.026 * Scale, 119, 258, 54, 55);

            // draw name
            name = PRI.PlayerName;
            C.StrLen(name, xl, yl);
            if(xl > MaxNamePos)
            {
                name = left(name, MaxNamePos / xl * len(name));
                C.StrLen(name, xl, yl);
            }
            C.DrawColor = NameColor;
            C.SetPos(posx - xl - namex, posy + namey); 
            C.DrawText(name);

            // draw health dot
            C.DrawColor = HudColorTeam[PRI.Team.TeamIndex];
            C.SetPos(posx - (0.016 * Scale * C.ClipX), posy + (0.0035 * Scale * C.ClipY));
            C.DrawTile(TeamTex, C.ClipX * 0.0165 * Scale, C.ClipY * 0.0185 * Scale, 340, 432, 78, 78);

            // enemies shown
            enemies++;
        }
    }
}

simulated function UpdateRankAndSpread(Canvas C)
{
    if(MyOwner == None)
        return;

    DrawPlayers(C);
}


simulated function UpdateHUD()
{
    local Color red;
    local Color blue;
    local int team;

    if(myOwner == None)
    {
        myOwner = Misc_Player(PlayerOwner);

        if(myOwner == None)
        {
            Super.UpdateHUD();
            return;
        }
    }

    if(MyOwner.bMatchHUDToSkins)
	{
        if(MyOwner.PlayerReplicationInfo.bOnlySpectator)
        {
            if(Pawn(MyOwner.ViewTarget) != None && Pawn(MyOwner.ViewTarget).GetTeamNum() != 255)
                team = Pawn(MyOwner.ViewTarget).GetTeamNum();
            else
                return;
        }
        else
            team = MyOwner.GetTeamNum();

        red = MyOwner.RedOrEnemy * 2;
        blue = MyOwner.BlueOrAlly * 2;
        red.A = HudColorRed.A;
        blue.A = HudColorBlue.A;

		if(!MyOwner.bUseTeamColors)
		{
			if(team == 0)
			{
				HudColorRed = blue;
				HudColorBlue = red;
                HudColorTeam[0] = blue;
                HudColorTeam[1] = red;

				TeamSymbols[0].Tints[0] = blue;
				TeamSymbols[0].Tints[1] = blue;
				TeamSymbols[1].Tints[0] = red;
				TeamSymbols[1].Tints[1] = red;
			}
			else
			{
				HudColorBlue = blue;
				HudColorRed = red;
                HudColorTeam[1] = blue;
                HudColorTeam[0] = red;

				TeamSymbols[0].Tints[0] = red;
				TeamSymbols[0].Tints[1] = red;
				TeamSymbols[1].Tints[0] = blue;
				TeamSymbols[1].Tints[1] = blue;
			}
		}
		else
		{
			HudColorRed = red;
			HudColorBlue = blue;
		}
	}
	else
	{
		HudColorRed = default.HudColorRed;
		HudColorBlue = default.HudColorBlue;
        HudColorTeam[0] = default.HudColorTeam[0];
        HudColorTeam[1] = default.HudColorTeam[1];

		TeamSymbols[0].Tints[0] = default.HudColorTeam[0];
		TeamSymbols[0].Tints[1] = default.HudColorTeam[0];
		TeamSymbols[1].Tints[0] = default.HudColorTeam[1];
		TeamSymbols[1].Tints[1] = default.HudColorTeam[1];
	}

    Super.UpdateHUD();
}

/*simulated function DrawTrackedPlayer(Canvas C, Misc_PawnReplicationInfo P, Misc_PRI PRI)
{
    local float	SizeScale, SizeX, SizeY;
    local vector ScreenPos;

    if(DrawPlayerTracking(C, P, false, ScreenPos) && (!p.bInvis || MyOwner.bEnhancedRadar) && PRI != PawnOwner.PlayerReplicationInfo)
    {
        if(MyOwner.bEnhancedRadar)
            C.DrawColor = HudColorTeam[pri.Team.TeamIndex];
        else
            C.DrawColor = WhiteColor * 0.8;
        C.DrawColor.A = 175;
        C.Style = ERenderStyle.STY_Alpha;

	    SizeScale	= 0.2;
	    SizeX		= 32 * SizeScale * ResScaleX;
	    SizeY		= 32 * SizeScale * ResScaleY;

	    C.SetPos(ScreenPos.X - SizeX * 0.5, ScreenPos.Y - SizeY * 0.5);
	    C.DrawTile(TrackedPlayer, SizeX, SizeY, 0, 0, 64, 64);
    }
}

simulated function bool DrawPlayerTracking( Canvas C, Actor P, bool bOptionalIndicator, out vector ScreenPos )
{
	local Vector	CamLoc;
	local Rotator	CamRot;

	C.GetCameraLocation(CamLoc, CamRot);

	if(IsTargetInFrontOfPlayer(C, P, ScreenPos, CamLoc, CamRot) && !FastTrace(Misc_PawnReplicationInfo(P).Position, CamLoc))
		return true;

	return false;
}

static function bool IsTargetInFrontOfPlayer( Canvas C, Actor Target, out Vector ScreenPos,
											 Vector CamLoc, Rotator CamRot )
{
	// Is Target located behind camera ?
	if((Misc_PawnReplicationInfo(Target).Position - CamLoc) Dot vector(CamRot) < 0)
		return false;

	// Is Target on visible canvas area ?
	ScreenPos = C.WorldToScreen(Misc_PawnReplicationInfo(Target).Position);
	if(ScreenPos.X <= 0 || ScreenPos.X >= C.ClipX)
        return false;
	if(ScreenPos.Y <= 0 || ScreenPos.Y >= C.ClipY)
        return false;

	return true;
}*/

function CheckCountdown(GameReplicationInfo GRI)
{
    local Misc_BaseGRI G;

    G = Misc_BaseGRI(GRI);
    if(G == None || G.MinsPerRound == 0 || G.RoundTime == 0 || G.RoundTime == OldRoundTime || GRI.Winner != None)
    {
        Super.CheckCountdown(GRI);
        return;
    }

    OldRoundTime = G.RoundTime;

    if(OldRoundTime > 30 && G.MinsPerRound < 2)
        return;

    if(OldRoundTime == 60)
        PlayerOwner.PlayStatusAnnouncement(LongCountName[3], 1, true);
    else if(OldRoundTime == 30)
        PlayerOwner.PlayStatusAnnouncement(LongCountName[4], 1, true);
    else if(OldRoundTime == 20)
        PlayerOwner.PlayStatusAnnouncement(LongCountName[5], 1, true);
    else if(OldRoundTime <= 5 && OldRoundTime > 0)
        PlayerOwner.PlayStatusAnnouncement(CountDownName[OldRoundTime - 1], 1, true);
}

simulated function DrawTimer(Canvas C)
{
	local Misc_BaseGRI GRI;
	local int Minutes, Hours, Seconds;

	GRI = Misc_BaseGRI(PlayerOwner.GameReplicationInfo);

    if(GRI == None)
        return;

	if(GRI.MinsPerRound > 0)
    {
        Seconds = GRI.RoundTime;
        if(GRI.TimeLimit > 0 && GRI.RoundTime > GRI.RemainingTime)
            Seconds = GRI.RemainingTime;
    }
    else if(GRI.TimeLimit > 0)
        Seconds = GRI.RemainingTime;
	else
		Seconds = GRI.ElapsedTime;

	TimerBackground.Tints[TeamIndex] = HudColorBlack;
    TimerBackground.Tints[TeamIndex].A = 150;

	DrawWidgetAsTile(C, TimerBackground);
	DrawWidgetAsTile(C, TimerBackgroundDisc);
	DrawWidgetAsTile(C, TimerIcon);

	TimerMinutes.OffsetX = default.TimerMinutes.OffsetX - 80;
	TimerSeconds.OffsetX = default.TimerSeconds.OffsetX - 80;
	TimerDigitSpacer[0].OffsetX = Default.TimerDigitSpacer[0].OffsetX;
	TimerDigitSpacer[1].OffsetX = Default.TimerDigitSpacer[1].OffsetX;

	if( Seconds > 3600 )
    {
        Hours = Seconds / 3600;
        Seconds -= Hours * 3600;

		DrawNumericWidgetAsTiles( C, TimerHours, DigitsBig );
        TimerHours.Value = Hours;

		if(Hours>9)
		{
			TimerMinutes.OffsetX = default.TimerMinutes.OffsetX;
			TimerSeconds.OffsetX = default.TimerSeconds.OffsetX;
		}
		else
		{
			TimerMinutes.OffsetX = default.TimerMinutes.OffsetX -40;
			TimerSeconds.OffsetX = default.TimerSeconds.OffsetX -40;
			TimerDigitSpacer[0].OffsetX = Default.TimerDigitSpacer[0].OffsetX - 32;
			TimerDigitSpacer[1].OffsetX = Default.TimerDigitSpacer[1].OffsetX - 32;
		}
		DrawWidgetAsTile( C, TimerDigitSpacer[0] );
	}
	DrawWidgetAsTile( C, TimerDigitSpacer[1] );

	Minutes = Seconds / 60;
    Seconds -= Minutes * 60;

    TimerMinutes.Value = Min(Minutes, 60);
	TimerSeconds.Value = Min(Seconds, 60);

	DrawNumericWidgetAsTiles( C, TimerMinutes, DigitsBig );
	DrawNumericWidgetAsTiles( C, TimerSeconds, DigitsBig );
	
}

simulated function DrawHudPassC (Canvas C) // Alpha Pass
{
	local Misc_BaseGRI GRI;
	
	Super.DrawHudPassC(C);

	GRI = Misc_BaseGRI(PlayerOwner.GameReplicationInfo);
	
	if (GRI.bMatchHasBegun && GRI.bPracticeRound)
		DrawPracticeRoundInfo(C);
}

simulated function DrawSpectatingHud (Canvas C)
{
	local string InfoString;
	local plane OldModulate;
	local float xl,yl,Full, Height, Top, TextTop, MedH, SmallH,Scale;
	local Misc_BaseGRI GRI;

	// Hack for tutorials.
	bIsCinematic = IsInCinematic();

    DisplayLocalMessages (C);
 
	if ( bIsCinematic )
		return;
		
    OldModulate = C.ColorModulate;

    C.Font = GetMediumFontFor(C);
    C.StrLen("W",xl,MedH);
	Height = MedH;
	C.Font = GetConsoleFont(C);
    C.StrLen("W",xl,SmallH);
    Height += SmallH;

	Full = Height;
    Top  = C.ClipY-8-Full;

	Scale = (Full+16)/128;

	// I like Yellow

    C.ColorModulate.X=255;
    C.ColorModulate.Y=255;
    C.ColorModulate.Z=0;
    C.ColorModulate.W=255;

	// Draw Border

	C.SetPos(0,Top);
    C.SetDrawColor(255,255,255,255);
    C.DrawTileStretched(material'InterfaceContent.SquareBoxA',C.ClipX,Full);
    C.ColorModulate.Z=255;

    TextTop = Top + 4;
    GRI = Misc_BaseGRI(PlayerOwner.GameReplicationInfo);
	
	if (GRI == None)
		return;

    C.SetPos(0,Top-8);
    C.Style=5;
    C.DrawTile(material'LMSLogoSmall',256*Scale,128*Scale,0,0,256,128);
    C.Style=1;

	if ( UnrealPlayer(Owner).bDisplayWinner ||  UnrealPlayer(Owner).bDisplayLoser )
	{
		if ( UnrealPlayer(Owner).bDisplayWinner )
			InfoString = YouveWonTheMatch;
		else
		{
			if ( PlayerReplicationInfo(PlayerOwner.GameReplicationInfo.Winner) != None )
				InfoString = WonMatchPrefix$PlayerReplicationInfo(PlayerOwner.GameReplicationInfo.Winner).PlayerName$WonMatchPostFix;
			else
				InfoString = YouveLostTheMatch;
		}

        C.SetDrawColor(255,255,255,255);
        C.Font = GetMediumFontFor(C);
        C.StrLen(InfoString,XL,YL);
        C.SetPos( (C.ClipX/2) - (XL/2), Top + (Full/2) - (YL/2));
        C.DrawText(InfoString,false);
    }

	else if ( (!GRI.bPracticeRound || !GRI.bEndOfRound) && Pawn(PlayerOwner.ViewTarget) != None && Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo != None )
    {
    	// Draw View Target info

		C.SetDrawColor(32,255,32,255);

		if ( C.ClipX < 640 )
			SmallH = 0;
		else
		{
			// Draw "Now Viewing"

			C.SetPos((256*Scale*0.75),TextTop);
			C.DrawText(NowViewing,false);

    		// Draw "Score"

			InfoString = GetScoreText();
			C.StrLen(InfoString,Xl,Yl);
			C.SetPos(C.ClipX-5-XL,TextTop);
			C.DrawText(InfoString);
		}

        // Draw Player Name

        C.SetDrawColor(255,255,0,255);
        C.Font = GetMediumFontFor(C);
        C.SetPos((256*Scale*0.75),TextTop+SmallH);
        C.DrawText(Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo.PlayerName,false);

        // Draw Score

	    InfoString = GetScoreValue(Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo);
	    C.StrLen(InfoString,xl,yl);
	    C.SetPos(C.ClipX-5-XL,TextTop+SmallH);
	    C.DrawText(InfoString,false);

        // Draw Tag Line

	    C.Font = GetConsoleFont(C);
	    InfoString = GetScoreTagLine();
	    C.StrLen(InfoString,xl,yl);
	    C.SetPos( (C.ClipX/2) - (XL/2),Top-3-YL);
	    C.DrawText(InfoString);
    }
    else
    {
		InfoString = GetInfoString();

    	// Draw
    	C.SetDrawColor(255,255,255,255);
        C.Font = GetMediumFontFor(C);
        C.StrLen(InfoString,XL,YL);
        C.SetPos( (C.ClipX/2) - (XL/2), Top + (Full/2) - (YL/2));
        C.DrawText(InfoString,false);
    }

    C.ColorModulate = OldModulate;

	if ( (PlayerOwner != None) && (PlayerOwner.PlayerReplicationInfo != None)
		&& PlayerOwner.PlayerReplicationInfo.bOnlySpectator )
	{
		UpdateRankAndSpread(C);
		ShowTeamScorePassA(C);
		ShowTeamScorePassC(C);
		UpdateTeamHUD();
	}
	
	if (GRI.bMatchHasBegun && GRI.bPracticeRound)
		DrawPracticeRoundInfo(C);
}

simulated function String GetInfoString()
{
	local Misc_BaseGRI GRI;
	
	GRI = Misc_BaseGRI(PlayerOwner.GameReplicationInfo);
	
	if (GRI == None)
		return "";
	
	if (GRI.bPracticeRound && GRI.bEndOfRound)
		return PracticeRoundEndedString;
	
	return Super.GetInfoString();
}

simulated function DrawPracticeRoundInfo( Canvas C )
{
	local float	Seconds;
	local Misc_BaseGRI G;
	local Color	myColor;

  G = Misc_BaseGRI(PlayerOwner.GameReplicationInfo);

	if ( PlayerOwner == None || ScoreBoard == None)
		return;

	C.Font	= GetFontSizeIndex( C, 0 );
	C.Style = ERenderStyle.STY_Alpha;
	myColor = GoldColor*(1.f-fPulse) + WhiteColor * fPulse;
	Seconds = Max(0, G.RoundTime);
	DrawTextWithBackground( C, PracticeRoundString @ ScoreBoard.FormatTime(Seconds), myColor, C.ClipX*0.5, C.ClipY*0.67 );
}

simulated function DrawTextWithBackground( Canvas C, String Text, Color TextColor, float XO, float YO )
{
	local float	XL, YL, XL2, YL2;

	C.StrLen( Text, XL, YL );

	XL2	= XL + 64 * ResScaleX;
	YL2	= YL +  8 * ResScaleY;

	C.DrawColor = C.MakeColor(0, 0, 0, 150);
	C.SetPos( XO - XL2*0.5, YO - YL2*0.5 );
	C.DrawTile(Texture'HudContent.Generic.HUD', XL2, YL2, 168, 211, 166, 44);

	C.DrawColor = TextColor;
	C.SetPos( XO - XL*0.5, YO - YL*0.5 );
	C.DrawText( Text, false );
}

simulated function Tick(float DeltaTime)
{
	super.Tick( DeltaTime );

	fBlink += DeltaTime;
	while ( fBlink > 0.5 )
		fBlink -= 0.5;

	fPulse = Abs(1.f - 4*fBlink);
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
	// CurHudScale = HudScale;
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
			BarBorder[i].PosX =  default.BarBorder[i].PosX +( BarBorderScaledPosition[i] - default.BarBorder[i].PosX) * HudScaleOffset;
		else
			BarBorder[i].PosX = 0.5 - ((0.5 - default.BarBorder[i].PosX) * (ResScaleY / ResScaleX) * HUDScale); 
		BarWeaponIcon[i].PosX = BarBorder[i].PosX;

		IconOffset = (default.BarBorder[i].TextureCoords.X2 - default.BarBorder[i].TextureCoords.X1) * 0.5;
	    BarWeaponIcon[i].OffsetX =  IconOffset;

        BarBorder[i].Tints[0] = HudColorRed;
        BarBorder[i].Tints[1] = HudColorBlue;
        BarBorder[i].OffsetY = 0;
		BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;


		if( W == none )
        {
			BarWeaponStates[i].HasWeapon = false;
			if ( bShowMissingWeaponInfo )
			{
				if ( BarWeaponIcon[i].Tints[TeamIndex] != HudColorBlack )
				{
					BarWeaponIcon[i].WidgetTexture = default.BarWeaponIcon[i].WidgetTexture;
					BarWeaponIcon[i].TextureCoords = default.BarWeaponIcon[i].TextureCoords;
					BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
					BarWeaponIcon[i].Tints[TeamIndex] = HudColorBlack;
					BarWeaponIconAnim[i] = 0;
				}
				DrawWidgetAsTile( C, BarBorder[i] );
				DrawWidgetAsTile( C, BarWeaponIcon[i] ); // FIXME- have combined version
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
			
            BarBorderAmmoIndicator[i].Scale = FMin(W.AmmoStatus(), 1);
            BarWeaponIcon[i].Tints[TeamIndex] = HudColorNormal;

			if( BarWeaponIconAnim[i] == 0 )
            {
                if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.6 )
	            {
		           if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.3 )
	               {
					   	BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale * (1 + 1.3 * (Level.TimeSeconds - BarWeaponStates[i].PickupTimer));
                        BarWeaponIcon[i].OffsetX =  IconOffset - IconOffset * ( Level.TimeSeconds - BarWeaponStates[i].PickupTimer );
                   }
                   else
                   {
					    BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale * (1 + 1.3 * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds));
                        BarWeaponIcon[i].OffsetX = IconOffset - IconOffset * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds);
                   }
                }
                else
                {
                    BarWeaponIconAnim[i] = 1;
                    BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
				}
			}

            if (W == PendingWeapon)
            {
				// Change color to highlight and possibly changeTexture or animate it
				BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
				BarBorder[i].OffsetY = -10;
				BarBorderAmmoIndicator[i].OffsetY = -10;
				BarWeaponIcon[i].OffsetY += -10;
			}
		    if ( ExtraWeapon[i] == 1 )
		    {
			    if ( W == PendingWeapon )
			    {
                    BarBorder[i].Tints[0] = HudColorRed;
                    BarBorder[i].Tints[1] = HudColorBlue;
				    BarBorder[i].OffsetY = 0;
				    BarBorder[i].TextureCoords.Y1 = 80;
				    DrawWidgetAsTile( C, BarBorder[i] );
				    BarBorder[i].TextureCoords.Y1 = 39;
				    BarBorder[i].OffsetY = -10;
				    BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
			    }
			    else
			    {
				    BarBorder[i].OffsetY = -52;
				    BarBorder[i].TextureCoords.Y2 = 48;
		            DrawWidgetAsTile( C, BarBorder[i] );
				    BarBorder[i].TextureCoords.Y2 = 93;
				    BarBorder[i].OffsetY = 0;
			    }
		    }
	        DrawWidgetAsTile( C, BarBorder[i] );
            DrawWidgetAsTile( C, BarBorderAmmoIndicator[i] );
			
			//Draw standard icons for non-BW weapons
			if (!bCorrectAspectRatio || BallisticWeapon(W) == None)
				DrawWidgetAsTile( C, BarWeaponIcon[i] );
			else
			{
				C.DrawColor = BarWeaponIcon[i].Tints[TeamIndex];
				C.SetPos((C.ClipX * BarBorder[i].PosX) + (BarBorder[i].OffsetX) * (BarBorder[i].TextureScale * ResScaleY *  HUDScale),
							(C.ClipY * BarBorder[i].PosY) + (BarBorder[i].OffsetY - (BarBorder[i].TextureCoords.Y2 - BarBorder[i].TextureCoords.Y1))  * (BarBorder[i].TextureScale * ResScaleY * HUDScale));
				C.DrawTile(	BallisticWeapon(W).BigIconMaterial, 
					(BarBorder[i].TextureCoords.X2 - BarBorder[i].TextureCoords.X1) * BarBorder[i].TextureScale * ResScaleY * HUDScale,  
					(BarBorder[i].TextureCoords.X2 - BarBorder[i].TextureCoords.X1) * 0.5  * BarBorder[i].TextureScale * ResScaleY * HUDScale, 
					0, 0, 512, 256);
			}
       }
    }
}

defaultproperties
{
     TeamTex=Texture'HUDContent.Generic.HUD'
     TrackedPlayer=Texture'3SPNv3141BW.textures.chair'
     FullHealthColor=(B=200,G=100,A=255)
     NameColor=(B=200,G=200,R=200,A=255)
     LocationColor=(G=130,R=175,A=255)
     PracticeRoundString="Practice Round"
     PracticeRoundEndedString="Practice round over. Get ready!"
     FontArrayNames(8)="UT2003Fonts.FontMono"
}
