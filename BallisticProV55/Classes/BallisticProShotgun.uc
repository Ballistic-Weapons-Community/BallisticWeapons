//======================================================
// Ballistic Pro Shotgun
//
// Crosshairs
//======================================================
class BallisticProShotgun extends BallisticShotgun
	abstract
	HideDropDown
	CacheExempt;

// Draws simple crosshairs round the pellet spread, at any FOV and resolution: the side bars as far out as the pellets go
// across, the top and bottom bars as far as they go up and down.
// The spread is read from the primary fire each frame, as BallisticProShotgunFire.GetXInaccuracy / GetYInaccuracy give it
// to the shot: the weapon's params (game style) and the Shotgun Spread rule are only set on the fire after PostBeginPlay,
// and with the sights up (shown in third person) the hip factor and the fire chaos are left out
simulated function DrawSimpleCrosshairs(Canvas C)
{
	local BallisticProShotgunFire ShotgunFire;
	local float XSpread, YSpread, ScreenScale, AimOffset;

	// (the Wrenchgun is a shotgun whose primary fire throws things: no spread shown)
	ShotgunFire = BallisticProShotgunFire(BFireMode[0]);
	if (ShotgunFire != None)
	{
		XSpread = ShotgunFire.XInaccuracy;
		YSpread = ShotgunFire.YInaccuracy;

		if (!bScopeView)
		{
			XSpread *= ShotgunFire.HipSpreadFactor * Lerp(AimComponent.GetFireChaos(), 1, ShotgunFire.MaxSpreadFactor);
			YSpread *= ShotgunFire.HipSpreadFactor * Lerp(AimComponent.GetFireChaos(), 1, ShotgunFire.MaxSpreadFactor);
		}
	}

	ScreenScale = (C.ClipX / 2) / tan((Instigator.Controller.FovAngle/2) * 0.01745329252);

	if (!bScopeView)
		AimOffset = AimComponent.CalcCrosshairOffset(C);

	DrawSimpleCrosshairBars(C, ScreenScale * tan(XSpread * 0.000095873799) + AimOffset, ScreenScale * tan(YSpread * 0.000095873799) + AimOffset);
}

defaultproperties
{
}
