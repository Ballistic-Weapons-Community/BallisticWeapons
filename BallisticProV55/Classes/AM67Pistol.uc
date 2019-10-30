//=============================================================================
// AM67Pistol
//
// A powerful sidearm designed for close combat. The .50 bulelts are very
// deadly up, but weaken at range. Secondary is a blinging flash attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67Pistol extends BallisticHandgun;

//simulated function bool SlaveCanUseMode(int Mode) {return (Mode == 0) || Othergun.class==class || ;}
simulated function bool MasterCanSendMode(int Mode) {return (Mode == 0) || Othergun.class==class || level.TimeSeconds <= FireMode[1].NextFireTime;}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return True;
	return super.CanAlternate(Mode);
}

simulated function bool CanSynch(byte Mode)
{
	return false;
	if (Mode != 0)
		return false;
	return super.CanSynch(Mode);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (bNeedCock)
		BringUpTime = 0.4;
	super.BringUp(PrevWeapon);
	BringUpTime = default.BringUpTime;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function float ChargeBar()
{
	if (level.TimeSeconds >= FireMode[1].NextFireTime)
		return 1;
	return 1 - (FireMode[1].NextFireTime - level.TimeSeconds) / FireMode[1].FireRate;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	if (level.TimeSeconds >= FireMode[1].NextFireTime && FRand() > 0.6)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	if (IsSlave())
		return 0;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = AIRating;
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	else if (Dist < 500 && B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.2;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
	 AimDisplacementDurationMult=0.33
     bShouldDualInLoadout=False
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_AM67'
     SightFXClass=Class'BallisticProV55.AM67SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="High-powered bullet fire, with good range. The AM67 has the option of fully automatic and burst fire. Recoil is, however, high."
     ManualLines(1)="Engages the integrated flash device. Blinds enemies for a short duration. Enemies closer both to the player and to the point of aim will be blinded for longer."
     ManualLines(2)="Effective at close to medium range."
     SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=14
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.AM67.AM67-Cock')
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipIn')
     ClipInFrame=0.650000
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-12.000000,Z=6.500000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     SightAimFactor=0.150000
     JumpChaos=0.200000
     AimAdjustTime=0.450000
     AimSpread=16
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=384
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=8192.000000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.500000
     FireModeClass(0)=Class'BallisticProV55.AM67PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.AM67SecondaryFire'
     PutDownTime=0.600000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     bShowChargingBar=True
     Description="Another of Enravion's fine creations, the AM67 Assault Pistol was designed for close quarters combat against Cryon and Skrith warriors.|Initially constructed before the second war, Enravion produced the AM67, primarily for anti-Cryon operations, but it later proved to perform well in close-quarters combat when terran forces were ambushed by the stealthy Skrith warriors."
     Priority=24
     HudColor=(B=25,G=150,R=50)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     GroupOffset=6
     PickupClass=Class'BallisticProV55.AM67Pickup'
     PlayerViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
     AttachmentClass=Class'BallisticProV55.AM67Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_AM67'
     IconCoords=(X2=127,Y2=31)
     ItemName="AM67 Assault Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticProAnims.AM67Pistol'
     DrawScale=0.200000
}
