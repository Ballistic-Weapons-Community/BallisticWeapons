//=============================================================================
// A42SkrithPistol.
//
// Alien energy sidearm with recharging ammo, a rapid fire projectile fire for
// primary and a charged up beam for secondary. Primary heals vehicles and
// power nodes.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A2WSkrithLance extends BallisticWeapon;

var Actor GlowFX;

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (GlowFX != None)
		GlowFX.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	GlowFX = None;
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'A2WAmbientFX', DrawScale, self, 'Weapon');
	}
}

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

// AI Interface =====
function byte BestMode()	{	return 0;	}

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
	if (Vehicle(B.Enemy) != None)
		Result *= 2;
	Result += (Dist-1000) / 2000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_A42'
	BigIconCoords=(X1=80,Y1=24,X2=410,Y2=230)
	//MeleeFireClass=Class'BallisticProV55.A2WMeleeFire'
	bWT_RapidProj=True
	bWT_Energy=True
	ManualLines(0)=""
	ManualLines(1)=""
	ManualLines(2)=""
	SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Putaway')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipIn')
	MagAmmo=40
	bNonCocking=True
	bNoCrosshairInScope=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc10',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=160,G=44,R=89,A=137),Color2=(B=151,R=0,A=202),StartSize1=84,StartSize2=61)
    NDCrosshairInfo=(SpreadRatios=(X1=0.300000,Y1=0.300000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.700000
	SightOffset=(X=-24.000000,Y=-0.500000,Z=18.000000)
	MeleeFireClass=Class'BWBP_SWC_Pro.A2WMeleeFire'
	ParamsClasses(0)=Class'A2WWeaponParams'
	ParamsClasses(1)=Class'A2WWeaponParamsClassic'
	ParamsClasses(2)=Class'A2WWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SWC_Pro.A2WPrimaryFire'
	FireModeClass(1)=Class'BWBP_SWC_Pro.A2WSecondaryFire'
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.6000
	CurrentRating=0.600000
	bShowChargingBar=True
	Description=""
	Priority=16
	HudColor=(B=255,G=175,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=5
	PickupClass=Class'BWBP_SWC_Pro.A2WPickup'
	PlayerViewOffset=(X=3.000000,Y=10.000000,Z=-15.000000)
	AttachmentClass=Class'BWBP_SWC_Pro.A2WAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_A42'
	IconCoords=(X2=127,Y2=31)
	ItemName="[B] A2-W Skrith Lance"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_SWC_Anims.FPm_SkrithLance'
	DrawScale=0.300000
	SoundPitch=56
	SoundRadius=32.000000
	

}
