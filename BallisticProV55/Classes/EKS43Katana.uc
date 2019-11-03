//=============================================================================
// EKS43Katana.
//
// A large sword that takes advantage of a sweeping melee attack. More range
// than akinfe, but slower and can't be thrown. Can be used to block otehr
// melee attacks and has a held attack for secondary which sweeps down and is
// prone to headshots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EKS43Katana extends BallisticMeleeWeapon;

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (VSize(B.Enemy.Location - Instigator.Location) > FireMode[0].MaxRange()*1.5)
		return 1;
	Result = FRand();
	if (vector(B.Enemy.Rotation) dot Normal(Instigator.Location - B.Enemy.Location) < 0.0)
		Result += 0.3;
	else
		Result -= 0.3;

	if (Result > 0.5)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = AIRating;
	// Enemy too far away
	if (Dist > 1500)
		return 0.1;			// Enemy too far away
	// Better if we can get him in the back
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0)
		Result += 0.08 * B.Skill;
	// If the enemy has a knife too, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result = FMax(0.0, Result *= 0.7 - (Dist/1000));
	// The further we are, the worse it is
	else
		Result = FMax(0.0, Result *= 1 - (Dist/1000));

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -1;
}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.150000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_EKS43'
     BigIconCoords=(Y1=32,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Slashes with the katana. Has a relatively long range and good damage, but a poor swing rate."
     ManualLines(1)="Prepares a slash, which will be executed upon release. The damage of this slash increases the longer altfire is held, up to 1.5 seconds for maximum damage output. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key allows the player to block. Whilst blocking, no attacks are possible, but all melee damage striking the player frontally will be mitigated.||The EKS-43 is effective at close range, but has lower DPS than shorter ranged melee weapons."
     SpecialInfo(0)=(Info="240.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Putaway')
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BallisticProV55.EKS43PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.EKS43SecondaryFire'
     PutDownTime=0.500000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.300000
     CurrentRating=0.300000
     bMeleeWeapon=True
     Description="The EKS-43 sword is one of a few weapons produced by Enravion, not designed for widescale military use. It is an expenisve artefact preferred by collectors and other rare procurers. The blade is forged by the use of both ancient techniques and the most modern technology, making it a mighty weapon with incredible sharpness and legendary Enravion strength. Civilians use the weapon for various training and other personal purposes, while several mercenary groups, most notably, the highly skilled 'Apocalytes', adopted the weapon for use with their more skilled warriors."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=1
     PickupClass=Class'BallisticProV55.EKS43Pickup'
     PlayerViewOffset=(X=6.000000,Z=-18.000000)
     AttachmentClass=Class'BallisticProV55.EKS43Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_EKS43'
     IconCoords=(X2=127,Y2=31)
     ItemName="EKS-43 Katana"
     Mesh=SkeletalMesh'BallisticAnims2.Katana'
     DrawScale=0.250000
}
