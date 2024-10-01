//=============================================================================
// M353Machinegun.
//
// The "Guardian" M353 Machinegun has an extremely high fire rate, high ammo
// capacity and decent damage, but is extremely inacurate and can quickly fight
// its way from its owner's control. Secondary allows the user to mount the
// weapon on the ground by crouching.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TridentMachinegun extends BallisticMachinegun
	transient
	HideDropDown
	CacheExempt;

var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;

var float		RotationSpeeds[3];

var() BUtil.FullSound	LeverUpSound;	// Sound to play when Lever opens
var() BUtil.FullSound	LeverDownSound;	// Sound to play when Lever closes

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;
}

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	TridentPrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	TridentPrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
	
	TridentSecondaryFire(FireMode[1]).TurnVelocity.Yaw = NewTVYaw;
	TridentSecondaryFire(FireMode[1]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	TridentPrimaryFire(FireMode[0]).TridentWeapon = self;
	TridentSecondaryFire(FireMode[1]).TridentWeapon = self;
}

simulated function float GetRampUpSpeed()
{
	local float mult;
	
	mult = 1 - (BarrelSpeed / RotationSpeeds[2]);
	
	return 0.075f + (0.07f * mult * mult);	//change 0.07f here to increase/decrease rotation acceleration. higher values = faster accel
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

	if ((FireMode[0].IsFiring() || FireMode[1].IsFiring()) && !bServerReloading)
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
		TridentAttachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
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

simulated function float ChargeBar()
{
     return BarrelSpeed / DesiredSpeed;
}

// Run when Lever is Up
simulated function Notify_LeverUp ()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(LeverUpSound.Sound,LeverUpSound.Slot,LeverUpSound.Volume,LeverUpSound.bNoOverride,LeverUpSound.Radius,LeverUpSound.Pitch,LeverUpSound.bAtten);
	else
	    class'BUtil'.static.PlayFullSound(self, LeverUpSound);
}

// Run when Lever is Down
simulated function Notify_LeverDown ()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(LeverDownSound.Sound,LeverDownSound.Slot,LeverDownSound.Volume,LeverDownSound.bNoOverride,LeverDownSound.Radius,LeverDownSound.Pitch,LeverDownSound.bAtten);
	else
	    class'BUtil'.static.PlayFullSound(self, LeverDownSound);
}

simulated function PlayReload()
{
	PlayAnim('ReloadHold', ReloadAnimRate, , 0.25);
}

simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHold', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function PositionSights ()
{
	super.PositionSights();
	if (SightingPhase <= 0.0)
		SetBoneRotation('TopHandle', rot(0,0,0));
	else if (SightingPhase >= 1.0 )
		SetBoneRotation('TopHandle', rot(0,0,-8192));
	else
		SetBoneRotation('TopHandle', class'BUtil'.static.RSmerp(SightingPhase, rot(0,0,0), rot(0,0,-8192)));
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

/*function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
	local SandbagLayer Bags;
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
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
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
		
	if(BallisticTurret(Instigator) == None && Instigator.IsHumanControlled() && class'SandbagLayer'.static.ShouldGiveBags(Instigator))
    {
        Bags = Spawn(class'SandbagLayer',,,Instigator.Location);
		
		if (Instigator.Weapon == None)
			Instigator.Weapon = Self;
			
        if( Bags != None )
            Bags.GiveTo(Instigator);
    }
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}*/

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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 1024, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
	BarrelSpinSound=Sound'IndoorAmbience.Machinery14'
    BarrelStopSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStop'
    BarrelStartSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStart'
	bShowChargingBar=True
	BeltBones(0)="Bullet2"
	LeverUpSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-LeverUp')
	LeverDownSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-LeverDown')
	BoxOnSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-BoxOn')
	BoxOffSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-BoxOff')
	FlapUpSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-FlapUp')
	FlapDownSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-FlapDown')
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BWBP_CC_Tex.CruMg.BigIcon_CruML'
	BigIconCoords=(Y1=50,Y2=240)
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)=""
	ManualLines(1)=""
	ManualLines(2)=""
	SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-Cock')
	ReloadAnim="ReloadStart"
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-BulletsOff')
	ClipInSound=(Sound=Sound'BWBP_CC_Sounds.CruMG.MG-BulletsOn')
	ClipInFrame=0.650000
	bCockOnEmpty=True
	WeaponModes(0)=(ModeName="800 RPM",ModeID="WM_FullAuto")
    WeaponModes(1)=(ModeName="1200 RPM",ModeID="WM_FullAuto",bUnavailable=True)
    WeaponModes(2)=(ModeName="1800 RPM",ModeID="WM_FullAuto",bUnavailable=True)
	
	// originally XMV is 1200 RPM on its base firemode, so its rotation speed is 0.33. (3600 RPM = 1.00 rot speed)
	// so divide desired RPM by 3600 to get rot speed
	RotationSpeeds(0)=0.23 // 829 RPM
	RotationSpeeds(1)=0.34 // 1224 RPM
	RotationSpeeds(2)=0.51 // 1836 RPM
	
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	ParamsClasses(0)=Class'TridentMachinegunWeaponParamsArena'
	ParamsClasses(1)=Class'TridentMachinegunWeaponParamsClassic'
	ParamsClasses(2)=Class'TridentMachinegunWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_APC_Pro.TridentPrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.TridentSecondaryFire'
	PutDownTime=0.600000
	BringUpTime=1.100000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.7500000
	CurrentRating=0.7500000
	Description=""
	Priority=43
	HudColor=(B=150,R=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	PickupClass=Class'BWBP_APC_Pro.TridentPickup'
	SightOffset=(X=5.000000,Y=-0.900000,Z=19.30000)
	PlayerViewOffset=(X=-5.000000,Y=10.000000,Z=-16.000000)
	AttachmentClass=Class'BWBP_APC_Pro.TridentAttachment'
	IconMaterial=Texture'BWBP_CC_Tex.CruMg.SmallIcon_CruML'
	IconCoords=(X2=127,Y2=31)
	ItemName="[B] Trident Splitter Machinegun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_CC_Anim.CruMG_FPm'
	DrawScale=0.350000
}
