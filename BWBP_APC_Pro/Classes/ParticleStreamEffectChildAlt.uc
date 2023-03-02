class ParticleStreamEffectChildAlt extends ParticleStreamEffectChild;

#exec OBJ LOAD FILE=BWBP_OP_Tex.utx

simulated function SetColor()
{
	if (!bAltColor)
	{
		Skins[0] = TexPanner'BWBP_OP_Tex.ProtonPack.ProtonPurplePanner';
	}
	else
	{
		Skins[0] = TexPanner'BWBP_OP_Tex.ProtonPack.ProtonGreenPanner';
	}	
}

defaultproperties
{
     Skins(0)=TexPanner'BWBP_OP_Tex.ProtonPack.ProtonPurplePanner'
}
