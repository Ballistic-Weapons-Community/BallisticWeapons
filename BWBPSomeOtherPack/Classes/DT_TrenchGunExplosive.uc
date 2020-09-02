class DT_TrenchGunExplosive extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k's explosive double barrel shot blasted %o into giblets."
     DeathStrings(1)="%o was served a double helping of %k's explosive shotgun shells."
	DeathStrings(2)="%o was disassembled by %k's trenchgun."
     SimpleKillString="Trenchgun Explosive Rounds"
     //FlashThreshold=0
     //FlashV=(X=350.000000,Y=350.000000,Z=700.000000)
     //FlashF=0.250000
     WeaponClass=Class'BWBPSomeOtherPack.TrenchGun'
	 InvasionDamageScaling=1.250000
     DeathString="%k's explosive double barrel shot blasted %o into giblets."
     FemaleSuicide="%o got a little too close to her own explosive rounds."
     MaleSuicide="%o got a little too close to his own explosive rounds."
	DamageDescription=",Shell,Fire,"
     GibModifier=0.500000
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleDamageScaling=2.000000
}
