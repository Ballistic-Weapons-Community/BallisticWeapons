//=============================================================================
// DT_MP40Head.
//
// DamageType for MP40 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MP40Head_Corrosive extends DT_BWBullet;

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

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.headcount++;
		if ( (xPRI.headcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('HeadHunter',15);
	}
}
// --------------------------------------------------------

defaultproperties
{
	 ArmorDrain=0.750000
     DeathStrings(0)="%o didn't have time to kneel and surrender before %vh brains was melted by %k."
     DeathStrings(1)="Here we have the modern exhibit from %k, using %o's green matter as paint."
     DeathStrings(2)="%o got some acid rain from %k, melting %vh brains into neon green mud."
     bHeaddie=True
     WeaponClass=Class'BWBP_SKC_Pro.FMPMachinePistol'
     DeathString="%o was lobotomized by %k's FMP bullets."
     FemaleSuicide="%o shot herself in the face."
     MaleSuicide="%o shot himself in the face."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.650000
}
