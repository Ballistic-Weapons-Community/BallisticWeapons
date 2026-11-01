class AM_HUD extends HudWDeathMatch;

var Texture     TeamTex;
var Material    TrackedPlayer;
var int         OldRoundTime;
var Misc_Player myOwner;

var float	fBlink, fPulse;
var localized string PracticeRoundString;
var localized string PracticeRoundEndedString;

function DisplayMessages(Canvas C)
{
    if(bShowScoreboard || bShowLocalStats)
        ConsoleMessagePosY = 0.995;
    else
        ConsoleMessagePosY = default.ConsoleMessagePosY;

    super.DisplayMessages(C);
}

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

simulated function UpdateRankAndSpread(Canvas C)
{
    local int i;
    local float xl;
    local float yl;
    local float MaxNamePos;
    local int posx;
    local int posy;
    local float scaley, scalex;
    local string name;
    local int listy;
    local int space;
    local int namey;
    local int namex;
    local int height;
    local int width;
    local int enemies;
    local Misc_PRI pri;

    if(myOwner == None)
        myOwner = Misc_Player(PlayerOwner);

    listy = 0.08 * HUDScale * C.ClipY;
    space = 0.005 * HUDScale * C.ClipY;
    scaley = Fmax(HUDScale, 0.75);
	scalex = scaley / ((C.ClipX / C.ClipY) * 0.75);
    height = C.ClipY * 0.0255 * ScaleY;
    width = C.ClipX * 0.13 * ScaleX;
    namex = C.ClipX * 0.025 * ScaleX; 
    MaxNamePos = 0.99 * (width - namex);
	
    C.Font = GetFontSizeIndex(C, -3 + int(ScaleX * 1.25));
    C.StrLen("Test", xl, yl);
    namey = (height * 0.6) - (yl * 0.5);
	
    posx = C.ClipX * 0.99;

    for(i = 0; i < MyOwner.GameReplicationInfo.PRIArray.Length; i++)
    {
        pri = Misc_PRI(myOwner.GameReplicationInfo.PRIArray[i]);
        if(PRI == None || PRI.bOutOfLives || PRI == PlayerOwner.PlayerReplicationInfo)
            continue;

        if(!myOwner.bShowTeamInfo || enemies > 9)
            continue;

        posy = listy + ((height + space) * enemies);

        // draw background
        C.SetPos(posx - width, posy);
        C.DrawColor = default.BlackColor;
        C.DrawColor.A = 128;
        C.DrawTile(TeamTex, width, height, 168, 211, 166, 44);

        // draw disc
        C.SetPos(posx - (C.ClipX * 0.0195 * ScaleX), posy);
        C.DrawColor = default.WhiteColor;
        C.DrawTile(TeamTex, C.ClipX * 0.0195 * ScaleX, C.ClipY * 0.026 * ScaleY, 119, 258, 54, 55);

        // draw name
        name = PRI.PlayerName;
        C.StrLen(name, xl, yl);
        if(xl > MaxNamePos)
        {
            name = left(name, MaxNamePos / xl * len(name));
            C.StrLen(name, xl, yl);
        }
        C.DrawColor = WhiteColor;
        C.SetPos(posx - xl - namex, posy + namey); 
        C.DrawText(name);

        // draw health dot
        C.DrawColor = myOwner.RedOrEnemy * 2.5;
        C.DrawColor.A = 255;
        C.SetPos(posx - (0.0165 * ScaleX * C.ClipX), posy + (0.0035 * ScaleY * C.ClipY));
        C.DrawTile(TeamTex, C.ClipX * 0.0165 * ScaleX, C.ClipY * 0.0185 * ScaleY, 340, 432, 78, 78);

        enemies++;
    }
}

function CheckCountdown(GameReplicationInfo GRI)
{
    local TAM_GRI G;

    G = TAM_GRI(GRI);
    if(G == None || G.SecondsPerRound == 0 || G.RoundTime == 0 || G.RoundTime == OldRoundTime || GRI.Winner != None)
    {
        Super.CheckCountdown(GRI);
        return;
    }

    OldRoundTime = G.RoundTime;

    if(OldRoundTime > 30 && G.SecondsPerRound < 120)
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

	if(GRI.SecondsPerRound > 0)
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
		UpdateRankAndSpread(C);

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

defaultproperties
{
     TeamTex=Texture'HUDContent.Generic.HUD'
     TrackedPlayer=Texture'3SPNv3141BW.textures.chair'
     PracticeRoundString="Practice Round"
     PracticeRoundEndedString="Practice round over. Get ready!"
     FontArrayNames(8)="UT2003Fonts.FontMono"
}
