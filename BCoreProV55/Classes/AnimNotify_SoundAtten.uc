//=============================================================================
// AnimNotify_SoundAtten.
//
// The sound notify with an Attenuate switch, as PlaySound has.
//
// The stock sound notify (AnimNotify_Sound) plays its sound from where the
// actor is: a first person weapon's sounds come from the gun's place beside
// the view, off to one side. With Attenuate off (the default) the player whose
// weapon or body plays the animation hears the sound flat, not placed in the
// world, the way they hear their weapon's fire sound; everybody else hears it
// from where it is, fading with distance. Attenuate on: everybody hears it
// from where it is, as with the stock notify.
//
// Like the stock sound notify it plays only on the machine that runs the
// animation, and not on a dedicated server. The animation browser does not
// play it: the editor skips script notifies.
//=============================================================================
class AnimNotify_SoundAtten extends AnimNotify_Scripted;

var() sound Sound;
var() float Volume;
var() int Radius;
var() bool Attenuate;

// Simulated, so PlaySound plays on this machine only and is not sent on to
// other players: they run the animation and its notifies themselves.
simulated event Notify( Actor Owner )
{
	local float R;

	if( Sound == None || Owner == None || Owner.Level.NetMode == NM_DedicatedServer )
		return;

	R = Radius;
	if( R == 0 )
		R = 80;		// the stock sound notify's default radius

	// PlaySound plays at half the volume it is given, the stock notify at the
	// full one, hence twice the volume here.
	Owner.PlaySound( Sound, SLOT_None, 2.0 * Volume, false, R, 1.0, Attenuate );
}

defaultproperties
{
	Volume=1.0
	Radius=0
	Attenuate=False
}
