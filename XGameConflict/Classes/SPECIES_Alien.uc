class SPECIES_Alien extends SpeciesType
	abstract;

static function string GetRagSkelName(String MeshName)
{
	return "Alien2";
}

defaultproperties
{
	SpeciesName="Alien"
	MaleVoice="XGame.AlienMaleVoice"
	FemaleVoice="XGame.AlienFemaleVoice"
	MaleSoundGroup="XGame.xAlienMaleSoundGroup"
	FemaleSoundGroup="XGame.xAlienFemaleSoundGroup"
	MaleSkeleton="Aliens.Skeleton_Alien"
	FemaleSkeleton="Aliens.Skeleton_Alien"
	GibGroup="xEffects.xAlienGibGroup"
	AirControl=+1.2
	GroundSpeed=+1.4
	WaterSpeed=+1.0
	JumpZ=+1.0
	ReceivedDamageScaling=+1.3
	DamageScaling=+1.0
	AccelRate=+1.1
	WalkingPct=+1.0
	CrouchedPct=+1.0
	DodgeSpeedFactor=+1.0
	DodgeSpeedZ=+1.0

	TauntAnimNames(8)="Tail wag"
	TauntAnimNames(9)="Gun check"
	
	TauntAnims(10)=Gesture_Taunt02
	TauntAnimNames(10)="Dismissal"
	
	TauntAnims(11)=Idle_Character02
	TauntAnimNames(11)="360"
}