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
// piece of hardware being able to hose down an area with bullets and leave no
// room for enemies to dodge. The deployed mode eliminates the restrictive
// recoil, but the user must be stationary.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV850Minigun extends BallisticWeapon;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx

var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;
var() Sound DeploySound;
var() Sound UndeploySound;

var float		RotationSpeeds[3];

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;
}

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	XMV850MinigunPrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	XMV850MinigunPrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (Instigator!=None && Instigator.IsLocallyControlled())
		Shader'BW_Core_WeaponTex.XMV850.XMV850_Barrels_SD'.FallbackMaterial = Texture'BW_Core_WeaponTex.XMV850.XMV850_Barrels';
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		XMV850MinigunPrimaryFire(FireMode[0]).bRequireSpool=true;
	}
}

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}
simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local string s;

	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(255,128,128);
	s = "XMV850Minigun: TraceCount: "$XMV850MinigunPrimaryFire(FireMode[0]).TraceCount$ ", FireRate: "$1.0/FireMode[0].FireRate$"TurnVelocity: "$XMV850MinigunPrimaryFire(FireMode[0]).TurnVelocity.Pitch$", "$XMV850MinigunPrimaryFire(FireMode[0]).TurnVelocity.Yaw;
	Canvas.DrawText(s);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	XMV850MinigunPrimaryFire(FireMode[0]).Minigun = self;
}

// takes more time to reach higher speeds
// this is unrealistic because miniguns are electric with extremely powerful motors and provide constant torque,
// but do you really want the xmv to spin up to 3600rpm instantly? I for one don't
simulated function float GetRampUpSpeed()
{
	local float mult;
	
	if (class'BallisticReplicationInfo'.static.IsArena())
	{
		mult = 1 - (BarrelSpeed / RotationSpeeds[2]);
		
		return 0.075f + (0.5f * Square(mult) * (1 + 0.25*int(bBerserk)));
	}
	else
	{
		return 0.4f;
	}
	
	/*
	if (BarrelSpeed < RotationSpeeds[0])
		return 0.5f;
		
	mult = ((BarrelSpeed - RotationSpeeds[0]) / (RotationSpeeds[2] - RotationSpeeds[0])); 
	

	return 0.5f - (0.47f * mult * mult); 
	*/
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;

	SetBoneRotation('Barrels', BT);

	DesiredSpeed = RotationSpeeds[CurrentWeaponMode];

	super.WeaponTick(DT);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		Instigator.AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if (FireMode[0].IsFiring() && !bServerReloading)
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.35*DT, GetRampUpSpeed() *DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.5*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			Instigator.AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		Instigator.AmbientSound = BarrelSpinSound;
		Instigator.SoundPitch = 32 + 96 * BarrelSpeed;
	}

	if (ThirdPersonActor != None)
		XMV850MinigunAttachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode > 0 && FireCount >= 1)
		return false;
	return super.CheckWeaponMode(Mode);
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}
	if (!WeaponModes[NewMode].bUnavailable)
		CurrentWeaponMode = NewMode;
}

function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local int Forward;

	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	// BallisticPro specific: Can be deployed upon sandbags providing that sandbag is not hosting
	// another weapon already. When deployed upon sandbags, the weapon is automatically deployed 
	// to the centre of the bags.
	
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'XMV850Turret'.default.CollisionHeight + 15;
	}
	
	else
	{
		HitLoc.Z += class'XMV850Turret'.default.CollisionHeight - 9;
	}
	
	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'XMV850Turret', None,, HitLoc, CompressedEq);
	
    if (Turret != None)
    {
    	if (Sandbag(T) != None)
			Sandbag(T).AttachedWeapon = Turret;
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    
    else
		log("Notify_Deploy: Could not spawn turret for XMV850 Minigun");
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
		{
			GenerateLayout(BallisticWeaponPickup(Pickup).LayoutIndex);
			GenerateCamo(BallisticWeaponPickup(Pickup).CamoIndex);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		}
		else
		{
			GenerateLayout(255);
			GenerateCamo(255);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
            MagAmmo = MagAmmo + (int(!bNonCocking) *  int(bMagPlusOne) * int(!bNeedCock));
		}
    }
 	
   	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;
	    

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

