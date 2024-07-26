//=============================================================================
// LS14Attachment.
//
// Third person actor for the LS-14 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LS14Attachment extends BallisticAttachment;

var byte CurrentTracerMode;
var array< class<BCTraceEmitter> >	TracerClasses[5];

var Vector		SpawnOffset;
var byte 		LasPower;
var bool			bDouble, bTopBarrel, bBigLaser;

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		LasPower, bDouble;
}

//layout tracers
function InitFor(Inventory I)
{
    Super.InitFor(I);

	if (LS14Carbine(I) != None)
	{
		if (LS14Carbine(I).bGatling)
		{
			CurrentTracerMode=3;
		}
		if (LS14Carbine(I).bHighPower)
		{
			CurrentTracerMode=2;
		}
	}
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local TraceEmitter_LS14C TE_Top;
	local TraceEmitter_LS14C TE_Bottom;
	local float Dist;

	if (VSize(V) < 2)
		V = Instigator.Location + Instigator.EyePosition() + V * 10000;
	Dist = VSize(V-GetModeTipLocation());

	// Spawn Trace Emitter Effect
	if (bDouble)
	{
		TE_Top = Spawn(class'TraceEmitter_LS14C', self, , GetModeTipLocation(), Rotator(V - GetModeTipLocation()));
		TE_Bottom = Spawn(class'TraceEmitter_LS14C', self, , GetModeTipLocationStyleTwo(), Rotator(V - GetModeTipLocationStyleTwo()));
		TE_Top.Initialize(Dist, LasPower);
		TE_Bottom.Initialize(Dist, LasPower);
	}
	else if (bTopBarrel || CurrentTracerMode != 0)
	{
		Tracer = Spawn(TracerClasses[CurrentTracerMode], self, , GetModeTipLocation(), Rotator(V - GetModeTipLocation()));
		//Tracer.Initialize(Dist, LasPower);
	}
	else
	{
		TE_Bottom = Spawn(class'TraceEmitter_LS14C', self, , GetModeTipLocationStyleTwo(), Rotator(V - GetModeTipLocationStyleTwo()));
		TE_Bottom.Initialize(Dist, LasPower);
	}
	
	bTopBarrel = !bTopBarrel;
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

//get the bottom barrel
simulated function Vector GetModeTipLocationStyleTwo()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{

		if (LS14Carbine(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-20;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip2').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip2').Origin;

    return Loc;
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
	WeaponClass=class'LS14Carbine'
	TracerClasses(0)=class'TraceEmitter_LS14C' //top barrel
	TracerClasses(1)=class'TraceEmitter_LS14B' //bottom barrel
	TracerClasses(2)=class'TraceEmitter_LS14H' //high power tracer
	TracerClasses(3)=class'TraceEmitter_LS14Auto' //gatling tracer
	SpawnOffset=(X=0.000000)
	MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXLaserFlashEmitter'
	AltMuzzleFlashClass=class'M50M900FlashEmitter'
	ImpactManager=Class'BWBP_SKC_Pro.IM_LS14Impacted'
	AltFlashBone="tip3"
	BrassClass=class'Brass_Railgun'
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_LS14C'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FlyBy',Volume=0.700000)
	FlyByBulletSpeed=-1.000000
	bRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_LS14'
	RelativeLocation=(X=-3.000000,Z=2.000000)
	RelativeRotation=(Pitch=32768)
	DrawScale=0.200000
}
