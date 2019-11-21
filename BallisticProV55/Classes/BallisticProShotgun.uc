//======================================================
// Ballistic Pro Shotgun
//
// Crosshairs
//======================================================
class BallisticProShotgun extends BallisticShotgun
	abstract
	HideDropDown
	CacheExempt;

var float CrosshairSpreadAngle;
var int	 MaxSpreadFactor;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	CrosshairSpreadAngle = BallisticProShotgunFire(BFireMode[0]).GetCrosshairInaccAngle();
	MaxSpreadFactor = BallisticProShotgunFire(BFireMode[0]).MaxSpreadFactor;
}	

//Draws simple crosshairs to accurately describe hipfire at any FOV and resolution.
simulated function DrawCrosshairs(canvas C)
{
	local float 		ShortBound, LongBound;
	local float 		OffsetAdjustment;
	local Color 		SavedDrawColor;

	// Draw weapon specific Crosshairs
	if (bOldCrosshairs || bScopeView)
		return;

	if (!bNoMag && MagAmmo == 0)
	{
		SavedDrawColor = MagEmptyColor;
		SavedDrawColor.A = class'HUD'.default.CrosshairColor.A;
	}
	
	else if (bNeedCock)
	{
		SavedDrawColor = CockingColor;
		SavedDrawColor.A = class'HUD'.default.CrosshairColor.A;
	}
		
	else SavedDrawColor = class'HUD'.default.CrosshairColor;
	
	C.DrawColor = SavedDrawColor;
	
	ShortBound = 2;
	LongBound= 10;
	

	OffsetAdjustment = C.ClipX / 2;
	OffsetAdjustment *= tan (CrosshairSpreadAngle * Lerp(FireChaos, 1, MaxSpreadFactor) * 0.000095873799) / tan((Instigator.Controller.FovAngle/2) * 0.01745329252);
	

	//black

	C.SetDrawColor(0,0,0,255);
	
	//hor
	C.SetPos((C.ClipX / 2) - (LongBound + OffsetAdjustment+1), (C.ClipY/2) - (ShortBound/2+1));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound+2, ShortBound+2);
	
	C.SetPos((C.ClipX / 2) + OffsetAdjustment -1, (C.ClipY/2) - (ShortBound/2+1));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound+2, ShortBound+2);
	
	//ver
	C.SetPos((C.ClipX / 2) - (ShortBound/2+1), (C.ClipY/2) - (LongBound + OffsetAdjustment+1));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound+2, LongBound+2);
	
	C.SetPos((C.ClipX / 2) - (Shortbound/2+1), (C.ClipY/2) + OffsetAdjustment-1);
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound+2, LongBound+2);
	
	//centre square
	if (bDrawCrosshairDot)
	{
		C.DrawColor.A = 255;
		C.SetPos(C.ClipX / 2 - 2, C.ClipY/2 - 2);
		C.DrawTileStretched(Texture'Engine.WhiteTexture', 4, 4);
	}
	
	//green
	C.DrawColor = SavedDrawColor;
	
	//hor
	C.SetPos((C.ClipX / 2) - (LongBound + OffsetAdjustment), (C.ClipY/2) - (ShortBound/2));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
	
	C.SetPos((C.ClipX / 2) + OffsetAdjustment, (C.ClipY/2) - (ShortBound/2));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
	
	//ver
	C.SetPos((C.ClipX / 2) - (ShortBound/2), (C.ClipY/2) - (LongBound + OffsetAdjustment));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
	
	C.SetPos((C.ClipX / 2) - (Shortbound/2), (C.ClipY/2) + OffsetAdjustment);
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
	
	//centre square
	if (bDrawCrosshairDot)
	{
		C.DrawColor.A = 255;
		C.SetPos(C.ClipX / 2 - 1, C.ClipY/2 - 1);
		C.DrawTileStretched(Texture'Engine.WhiteTexture', 2, 2);
	}
}

defaultproperties
{
}
