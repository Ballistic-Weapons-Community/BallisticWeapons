//=============================================================================
// M75Attachment.
//
// 3rd person weapon attachment for M75 Railgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M75Attachment extends RailgunAttachment;

var M75Pack 	Pack;			// The Railgun Backpack
var byte		RailPower;		// Shot intensity. Used to control effect opacity
var Vector		SpawnOffset;

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		RailPower;
}

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( Pack != None )
		Pack.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack!= None)
		Pack.bHidden = NewbHidden;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	Pack = Spawn(class'M75Pack');
	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');
	Pack.SetBoneScale(0, 0.0001, 'Bone03');
}
simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();
	super.Destroyed();
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local M75Spiral Spiral;
	local TraceEmitter_Railgun TER;
	local float Dist;

	if (VSize(V) < 2)
		V = Instigator.Location + Instigator.EyePosition() + V * 10000;
	Dist = VSize(V-GetModeTipLocation());
	// Spawn Siral Effect
	Spiral = Spawn(class'M75Spiral', self, , GetModeTipLocation(), Rotator(V - GetModeTipLocation()));
	Spiral.InitSpiral(Dist, RailPower);
	// Spawn Trace Emitter Effect
	TER = Spawn(class'TraceEmitter_Railgun', self, , GetModeTipLocation(), Rotator(V - GetModeTipLocation()));
	TER.Initialize(Dist, RailPower);
}

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z;

	if (Instigator.IsFirstPerson())
	{
		if (M75Railgun(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			return Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}

	return GetBoneCoords('tip').Origin;
}

defaultproperties
{
     SpawnOffset=(X=-170.000000,Y=-15.000000,Z=13.000000)
     MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_RailBullet'
     BrassClass=Class'BallisticProV55.Brass_Railgun'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Railgun'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=Sound'BW_Core_WeaponSound.FlyBys.RailFlyBy',Volume=1.200000)
     FlyByBulletSpeed=-1.000000
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     AmbientSound=Sound'BW_Core_WeaponSound.M75.M75Hum'
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.M75_TPm'
     DrawScale=0.130000
     SoundVolume=48
     SoundRadius=128.000000
}
