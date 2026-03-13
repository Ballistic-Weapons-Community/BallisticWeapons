class SPECIES_Egypt extends SPECIES_Human
	abstract;

defaultproperties
{
	SpeciesName="Egyptian"
	RaceNum=2
	AirControl=+2.5
	GroundSpeed=+1.1
	WaterSpeed=+1.0
	JumpZ=+1.5
	ReceivedDamageScaling=+1.2
	DamageScaling=+1.0
	AccelRate=+1.0
	WalkingPct=+1.0
	CrouchedPct=+1.0
	DodgeSpeedFactor=+1.0
	DodgeSpeedZ=+1.5
	MaleVoice="XGame.MercMaleVoice"
	FemaleVoice="XGame.MercFemaleVoice"
	MaleSoundGroup="XGame.xEgyptMaleSoundGroup"
	FemaleSoundGroup="XGame.xEgyptFemaleSoundGroup"
	TauntAnims(8)=Gesture_Taunt02
	TauntAnims(9)=Idle_Character02
}