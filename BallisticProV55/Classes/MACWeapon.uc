//=============================================================================
// MACWeapon.
//
// HAMR (Heavy Anti-Materi�l Rifle). A man-portable artilery cannon. Fires a
// powerful explosive shell. Can be deployed into turret form to deal with
// recoil problems
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACWeapon extends BallisticWeapon;

var() Texture RulerTex, PointerTex;

var() Sound DeploySound;
var() Sound UndeploySound;
var() name	Shells[3];

var   bool	bPendingShellLoad;

struct BeaconInfo
{
	var MACBeacon			Beacon;
	var MACBeaconTrail		Trail;
	var MACExplodeSphere	Sphere;
	var rotator		Aim;
	var vector		Start;
	var vector		Hit;
	var float		StartTime;
	var float		HitTime;
	var float		Range;
};
var   array<BeaconInfo> Beacons;

var   float	NextBeaconTime;

exec simulated function WeaponSpecial(optional byte i)
{
	if (level.TimeSeconds >= NextBeaconTime && MACPrimaryFire(FireMode[0]) != None)
	{
		NextBeaconTime = level.TimeSeconds + 1;
		MACPrimaryFire(FireMode[0]).LaunchBeacon();
	}
}

simulated function BeaconHit(MACBeacon Beacon, vector HitLocation, MACExplodeSphere Sphere)
{
	local int i;
	for (i=0;i<Beacons.length;i++)
	{
		if (Beacons[i].Beacon == Beacon)
		{
			Beacons[i].Hit		= HitLocation;
			Beacons[i].HitTime	= level.TimeSeconds;
			Beacons[i].Range	= VSize(HitLocation - Beacons[i].Start);
			Beacons[i].Sphere	= Sphere;
			if (Sphere != None)
				Sphere.bHidden = !bScopeView;
			return;
		}
	}
}

simulated function AddBeacon(MACBeacon Beacon, vector Start, rotator Aim, MACBeaconTrail Trail)
{
	local int i;
	for (i=0;i<Beacons.length;i++)
	{
		if (Beacons[i].Beacon == None && Beacons[i].Sphere == None && Beacons[i].HitTime < level.TimeSeconds - 8)
		{
			Beacons[i].Beacon		= Beacon;
			Beacons[i].Trail		= Trail;
			Beacons[i].Aim			= Aim;
			Beacons[i].Start		= Start;
			Beacons[i].StartTime	= level.TimeSeconds;
			if (Trail != None)
				Trail.bHidden = !bScopeView;
			return;
		}
	}
	Beacons.length = i+1;
	Beacons[i].Beacon		= Beacon;
	Beacons[i].Trail		= Trail;
	Beacons[i].Aim			= Aim;
	Beacons[i].Start		= Start;
	Beacons[i].StartTime	= level.TimeSeconds;
	if (Trail != None)
		Trail.bHidden = !bScopeView;
}

simulated event WeaponTick(float DT)
{
	local int i;

	super.WeaponTick(DT);
	for (i=0;i<Beacons.length;i++)
	{
		if (Beacons[i].Trail != None)
			Beacons[i].Trail.bHidden = !bScopeView;
		if (Beacons[i].Sphere != None)
			Beacons[i].Sphere.bHidden = !bScopeView;
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	if (MagAmmo < 1)
		bPendingShellLoad=true;
}

simulated function PlayReload()
{
	local int i;

	SetBoneScale(2, 1.0, Shells[2]);

	for (i=0;i<2;i++)
		if ((bPendingShellLoad && MagAmmo <= i) || (!bPendingShellLoad && MagAmmo-1 <= i))
			SetBoneScale(i, 0.0, Shells[i]);
		else
			SetBoneScale(i, 1.0, Shells[i]);
	super.PlayReload();
}
simulated function PlayShovelLoop()
{
	local int i;
	for (i=0;i<2;i++)
		if ((bPendingShellLoad && MagAmmo <= i) || (!bPendingShellLoad && MagAmmo-1 <= i))
			SetBoneScale(i, 0.0, Shells[i]);
		else
			SetBoneScale(i, 1.0, Shells[i]);
	SafePlayAnim(ReloadAnim, ReloadAnimRate, 0.0, , "RELOAD");
}
simulated function PlayShovelEnd()
{
	local int i;
	for (i=0;i<3;i++)
		if ((bPendingShellLoad && MagAmmo <= i) || (!bPendingShellLoad && MagAmmo-1 <= i))
			SetBoneScale(i, 0.0, Shells[i]);
		else
			SetBoneScale(i, 1.0, Shells[i]);
	SafePlayAnim(EndShovelAnim, EndShovelAnimRate, 0.0, ,"RELOAD");
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	local int i;
	if (bPendingShellLoad && Anim == EndShovelAnim)
	{
		super.AnimEnded(Channel, anim, frame, rate);
		Notify_HAMRShellCycle();
		FireMode[0].NextFireTime = level.TimeSeconds + 1.0;
	}
	else if (Anim == 'Refire')
	{
		for (i=0;i<3;i++)
			if (MagAmmo-1 <= i)
				SetBoneScale(i, 0.0, Shells[i]);

		IdleTweenTime=0.0;
		PlayIdle();
		IdleTweenTime=default.IdleTweenTime;
	}
	else
		super.AnimEnded(Channel, anim, frame, rate);
}

simulated function Notify_HAMRShellCycle()
{
	if (MagAmmo > 0)
	{
		SafePlayAnim('Refire', 1.0, 0.1);
		bPendingShellLoad=false;
	}
	else
		bPendingShellLoad=true;
}

function PlayFiring()
{
	local int i;
	for (i=0;i<3;i++)
		if (MagAmmo-BFireMode[0].ConsumedLoad <= i)
			SetBoneScale(i, 0.0, Shells[i]);
		else
			SetBoneScale(i, 1.0, Shells[i]);
}

simulated function Notify_Deploy ()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local float Forward;

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();
	if (Role < ROLE_Authority || Instigator.HeadVolume.bWaterVolume)
	{
		PlayIdle();
		return;
	}
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
		{
			PlayIdle();
			return;
		}
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && T.bWorldGeometry && HitNorm.Z >= 0.7 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
		{
			PlayIdle();
			return;
		}
	}

	HitLoc.Z += class'MACTurret'.default.CollisionHeight - 9;

	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq = Instigator.Rotation;
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'MACTurret', None,, HitLoc, CompressedEq);
    if (Turret != None)
    {
		Turret.InitDeployedTurretFor(self);

		PlaySound(DeploySound, Slot_Interact, 0.7,,64,1,true);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for HAMR Cannon", 'Warning');
}

