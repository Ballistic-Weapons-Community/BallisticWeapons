class xAlienFemaleSoundGroup extends xPawnSoundGroup;

#exec OBJ LOAD FILE=..\sounds\NewDeath.uax

defaultproperties
{
    Sounds(2)=Sound'PlayerSounds.Final.HitUnderWaterAlienFemale'
    Sounds(3)=Sound'PlayerSounds.AlienJump1'
    Sounds(4)=Sound'PlayerSounds.Final.LandGruntAlienFemale'
    Sounds(5)=Sound'PlayerSounds.Final.GaspAlienFemale'
    Sounds(6)=Sound'PlayerSounds.Final.DrownAlienFemale'
    Sounds(7)=Sound'PlayerSounds.Final.BreathAgainAlienFemale'
    Sounds(8)=Sound'PlayerSounds.AlienDodge'
    Sounds(9)=Sound'PlayerSounds.AlienJump2'
    
    PainSounds(0)=Sound'NewDeath.fn_hit01'
    PainSounds(1)=Sound'NewDeath.fn_hit02'
    PainSounds(2)=Sound'NewDeath.fn_hit03'
    PainSounds(3)=Sound'NewDeath.fn_hit05'
    PainSounds(4)=Sound'NewDeath.fn_hit07'
    PainSounds(5)=Sound'NewDeath.fn_hit09'
    
    DeathSounds(0)=Sound'NewDeath.fn_death01'
    DeathSounds(1)=Sound'NewDeath.fn_death02'
    DeathSounds(2)=Sound'NewDeath.fn_death03'
    DeathSounds(3)=Sound'NewDeath.fn_death04'
    DeathSounds(4)=Sound'NewDeath.fn_death05'
}
