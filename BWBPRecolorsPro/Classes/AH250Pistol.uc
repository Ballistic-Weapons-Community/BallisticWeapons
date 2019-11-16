//=============================================================================
// AH250 "Hawk".
// With compliments of team-spec*Azarael
//=============================================================================
class AH250Pistol extends BallisticWeapon;

var   Emitter		LaserDot;
var   bool			bLaserOn;

var() Sound			LaserOnSound;
var() Sound			LaserOffSound;

var(AH250Pistol) name		RDSBone;			// Bone to use for hiding Red Dot Sight
var(AH250Pistol) name		MuzzBone;			// Bone to use for hiding Compensator
var(AH250Pistol) name		LAMBone;			// Bone to use for hiding LAM
var(AH250Pistol) name		ScopeBone;			// Bone to use for hiding scope
var(AH208Pistol) name		BulletBone;			// Bone to use for hiding bullet

replication
{
	reliable if (Role < ROLE_Authority)
		ServerUpdateLaser;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	SetBoneScale (0, 0.0, RDSBone);
	SetBoneScale (5, 0.0, LAMBone);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		SelectAnim = 'OpenPullout';
		BringUpTime=default.BringUpTime;
		SetBoneScale(4,0.0,BulletBone);
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SelectAnim = 'Pullout';
		BringUpTime=default.BringUpTime;
	}
	
	Super.BringUp(PrevWeapon);
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}

simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		bLaserOn=false;
		KillLaserDot();
		return true;
	}
	return false;
}

simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal;
	local Rotator AimDir;
	local Actor Other;

	if (ClientState != WS_ReadyToFire || Firemode[1].bIsFiring || !bLaserOn/* || !bScopeView */|| ReloadState != RS_None || IsInState('DualAction')/* || Level.TimeSeconds - FireMode[0].NextFireTime < 0.2*/)
	{
		KillLaserDot();
		return;
	}

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	SpawnLaserDot(HitLocation);
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
}

function ServerUpdateLaser(bool bNewLaserOn)
{
	bUseNetAim = default.bUseNetAim || bScopeView || bNewLaserOn;
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Notify_HideBullet()
{
	if (MagAmmo < 2)
		SetBoneScale(4,0.0,BulletBone);
}

simulated function Notify_ShowBullet()
{
	SetBoneScale(4,1.0,BulletBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == 'OpenFire' || Anim == 'OpenSightFire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
			PutDownAnim = 'OpenPutaway';
			SelectAnim = 'OpenPullout';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			PutDownAnim = 'Putaway';
			SelectAnim = 'Pullout';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
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
// choose between regular or alt-fire
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
	AIRating=0.6
	CurrentRating=0.6
	ManualLines(0)="High-powered semi-automatic fire."
	ManualLines(1)="Engages the scope."
	ManualLines(2)="Effective at medium range."
     LaserOnSound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-LaserClick'
     LaserOffSound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-LaserClick'
     RDSBone="RedDotSight"
     MuzzBone="Compensator"
     LAMBone="LAM"
     ScopeBone="Scope"
     BulletBone="Bullet"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticRecolors4TexPro.Eagle.BigIcon_EagleAlt'
     BigIconCoords=(X1=48,Y1=0,X2=455,Y2=255)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=4
     bWT_Bullet=True
     SpecialInfo(0)=(Info="140.0;12.0;0.7;70.0;0.55;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=7
     CockSound=(Sound=Sound'PackageSounds4Pro.Eagle.Eagle-Cock',Volume=5.100000,Radius=48.000000)
     ClipHitSound=(Sound=Sound'PackageSounds4Pro.Eagle.Eagle-ClipHit',Volume=2.500000,Radius=48.000000)
     ClipOutSound=(Sound=Sound'PackageSounds4Pro.Eagle.Eagle-ClipOut',Volume=2.500000,Radius=48.000000)
     ClipInSound=(Sound=Sound'PackageSounds4Pro.Eagle.Eagle-ClipIn',Volume=2.500000,Radius=48.000000)
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Semi-Automatic")
     WeaponModes(1)=(ModeName="Mode-2",bUnavailable=True,Value=7.000000)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomType=ZT_Fixed
     ScopeViewTex=Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=40.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(X=70.000000,Y=-7.350000,Z=45.400002)
     SightDisplayFOV=40.000000
     GunLength=4.000000
     ChaosDeclineTime=0.450000
     ChaosAimSpread=1024
     RecoilXFactor=0.300000
     RecoilYFactor=0.400000
     RecoilMax=8192.000000
     RecoilDeclineDelay=1.000000
     FireModeClass(0)=Class'BWBPRecolorsPro.AH250PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.AH208MeleeFire'
     SelectAnimRate=2.000000
     PutDownAnimRate=1.600000
     PutDownTime=0.500000
     BringUpTime=0.600000
     SelectForce="SwitchToAssaultRifle"
     Description="AH-250 'Hawk' Assault Pistol||Manufacturer: Enravion Combat Solutions|Primary: Magnum Rounds|Secondary: Scope|The new AH-250 is an updated version of Enravion's AH-208 model. Equipped with a compensator for recoil, match-grade internals, and a precision scope, the AH-250 is a powerful and precise sidearm. Big game hunters have taken a liking to the gun and it can be seen in almost every outer planet action flick. Military adoption remains low due to the heavy recoil and impracticality of carrying around such a large sidearm."
     Priority=96
     HudColor=(B=200,G=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=13
     PickupClass=Class'BWBPRecolorsPro.AH250Pickup'
     PlayerViewOffset=(Y=19.500000,Z=-30.000000)
     BobDamping=1.200000
     AttachmentClass=Class'BWBPRecolorsPro.AH250Attachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.Eagle.SmallIcon_EagleAlt'
     IconCoords=(X2=127,Y2=31)
     ItemName="AH250 Assault Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.DEagle_FP'
     DrawScale=0.800000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-MainSilverEngraved'
     Skins(2)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-Misc'
     Skins(3)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeRed'
     Skins(4)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-FrontSilver'
     Skins(5)=Shader'BallisticRecolors4TexPro.Eagle.Eagle-SightDotGreen'
}
