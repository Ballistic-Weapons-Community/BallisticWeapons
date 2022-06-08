//=============================================================================
// Brass_PUMA.
//
// A duracell battery
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_PUMA extends BWBrass_Default;

var Emitter Trail;

// Initialize velocity and spin
simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if (level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
		Trail = Spawn(class'ShotgunBrassTrail',,, Location + vector(Rotation) * 19 * DrawScale);
	if (Trail != None)
	{
		class'BallisticEmitter'.static.ScaleEmitter(Trail, DrawScale);
		Trail.SetBase(self);
	}
}

simulated function Destroyed()
{
	if (Trail != None)
		Trail.Destroy();

	super.Destroyed();
}

defaultproperties
{
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     HitSounds(1)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     HitSounds(2)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     HitSounds(3)=SoundGroup'BW_Core_WeaponSound.Brass.ShellMetal'
     HitSounds(4)=SoundGroup'BW_Core_WeaponSound.Brass.ShellWood'
     HitSounds(5)=SoundGroup'BW_Core_WeaponSound.Brass.ShellWood'
     HitSounds(6)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     HitSounds(7)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     HitSounds(8)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     HitSounds(10)=SoundGroup'BW_Core_WeaponSound.Brass.ShellConcrete'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell'
     DrawScale=0.110000
     Skins(0)=Texture'BWBP_SKC_TexExp.PUMA.Cart_Puma'
}
