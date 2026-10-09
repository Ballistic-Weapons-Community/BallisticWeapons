//=============================================================================
// A49FlashEmitterRed.
//
// The A49's shockwave flash in the red of the Elite layout.
//=============================================================================
class A49FlashEmitterRed extends A49FlashEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	// the colours of A73FlashEmitterB
	Emitters[1].Texture = Texture'BW_Core_WeaponTex.A73RedLayout.FlareB1';
	Emitters[1].ColorScale[1].Color.R = 255;
	Emitters[1].ColorScale[1].Color.G = 64;
	Emitters[1].ColorScale[1].Color.B = 64;

	Emitters[2].Texture = Texture'BW_Core_WeaponTex.A73RedLayout.FlareB1';
	Emitters[2].ColorScale[1].Color.R = 255;
	Emitters[2].ColorScale[1].Color.G = 192;
	Emitters[2].ColorScale[1].Color.B = 192;
	Emitters[2].ColorScale[2].Color.R = 255;
	Emitters[2].ColorScale[2].Color.G = 128;
	Emitters[2].ColorScale[2].Color.B = 64;
	Emitters[2].ColorScale[3].Color.R = 255;
	Emitters[2].ColorScale[3].Color.B = 0;
}

defaultproperties
{
     // A mesh emitter draws its mesh with the skins of this actor
     Skins(0)=Texture'BW_Core_WeaponTex.A73RedLayout.A73BMuzzleFlash'
}
