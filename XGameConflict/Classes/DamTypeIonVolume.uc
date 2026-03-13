class DamTypeIonVolume extends DamageType
	abstract;

defaultproperties
{
    DeathString="%o was OBLITERATED by %k!"
    MaleSuicide="%o was OBLITERATED"
    FemaleSuicide="%o was OBLITERATED"

    bDetonatesGoop=true
    GibModifier=0
    bSuperWeapon=true
    bSkeletize=true
    bArmorStops=false
    DamageOverlayMaterial=Material'UT2004Weapons.ShockHitShader'
    DamageOverlayTime=1.0
}
