class DTWrenchgunShot extends DT_BWBlunt;

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local WrenchgunBleed C;

	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);


	if (xPawn(Victim) != None && xPawn(Victim).bProjTarget)
	{
		foreach Victim.BasedActors(class'WrenchgunBleed', C)
		{
			C.AddTime(2.5);
			return;
		}
		C = Victim.Spawn(class'WrenchgunBleed',Victim, , Victim.Location, Victim.Rotation);
		C.Initialize(Victim);
		C.Instigator = Instigator;
	}
}

defaultproperties
{
     DeathStrings(0)="%k redefined terminal velocity by fatally lobbing a wrench at %o."
     DeathStrings(1)="%o proved to be no match for %k's patented flying wrench technique."
     DeathStrings(2)="%o mistakenly brought a gun to %k's ballistic wrench fight."
     SimpleKillString="Redwood Wrenchgun Wrenchshot"
     InvasionDamageScaling=2.000000
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_APC_Pro.Wrenchgun'
     DeathString="%k hunted down a cowering %o with %kh wrenchgun."
     FemaleSuicide="%o doesn't know how to aim."
     MaleSuicide="%o can't aim very well."
     bExtraMomentumZ=True
     GibModifier=1.500000
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
}
