//=============================================================================
// R9RangerRifle.
//
// A simple, semi-auto, unscoped, accuracte, medium to high power, long range
// rifle. Secondary fire is iron sights. Has a decent Mag. Not too great at
// mobile combat. Suffers from long-gun.
// A handy when you need a quick to opertate rifle for fighting at medium to
// long range. (Works pretty well close-up too!)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class R9RangerRifle extends BallisticWeapon;

#exec OBJ LOAD File=R9A_tex.utx

exec simulated function SwitchWeaponMode (optional byte ModeNum)	
{
	if (ClientState == WS_ReadyToFire && ReloadState == RS_None) 
	{
		if (ModeNum == 0)
			ServerSwitchWeaponMode(255);
		else ServerSwitchWeaponMode(ModeNum-1);
	}
}

// Cycle through the various weapon modes
function ServerSwitchWeaponMode (byte NewMode)
{
	local int m;
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
		
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
		
	if (NewMode == CurrentWeaponMode)
		return;
	
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}
	if (!WeaponModes[NewMode].bUnavailable)
	{
		CurrentWeaponMode = NewMode;
		NetUpdateTime = Level.TimeSeconds - 1;
	}
	
	if (bNotifyModeSwitch)
	{
		if (Instigator != None && !Instigator.IsLocallyControlled())
		{
			BFireMode[0].SwitchWeaponMode(CurrentWeaponMode);
			BFireMode[1].SwitchWeaponMode(CurrentWeaponMode);
		}
		ClientSwitchWeaponModes(CurrentWeaponMode);
	}
	
	R9Attachment(ThirdPersonActor).CurrentTracerMode = CurrentWeaponMode;

	if (Instigator.IsLocallyControlled())
		default.LastWeaponMode = CurrentWeaponMode;
		
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
	CommonStartReload(0);	//Server animation
	ClientStartReload(0);	//Client animation
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_FullAuto" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_None")
		return true;
	if ((Mode == 0 && FireCount >= WeaponModes[CurrentWeaponMode].Value) || (Mode == 1 && FireCount >= 2))
		return false;
	return true;
}

//===========================================================================
// ManageHeatInteraction
//
// Called from primary fire when hitting a target. Objects don't like having iterators used within them
// and may crash servers otherwise.
//===========================================================================
function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local R9HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'R9HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'R9HeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
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
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
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
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=5)
     BigIconMaterial=Texture'BallisticTextures3.ui.BigIcon_R9'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Semi-automatic rifle fire. High damage, long range, high penetration and moderate recoil. Sustained damage output is modest."
     ManualLines(1)="As primary, except fires subsonic rounds. Loses damage over range but has lower recoil, lesser flash and is quieter."
     ManualLines(2)="As a long-ranged weapon lacking a scope, it has a reasonably quick aiming time. Does not use tracer rounds. Cumbersome to use in close combat."
     SpecialInfo(0)=(Info="240.0;25.0;0.5;50.0;1.0;0.2;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway')
     MagAmmo=15
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Cock')
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipIn')
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Regular")
     WeaponModes(1)=(ModeName="Freeze",ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(2)=(ModeName="Laser",ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(3)=(ModeName="Phosphorous",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(4)=(ModeName="Poison",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     FullZoomFOV=60.000000
     bNoCrosshairInScope=True
     SightZoomFactor=20
     SightPivot=(Pitch=50)
     SightOffset=(X=25.000000,Y=0.030000,Z=8.000000)
     SightDisplayFOV=40.000000
     SightingTime=0.400000
     GunLength=80.000000
     CrouchAimFactor=0.750000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=0.600000
     ChaosSpeedThreshold=3000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.070000),(InVal=0.500000,OutVal=0.040000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.300000
     RecoilYFactor=0.200000
     RecoilMinRandFactor=0.500000
     RecoilDeclineDelay=0.350000
     FireModeClass(0)=Class'BallisticProV55.R9PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.R9SecondaryFire'
     SelectAnimRate=1.100000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="Outstanding reliability and durability in the field are what characterise one of Black & Wood's legendary rifles. Though not widely used by most military forces, the R9 is renowned for its near indestructable design, and superb reliability. Those who use the weapon, mostly snipers, hunters, and specialised squads, swear by it's accuracy and dependability. Often used without fancy features or burdening devices such as optical scopes and similar attachements, the R9 is a true legend with it's users."
     Priority=33
     HudColor=(G=175)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=3
     PickupClass=Class'BallisticProV55.R9Pickup'
     PlayerViewOffset=(Y=9.500000,Z=-11.000000)
     AttachmentClass=Class'BallisticProV55.R9Attachment'
     IconMaterial=Texture'BallisticTextures3.ui.SmallIcon_R9'
     IconCoords=(X2=127,Y2=31)
     ItemName="R9 Ranger Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticProAnims.USSR'
     DrawScale=0.500000
     Skins(4)=Shader'R9A_tex.R9_body_SH1'
}
