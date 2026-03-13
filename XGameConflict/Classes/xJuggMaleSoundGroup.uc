class xJuggMaleSoundGroup extends xPawnSoundGroup;


static function Sound GetHitSound()
{
	if ( FRand() < 0.01 )
		return sound'NewDeath.mj_hit15';
	return default.PainSounds[rand(default.PainSounds.length)];
}
defaultproperties
{
    Sounds(2)=Sound'PlayerSounds.Final.HitUnderWaterJuggMale'
    Sounds(3)=Sound'PlayerSounds.MaleJump1'
    Sounds(4)=Sound'PlayerSounds.Final.LandGruntJuggMale'
    Sounds(5)=Sound'PlayerSounds.Final.GaspJuggMale'
    Sounds(6)=Sound'PlayerSounds.Final.DrownJuggMale'
    Sounds(7)=Sound'PlayerSounds.Final.BreathAgainJuggMale'
    Sounds(8)=Sound'PlayerSounds.MaleDodge'
    Sounds(9)=Sound'PlayerSounds.MaleJump2'
    
    PainSounds(0)=Sound'NewDeath.mj_hit01'
    PainSounds(1)=Sound'NewDeath.mj_hit02'
    PainSounds(2)=Sound'NewDeath.mj_hit06'
    PainSounds(3)=Sound'NewDeath.mj_hit07'
    PainSounds(4)=Sound'NewDeath.mj_hit11'
    PainSounds(5)=Sound'NewDeath.mj_hit13'
    
    DeathSounds(0)=Sound'NewDeath.mj_death01'
    DeathSounds(1)=Sound'NewDeath.mj_death05'
    DeathSounds(2)=Sound'NewDeath.mj_death07'
    DeathSounds(3)=Sound'NewDeath.mj_death08'
    DeathSounds(4)=Sound'NewDeath.mj_death11'
}
