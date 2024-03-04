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
class BlackOpsWristBlade extends BallisticMeleeWeapon;

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
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 4;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/1500));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.100000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.BlkOpsBlade.BigIcon_WristBld'
     SpecialInfo(0)=(Info="360.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Pullout',Volume=0.105000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway',Volume=0.105000)
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     FireModeClass(0)=Class'BWBP_SKC_Pro.BlackOpsWristBladePrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.BlackOpsWristBladeSecondaryFire'
     PutDownTime=0.500000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.300000
     CurrentRating=0.300000
     bMeleeWeapon=True
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50In',USize1=256,VSize1=256,Color1=(B=159,G=64,R=0),Color2=(B=255),StartSize1=98,StartSize2=101)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)
     Description="X5W Black Ops Wrist Blade||Manufacturer: Enravion Combat Solutions|Primary: Slash|Secondary: Prepared Slash|Special: Block||A rare variant of the X5 short combat sword, the X5W is a special edition wrist blade developed for the UTC Black Ops paramilitary forces. Given to the elite assassination squads during the Skrith wars, this blade proved itself many times in close quarters combat. It is constructed using modern forging techniques and the highest quality materials, is built to last and is one of the only blades capable of standing its own against a charging Skrith warrior. Don't leave home without one."
     Priority=12
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=5
     PickupClass=Class'BWBP_SKC_Pro.BlackOpsWristBladePickup'
     PlayerViewOffset=(X=50.000000,Y=0.000000,Z=-40.000000)
     BobDamping=1.000000
     AttachmentClass=Class'BWBP_SKC_Pro.BlackOpsWristBladeAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.BlkOpsBlade.SmallIcon_WristBld'
     IconCoords=(X2=127,Y2=31)
     ItemName="X5W Black Ops Blade"
	 ParamsClasses(0)=Class'BlackOpsWristBladeWeaponParamsArena'
	 ParamsClasses(1)=Class'BlackOpsWristBladeWeaponParamsClassic'
	 ParamsClasses(2)=Class'BlackOpsWristBladeWeaponParamsRealistic'
	 ParamsClasses(3)=Class'BlackOpsWristBladeWeaponParamsTactical'
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_BOB'
     DrawScale=1.250000
}
