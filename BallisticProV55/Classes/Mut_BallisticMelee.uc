//=============================================================================
// Mut_BallisticMelee.
//
// Replaces normal weapons with Ballistic's melee ones
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_BallisticMelee extends Mut_Ballistic
	transient
	HideDropDown
	CacheExempt;

simulated event PreBeginPlay()
{
	Replacements.Length = 23;
	super.PreBeginPlay();
}
// Modify players and bots a bit
function ModifyPlayer(Pawn Other)
{
	local class<Weapon> FW;
	local int i;

/*	// Make players a bit crap
	Other.GroundSpeed=350;
	Other.WaterSpeed=220;
	Other.AirSpeed=440;
	Other.JumpZ=340;
	Other.WalkingPct=0.5;
	Other.CrouchedPct=0.4;
*/
	// Different UDamage sound
	if (xPawn(Other) != none)
		xPawn(Other).UDamageSound=UDamageSnd;

	// Change things that we can't get to from the server
//	Other.Spawn(class'ClientModifier', Other);

	// No lights please
	xPlayerReplicationInfo(Other.PlayerReplicationInfo).bForceNoPlayerLights = true;

	// Change favorite weapons for bots
	if (Other.Controller != None && Bot(Other.Controller) != None && Bot(Other.Controller).FavoriteWeapon != None)
	{
		FW = Bot(Other.Controller).FavoriteWeapon;
		for (i=0;i<Replacements.Length;i++)
		{
			if (GetInventoryFor(Replacements[i].OldItem) == FW)
				Bot(Other.Controller).FavoriteWeapon = class<Weapon>(GetInventoryFor(GetNewItem(i, true)));
		}
	}
	Super(Mutator).ModifyPlayer(Other);
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if (Ammo(Other) != None)
	{
		bSuperRelevant = 0;
		return false;
	}
	return super.CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
     Replacements(0)=(OldItem=Class'XWeapons.ShieldGun',NewItemNames=("BallisticProV55.X3Pickup"))
     Replacements(1)=(OldItem=Class'XWeapons.AssaultRifle',NewItemNames=("BallisticProV55.X3Pickup"))
     Replacements(2)=(OldItem=Class'XWeapons.BioRiflePickup',NewItemNames=("BallisticProV55.Melee_M763Pickup"))
     Replacements(3)=(OldItem=Class'XWeapons.ShockRiflePickup',NewItemNames=("BWBP_OP_Pro.DefibFistsPickup"))
     Replacements(4)=(OldItem=Class'XWeapons.LinkGunPickup',NewItemNames=("BallisticProV55.Melee_A73Pickup"))
     Replacements(5)=(OldItem=Class'XWeapons.MinigunPickup',NewItemNames=("BallisticProV55.A909Pickup"))
     Replacements(6)=(OldItem=Class'XWeapons.FlakCannonPickup',NewItemNames=("BallisticProV55.EKS43Pickup"))
     Replacements(7)=(OldItem=Class'XWeapons.RocketLauncherPickup',NewItemNames=("BWBP_OP_Pro.BallisticShieldPickup"))
     Replacements(8)=(OldItem=Class'XWeapons.SniperRiflePickup',NewItemNames=("BWBP_SKC_Pro.BlackOpsWristBladePickup"))
     Replacements(9)=(OldItem=Class'XWeapons.PainterPickup',NewItemNames=("BWBP_OP_Pro.FlameSwordPickup"))
     Replacements(10)=(OldItem=Class'XWeapons.RedeemerPickup',NewItemNames=("BWBP_SKC_Pro.DragonsToothPickup"))
     Replacements(11)=(OldItem=Class'UTClassic.ClassicSniperRiflePickup',NewItemNames=("BWBP_SKC_Pro.X8Pickup"))
     Replacements(12)=(OldItem=Class'Onslaught.ONSAVRiLPickup',NewItemNames=("BallisticProV55.EKS43Pickup"))
     Replacements(13)=(OldItem=Class'Onslaught.ONSGrenadePickup',NewItemNames=("BWBP_SKC_Pro.ChaffPickup"))
     Replacements(14)=(OldItem=Class'Onslaught.ONSMineLayerPickup',NewItemNames=("BallisticProV55.Melee_A73Pickup"))
     Replacements(15)=(OldItem=Class'OnslaughtFull.ONSPainterPickup',NewItemNames=("BWBP_OP_Pro.MAG78Pickup"))
     Replacements(16)=(OldItem=Class'XPickups.HealthPack',NewItemNames=("BallisticProV55.IP_HealthKit"))
     Replacements(17)=(OldItem=Class'XPickups.MiniHealthPack',NewItemNames=("BallisticProV55.IP_Bandage"))
     Replacements(18)=(OldItem=Class'XPickups.AdrenalinePickup',NewItemNames=("BallisticProV55.IP_Adrenaline"))
     Replacements(19)=(OldItem=Class'XPickups.UDamagePack',NewItemNames=("BallisticProV55.IP_UDamage"))
     Replacements(20)=(OldItem=Class'XPickups.SuperHealthPack',NewItemNames=("BallisticProV55.IP_SuperHealthKit"))
     Replacements(21)=(OldItem=Class'XPickups.SuperShieldPack',NewItemNames=("BallisticProV55.IP_BigArmor"))
     Replacements(22)=(OldItem=Class'XPickups.ShieldPack',NewItemNames=("BallisticProV55.IP_SmallArmor"))
     DefaultWeaponName="BallisticProV55.X3knife"
     FriendlyName="BallisticPro: Melee Only"
     Description="Play with Ballistic Weapons mutator using only the melee weapons.||http://www.runestorm.com"
}
