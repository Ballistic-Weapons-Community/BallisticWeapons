//=============================================================================
// LS14Attachment.
//
// Third person actor for the LS-14 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LS14Attachment extends BallisticAttachment;
var Vector		SpawnOffset;
var byte 		LasPower;
var bool			bDouble, FireIndex, bBigLaser;

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		LasPower, bDouble;
}


simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		bBigLaser=True;
	}
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local TraceEmitter_LS14C TER;
	local TraceEmitter_LS14B TEL;
	local TraceEmitter_LS14B TEA;
	local TraceEmitter_LS14H TEH;
	local float Dist;

	if (VSize(V) < 2)
		V = Instigator.Location + Instigator.EyePosition() + V * 10000;
	Dist = VSize(V-GetModeTipLocation());

	// Spawn Trace Emitter Effect
	if (bDouble)
	{
		TER = Spawn(class'TraceEmitter_LS14C', self, , GetModeTipLocation(), Rotator(V - GetModeTipLocation()));
		TEL = Spawn(class'TraceEmitter_LS14B', self, , GetModeTipLocationStyleTwo(), Rotator(V - GetModeTipLocation()));
		TEL.Initialize(Dist, LasPower);
		TER.Initialize(Dist, LasPower);
	}
	else if (bBigLaser)
	{
		TEH = Spawn(class'TraceEmitter_LS14H', self, , GetModeTipLocationStyleTwo(), Rotator(V - GetModeTipLocation()));
		TEH.Initialize(Dist, LasPower);
	}
	else if (FireIndex)
	{
		TEA = Spawn(class'TraceEmitter_LS14B', self, , GetModeTipLocation(), Rotator(V - GetModeTipLocation()));
		TEA.Initialize(Dist, LasPower);
	}
	else
	{
		TER = Spawn(class'TraceEmitter_LS14C', self, , GetModeTipLocationStyleTwo(), Rotator(V - GetModeTipLocation()));
		TER.Initialize(Dist, LasPower);
	}
	
	FireIndex = !FireIndex;
}

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (LS14Carbine(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
		{
			Loc = Instigator.Weapon.GetEffectStart();
		}
	}
	else
		Loc = GetBoneCoords('tip').Origin;
		
    return Loc;
}

simulated function Vector GetModeTipLocationStyleTwo()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{

		if (LS14Carbine(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip2').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip2').Origin + Y*200;

    return Loc;
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
     SpawnOffset=(X=-30.000000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXLaserFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     ImpactManager=Class'BWBP_SKC_Pro.IM_LS14Impacted'
     AltFlashBone="tip3"
     BrassClass=Class'BallisticProV55.Brass_Railgun'
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_LS14C'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FlyBy',Volume=0.700000)
     FlyByBulletSpeed=-1.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.LS14_TPm'
     RelativeLocation=(X=-3.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
}
