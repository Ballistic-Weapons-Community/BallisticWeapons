//=============================================================================
// DTSRXRifle.
//
// DamageType for the SRS900 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRXRifle_Corrosive extends DT_BWBullet;

var() float ArmorDrain;

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
// todo: core-ify this function to apply to all weapons
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local Armor BestArmor;

	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);

	//Don't damage teammates' armor
	if (Instigator.Controller != None && Pawn(Victim).Controller != Instigator.Controller && Instigator.Controller.SameTeamAs(Pawn(Victim).Controller))
		return;

	// Do additional damage to armor..
	if(Pawn(Victim) != None)
	{
		BestArmor = Pawn(Victim).Inventory.PrioritizeArmor(Damage*Default.ArmorDrain,Default.Class,HitLocation);
		if(BestArmor != None)
		{
			Victim.TakeDamage(Damage*Default.ArmorDrain, Instigator, HitLocation, Momentum, DT);
			BestArmor.ArmorAbsorbDamage(Damage*Default.ArmorDrain,Default.Class,HitLocation);
		}
	}
}

defaultproperties
{
	 ArmorDrain=0.325000
     DeathStrings(0)="%o's veins are glowing bright with acid thanks to %k."
     DeathStrings(1)="%k injected some acid into %o's system and they melted from the inside."
     DeathStrings(2)="%o's armor and flesh fused into a bloody mess due to %k's acidic SRK."
     DeathStrings(3)="%k made some acidic soup, using their SRK and %o as ingredients."
     AimedString="Scoped"
     DamageIdent="Sniper"
     WeaponClass=Class'BWBPRecolorsPro.SRXRifle'
     DeathString="%k assasinated %o with %kh SRK-650."
     FemaleSuicide="%o took the wrong kind of acid as a recreational drug."
     MaleSuicide="%o drank their own acid."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
