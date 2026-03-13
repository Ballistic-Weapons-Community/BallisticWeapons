class SPECIES_Merc extends SPECIES_Human
	abstract;


static function string GetRagSkelName(string MeshName)
{
	if(InStr(MeshName, "Gitty") >= 0)
		return Default.FemaleRagSkelName;
	if(InStr(MeshName, "Ophelia") >= 0)
		return Default.FemaleRagSkelName;
	
	return Super.GetRagSkelName(MeshName);
}
defaultproperties
{
	SpeciesName="Mercenary"
	RaceNum=4
	MaleVoice="XGame.MercMaleVoice"
	FemaleVoice="XGame.MercFemaleVoice"
	MaleSoundGroup="XGame.xMercMaleSoundGroup"
	FemaleSoundGroup="XGame.xMercFemaleSoundGroup"
	AirControl=+1.0
	GroundSpeed=+1.0
	WaterSpeed=+1.0
	JumpZ=+1.0
	ReceivedDamageScaling=+1.0
	DamageScaling=+1.0
	AccelRate=+1.0
	WalkingPct=+1.0
	CrouchedPct=+1.0
	DodgeSpeedFactor=+1.0
	DodgeSpeedZ=+1.0
}