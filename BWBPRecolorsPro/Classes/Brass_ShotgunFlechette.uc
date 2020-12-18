//=============================================================================
// Brass_ShotgunFlechette.
//
// A Flechette Shotgun shell casing
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_ShotgunFlechette extends BWBrass_Default;

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
     HitSounds(0)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(1)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(2)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(3)=SoundGroup'BallisticSounds2.Brass.ShellMetal'
     HitSounds(4)=SoundGroup'BallisticSounds2.Brass.ShellWood'
     HitSounds(5)=SoundGroup'BallisticSounds2.Brass.ShellWood'
     HitSounds(6)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(7)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(8)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(9)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(10)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     StaticMesh=StaticMesh'BallisticHardware2.Brass.EmptyShell'
     DrawScale=0.110000
     Skins(0)=Texture'BallisticRecolors4TexPro.M1014.Cart_ShotgunF'
}