simulated function string GetHUDAmmoText(int Mode)
{
	return string(Ammo[Mode].AmmoAmount);
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

simulated function float ChargeBar()
{
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
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 1;	}
// End AI Stuff =====

defaultproperties
{

	BarrelSpinSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelSpinLoop'
	BarrelStopSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStop'
	BarrelStartSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStart'
	DeploySound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Deploy'
	UndeploySound=Sound'BW_Core_WeaponSound.XMV-850.XMV-UnDeploy'


	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_XMV850'
	BigIconCoords=(Y2=255)
	
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Spins up the barrel. Once spun up to speed, unleashes a hail of bullets. Incredible fire rate and moderate damage. Sustained damage output is extremely high. Large ammo reserves due to the attached backpack mean the weapon can fire continuously for long periods."
	ManualLines(1)="Deploys the minigun upon the ground or a nearby wall. May also be deployed upon sandbags. Whilst deployed, becomes perfectly accurate, loses its iron sights and gains a reduction in recoil. Locational damage (damage which can target an area on the body) taken from the front is significantly reduced."
	ManualLines(2)="The XMV-850 is one of the heaviest weapons in the game and halves your movement speed when equipped.||Effective at medium range. Extremely effective from ambush and deployed mode."
	SpecialInfo(0)=(Info="480.0;60.0;2.0;100.0;0.5;0.5;0.5")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway')

	CockSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Cock')
	ReloadAnimRate=1.300000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-ClipIn')
	ClipInFrame=0.650000

	WeaponModes(0)=(ModeName="1200 RPM",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="2400 RPM",ModeID="WM_FullAuto",bUnavailable=True)
	WeaponModes(2)=(ModeName="3600 RPM",ModeID="WM_FullAuto",bUnavailable=True)

	RotationSpeeds(0)=0.33 // 1200 RPM - 150 revolutions per minute x 6 shots
	RotationSpeeds(1)=0.66 // 2400 RPM - 300 revolutions per minute x 6 shots
	RotationSpeeds(2)=1.00  // 3600 RPM - 600 revolutions per minute x 6 shots

	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=119),Color2=(B=220,R=0,A=206),StartSize1=101)
    NDCrosshairInfo=(SpreadRatios=(Y2=0.500000))
    
	CurrentWeaponMode=0
	bShowChargingBar=True
	SightPivot=(Pitch=700,Roll=2048)
	SightOffset=(X=4.000000,Z=15.000000)
	ParamsClasses(0)=Class'XMV850WeaponParamsComp'
	ParamsClasses(1)=Class'XMV850WeaponParamsClassic' //Todo: state code to support fire while spinning
	ParamsClasses(2)=Class'XMV850WeaponParamsRealistic' //Todo: state code to support fire while spinning
    ParamsClasses(3)=Class'XMV850WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.XMV850MinigunPrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.XMV850MinigunSecondaryFire'
	SelectAnimRate=0.750000
	PutDownTime=0.800000
	BringUpTime=2.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	Description="Anti-Krao weapons are a common thing these days, with many being designed specifically to kill as many as possible in a short time. However, no infantry weapon does this better, than the XMV-850. A weapon to be feared, this monster is capable of firing as many as sixty 5.56mm rounds a second. While most miniguns are capable of firing ten or twelve thousand rounds-per-minute, the XMV-850 has been designed for infantry use, as a fire-rate that high, would generate far to much recoil. To make the weapon usable in a defensive position, it can be deployed to stabilise it, and allows the user to become that much more effective. To help with recoil, and allow the soldier to use the weapon more efectively when not deployed, the fire-rate can be limited to a lower RPM. Though not terribly accurate or damaging, the fact that it can pour out bullets at such a rate, means that it will be difficult to miss the target."
	Priority=47
	HudColor=(B=200,G=200,R=0)
	CustomCrossHairColor=(A=219)
	CustomCrossHairScale=1.008803
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	GroupOffset=2
	PickupClass=Class'BallisticProV55.XMV850Pickup'
	PlayerViewOffset=(X=-2.500000,Y=4.000000,Z=-10.000000)
	AttachmentClass=Class'BallisticProV55.XMV850MinigunAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_XMV850'
	IconCoords=(X2=127,Y2=31)
	ItemName="XMV-850 Minigun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_XMV850'
	DrawScale=0.300000
	SoundRadius=128.000000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BW_Core_WeaponTex.XMV850.XMV850_Main'
	Skins(2)=Shader'BW_Core_WeaponTex.XMV850.XMV850_Barrels_SD'
}
