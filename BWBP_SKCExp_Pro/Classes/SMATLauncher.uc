//=============================================================================
// SMATAA Recoilless.
//
// Portable artillery system. Fires a high speed shaped charge that decimates
// armor. Instant hit is almost always a kill.
// Comes with the all-new suicide alt fire!
//
// by Sgt Kelly
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATLauncher extends BallisticWeapon;

var() BUtil.FullSound	HatchSound;

var   bool          bRunOffsetting;
var   bool          bRunOverride;
var	bool		  bInUse;
var() rotator       RunOffset;

var()     float Heat;
var()     float CoolRate;


simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		bRunOverride=true;
	}

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

simulated function bool PutDown()
{
	Super.PutDown();

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;
}

simulated event Tick (float DT)
{
	Heat = FMax(0, Heat - CoolRate*DT);
	super.Tick(DT);
}

simulated function WeaponTick(float DT)
{
	Super.WeaponTick(DT);

	if (FireMode[0].bIsFiring == true)
	{
		bInUse = true;
		SMATSecondaryFire(Firemode[1]).RailPower=0;
		Heat=0;
	}
	else
		bInUse = false;

}


// AI Interface =====
function byte BestMode()
{
	return 0;	
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
	if (Dist < 600)
		Result -= 0.6;
	else if (Dist > 4000)
		Result -= 0.3;
	else if (Dist > 20000)
		Result += (Dist-1000) / 2000;
	result += 0.2 - FRand()*0.4;
	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

/*
simulated event RenderOverlays (Canvas Canvas)
{

	if (!bScopeView)
	{
		Super.RenderOverlays(Canvas);
		if (SightFX != None)
			RenderSightFX(Canvas);
		return;
	}
	if (!bNoMeshInScope)
	{
		Super.RenderOverlays(Canvas);
		if (SightFX != None)
			RenderSightFX(Canvas);
	}
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	// Draw Scope View
    if (ScopeViewTex != None)
    	{
 	        Canvas.SetDrawColor(255,255,255);

        	Canvas.SetPos(Canvas.OrgX, Canvas.OrgY);
    		Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);

        	Canvas.SetPos((Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(ScopeViewTex, Canvas.SizeY, Canvas.SizeY, 0, 0, 1024, 1024);

        	Canvas.SetPos(Canvas.SizeX - (Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);
		
	}
}
*/
simulated function float ChargeBar()
{
    return FMin((Heat + SMATSecondaryFire(Firemode[1]).RailPower), 1);
}

defaultproperties
{
     RunOffset=(Pitch=-1500,Yaw=-4500)
     CoolRate=0.700000
     PlayerSpeedFactor=0.700000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     //BigIconMaterial=Texture'BWBP_SKC_TexExp.SMAA.BigIcon_SMAA'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Super=True
     SpecialInfo(0)=(Info="500.0;60.0;1.0;80.0;2.0;0.0;1.5")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Deploy',Volume=1.100000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Undeploy',Volume=1.100000)
     MagAmmo=1
     CockAnimRate=1.000000
     CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
     ReloadAnim="ReloadFancy"
     ReloadAnimRate=1.000000
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-BigOn',Volume=1.100000)
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Cycle',Volume=1.100000)
     bNeedCock=True
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
	 
	ScopeViewTex=Texture'BWBP_SKC_TexExp.SMAA.SMATAAScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	MinZoom=2.000000
	MaxZoom=8.000000
	ZoomStages=2
	ScopeXScale=1.333000
	ZoomInAnim="ZoomIn"
	ZoomOutAnim="ZoomOut"
	bNoCrosshairInScope=True
	SightOffset=(X=-6.000000,Y=-7.500000,Z=5.500000)
	 
     NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,Color1=(A=192),Color2=(A=192),StartSize1=89,StartSize2=13)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.250000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
     //CrosshairChaosFactor=0.750000
	 
	 
	ParamsClasses(0)=Class'SMATWeaponParamsArena'
	ParamsClasses(1)=Class'SMATWeaponParamsClassic' //todo: seeker stats
	ParamsClasses(2)=Class'SMATWeaponParamsRealistic' //todo: seeker stats
     FireModeClass(0)=Class'BWBP_SKCExp_Pro.SMATPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKCExp_Pro.SMATSecondaryFire'
     SelectAnimRate=0.600000
     PutDownAnimRate=0.800000
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     SightingTime=0.750000
     bShowChargingBar=True
     Description="FGM-16 Shoulder Mounted Anti-Tank Infantry Cannon||Manufacturer: UTC Defense Tech|Primary: Launch Rocket|Secondary: Detonate Rocket||The SMAT Infantry Cannon is a reloadable, single shot rocket launcher. The portable version of the Flak 54 AT system, the FGM-16 SMAT is housed in a reinforced casing with advanced recoil buffering technlogy and fires high-speed HEAT-DP shaped charges for maximum penetration and damage. Engineered after UTC generals noticed the Cryons' knack for overrunning and taking over their Flak 54 sites, this new portable cannon has been the bane of Cryon armored divisions ever since."
     Priority=164
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBP_SKCExp_Pro.SMATPickup'
     PlayerViewOffset=(X=20.000000,Y=15.000000,Z=-10.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBP_SKCExp_Pro.SMATAttachment'
     //IconMaterial=Texture'BWBP_SKC_TexExp.SMAA.SmallIcon_SMAA'
     IconCoords=(X2=127,Y2=31)
     ItemName="S.M.A.T. Infantry Cannon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_Smarf'
     DrawScale=0.400000
}
