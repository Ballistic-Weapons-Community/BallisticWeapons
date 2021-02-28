class DTCoachShot extends DT_BWShell;

/*
// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local CoachBleed C;

	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);


	if (xPawn(Victim) != None && xPawn(Victim).bProjTarget)
	{
		foreach Victim.BasedActors(class'CoachBleed', C)
		{
			C.AddTime(2.5);
			return;
		}
		C = Victim.Spawn(class'CoachBleed',Victim, , Victim.Location, Victim.Rotation);
		C.Initialize(Victim);
		C.Instigator = Instigator;
	}
}
*/

defaultproperties
{
     DeathStrings(0)="%k hunted down a cowering %o with %kh coach gun."
     DeathStrings(1)="%k's break-open shotgun tore %o to shreds."
     DeathStrings(2)="%o was blasted away by %k's coach gun."
     SimpleKillString="Redwood Coach Gun"
     InvasionDamageScaling=2.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBPRecolorsPro.CoachGun'
     DeathString="%k hunted down a cowering %o with %kh coach gun."
     FemaleSuicide="%o doesn't know how to aim."
     MaleSuicide="%o can't aim very well."
     GibModifier=1.500000
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
}
