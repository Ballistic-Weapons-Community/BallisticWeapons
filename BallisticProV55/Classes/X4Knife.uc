//=============================================================================
// X4Knife.
//
// The X3's stronger brother, an equally lethal larger green handled knife for cutting eared 'fruit'.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class X4Knife extends BallisticMeleeWeapon;

#exec OBJ LOAD File=BallisticSounds3.uax

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
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticTextures_25.X4.BigIcon_X4'
     BigIconCoords=(Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Slashes with the knife. Solid damage output and short range."
     ManualLines(1)="Prepared slash. Gains damage over hold time (maximum bonus reached after 1.5 seconds). Deals more damage from behind."
     ManualLines(2)="The user's movement speed improves with this weapon active."
     SpecialInfo(0)=(Info="180.0;6.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.Knife.KnifePullOut')
     PutDownSound=(Sound=Sound'BallisticSounds2.Knife.KnifePutaway')
     bCanBlock=False
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True
     ParamsClass=Class'X4WeaponParams'
     FireModeClass(0)=Class'BallisticProV55.X4PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.X4SecondaryFire'
     SelectAnimRate=1.250000
     PutDownTime=0.200000
     BringUpTime=0.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     bMeleeWeapon=True
     Description="Much like its predecessor, the X4 is a high quality weapon, manufactured by the renowned Enravion group. The X4 was designed for use in other combat situations, specifically for the Outworld's large urban and industrial sprawls. Made of tougher, heavier and more durable materials, the X4 is not as light or balanced as the X3, and is thus not an easy weapon to use for throwing purposes."
     Priority=13
     HudColor=(B=25,G=150,R=50)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=3
     PickupClass=Class'BallisticProV55.X4Pickup'
     PlayerViewOffset=(X=4.000000,Y=8.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.X4Attachment'
     IconMaterial=Texture'BallisticTextures_25.X4.SmallIcon_X4'
     IconCoords=(X2=128,Y2=32)
     ItemName="X4 Knife"
     Mesh=SkeletalMesh'BallisticAnims_25.X4'
     DrawScale=0.300000
}
