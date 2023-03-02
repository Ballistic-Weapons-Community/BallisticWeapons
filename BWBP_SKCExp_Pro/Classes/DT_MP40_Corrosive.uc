//=============================================================================
// DT_MP40Chest.
//
// DamageType for the FMP-2012
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MP40_Corrosive extends DT_BWBullet;

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
     DeathStrings(0)="%k embraced Schadenfreude as %kh FMP destroyed %o."
     DeathStrings(1)="%o lost the war to %k's FMP-2012."
     DeathStrings(2)="%k enacted blitzkrieg on %o with %kh FMP-2012."
     DeathStrings(3)="%o was removed from the gene pool by %k's FMP."
     DeathStrings(4)="%k's FMP-2012 executed the untermensch %o."
     WeaponClass=Class'BWBP_SKCExp_Pro.FMPMachinePistol'
     DeathString="%k embraced Schadenfreude as %kh FMP destroyed %o."
     FemaleSuicide="%o did her fuhrer impression."
     MaleSuicide="%o did his fuhrer impression."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.650000
}
