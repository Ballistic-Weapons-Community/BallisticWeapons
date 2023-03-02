//=============================================================================
// DTalaxe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTalaxe extends DTJunkDamage;

static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local float ShieldStart, ShieldEnd;
	
	ShieldStart = Pawn(Victim).GetShieldStrength();
	
	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);
	
	if (Pawn(Victim) != None)
		ShieldEnd = Pawn(Victim).GetShieldStrength();
		
	log("ShieldStart:"@ShieldStart@"ShieldEnd:"@ShieldEnd);
		
	if (ShieldStart - ShieldEnd > 0)
		Instigator.AddShieldStrength(ShieldStart - ShieldEnd);
}

defaultproperties
{
     DeathStrings(0)="%k disintegrated %o with an alien axe."
     DeathStrings(1)="%k did some manslaughter stuff on %o."
     DeathStrings(2)="%k destroyed %o with %kh alien axe."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=180
     DamageDescription=",Hack,"
     ImpactManager=None
     DeathString="%o was completey halved by %k's Alien Axe assault."
     FemaleSuicide="%o halved herself with an Alien Axe."
     MaleSuicide="%o halved himself with an Alien Axe."
     bNeverSevers=False
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
}
