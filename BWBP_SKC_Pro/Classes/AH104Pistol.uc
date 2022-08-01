//=============================================================================
// AH104Pistol.
//
// A powerful sidearm designed for long range combat. The .600 bulelts are very
// powerful. Secondary is a laser attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AH104Pistol extends BallisticWeapon;

var Name 			ReloadAltAnim;
var() int			AltMagAmmo;
var BUtil.FullSound DrumInSound, DrumOutSound;

var   bool			bLaserOn;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

var bool		bCamoChoosen;		// Set and store camo.
var bool		bFiresound1;
var bool		bFiresound2;

var   RX22ASpray		Flame;

replication
{
	reliable if (Role == ROLE_Authority)
		AltMagAmmo,bLaserOn;
}

//===========================================================================
// Generic code for weapons which have multiple magazines.
//===========================================================================
function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (AltMagAmmo < default.AltMagAmmo && Ammo[1].AmmoAmount > 0)
		Loadings[1] = 1;
	if (Loadings[0] == 0 && Loadings[1] == 0)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	
	if (i == 1)
		m = 0;
	else m = 1;
	
	if (Loadings[i] == 1)
	{
		ClientStartReload(i);
		CommonStartReload(i);
	}
	
	else if (Loadings[m] == 1)
	{
		ClientStartReload(m);
		CommonStartReload(m);
	}
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1)
			CommonStartReload(1);
		else
			CommonStartReload(0);
	}
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_PreClipOut;
		PlayReloadAlt();
	}
	else
	{
		ReloadState = RS_StartShovel;
		PlayReload();
	}

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function PlayReloadAlt()
{
	SafePlayAnim(ReloadAltAnim, 1, , 0, "RELOAD");
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet1');
	SetBoneScale (2, 1.0, 'Bullet2');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 2)
		SetBoneScale (1, 0.0, 'Bullet2');
	if (MagAmmo < 1)
		SetBoneScale (2, 0.0, 'Bullet1');
}

simulated function Notify_DrumOut()	
{	
	PlayOwnedSound(DrumOutSound.Sound,DrumOutSound.Slot,DrumOutSound.Volume,DrumOutSound.bNoOverride,DrumOutSound.Radius,DrumOutSound.Pitch,DrumOutSound.bAtten);
	ReloadState = RS_PreClipIn;
}

simulated function Notify_DrumIn()          
{   
	local int AmmoNeeded;
	
	PlayOwnedSound(DrumInSound.Sound,DrumInSound.Slot,DrumInSound.Volume,DrumInSound.bNoOverride,DrumInSound.Radius,DrumInSound.Pitch,DrumInSound.bAtten);    
	ReloadState = RS_PostClipIn; 
	
	if (Level.NetMode != NM_Client)
	{
		AmmoNeeded = default.AltMagAmmo - AltMagAmmo;
		if (AmmoNeeded > Ammo[1].AmmoAmount)
			AltMagAmmo +=Ammo[1].AmmoAmount;
		else
			AltMagAmmo = default.AltMagAmmo;   
		Ammo[1].UseAmmo (AmmoNeeded, True);
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	local float f;

	if (!bCamoChoosen)
	{
		f = FRand();
		if (f > 0.90) { bFiresound1=True;}
		else if (f > 0.50){bFiresound2=True;}
		else{bFiresound2=False;bFiresound1=False;}
		bCamoChoosen=true;
	}
	Super.BringUp(PrevWeapon);

	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'BallisticProV55.LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if ( ThirdPersonActor != None )
		AH104Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		ReloadAnim = 'ReloadEmpty';
	}
	else
	{
		ReloadAnim = 'Reload';
	}
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function OnLaserSwitched()
{
	if (bLaserOn)
		ApplyLaserAim();
	else
		AimComponent.Recalculate();
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bLaserOn)
		ApplyLaserAim();
}

