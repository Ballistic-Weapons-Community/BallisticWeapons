//=============================================================================
// A73ProjectileBal.
//
// Bigger, slower projectile for da A73.
//
// Kaboodles
//=============================================================================
class A73PowerProjectileBal extends A73PowerProjectile;

defaultproperties
{
	ModeIndex=1
	ImpactManager=Class'BallisticProV55.IM_A73LobBal'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.A42.A42Projectile'
	TrailClass=Class'BallisticProV55.A73PowerTrailEmitterBal'
	
	Skins[0]=FinalBlend'BWBP_KBP_Tex.A73Purple.A73ProjBigFinal'
	Skins[1]=FinalBlend'BWBP_KBP_Tex.A73Purple.A73ProjBig2Final'
}

