class ParticleStreamEffectNewAlt extends ParticleStreamEffectNew;

#exec OBJ LOAD FILE=BWBP_OP_Tex.utx

simulated function SetColor()
{
	if (!bAltColor)
	{
		Skins[0] = TexPanner'BWBP_OP_Tex.ProtonPack.ProtonGreenPanner';
	}
	else
	{
		Skins[0] = TexPanner'BWBP_OP_Tex.ProtonPack.ProtonPurplePanner';
	}
}

defaultproperties
{
     Skins(0)=TexPanner'BWBP_OP_Tex.ProtonPack.ProtonGreenPanner'
}
