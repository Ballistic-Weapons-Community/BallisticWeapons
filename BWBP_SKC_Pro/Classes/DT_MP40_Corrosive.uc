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
	if(Pawn(Victim) != None && Pawn(Victim).Inventory != None)
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
     DeathStrings(0)="%k adapted to the amplified tehcnology, %o did not as %ve turned into a pile of goo."
     DeathStrings(1)="%o was on the wrong end of %k's chemical warfare."
     DeathStrings(2)="%k turned %o into primordial goop with an acidic AMP."
     DeathStrings(3)="%o couldn't hide from the impending acidic blitzkrieg from %k's amped FMP."
     DeathStrings(4)="Who wants a %o smoothie from %k?  Made of flesh and corrosive bullets."
     WeaponClass=Class'BWBP_SKC_Pro.FMPMachinePistol'
     DeathString="%k embraced Schadenfreude as %kh FMP destroyed %o."
     FemaleSuicide="%o did her Führer impression."
     MaleSuicide="%o did his Führer impression."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.650000

	TagMultiplier=0.7
	TagDuration=0.1
}
