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
	local IntBox				Size;
	local float					ScaleFactor;
	local NonDefCrosshairCfg 	CHCfg;
	
	ScaleFactor = C.ClipX / 1600;

	// Draw weapon specific Crosshairs
	if (bOldCrosshairs || bScopeView)
		return;

	if (bDrawSimpleCrosshair)
	{
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
		

		OffsetAdjustment = (C.ClipX / 2) * tan (CrosshairSpreadAngle * Lerp(AimComponent.GetFireChaos(), 1, MaxSpreadFactor) * 0.000095873799) / tan((Instigator.Controller.FovAngle/2) * 0.01745329252);

		if (!bScopeView)
			OffsetAdjustment += AimComponent.CalcCrosshairOffset(C);
		
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
	else
	{
		if (bGlobalCrosshair)
			CHCfg = class'BallisticProShotgun'.default.NDCrosshairCfg;
		else
			CHCfg = NDCrosshairCfg;

		//Work out the exact size of the crosshair
		Size.X1 = CHCfg.StartSize1 * NDCrosshairInfo.SizeFactors.X1 * (1 + (NDCrosshairInfo.CurrentScale * NDCrosshairInfo.SpreadRatios.X1)) * ScaleFactor * class'HUD'.default.CrosshairScale;
		Size.Y1 = CHCfg.StartSize1 * NDCrosshairInfo.SizeFactors.Y1 * (1 + (NDCrosshairInfo.CurrentScale * NDCrosshairInfo.SpreadRatios.Y1)) * ScaleFactor * class'HUD'.default.CrosshairScale;
		Size.X2 = CHCfg.StartSize2 * NDCrosshairInfo.SizeFactors.X2 * (1 + (NDCrosshairInfo.CurrentScale * NDCrosshairInfo.SpreadRatios.X2)) * ScaleFactor * class'HUD'.default.CrosshairScale;
		Size.Y2 = CHCfg.StartSize2 * NDCrosshairInfo.SizeFactors.Y2 * (1 + (NDCrosshairInfo.CurrentScale * NDCrosshairInfo.SpreadRatios.Y2)) * ScaleFactor * class'HUD'.default.CrosshairScale;

		// Draw primary
		if (CHCfg.Pic1 != None)
		{
			C.DrawColor = CHCfg.Color1;
			if (bScopeView)	C.DrawColor.A = float(C.DrawColor.A) / 1.3;
			C.SetPos((C.ClipX / 2) - (Size.X1/2), (C.ClipY / 2) - (Size.Y1/2));
			C.DrawTile (CHCfg.Pic1, Size.X1, Size.Y1, 0, 0, CHCfg.USize1, CHCfg.VSize1);
		}
		// Draw secondary
		if (CHCfg.Pic2 != None)
		{
			C.DrawColor = CHCfg.Color2;
			if (bScopeView)	C.DrawColor.A = float(C.DrawColor.A) / 1.5;
			C.SetPos((C.ClipX / 2) - (Size.X2/2), (C.ClipY / 2) - (Size.Y2/2));
			C.DrawTile (CHCfg.Pic2, Size.X2, Size.Y2, 0, 0, CHCfg.USize2, CHCfg.VSize2);
		}
	}
}

defaultproperties
{
}
