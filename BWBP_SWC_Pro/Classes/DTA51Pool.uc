//=============================================================================
// DTA500Pool.
//
// Damage type for the A500 Acid Pool.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA51Pool extends DTA500Blast;

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local Armor BestArmor;

	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);

	// Do additional damage to armor..
	if(Pawn(Victim) != None)
	{
		if (Pawn(Victim).Inventory == None)
			return;
		BestArmor = Pawn(Victim).Inventory.PrioritizeArmor(Damage*Default.ArmorDrain,Default.Class,HitLocation);
		if(BestArmor != None)
			BestArmor.ArmorAbsorbDamage(Damage*Default.ArmorDrain,Default.Class,HitLocation);
	}
}

defaultproperties
{
     DeathStrings(0)="%o waddled into %k's noxious acid pool and melted."
     DeathStrings(1)="%k's acid pool turned %o into a slurred puddle."
     DeathStrings(2)="%o tripped into %k's acidic A51 puddle and melted %vs. "
     DamageDescription=",Corrosive,Hazard,NonSniper,Poison"
     WeaponClass=Class'BWBP_SWC_Pro.A51Grenade'
     DeathString="%o waddled into %k's noxious acid pool and melted."
     FemaleSuicide="%o dissolved herself in her own gooey A51 acid pool."
     MaleSuicide="%o dissolved himself in his own gooey A51 acid pool."
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.Reptile.Rep_PlayerImpact'
     VehicleDamageScaling=1.000000
     TransientSoundVolume=2.000000
}
