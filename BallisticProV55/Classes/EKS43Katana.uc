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

var() bool	bIsSuperHeated;

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	
	bIsSuperHeated=false;

	if (InStr(WeaponParams.LayoutTags, "superheated") != -1)
	{
		bIsSuperHeated=true;
	}
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

// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_EKS43'
     BigIconCoords=(Y1=32,Y2=230)
     
     ManualLines(0)="Slashes with the katana. Has a relatively long range and good damage, but a poor swing rate."
     ManualLines(1)="Prepares a slash, which will be executed upon release. The damage of this slash increases the longer altfire is held, up to 1.5 seconds for maximum damage output. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key allows the player to block. Whilst blocking, no attacks are possible, but all melee damage striking the player frontally will be mitigated.||The EKS-43 is effective at close range, but has lower DPS than shorter ranged melee weapons."
     SpecialInfo(0)=(Info="240.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Pullout',Volume=0.209000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway',Volume=0.209000)
     GunLength=0.000000
     bAimDisabled=True
     ParamsClasses(0)=Class'EKS43WeaponParamsComp'
     ParamsClasses(1)=Class'EKS43WeaponParamsClassic'
     ParamsClasses(2)=Class'EKS43WeaponParamsRealistic'
     ParamsClasses(3)=Class'EKS43WeaponParamsTactical'
     FireModeClass(0)=Class'BallisticProV55.EKS43PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.EKS43SecondaryFire'
	 
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.X3InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=159,G=64,R=0),Color2=(B=255),StartSize1=98,StartSize2=101)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)
	 
     SelectAnimRate=1.5
     PutDownAnimRate=1.5
     PutDownTime=0.300000
     BringUpTime=0.300000
     SelectForce="SwitchToAssaultRifle"
     bMeleeWeapon=True
     Description="The EKS-43 sword is one of a few weapons produced by Enravion, not designed for widescale military use. It is an expenisve artefact preferred by collectors and other rare procurers. The blade is forged by the use of both ancient techniques and the most modern technology, making it a mighty weapon with incredible sharpness and legendary Enravion strength. Civilians use the weapon for various training and other personal purposes, while several mercenary groups, most notably, the highly skilled 'Apocalytes', adopted the weapon for use with their more skilled warriors."
     Priority=12
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=1
     PickupClass=Class'BallisticProV55.EKS43Pickup'
     PlayerViewOffset=(X=7.200000,Z=-21.600000)
     AttachmentClass=Class'BallisticProV55.EKS43Attachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_EKS43'
     IconCoords=(X2=127,Y2=31)
     ItemName="EKS-43 Katana"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.EKS43_FPm'
     DrawScale=0.3
}
