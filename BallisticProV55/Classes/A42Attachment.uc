//=============================================================================
// A42Attachment.
//
// 3rd person weapon attachment for A42 Skrith Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42Attachment extends HandgunAttachment;

var Actor GlowFX;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

    if (level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'A42AmbientFX', DrawScale, self, 'tip');
}


simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local TraceEmitter_A42Beam Tracer;
	local float Dist;
	if (Level.DetailMode < DM_High)
		return;
	if (TracerMode == MU_None || (TracerMode == MU_Secondary && Mode == 0) || (TracerMode == MU_Primary && Mode != 0))
		return;
	if (TracerClass == None)
		return;
	if (TracerChance < 1 && FRand() > TracerChance)
		return;
	if (VSize(V) < 2)
		V = Instigator.Location + Instigator.EyePosition() + V * 5000;
	Dist = VSize(V - GetTipLocation());
	if (Dist > 25)
	{
		Tracer = Spawn(class'TraceEmitter_A42Beam', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
		Tracer.Initialize(Dist);
	}
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_A42Projectile'
     BrassMode=MU_None
     TracerMode=MU_Secondary
     InstantMode=MU_Secondary
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_A42Beam'
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.A42_TPm'
     DrawScale=0.080000
}
