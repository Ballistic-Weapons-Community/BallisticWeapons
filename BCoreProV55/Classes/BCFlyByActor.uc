//=============================================================================
// BCFlyByActor.
//
// This non replicated actor is spawned client-side and is used to play a
// sound effect at a specific location.
// A Delay var is also available to make the sound go off a certain amount of
// time after initialazation.
// FIXME: Potentially make this a generic positioned sound actor instead of just for flybys!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BCFlyByActor extends Actor
	DependsOn(BUtil);

var() BUtil.FullSound		FlyBySound;			//The sound to play... (what the hell else is it likely to be HUH!?)

// This static function will play a FullSound at a specific point by spawning this actor
static simulated function SoundOff (Actor A, BUtil.FullSound TheSound, optional vector SoundLocation, optional float Delay)
{
	local BCFlyByActor FlyBy;
	FlyBy = A.Spawn(default.class, A,, SoundLocation);
	FlyBy.InitFlyBy(TheSound, Delay);
}

simulated function InitFlyBy(BUtil.FullSound TheSound, optional float Delay)
{
	FlyBySound = TheSound;
	if (Delay <= 0)
		Timer();
	else
		SetTimer(Delay, false);
}

event Timer()
{
    class'BUtil'.static.PlayFullSound(self, FlyBySound);
    Destroy();
}

defaultproperties
{
     bHidden=True
     RemoteRole=ROLE_None
}
