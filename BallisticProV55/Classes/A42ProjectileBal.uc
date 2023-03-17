//=============================================================================
// A48Projectile.
//
// Simple projectile for da A48.
//
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42ProjectileBal extends A42Projectile;

defaultproperties
{
	ImpactManager=Class'BallisticProV55.IM_A42ProjectileBal'
	PenetrateManager=Class'BallisticProV55.IM_A42ProjectileBal'
	TrailClass=Class'BallisticProV55.A42TrailEmitterBal'

	Skins(0)=FinalBlend'BWBP_KBP_Tex.A48.A48ProjFinal'
	Skins(1)=FinalBlend'BWBP_KBP_Tex.A48.A48Proj2Final'
}
