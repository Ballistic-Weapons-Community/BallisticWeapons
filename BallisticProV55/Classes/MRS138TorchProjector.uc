//===========================================================================
// MRS138's taclight projector.
// SquirrelZero's flashlight code.
//===========================================================================
class MRS138TorchProjector extends DynamicProjector;

var MRS138TorchGlow Glow;

// Spawn the dynamic light
simulated function PostBeginPlay()
{
	if (bProjectActor)
		SetCollision(True, False, False);

	Glow = spawn(class'MRS138TorchGlow');
}

// On a third person gun the light hangs on a bone of the gun, and the gun on a bone of its holder. Bones are only
// worked out for what is seen: without this the light of somebody out of sight stays where he was last seen
simulated function SetSkelUpdate(bool bOn)
{
	if (WeaponAttachment(Owner) == None)
		return;
	Owner.bForceSkelUpdate = bOn || Owner.default.bForceSkelUpdate;
	if (Owner.Base != None)
		Owner.Base.bForceSkelUpdate = bOn || Owner.Base.default.bForceSkelUpdate;
}

//simplified implementation for how this stock BW projector works
simulated function Tick(float DeltaTime)
{
	local vector StartTrace,EndTrace,HitLocation,HitNormal;
	local actor SurfaceActor;
	local float BeamLength;

	SetSkelUpdate(true);

	//detach and reattach
	Super.Tick(DeltaTime);

	StartTrace = Location;
	EndTrace = StartTrace + MaxTraceDistance*vector(Rotation);
	SurfaceActor = Trace(HitLocation,HitNormal,EndTrace,StartTrace,true);

	// find out how far the first hit was
	BeamLength = VSize(StartTrace-HitLocation);

	// better than tracing for the actor, makes it more projector-like
	if (SurfaceActor != None)
	{	
		//linear fade
		Glow.LightBrightness = Glow.Default.LightBrightness * (1 - (BeamLength / MaxTraceDistance));
		Glow.LightRadius = Glow.default.LightRadius + (23 * (BeamLength / MaxTraceDistance));
		Glow.SetLocation(HitLocation-vector(Rotation)*16);
		Glow.SetRotation(rotator(HitLocation-StartTrace));
	}
	// else if the trace returned nothing, then we put the light right in front of the player, scale its brightness down,
	// and give it normal radius.  This makes it seem as if the light is casting a dull glow  onto the ground in front 
	// of the player, and is dim enough for players to not notice the transition.
	else
	{
		Glow.LightRadius = Glow.Default.LightRadius;
		Glow.LightBrightness = 24;
		Glow.SetLocation(StartTrace+vector(Rotation)*84);
	}
}

simulated function Destroyed()
{
	SetSkelUpdate(false);
	if (Glow != None)
		Glow.Destroy();
}

defaultproperties
{
     MaterialBlendingOp=PB_Modulate
     FrameBufferBlendingOp=PB_Add
     ProjTexture=Texture'BW_Core_WeaponTex.Light.MRS138LightMark'
     FOV=25
     MaxTraceDistance=3072
     bClipBSP=True
     bClipStaticMesh=True
     bGradient=True
     bProjectOnAlpha=True
     bProjectOnParallelBSP=True
     bNoProjectOnOwner=True
     DrawType=DT_None
     CullDistance=3072.000000
     bHidden=False
     bDetailAttachment=True
     DrawScale=0.020000
     bGameRelevant=True
}
