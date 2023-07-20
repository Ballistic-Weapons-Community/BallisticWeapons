//=============================================================================
// A73Projectile.
//
// Simple projectile for the elite A762.2.
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73ProjectileB extends A73Projectile;

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_A73ProjectileB'
     PenetrateManager=Class'BallisticProV55.IM_A73ProjectileB'
     TrailClass=Class'BallisticProV55.A73TrailEmitterB'
     LightHue=10
     LightSaturation=50
     Skins(0)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BProjFinal'
     Skins(1)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BProj2Final'
}
