//=============================================================================
// Brass_Minigun.
//
// A shell casing for a minigun. It should be much faster for performance
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_Minigun extends BWBrass_Default;

simulated function HitWall (Vector HitNormal, Actor Wall)
{
    local float Speed;
	local Rotator R;
	local Vector V, V2;

	if (level.TimeSeconds - LastRenderTime > 0.05)
	{
		Destroy();
		return;
	}

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
		SetTimer(FMax(0.2, LifeSpan-2.0), false);
    }
	else if (Speed > 100)
    {
		if (bHitSounds && HitSounds.Length > 0)
			PlaySound(HitSounds[0],,HitSoundVolume,,HitSoundRadius,,true );
    }
}

defaultproperties
{
     StartVelocity=(Z=150.000000)
     StaticMesh=StaticMesh'BallisticHardware2.Brass.EmptyRifleRound'
     LifeSpan=4.000000
     DrawScale=0.090000
}
