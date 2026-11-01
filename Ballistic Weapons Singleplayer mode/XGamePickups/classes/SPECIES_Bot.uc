class SPECIES_Bot extends SpeciesType
	abstract;

static function string GetRagSkelName(String MeshName)
{
	return "Bot2";
}

defaultproperties
{
	SpeciesName="Robot"
	RaceNum=1
	MaleVoice="XGame.RobotVoice"
	FemaleVoice="XGame.FemRobotVoice"
	MaleSoundGroup="XGame.xBotSoundGroup"
	FemaleSoundGroup="XGame.xBotSoundGroup"
	GibGroup="xEffects.xBotGibGroup"
	AirControl=+1.0
	GroundSpeed=+1.0
	WaterSpeed=+1.0
	JumpZ=+1.0
	ReceivedDamageScaling=+1.2
	DamageScaling=+1.2
	AccelRate=+1.1
	WalkingPct=+0.8
	CrouchedPct=+0.7
	DodgeSpeedFactor=+1.0
	DodgeSpeedZ=+1.0
	DMTeam=1

	TauntAnimNames(8)="Want some?"
	
	TauntAnims(9)=
}