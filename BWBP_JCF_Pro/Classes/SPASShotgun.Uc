//=============================================================================
// MRS138Shotgun.
//
// A combat shotgun with a Flashlight and Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASShotgun extends BallisticProShotgun;



simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassic())
	{
		FireModeClass[1]=Class'BCoreProV55.BallisticScopeFire';
	}
}

simulated function AltFire(float F)	{	FirePressed(F);	}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 450)
		return 1;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 0;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(Instigator.Velocity) < 0.5))
		return 1;
	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (!HasMagAmmo(0) && Ammo[0].AmmoAmount < 1)
	{
		if (Dist > 400)
			return 0;
		return Result / (1+(Dist/400));
	}
	// Enemy too far away
	if (Dist > 1000)
		Result -= (Dist-1000) / 2000;
	// If the enemy has a knife, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.1 * B.Skill;
	// Sniper bad, very bad
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.3;
	Result += 1 - Dist / 1000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

    return 0.3 - (B.Skill / 6) * (1-(Dist/3000));
}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_JCF_Tex.SPAS.BigIcon_SPAS'
     bWT_Shotgun=True
     SpecialInfo(0)=(Info="240.0;30.0;1.5;100.0;0.0;2.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
     MagAmmo=10
     CockSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Cock',Volume=0.800000)
     ReloadAnim="ReloadLoop"
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-ShellIn')
     ClipInFrame=0.375000
     bCockOnEmpty=True
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="PrepReload"
     EndShovelAnim="EndReload"
	 ReloadAnimRate=1.5
     WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightOffset=(X=-4.000000,Y=-0.130000,Z=8.650000)
     SightingTime=0.450000
     GunLength=32.000000
     LongGunPivot=(Pitch=4500,Yaw=-8000)
	 bNoCrosshairInScope=True
	 Bobdamping=2.35
     FireModeClass(0)=Class'BWBP_JCF_Pro.SPASSecondaryFire'
     FireModeClass(1)=Class'BWBP_JCF_Pro.SPASPrimaryFire'
     PutDownTime=0.500000
     AIRating=0.600000
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M763OutA',USize1=128,VSize1=128,USize2=256,VSize2=256,Color1=(B=121,G=123,R=125,A=177),Color2=(B=21,G=23,R=27,A=255),StartSize1=32,StartSize2=96)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     CurrentRating=0.600000
     Description="SPAS-12 Shotgun||Manufacturer: Classic Weapons Industries|Primary: Pump Shot|Secondary: Semi-Auto Shot||The SPAS is another well known firearm brought back to life by Classic Weapons Industries. A highly accurate 12-gauge shotgun, the 8 shell SPAS 12 was originally produced by Franchi in the pre-war period. It was a formidible dual-mode shotgun that could be fired in both semi-automatic and pump-action firemodes. CWI has worked to improve this venerable classic and has overhauled the original pump action firemode for improved accuracy and range. Users have the option of quickly switching between these modes to deal with different tactical situations. Comes with a variety of pre-war attachments for all your shooting needs."
     DisplayFOV=50.000000
     Priority=36
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     GroupOffset=31
     PickupClass=Class'BWBP_JCF_Pro.SPASPickup'
     PlayerViewOffset=(X=5.000000,Y=3.000000,Z=-6.500000)
     AttachmentClass=Class'BWBP_JCF_Pro.SPASAttachment'
     IconMaterial=Texture'BWBP_JCF_Tex.SPAS.SmallIcon_SPAS'
     IconCoords=(X2=127,Y2=30)
     ItemName="SP-12 Compact Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
	 ParamsClasses(0)=Class'BWBP_JCF_Pro.SPASShotgunWeaponParamsArena'
	 ParamsClasses(1)=Class'BWBP_JCF_Pro.SPASShotgunWeaponParamsClassic'
	 ParamsClasses(2)=Class'BWBP_JCF_Pro.SPASShotgunWeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_JCF_Anims.FPm_Spas'
     DrawScale=1.000000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
