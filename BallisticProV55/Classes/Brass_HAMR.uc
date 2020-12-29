//=============================================================================
// Brass_HAMR.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_HAMR extends BWBrass_Default;

var() float HitSoundPitch;

simulated function HitWall (Vector HitNormal, Actor Wall)
{
    local float Speed;
	local Rotator R;
	local Vector HitLoc, HitNorm, V, V2;
	local Material HitMat;
	local int Surf;

    Velocity = DampenFactor * ((Velocity dot HitNormal) * HitNormal * -2.0 + Velocity);
    Speed = VSize(Velocity);
    RandSpin(Spin);
    if (Speed < 20 || (Wall != None && Mover(Wall) != None))
    {
        bBounce = False;
        SetPhysics (PHYS_None);
        R = Normalize(Rotation);
        if (HitNormal.Z == 1)
        {
			if (R.Pitch > 16384 || R.Pitch < -16384)
        		R.Pitch = 32768;
			else
        		R.Pitch = 0;
        }
        else
        {
        	V = Vector(Rotator(HitNormal)-rot(16384,0,0)); V.Z=0;
        	V2 = Vector(R); V2.Z=0;
        	R.Pitch += ((Rotator(HitNormal).Pitch - 16384) - R.Pitch) * Abs(Normal(V) Dot Normal(V2));
        }
		SetRotation(R);
		bCollideWorld = false;
		SetCollision(false, false);
		if (Wall != None)
		{
			bHardAttach = true;
			SetBase(Wall);
		}
		if (LifeTimeScale != 0)
			SetTimer(FMax(0.2, LifeSpan-2.0), false);
    }
	else if (Speed > 100)
    {
		if (Wall != None && !Wall.bWorldGeometry)
			Surf = int(Wall.SurfaceType);
		else
		{
			Trace(HitLoc, HitNorm, Location-HitNormal*10, Location+HitNormal*10, false, , HitMat);
			if (HitMat != None)
			Surf = int(HitMat.SurfaceType);
		}
		if (bHitSounds && HitSounds.Length > Surf)
			PlaySound(HitSounds[Surf],,HitSoundVolume,,HitSoundRadius,HitSoundPitch,true );
    }
}

defaultproperties
{
     HitSoundPitch=0.500000
     StartVelocity=(X=-150.000000,Y=0.000000,Z=50.000000)
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Brass.EmptyPistolRound'
     DrawScale=0.400000
     RotationRate=(Pitch=40000,Yaw=20000,Roll=30000)
}
