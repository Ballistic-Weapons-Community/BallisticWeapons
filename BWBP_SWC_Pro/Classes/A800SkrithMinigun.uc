//=============================================================================
// XMV850Minigun.
//
// Almighty beast of a weapon, this spews out bullets at the unholy rate of
// sixty rounds per second. It comes with a variable fire rate, 20, 40 or 60
// rps and semi-auto fire.
//
// The minigun was really challenging because we had to develop some advanced
// new systems to allow for the demanded features. These included support for
// high fire rates(likely higher than PC's FPS) and a new turret system.
//
// The RoF is done by firing as fast as possible normally and firing multiple
// bullets at once when there aren't enough frames. To fire multiple shots in
// one frame an interpolater is added to figure out where the bullets mil most
// likely be aimed, based on current view rotation speed as well as all the
// aiming system vars... Hell of a thing, but... it works...
//
// For turrets, a versatile, general purpose turret system was developed and
// will be used for more than just this weapon in the future.
//
// One of the most difficult weapons of v2.0, this is at least a devastating
// piece of hardware being able to hoze down an area with bullets and leave no
// room for enemies to dodge. The deployed mode eliminates the restrictive
// recoil, but the user must be stationary.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A800SkrithMinigun extends BallisticWeapon;



var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;
var() Sound ChargeLoadSound;
var float NextTickTime;
var   Pawn				Target;
var Actor	Glow;				// Blue charge effect

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;
	reliable if(Role==ROLE_Authority)
		Target;
}

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	A800MinigunPrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	A800MinigunPrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
	A800MinigunSecondaryFire(FireMode[1]).TurnVelocity.Yaw = NewTVYaw;
	A800MinigunSecondaryFire(FireMode[1]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
}

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
}
simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
}

simulated event PostBeginPlay()
{
	super.PostbeginPlay();
	A800MinigunPrimaryFire(FireMode[0]).Minigun = self;
	A800MinigunSecondaryFire(FireMode[1]).Minigun = self;
}

simulated event WeaponTick (float DT)
{
	local rotator BT;
	local float BestAim, BestDist;
	local Vector Start;
	local Pawn NewTarget;

	BT.Roll = BarrelTurn;

	SetBoneRotation('BarrelArray', BT);

	super.WeaponTick(DT);

	if (Firemode[1].bIsFiring)
	{
		class'bUtil'.static.InitMuzzleFlash(Glow, class'A800MinigunChargeGlow', DrawScale, self, 'tip');
	}
	else
	{
		if (Glow != None)	Glow.Destroy();
	}

	if (Role < ROLE_Authority)
		return;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	NewTarget = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);
	if (NewTarget != None)
	{
		if (NewTarget != Target)
		{
			Target = NewTarget;
		}
	}
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (Glow != None)	Glow.Destroy();
		AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	if (Glow != None)	Glow.Destroy();
	AmbientSound = None;
	Super.Destroyed();
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if (FireMode[0].IsFiring() || FireMode[1].IsFiring())
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.2*DT, 0.4*DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.25*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		AmbientSound = BarrelSpinSound;
		SoundPitch = 32 + 96 * BarrelSpeed;
	}

	if (ThirdPersonActor != None)
		A800MinigunAttachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;

}

simulated function SetGlowSize(float Size)
{
	if (Glow != None)
		A800MinigunChargeGlow(Glow).SetSize(Size);
}

simulated function bool CheckWeaponMode (int Mode)
{
	//log("Mode is: "$Mode);
	//if (Mode > 0 && FireCount >= 1)
	//	return false;
	return super.CheckWeaponMode(Mode);
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;
	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;
	PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo-MagAmmo;
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo = default.MagAmmo;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
}


simulated function string GetHUDAmmoText(int Mode)
{
	return string(Ammo[Mode].AmmoAmount);
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire || FireMode[1] != None && MagAmmo >= FireMode[1].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire || Ammo[1] != None && FireMode[1] != None && Ammo[1].AmmoAmount >= FireMode[1].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

simulated function float ChargeBar()
{
	if (FireMode[1].bIsFiring == true)
		return FMin(FireMode[1].HoldTime/4, 1);
	else
		return BarrelSpeed / DesiredSpeed;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy != None) )
		return 0;

	if (Instigator.bIsCrouched && B.Squad.IsDefending(B) && fRand() > 0.6)
		return 1;

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
	if (Dist > 1000)
		Result -= (Dist-1000) / 3000;
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.2;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.4;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====
//     PlayerViewOffset=(X=11.000000,Y=8.000000,Z=-14.000000)

