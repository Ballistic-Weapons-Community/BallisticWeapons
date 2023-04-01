//=============================================================================
// D49Revolver.
//YES THE BEST GUN EVER OH GOD SO GOOD
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MagicFinger extends BallisticHandgun;



// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}


function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     SelectAnim="Down"
     PutDownAnim="Up"
     ReloadAnim="Relod"
     IdleAnim="Idal"
     CockAnim="cacking"
     HandgunGroup=1
     PlayerSpeedFactor=1.100000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticRecolors4F.FART.BigIcon_FART'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="120.0;10.0;0.6;50.0;1.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'WeaponSounds.Minigun.miniempty')
     PutDownSound=(Sound=Sound'MenuSounds.denied1')
     CockSound=(Sound=Sound'PackageSounds4F.FART.FAR-Cock',Volume=1.500000)
     ClipHitSound=(Sound=Sound'PackageSounds4F.FART.FAR-Reload',Volume=1.500000)
     ClipOutSound=(Sound=Sound'PackageSounds4F.FART.FAR-Reload',Volume=1.500000)
     ClipInSound=(Sound=Sound'PackageSounds4F.FART.FAR-Reload',Volume=1.500000)
     MagAmmo=2362
     bNonCocking=False
     bNeedCock=True
     WeaponModes(0)=(ModeName="Single Fire",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     FullZoomFOV=60.000000
     SightPivot=(Pitch=768,Roll=-1024)
     SightOffset=(X=-20.000000,Y=-4.000000,Z=21.000000)
	ParamsClasses(0)=Class'MagicWeaponParams'
	ParamsClasses(1)=Class'MagicWeaponParams'
	ParamsClasses(2)=Class'MagicWeaponParams'
     FireModeClass(0)=Class'BWBP_KFC_DE.MagicFingerPrimaryFire'
     FireModeClass(1)=Class'BWBP_KFC_DE.MagicFingerSecondaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     bSniping=True
     bShowChargingBar=True
     Description="SMARF gun|Manuacturer: Apland Enterprises|Primary: Plasma Burst|Secondary: Heavy Laser||The F4R is one of the best rifles made by Apland Enterprises. They have sold 100s of units to UTC ground forces and it's excellent at fighting the Skrith. The first issues of the rifle generated considerable controversy because the gun suffered from a jamming flaw known as “failure to extract,” which meant that a plasma cell case remained lodged in the chamber after a plasma charge flew out the muzzle. According to a UTC report, the jamming was caused primarily by a change in voltage that was done without adequate testing and reflected a decision for which the safety of soldiers was a secondary consideration. Due to the issue, reports of soldiers being wounded were directly linked to the F4R, which many soldiers felt was unreliable compared to its precursor, the HVPC, which used backpacks, varying from the M50's utilization of ball powder. Meanwhile, the layout of the weapon itself was also somewhat different. Previous designs generally placed the sights directly on the barrel, using a bend in the stock to align the sights at eye level while transferring the recoil down to the shoulder. This meant that the weapon tended to rise when fired, making it very difficult to control during fully automatic fire. The UTC team used a solution previously used on weapons such as the FG50 HMG and Johnson Sergeant Xavious development Team; they located the barrel in line with the stock, well below eye level, and raised the sights to eye level. The rear sight was built into a carrying handle over the receiver. It may be noted that railgun velocities generally fall within the range of those achievable by two stage light gas guns; however, the latter are generally only considered to be suitable for laboratory use while plasma cannons are judged to offer some potential prospects for development as civillian weapons. In some hypervelocity research projects, projectiles are pre-injected into plasma rifles, to avoid the need for a standing start, and both two stage light gas guns and conventional powder guns have been used for this role. UTC soldiers often praise its amazing accuracy and firepower, and there are reports of them bringing the weapon home to show their parents."
     DisplayFOV=50.000000
     Priority=198
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=9
     PickupClass=Class'BWBP_KFC_DE.MagicFingerPickup'
     PlayerViewOffset=(X=25.000000,Y=13.000000,Z=-18.000000)
     PlayerViewPivot=(Pitch=512)
     BobDamping=1.200000
     AttachmentClass=Class'BWBP_KFC_DE.MagicFingerAttachment'
     IconMaterial=Texture'BallisticRecolors4F.FART.SmallIcon_FART'
     IconCoords=(X2=127,Y2=31)
     ItemName="SMAR.F Recoiless RIfle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimF.Finger'
     DrawScale=0.700000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
