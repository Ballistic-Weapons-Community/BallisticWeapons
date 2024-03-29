//=============================================================================
// A73Projectile.
//
// Simple projectile for the A73.
//
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73ProjectileBal extends A73Projectile;

defaultproperties
{
	ImpactManager=Class'BallisticProV55.IM_A73ProjectileBal'
	PenetrateManager=Class'BallisticProV55.IM_A73ProjectileBal'
	TrailClass=class'BallisticProV55.A73TrailEmitterBal'
	
	Skins[0]=FinalBlend'BW_Core_WeaponTex.A73PurpleLayout.A73ProjFinal'
    Skins[1]=FinalBlend'BW_Core_WeaponTex.A73PurpleLayout.A73Proj2Final'
}