defaultproperties
{
     BarrelSpinSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelSpinLoop'
     BarrelStopSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStop'
     BarrelStartSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStart'
	 ChargeLoadSound=Sound'BWBP_SWC_Sounds.A800.A800-Load2'
     PlayerSpeedFactor=0.780000
     PlayerJumpFactor=0.750000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBP_SWC_Tex.SkrithHyperBlaster.BigIcon_HyperBlaster'
     bWT_Machinegun=True
     bWT_Super=True
     SpecialInfo(0)=(Info="480.0;60.0;2.0;100.0;0.5;0.5;0.5")
     BringUpSound=(Sound=Sound'BWBP_SWC_Sounds.A800.A800-Pullout',Volume=1.500000)
     PutDownSound=(Sound=Sound'BWBP_SWC_Sounds.A800.A800-Putaway',Volume=1.500000)
     MagAmmo=90
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipIn')
     ClipInFrame=0.650000
     bNonCocking=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="1200 RPM",bUnavailable=True,ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="Rapid Fire")
     WeaponModes(3)=(ModeName="3600 RPM",bUnavailable=True,ModeID="WM_FullAuto")
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc10',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=160,G=80,R=88,A=137),Color2=(B=151,G=150,R=0,A=202),StartSize1=84,StartSize2=61)
     DesiredSpeed=0.33
     SightOffset=(X=-15.000000,Y=-25.000000,Z=6.500000)
	 SightingTime=0.600000
	 ReloadAnimRate=1.3
	 MinZoom=2.000000
     MaxZoom=8.000000
	 FireModeClass(0)=Class'BWBP_SWC_Pro.A800MinigunPrimaryFire'
     FireModeClass(1)=Class'BWBP_SWC_Pro.A800MinigunSecondaryFire'
     ScopeViewTex=Texture'BWBP_SWC_Tex.SkrithHyperBlaster.HyperBlaster-Scope'
     ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	 SelectAnimRate=1.20000
     PutDownTime=1.200000
     BringUpTime=1.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     Description="One of the more devastating skrith tools of destruction, the Y11 is their answer to the XMV-850 Minigun. Able to spit out a deluge of plasma bolts at a rapid pace of fire, the Y11 can cut down anyone who isn't prepared; such was the case when only 3 skrith warriors were able to mow down a small battalion of UTC troops in the dense forests. Without their armor, the soldiers fell quickly, leaving only a few scarred survivors to tell the tale; calling them 'Warthogs' due to the voracious firepower and speed. Newer models of the Y11 have the capabilities to fire HV Plasma Rockets, making it even more potent against personnel."
     Priority=78
     CustomCrossHairColor=(A=219)
     CustomCrossHairScale=1.008803
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBP_SWC_Pro.A800MinigunPickup'
     PlayerViewOffset=(X=25.000000,Y=25.000000,Z=-15.000000)
     //PlayerViewOffset=(X=30.000000,Y=20.000000,Z=-16.000000)
	 PlayerViewPivot=(Roll=-256)
     BobDamping=2.200000
     AttachmentClass=Class'BWBP_SWC_Pro.A800MinigunAttachment'
     IconMaterial=Texture'BWBP_SWC_Tex.SkrithHyperBlaster.SmallIcon_HyperBlaster'
     IconCoords=(X2=127,Y2=31)
     ItemName="A800 Skrith Hyperblaster"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClasses(0)=Class'A800SkrithMinigunWeaponParamsArena'
	 ParamsClasses(1)=Class'A800SkrithMinigunWeaponParamsClassic'
	 ParamsClasses(2)=Class'A800SkrithMinigunWeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_SWC_Anims.FPm_SkrithHyperBlaster'
     DrawScale=0.400000
     SoundRadius=128.000000
	 bShowChargingBar=True
}
