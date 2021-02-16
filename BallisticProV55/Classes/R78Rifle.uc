//=============================================================================
// R78Rifle.
//
// Powerful, accurate semi automatic rifle with good power and reasonable
// reload time, but low clip capacity. Secondary fire makes it the weapon it is
// by providing a powerful scope. Holding secondary zooms in further initially,
// but the player can still use Prev and Next weapon to adjust.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R78Rifle extends BallisticWeapon;

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && Type != 1)
		TemporaryScopeDown(0.5);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.9;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.9;	}
// End AI Stuff =====

defaultproperties
{

     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_R78'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Bolt-action sniper rifle fire with explosive rounds. High damage, long range, slow fire rate and deals damage to targets near the struck target."
     ManualLines(1)="Engages the scope."
     ManualLines(2)="Does not use tracer rounds. Effective at long range and against clustered enemies."
     SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	PutDownTime=0.5
     CockAnim="CockQuick"
     //CockSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-Cock')
	 CockSound=(Sound=Sound'BWBP_SKC_Sounds.R78NS.R78NS-Cock')
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Automatic")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0

     ScopeXScale=1.333000
     ZoomInAnim="ZoomIn"
     ScopeViewTex=Texture'BW_Core_WeaponTex.R78.RifleScopeView'
     ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=20.000000
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
     MinZoom=4.000000
     MaxZoom=16.000000
     ZoomStages=2
     GunLength=80.000000
     ParamsClasses(0)=Class'R78WeaponParams'
     FireModeClass(0)=Class'BallisticProV55.R78PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     bSniping=True
     Description="Originally taken from the design of a bird hunting rifle, the R78 'Raven', is a favourite among military snipers and commando corps. Used to a great extent by the expert marksmen of the New European Army, the Raven, is extremely reliable and capable of incredible damage in a single shot. The added long distance sniping scope makes the R78 one of the most deadly weapons. Of course, the gun is only as good as the soldier using it, with a low clip capacity, long reload times and it's terrible ineffectiveness in close quarters combat."
     DisplayFOV=55.000000
     Priority=33
     HudColor=(B=50,G=50,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=2
     PickupClass=Class'BallisticProV55.R78Pickup'
     PlayerViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
     AttachmentClass=Class'BallisticProV55.R78Attachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_R78'
     IconCoords=(X2=127,Y2=31)
     ItemName="R78A1 Sniper Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_R78'
     DrawScale=0.450000
}
