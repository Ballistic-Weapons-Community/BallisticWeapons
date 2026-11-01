class SPECIES_Night extends SPECIES_Human
	abstract;


static function int ModifyImpartedDamage( int Damage, pawn injured, pawn instigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType )
{
	Damage *= Default.DamageScaling;
	if ( instigatedBy.Health > 0 )
		instigatedBy.Health = Clamp(int(instigatedBy.Health+Damage*0.5), instigatedBy.Health, instigatedBy.HealthMax);
	
	return Damage;
}

defaultproperties
{
	SpeciesName="Night"
	RaceNum=5
	MaleVoice="XGame.NightMaleVoice"
	FemaleVoice="XGame.NightFemaleVoice"
	MaleSoundGroup="XGame.xNightMaleSoundGroup"
	FemaleSoundGroup="XGame.xNightFemaleSoundGroup"
	AirControl=+1.0
	GroundSpeed=+1.0
	WaterSpeed=+1.0
	JumpZ=+1.0
	ReceivedDamageScaling=+1.0
	DamageScaling=+0.7
	AccelRate=+1.0
	WalkingPct=+1.0
	CrouchedPct=+1.0
	DodgeSpeedFactor=+1.0
	DodgeSpeedZ=+1.0
	TauntAnims(8)=Gesture_Taunt03
	TauntAnims(9)=Idle_Character03
}