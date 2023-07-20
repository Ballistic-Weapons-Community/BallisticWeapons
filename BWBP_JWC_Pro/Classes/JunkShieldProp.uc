//=============================================================================
// JunkShieldProp.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkShieldProp extends JunkActor;

var() Sound ImpactSound;
var() StaticMesh FlyingMesh;

simulated function GoCrazy ()
{
	SetPhysics(PHYS_Falling);
	SetLocation(Location - vector(Rotation) * 20);
	Velocity = vector(Rotation) * 200 + VRand() * 200 + vect(0,0,1) * 100;
//	SetCollision(false, false, false);
	bCollideWorld=true;
	RotationRate = RotRand(true)*3;
	SetTimer(16, false);
	bBounce=true;
	bOnlyOwnerSee=false;
	bHidden=false;
	bFixedRotationDir=true;
	if (FlyingMesh != None)
	{
		SetRotation(Rotation + rot(16384,0,0));
		SetStaticMesh(FlyingMesh);
	}
}

simulated function Landed( vector HitNormal )
{
    HitWall( HitNormal, None );
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    local Vector VNorm;
    local float Speed;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * 0.3 + (Velocity - VNorm) * 0.8;

	RotationRate = RotRand(true)*4;

	Speed = VSize(Velocity);
	if ( (Level.NetMode != NM_DedicatedServer) && (Speed > 75) )
		PlaySound(ImpactSound, SLOT_Misc );

    if ( Speed < 50 )
    {
        bBounce = False;
//		PrePivot.Z = -1.5;
//		SetRotation(rotator(HitNormal));
		SetPhysics(PHYS_None);
//		RotationRate = rot(0,0,0);
		bFixedRotationDir=false;
		bRotateToDesired=true;
		DesiredRotation = rotator(HitNormal);
//		GotoState('FadeOut');
		bCollideWorld=false;
    }
}

event Timer ()
{
	GotoState('FadeOut');
}

state FadeOut
{
	function BeginState()
	{
		LifeSpan=2.0;
	}
	event Tick(float DT)
	{
		SetDrawScale(DrawScale - Default.DrawScale * 0.5 * DT);
		SetLocation(Location - vect(0,0,24) * DT);
		super.Tick(DT);
	}
	event Timer ();
}

defaultproperties
{
     ImpactSound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Metal'
     DrawType=DT_StaticMesh
     CollisionRadius=20.000000
     CollisionHeight=8.000000
}
