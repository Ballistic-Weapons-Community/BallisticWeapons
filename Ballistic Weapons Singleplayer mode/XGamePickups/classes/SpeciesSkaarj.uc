class SPECIESSkaarj extends SpeciesType
	abstract;

static function string GetRagSkelName(String MeshName)
{
	return "Skaarj";
}

defaultproperties
{
	SpeciesName="Skaarj"
	MaleVoice="XGame.AlienMaleVoice"
	FemaleVoice="XGame.AlienFemaleVoice"
	MaleSoundGroup="XGame.xAlienMaleSoundGroup"
	FemaleSoundGroup="XGame.xAlienFemaleSoundGroup"
	MaleSkeleton="SkaarjAnims.Skaarj_Skel"
	FemaleSkeleton="SkaarjAnims.Skaarj_Skel"
	GibGroup="xEffects.xAlienGibGroup"
	AirControl=+1.2
	GroundSpeed=+1.0
	WaterSpeed=+1.0
	JumpZ=+1.5
	ReceivedDamageScaling=+1.3
	DamageScaling=+1.0
	AccelRate=+1.0
	WalkingPct=+1.0
	CrouchedPct=+1.0
	DodgeSpeedFactor=+1.0
	DodgeSpeedZ=+1.0
	DMTeam=1

	TauntAnims(4)=Gesture_Taunt02
	TauntAnimNames(4)="Hair flip"
	
	TauntAnims(5)=Gesture_Taunt03
	TauntAnimNames(5)="Slash"
	
	TauntAnims(6)=Idle_Character03
	TauntAnimNames(6)="Scan"

	TauntAnims(7)=Gesture_Taunt01
	TauntAnimNames(7)="Finger"
	
	TauntAnims(8)=Idle_Character01
	TauntAnimNames(8)="Idle"

	TauntAnims(9)=
}