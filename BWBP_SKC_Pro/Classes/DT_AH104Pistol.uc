//=============================================================================
// DTAH104Pistol.
//
// Damage type for the AH104 Pistol. Armor piercing rounds.
//
// Does 20% extra damage through armor and to armor.
// Does 87% damage to vehicles. (High)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AH104Pistol extends DT_BWBullet;

var() float ArmorDrain;

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	local Armor BestArmor;

	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);

	if (Instigator.Controller != None && Pawn(Victim).Controller != Instigator.Controller && Instigator.Controller.SameTeamAs(Pawn(Victim).Controller))
		return; //Yeah no melting teammate armor. that's mean

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
	ArmorDrain=0.200000
	DeathStrings(0)="%k pounded %o to the ground with %kh AH104."
	DeathStrings(1)="%k punched through %o with %kh AH104."
	DeathStrings(2)="%o's body armor did nothing to stop %k's AH104."
	DeathStrings(3)="%k's AH104 blasted %o into submission."
	bIgniteFires=True
	WeaponClass=Class'BWBP_SKC_Pro.AH104Pistol'
	DeathString="%k pounded %o to the ground with %kh AH104."
	FemaleSuicide="%o nailed herself with the AH104."
	MaleSuicide="%o nailed himself with the AH104."
	VehicleDamageScaling=0.875000
	VehicleMomentumScaling=0.300000

	TagMultiplier=0.6
	TagDuration=0.2
}