simulated event RenderOverlays (Canvas C)
{
	Super.RenderOverlays(C);
	if (bScopeView)
	{
		//C.ColorModulate.W = 1.0;
		DrawHAMRScope(C);
	}
}

simulated event DrawHAMRScope (Canvas C)
{
	local float YS, RefPoint, ScaleFactor, VP, XL, YL;
	local string s;
	local int i;
	local vector V;

	ScaleFactor = C.SizeX/1024.0;
	VP = Instigator.GetViewRotation().Pitch;
	if (VP > 32768)
		VP -= 65546;
	RefPoint = 1280 - VP * 0.0625;
	YS = (float(C.SizeY)/C.SizeX)*512;

	C.SetPos(C.OrgX, C.OrgY);
	C.SetDrawColor(255,0,0,255);
	C.DrawTile(RulerTex, C.SizeX, C.SizeY, 0, RefPoint - YS, 1024, YS*2);

	C.SetPos(C.OrgX, C.OrgY+C.SizeY/2 - ScaleFactor*24);
	C.SetDrawColor(255,255,0,255);
	C.DrawTile(PointerTex, 51*ScaleFactor, 48*ScaleFactor, 0, 0, 34, 32);

	C.SetPos(C.ClipX-ScaleFactor*51, C.OrgY+C.SizeY/2 - ScaleFactor*24);
	C.DrawTile(PointerTex, 51*ScaleFactor, 48*ScaleFactor, 30, 0, 34, 32);

	C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
	VP *= 0.0054931640625;
	C.TextSize(VP, XL, YL);
	C.SetPos(C.OrgX+ScaleFactor*4, C.OrgY+C.SizeY/2 - YL - ScaleFactor*20);
	C.DrawText(VP);

	C.Font = GetFontSizeIndex(C, -4 + int(2 * class'HUD'.default.HudScale));
	C.SetDrawColor(255,192,0,255);
	for (i=0;i<Beacons.length;i++)
	{
		if (Beacons[i].Sphere != None)
		{
			V = C.WorldToScreen(Beacons[i].Hit);
			s = Beacons[i].Range/44.0 $ "m";
			C.TextSize(s, XL, YL);
			C.SetPos(V.X-XL/2, V.Y-YL);
			C.DrawText(s);

			s = Beacons[i].HitTime - Beacons[i].StartTime $ "s";
			C.TextSize(s, XL, YL);
			C.SetPos(V.X-XL/2, V.Y);
			C.DrawText(s);

			VP = Beacons[i].Aim.Pitch;
			if (VP > 32768)
				VP -= 65546;
			VP *= 0.0054931640625;
			s = VP $ "�";
			C.TextSize(s, XL, YL);
			C.SetPos(V.X-XL/2, V.Y+YL);
			C.DrawText(s);
		}
	}
	
	//C.ColorModulate.W = C.default.ColorModulate.W;
}

simulated function Destroyed()
{
	local int i;

	for (i=0;i<Beacons.length;i++)
	{
		if (Beacons[i].Trail != None)
			Beacons[i].Trail.Destroy();
		if (Beacons[i].Sphere != None)
			Beacons[i].Sphere.Destroy();
	}
	Super.Destroyed();
}

/*
// Relocate the weapon according to sight view.
simulated function PositionSights ()
{
}
*/

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

