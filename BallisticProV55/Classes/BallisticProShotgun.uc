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
simulated function DrawSimpleCrosshairs(Canvas C)
{
	local float Offset;

	Offset = (C.ClipX / 2) * tan (CrosshairSpreadAngle * Lerp(AimComponent.GetFireChaos(), 1, MaxSpreadFactor) * 0.000095873799) / tan((Instigator.Controller.FovAngle/2) * 0.01745329252);

	if (!bScopeView)
		Offset += AimComponent.CalcCrosshairOffset(C);
	
	DrawSimpleCrosshairBars(C, Offset, Offset);
}

defaultproperties
{
}
