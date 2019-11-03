//=============================================================================
// A909SkrithBlades.
//
// The A909 Skrith Wrist blades are rapid fire melee weapons with fair range,
// but without the useful, spread out swipe of other melee weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A909SkrithBlades extends BallisticMeleeWeapon;

simulated function bool HasAmmo()	{	return true;	}
simulated function bool ConsumeAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)	{ return true;	}

simulated function Notify_A909HackRight()
{
	A909PrimaryFire(FireMode[0]).bFireNotified=true;
	FireMode[0].ModeDoFire();
}
simulated function Notify_A909HackLeft()
{
	A909PrimaryFire(FireMode[0]).bFireNotified=true;
	FireMode[0].ModeDoFire();
}
// On the server, this adjusts anims, ammo and such. On clients it only adjusts anims.
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
    if (Anim == FireMode[0].FireAnim && FireMode[0].bIsFiring)
    	FireMode[0].PlayFiring();
	else
    	super.AnimEnd(Channel);
}

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return VSize(Other.Location - Instigator.Location) < FireMode[0].MaxRange() * 2;
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
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A909'
     BigIconCoords=(X1=24,X2=432)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Thrusting attack with the blades. Good range, but requires accuracy to hit. The first strike requires twice as long to complete as subsequent strikes. This attack has the highest sustained damage output of all melee weapons."
     ManualLines(1)="Prepares a slash, which will be executed upon release. The damage of this slash increases the longer altfire is held, up to 1.5 seconds for maximum damage output. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key allows the player to block. Whilst blocking, no attacks are possible, but all melee damage striking the player frontally will be mitigated.||The A909s have extreme damage output at close range, but their short range makes realizing this potential difficult.||The player moves faster with the blades equipped."
     SpecialInfo(0)=(Info="120.0;2.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.A909.A909Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A909.A909Putaway')
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BallisticProV55.A909PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.A909SecondaryFire'
     PutDownAnimRate=2.200000
     PutDownTime=0.200000
     BringUpTime=0.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.300000
     CurrentRating=0.300000
     bMeleeWeapon=True
     Description="The A909 Skrith Blades are a common Skrith melee weapon. They were a terrible bane of the human armies during the first war. The Skrith used them ruthlessly and with great skill to viciously slice up their enemies. Though the blades are useless at range, they are capable of great harm if the user can sneak up on an opponent. All or most Skrith warriors seem to prefer melee battle, and as such hone their skill with close range weapons. The blades can be extremely deadly when close up, as they can jab and slice very fast."
     DisplayFOV=70.000000
     Priority=13
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=2
     PickupClass=Class'BallisticProV55.A909Pickup'
     PlayerViewOffset=(X=63.000000,Y=-4.000000,Z=-6.000000)
     AttachmentClass=Class'BallisticProV55.A909Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A909'
     IconCoords=(X2=127,Y2=31)
     ItemName="A909 Skrith Blades"
     Mesh=SkeletalMesh'BallisticAnims2.A909Blades'
     DrawScale=0.370000
}