simulated function ApplyLaserAim()
{
	AimComponent.AimAdjustTime *= 1.5;
	AimComponent.AimSpread.Max *= 0.65;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		OnLaserSwitched();

		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	if (ThirdPersonActor != None)
		AH104Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	OnLaserSwitched();
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,3.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,3.7,,32);
	}
	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
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
		LaserDot = Spawn(class'BWBP_SKC_Pro.AH104LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			AH104Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	if (Flame != None)
		Flame.bHidden=false;
	Super.Destroyed();
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays(Canvas C)
{
	super.RenderOverlays(C);
	if (Flame != None)
	{
		Flame.SetLocation(ConvertFOVs(GetBoneCoords('tip2').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32));
		Flame.SetRotation(rotator(Vector(GetAimPivot() + GetRecoilPivot()) >> GetPlayerAim()));
		C.DrawActor(Flame, false, false, Instigator.Controller.FovAngle);
	}
	
	if (!IsInState('Lowered'))
		DrawLaserSight(C);
}


simulated function UpdateNetAim()
{
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'Fire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			ReloadAnim = 'ReloadEmpty';
		}
		else
		{
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
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

// Change some properties when using sights...
/*simulated function SetScopeBehavior()
{
	AdjustControlProperties();
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	if (bScopeView)
	{
		ViewRecoilFactor = 0.3;
		ChaosDeclineTime *= 1.5;
	}
}*/

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}


function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====


simulated function float ChargeBar()
{
	return float(AltMagAmmo)/float(default.AltMagAmmo);
}

defaultproperties
{
	DrumInSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameMagIn',Volume=1.100000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	DrumOutSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameMagOut',Volume=1.100000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	ReloadAltAnim="ReloadAlt"
	LaserOnSound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOn'
	LaserOffSound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOff'
	PlayerSpeedFactor=1.000000
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BWBP_SKC_Tex.AH104.BigIcon_AH104'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	SpecialInfo(0)=(Info="120.0;15.0;0.8;70.0;0.75;0.5;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	MagAmmo=7
	AltMagAmmo=50
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Cock',Volume=0.800000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipHit')
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-ClipOut',Volume=0.800000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-ClipIn',Volume=0.800000)
	ClipInFrame=0.650000
	bCockOnEmpty=True
	WeaponModes(1)=(ModeName="Laser-Auto",bUnavailable=True,Value=7.000000)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	SightOffset=(X=-30.000000,Y=-0.800000,Z=23.000000)
	SightDisplayFOV=40.000000
	GunLength=4.000000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.R78InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=192),StartSize1=61,StartSize2=62)
    NDCrosshairInfo=(SpreadRatios=(X1=0.750000,Y1=0.750000,X2=0.300000,Y2=0.300000))
	ParamsClasses(0)=Class'AH104PistolWeaponParamsArena'
	ParamsClasses(1)=Class'AH104PistolWeaponParamsClassic'
	ParamsClasses(2)=Class'AH104PistolWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SKC_Pro.AH104PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.AH104SecondaryFire'
	PutDownTime=1.000000
	BringUpTime=1.300000
	SelectForce="SwitchToAssaultRifle"
	Description="AH-104 'Hellfire' Handcannon||Manufacturer: Enravion Combat Solutions|Primary: HEAP Rounds|Secondary: Laser Sight||'The handcannon of the future.' Those were the words of Enravion as they publically released this modified version of the AM67. Nicknamed the 'Pounder' for its potent .600 explosive armor piercing rounds; the AH104 can legally carry the name handcannon. Its immense stopping power and anti-armor capability make this weapon a favorite of military leaders and personnel across the worlds. The full-steel AH104 is known to be absurdly heavy (12 lbs unloaded) in order to compensate for the power of its large rounds and cannot be dual wielded. It also comes equipped with a laser targeting system in place of the usual AM67 flash bulb."
	Priority=162
	bShowChargingBar=True
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=12
	PickupClass=Class'BWBP_SKC_Pro.AH104Pickup'
	PlayerViewOffset=(X=10.000000,Y=10.000000,Z=-18.000000)
	BobDamping=2.300000
	AttachmentClass=Class'BWBP_SKC_Pro.AH104Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.AH104.SmallIcon_AH104'
	IconCoords=(X2=127,Y2=31)
	ItemName="AH104 Handcannon"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AH104'
	DrawScale=0.400000
}
