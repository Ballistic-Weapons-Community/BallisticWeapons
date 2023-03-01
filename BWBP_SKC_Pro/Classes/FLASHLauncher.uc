//=============================================================================
// FLASHLauncher.
//
// Four barrels! Firey rockets! Watch them STREAk through the sky!
// These rockets melt the shiznit out of stuff.
// I love biscuits. Bizcitz.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FLASHLauncher extends BallisticWeapon;

#EXEC OBJ LOAD FILE=BWBP_SKC_Tex.utx

var   bool          bRunOffsetting;
var() rotator       RunOffset;

var() BUtil.FullSound	HatchSound;

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (class'BallisticReplicationInfo'.default.bNoReloading && AmmoAmount(0) > 1)
		SetBoneScale (0, 1.0, 'Rocket');

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

// Draw the scope view
simulated event RenderOverlays (Canvas C)
{
	local float ImageScaleRatio;

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	if (ZoomType == ZT_Irons)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
	}
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	// Draw Scope View
    if (ScopeViewTex != None)
    {
   		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		
		ImageScaleRatio = 1.3333333;

		C.ColorModulate.W = 1;

		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1024);

		C.SetPos((C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeY*ImageScaleRatio), C.SizeY, 0, 0, 1024, 1024);

		C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1024);
	}
}

simulated function PlayIdle()
{
	Super.PlayIdle();
	if (bPendingSightUp || SightingState != SS_None || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}


simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		if (MagAmmo < 2)
			SetBoneScale (0, 0.0, 'Rocket');
		return true;
	}

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;

	return false;
}

//Can't sight while run offsetting.
simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
	
	if ((ReloadState != RS_None && ReloadState != RS_Cocking) || bRunOffsetting || (Instigator.Controller.bRun == 0 && Instigator.Physics == PHYS_Walking) || (Instigator.Physics == PHYS_Falling && VSize(Instigator.Velocity) > Instigator.GroundSpeed * 1.5) || (SprintControl != None && SprintControl.bSprinting)) //should stop recoil issues where player takes momentum and knocked out of scope, also helps dodge
	{
		StopScopeView();
		return false;
	}
	return true;
}

simulated function bool CanUseSights()
{
	if ((Instigator.Physics == PHYS_Falling && VSize(Instigator.Velocity) > Instigator.GroundSpeed * 1.5) || bRunOffsetting || (SprintControl != None && SprintControl.bSprinting) || ClientState == WS_BringUp || ClientState == WS_PutDown || ReloadState != RS_None)
		return false;
	return true;
}

/*
simulated function WeaponTick(float DT)
{
	Super.WeaponTick(DT);

	if (Instigator.Base != none)
	{
		if (VSize(Instigator.velocity - Instigator.base.velocity) > 220)
		{
			if(!bRunOffsetting && !bScopeView)
			{
				SetNewAimOffset(CalcNewAimOffset(), OffsetAdjustTime);
				bRunOffsetting=true;  
			}
		}
		else if (bRunOffsetting)
		{
			SetNewAimOffset(default.AimOffset, OffsetAdjustTime);
			AimComponent.Reaim(0.05, AimAdjustTime);
			bRunOffsetting=false;
		}
	}
}
*/

// AI Interface =====
function byte BestMode()
{
	return 0;	
}

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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 1024, 1024); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

simulated function Notify_G5HatchOpen ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	class'BUtil'.static.PlayFullSound(self, HatchSound);
}
simulated function Notify_G5HideRocket ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticReplicationInfo'.default.bNoReloading || AmmoAmount(0) < 2)
		SetBoneScale (0, 0.0, 'Rocket');
}

defaultproperties
{

	RunOffset=(Pitch=-4000,Yaw=-2000)
	HatchSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Cliphit',Volume=0.700000,Pitch=1.000000)
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=5)
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.Flash.BigIcon_FLASH'
	BigIconCoords=(Y2=230)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Super=True
	ManualLines(0)="Fires a single AT40 rocket. Upon impact, explodes into flames, igniting nearby enemies and spreading pools of fire. AT40 rockets stacked upon each other will not deal more DPS from fire."
	ManualLines(1)="Dumps the entire load of remaining rockets at once. Overlapping fire patches will only deal damage once. Invariably fatal to any target directly struck."
	ManualLines(2)="As a rocket launcher, it has no recoil. Ineffective while jumping and at close range due to the risk of burning the user."
	SpecialInfo(0)=(Info="500.0;60.0;1.0;80.0;2.0;0.0;1.5")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-PullOut',Volume=2.200000)
	PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Putaway',Volume=2.200000)
	CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Flash.FLASH-PullOut',Volume=1.100000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Flash.FLASH-Insert',Volume=1.100000)
	bNonCocking=True
	ShovelIncrement=4
	WeaponModes(0)=(ModeName="Incendiary Rocket",ModeID="WM_FullAuto")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	ScopeViewTex=Texture'BW_Core_WeaponTex.G5.G5ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=90.000000
	bNoCrosshairInScope=True
	SightOffset=(Y=5.300000,Z=23.299999)
	ParamsClasses(0)=Class'FLASHWeaponParams'
	ParamsClasses(1)=Class'FLASHWeaponParamsClassic'
	ParamsClasses(2)=Class'FLASHWeaponParamsRealistic'
    ParamsClasses(3)=Class'FLASHWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.FLASHPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.FLASHSecondaryFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=0,R=255,A=192),Color2=(B=0,G=255,R=255,A=86),StartSize1=75,StartSize2=95)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.250000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.750000
	PutDownTime=1.400000
	BringUpTime=1.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.90000
	CurrentRating=0.90000
	Description="The G5 is an excellent tool against armored vehicles, but against infantry it loses some of its effectiveness. In response to field tester imput, the UTC is currently trying a new anti-infantry rocket launcher called the STREAK. This specialized rocket launcher uses a standard warhead filled with a mixture of napalm, tar and thermite, along with an igniting agent. This means that the STREAK can both take out infantry quickly with a direct blast and incinerate those caught in its wide area of effect. Another bonus of the STREAK is that the user can fire the rockets singlely to dispose of individuals or four at a time to wipe out larger groups. A scope can be used for larger ranges. Note: Make sure that the device is not used in tight areas, due to the large back blast of the weapon."
	Priority=164
	HudColor=(G=200,R=0)
	CenteredOffsetY=10.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BWBP_SKC_Pro.FLASHPickup'
	PlayerViewOffset=(X=10.000000,Z=-12.000000)
	BobDamping=1.800000
	AttachmentClass=Class'BWBP_SKC_Pro.FLASHAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.Flash.SmallIcon_FLASH'
	IconCoords=(X2=127,Y2=31)
	ItemName="AT40 STREAK"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_FLASH'
	DrawScale=0.400000
	Skins(0)=Texture'BWBP_SKC_Tex.Flash.FLASH-Scope'
	Skins(1)=Texture'BW_Core_WeaponTex.M353.M353_Ammo'
	Skins(2)=Texture'BWBP_SKC_Tex.Flash.FLASH-Main'
	Skins(3)=Texture'BWBP_SKC_Tex.Flash.FLASH-Lens'
	Skins(4)=Texture'BWBP_SKC_Tex.Flash.FLASH-Rocket'
	Skins(5)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