function AttachToPawn(Pawn P)
{
	local name BoneName;

	Instigator = P;
	if ( ThirdPersonActor == None )
	{
		ThirdPersonActor = Spawn(AttachmentClass,Owner);
		InventoryAttachment(ThirdPersonActor).InitFor(self);
	}
	else
		ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	BoneName = 'rshoulder';
	if ( BoneName == '' )
	{
		ThirdPersonActor.SetLocation(P.Location);
		ThirdPersonActor.SetBase(P);
	}
	else
		P.AttachToBone(ThirdPersonActor,BoneName);
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
	
	if (Dist < 2048) // too close
		return 0.4;
		
	// hamr doesn't need a height check - it just blows through cover anyway
	
	return Rating;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

defaultproperties
{
	RulerTex=Texture'BW_Core_WeaponTex.Artillery.Lines'
	PointerTex=Texture'BW_Core_WeaponTex.Artillery.Pointer'
	DeploySound=Sound'BW_Core_WeaponSound.Artillery.Art-Deploy'
	UndeploySound=Sound'BW_Core_WeaponSound.Artillery.Art-Undeploy'
	Shells(0)="Shell1"
	Shells(1)="Shell2"
	Shells(2)="Shell3"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=2)
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Artillery.BigIcon_Artillery'
	BigIconCoords=(Y1=24,Y2=225)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Super=True
	ManualLines(0)="Launches an artillery shell with massive damage output. These shells move extremely quickly and gain damage and blast radius over range. Recoil is extreme. This weapon damages the user if fired from an unstable position (i.e. in the air)."
	ManualLines(1)="Deploys the HAMR. Unlike machineguns, it cannot be deployed upon sandbags, only upon the ground or a wall. While deployed, recoil is reduced, fire rate improves and the user takes less damage from any frontal locational-hit attack."
	ManualLines(2)="While viewing through the HAMR's optical system, the Weapon Function key will cause the targeting system to simulate the trajectory, travel time and impact radius of a shell fired from the HAMR at the current aim rotation. This can be used to finely target a shot at long range.||The HAMR is heavy and will badly restrict the player's movement while it is active.||Effective at medium to long range. Extremely effective against groups and with height advantage."
	SpecialInfo(0)=(Info="300.0;40.0;1.0;90.0;0.8;0.0;1.2")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Putaway')
	ReloadAnim="ReloadLoop"
	ReloadAnimRate=2.250000
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-ShellIn')
	bNonCocking=True
	bCanSkipReload=True
	bShovelLoad=True
	StartShovelAnim="ReloadStart"
	EndShovelAnim="ReloadEnd"
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc5',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=185),Color2=(A=198),StartSize1=95,StartSize2=46)
	NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.250000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
	CurrentWeaponMode=0
	MinZoom=2
	MaxZoom=16
	ZoomStages=3
	ScopeXScale=1.333000
	ScopeViewTex=Texture'BW_Core_WeaponTex.Artillery.Artillery-ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=10.000000
	bNoCrosshairInScope=True
	SightPivot=(Pitch=450)
	SightOffset=(X=-5.000000,Y=-15.000000,Z=10.000000)
	SightDisplayFOV=70.000000
	GunLength=96.000000
	ParamsClasses(0)=Class'MACWeaponParams'
	ParamsClasses(1)=Class'MACWeaponParamsClassic'
	ParamsClasses(2)=Class'MACWeaponParamsRealistic'
	FireModeClass(0)=Class'BallisticProV55.MACPrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.MACSecondaryFire'
	SelectAnimRate=0.600000
	PutDownAnimRate=0.800000
	PutDownTime=0.800000
	BringUpTime=1.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.90000
	CurrentRating=0.90000
	Description="This heavy construct was designed for infantry use, to combat vehicles and large Cryon troops. After several failed designs and attempts, resulting in weapons which were far too heavy and cumbersome for infantry use, the HAMR was built. This new weapon could be carried by infantry, and could be deployed with the sturdy legs mounted underneath the weapon. The weapon can still be fired when mounted on the soldier's shoulder, but it generates extreme recoil, and leaves the users aim in complete disarray. The optical system mounted on the weapon, allows the user to viem from a remote screen attached to the soldiers helmet. Besides a zooming scope, the optical system also features an angle indicator and range finder, allowing the user to pitch the weapon as necessary depending on an inputed distance."
	DisplayFOV=70.000000
	Priority=44
	HudColor=(G=200,R=225)
	CenteredOffsetY=10.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	GroupOffset=1
	PickupClass=Class'BallisticProV55.MACPickup'
	PlayerViewOffset=(X=3.000000,Y=12.000000,Z=-3.000000)
	AttachmentClass=Class'BallisticProV55.MACAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Artillery.SmallIcon_Artillery'
	IconCoords=(X2=127,Y2=31)
	ItemName="Heavy Anti-Materiel Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_HAMR'
	DrawScale=0.300000
	Skins(0)=Texture'BW_Core_WeaponTex.Artillery.Artillery_Main'
	Skins(1)=Texture'BW_Core_WeaponTex.Artillery.Artillery_Glass'
}
