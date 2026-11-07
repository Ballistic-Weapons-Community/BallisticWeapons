//=============================================================================
// BCStaminaOverlay.
//
// The stamina bar of the local player, drawn by the HUD over everything else,
// in first and third person. BCSprintControl spawns it on the machine of the
// player it belongs to and adds it to that player's HUD.
//
// It shows once stamina drops and fades out a second after it is full again.
// Its colour goes from blue when full through amber to red when low. The fill
// is dimmed while the recharge is paused: below full and neither filling nor
// draining, as after a sprint or a jump, or in the air.
//=============================================================================
class BCStaminaOverlay extends HudOverlay;

var BCSprintControl	Control;				// Whose stamina this shows

var float			Visibility;				// 0 hidden, 1 shown
var float			FillBrightness;			// 1, or PauseBrightness while the recharge is paused
var float			LastStamina;
var float			LastChangeTime;			// Stamina last went up or down at this time
var float			FullSince;				// Stamina has been full since this time, -1 while it isn't

var float			FadeInTime;				// Seconds to show the bar once stamina drops
var float			HoldTime;				// Seconds the bar stays once stamina is full
var float			FadeOutTime;			// Seconds to hide it after that
var float			PauseAfter;				// Seconds without a change that make a pause
var float			PauseBrightness;		// Brightness of the fill during a pause
var float			BrightnessBlendTime;	// Seconds from full brightness to PauseBrightness and back

var Color			FullColour, MidColour, LowColour;
var Color			BackColour, FrameColour;

simulated function Tick(float DT)
{
	local float Target, Step;

	if (Control == None || Control.bDeleteMe)
	{
		Destroy();
		return;
	}

	if (Control.Stamina != LastStamina)
	{
		LastStamina = Control.Stamina;
		LastChangeTime = Level.TimeSeconds;
	}

	if (Control.Stamina < Control.MaxStamina)
	{
		FullSince = -1;
		Visibility = FMin(1, Visibility + DT / FadeInTime);
	}
	else
	{
		if (FullSince < 0)
			FullSince = Level.TimeSeconds;
		if (Level.TimeSeconds - FullSince >= HoldTime)
			Visibility = FMax(0, Visibility - DT / FadeOutTime);
	}

	if (Control.Stamina < Control.MaxStamina && Level.TimeSeconds - LastChangeTime > PauseAfter)
		Target = PauseBrightness;
	else
		Target = 1;

	Step = DT * (1 - PauseBrightness) / BrightnessBlendTime;
	if (FillBrightness < Target)
		FillBrightness = FMin(Target, FillBrightness + Step);
	else
		FillBrightness = FMax(Target, FillBrightness - Step);
}

// Blue when full, amber around the middle, red when low
simulated function Color StaminaColour(float Frac)
{
	if (Frac >= 0.65)
		return FullColour;
	if (Frac >= 0.45)
		return BlendColour(MidColour, FullColour, (Frac - 0.45) / 0.2);
	if (Frac >= 0.2)
		return BlendColour(LowColour, MidColour, (Frac - 0.2) / 0.25);
	return LowColour;
}

simulated function Color BlendColour(Color A, Color B, float T)
{
	local Color Result;

	Result.R = A.R + (B.R - A.R) * T;
	Result.G = A.G + (B.G - A.G) * T;
	Result.B = A.B + (B.B - A.B) * T;
	Result.A = 255;
	return Result;
}

simulated function DrawBox(Canvas C, float X, float Y, float W, float H)
{
	C.SetPos(X, Y);
	C.DrawTile(Texture'Engine.WhiteTexture', W, H, 0, 0, 1, 1);
}

simulated function Render(Canvas C)
{
	local HUD MyHUD;
	local PlayerController PC;
	local float Scale, X, Y, W, H, Line, Inset, Frac;
	local byte OldStyle;
	local Color OldColour, Fill;

	MyHUD = HUD(Owner);
	if (Visibility <= 0 || Control == None || MyHUD == None || MyHUD.bHideHUD)
		return;
	PC = MyHUD.PlayerOwner;
	// Only for the player's own body: not in a vehicle, not while spectating, not in a cinematic
	if (PC == None || PC.bViewingMatineeCinematic || PC.Pawn == None || PC.Pawn != Control.Instigator)
		return;
	if (!class'BallisticReplicationInfo'.default.bEnableSprint)
		return;

	OldStyle = C.Style;
	OldColour = C.DrawColor;
	C.Style = ERenderStyle.STY_Alpha;

	// Where the old bar was, as wide as it was when full
	Scale = C.ClipX / 1600 * MyHUD.HudScale;
	X = Round(5 * Scale);
	Y = Round(C.ClipY - 330 * Scale);
	W = Round(200 * Scale);
	H = Round(30 * Scale);
	Line = FMax(1, Round(1.5 * Scale));
	Inset = Line + FMax(1, Round(2 * Scale));
	Frac = FClamp(Control.Stamina / FMax(1, Control.MaxStamina), 0, 1);

	// Backing over the whole length
	C.DrawColor = BackColour;
	C.DrawColor.A = BackColour.A * Visibility;
	DrawBox(C, X, Y, W, H);

	// Frame
	C.DrawColor = FrameColour;
	C.DrawColor.A = FrameColour.A * Visibility;
	DrawBox(C, X, Y, W, Line);
	DrawBox(C, X, Y + H - Line, W, Line);
	DrawBox(C, X, Y + Line, Line, H - 2 * Line);
	DrawBox(C, X + W - Line, Y + Line, Line, H - 2 * Line);

	// Fill
	if (Frac > 0)
	{
		Fill = StaminaColour(Frac);
		C.DrawColor.R = Fill.R * FillBrightness;
		C.DrawColor.G = Fill.G * FillBrightness;
		C.DrawColor.B = Fill.B * FillBrightness;
		C.DrawColor.A = 230 * Visibility;
		DrawBox(C, X + Inset, Y + Inset, FMax(1, Round((W - 2 * Inset) * Frac)), H - 2 * Inset);
	}

	C.Style = OldStyle;
	C.DrawColor = OldColour;
}

defaultproperties
{
	FillBrightness=1.000000
	FullSince=-1.000000
	FadeInTime=0.120000
	HoldTime=0.750000
	FadeOutTime=0.300000
	PauseAfter=0.100000
	PauseBrightness=0.450000
	BrightnessBlendTime=0.150000
	FullColour=(R=70,G=150,B=255,A=255)
	MidColour=(R=255,G=175,B=30,A=255)
	LowColour=(R=235,G=45,B=35,A=255)
	BackColour=(R=0,G=0,B=0,A=150)
	FrameColour=(R=225,G=225,B=225,A=210)
}
