//=============================================================================
// M58Grenade.
//
// A smoke grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M58Grenade extends BallisticHandGrenade config(BallisticProV55);

simulated function DoExplosion()
{
	if (Role == ROLE_Authority)
	{
		CheckNoGrenades();
	}
}

simulated function ExplodeInHand()
{
	BFireMode[0].ModeDoFire();
}

defaultproperties
{
     ClipReleaseSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-PinOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.M58.BigIcon_M58'
     BigIconCoords=(Y1=12,Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     SpecialInfo(0)=(Info="0.0;0.0;0.0;-1.0;0.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway')
     CurrentWeaponMode=1
     FireModeClass(0)=Class'BallisticProV55.M58PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.M58SecondaryFire'
	 
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=255,G=255,R=0,A=114),Color2=(B=255,G=255,R=255,A=148),StartSize1=96,StartSize2=46)
	 
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     ParamsClasses(0)=Class'M58WeaponParams'
     ParamsClasses(1)=Class'M58WeaponParams'
     CurrentRating=0.400000
     Description="M58 Smoke Grenade||Manuacturer: UTC Defense Tech|Primary: Throw Grenade|Secondary: Roll Grenade|Special: Release Clip||Smoke grenades have been around since the 20th century, used for signaling troops or disguising movements through heavy smoke, they're extremely versatile. They're still in use today and the M58 Smoke Grenade is the latest model introduced by the UTC Defense Tech. Designed to spew out vivid gray smoke, the M58 allows the user to perform a wide range of activities from tactical retreats to confuse and disorient the enemy, and when used in tangent with thermal vision and good fire power, it can create ambushes as well. However, the smoke isn't damaging as well as having a short amount of time before the heavy cloud disperses, removing the element of surprise."
     Priority=3
     HudColor=(B=150,G=150,R=150)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     GroupOffset=7
     PickupClass=Class'BallisticProV55.M58Pickup'
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BallisticProV55.M58Attachment'
     IconMaterial=Texture'BW_Core_WeaponTex.M58.SmallIcon_M58'
     IconCoords=(X2=127,Y2=31)
     ItemName="M58 Smoke Grenade"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_T10'
     DrawScale=0.400000
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BW_Core_WeaponTex.M58.M58GrenadeSkin'
}
