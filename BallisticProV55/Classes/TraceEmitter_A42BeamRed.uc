//=============================================================================
// TraceEmitter_A42BeamRed.
//
// The A42's beam in the red of the Elite layout.
//=============================================================================
class TraceEmitter_A42BeamRed extends TraceEmitter_A42Beam;

simulated event PostBeginPlay()
{
	local int i;

	Super.PostBeginPlay();

	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].ColorMultiplierRange.X.Min = 1.0;
		Emitters[i].ColorMultiplierRange.X.Max = 1.0;
		Emitters[i].ColorMultiplierRange.Y.Min = 0.0;
		Emitters[i].ColorMultiplierRange.Y.Max = 0.0;
		Emitters[i].ColorMultiplierRange.Z.Min = 0.0;
		Emitters[i].ColorMultiplierRange.Z.Max = 0.0;
	}
	// a little orange in the core
	Emitters[0].ColorMultiplierRange.Y.Max = 0.3;
}

defaultproperties
{
}
