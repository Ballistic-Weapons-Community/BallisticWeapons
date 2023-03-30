//=============================================================================
// leMatRevolver.
//
// The Wilson DB 41 revolver with 9 .41 chambers and 1 16 gauge shotgun barrel.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class leMatRevolver extends BallisticHandgun;

// Sounds played at various stages of revolver reload
var() Sound				ShellOutSound;
var() Sound				ShellInSound;

var() rotator			CylinderRotation;	// Rotation aplied to drum
var	  bool				bRevCocked;			// Is it cocked? (for effect only)

var() bool				bSecLoaded;			// Is shotgun loaded
var() name				SGLoadAnim;			// Anim to play for reloading shotgun

var   byte				ShellIndex;

var   bool				bDryHeld;

struct RevInfo
{
	var() name	Shellname;
	var() name	BulletName;
};
var() RevInfo	Shells[10];
var() byte		LoadedChambers;

const NumShells	= 9;

var   Emitter		LaserDot;
var   bool			bLaserOn;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerUpdateLaser;
}

simulated state PendingSGReload extends PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) LoadShotgun();	}
	simulated event AnimEnd(int Channel)
	{
		Othergun.RaiseHandGun();
		global.AnimEnd(Channel);
	}
}

simulated event PostNetBeginPlay()
{
	if (class'BallisticReplicationInfo'.default.bNoReloading)
		FireMode[1].FireRate=2.0;
	super.PostNetBeginPlay();
}

simulated function bool IsReloadingShotgun()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == SGLoadAnim)
 		return true;
	return false;
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (anim == SGLoadAnim)
	{
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else if (anim == CockAnim)
	{
		bRevCocked=true;
		IdleTweenTime=0.0;

		SetBoneRotation('Hammer', rot(-7472,0,0));
		PlayIdle();
	}
	else if (anim == 'UnCock')
	{
		bRevCocked=false;
		IdleTweenTime=0.0;

		SetBoneRotation('Hammer', rot(0,0,0));
		PlayIdle();
	}
	else if (Anim == FireMode[0].FireAnim || Anim == FireMode[1].FireAnim)
	{
		PlayIdle();
		bPreventReload=false;
	}
	else
	{
		IdleTweenTime=default.IdleTweenTime;

//		if (Anim == FireMode[1].FireAnim && !bSecLoaded)
//			LoadShotgun();
//		else
			Super.AnimEnded(Channel, anim, frame, rate);
	}
}

//simulated function Notify_leMatShotgunOpen()	{	PlaySound(RevOpenSound.Sound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_leMatShotgunShellOut(){	PlaySound(ShellOutSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_leMatShotgunShellIn()	{	PlaySound(ShellInSound, SLOT_Misc, 0.5, ,64);	bSecLoaded = true;	}
//simulated function Notify_leMatShotgunClose()	{	PlaySound(RevCloseSound.Sound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_leMatShellDown()
{
	local vector start;

	if (Role==ROLE_Authority && ThirdPersonActor != None) //Azarael
		leMatAttachment(ThirdPersonActor).RevolverEjectBrass(64);
	if (level.NetMode != NM_DedicatedServer)
	{
		Start = Instigator.Location + Instigator.EyePosition() + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), vect(5,10,-5));
		Spawn(class'Brass_leMatSG', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
	}
}

// Load in a grenade
simulated function LoadShotgun()
{
	if (Ammo[1].AmmoAmount < 1 || bSecLoaded)
		return;
	if (ReloadState == RS_None)
		PlayAnim(SGLoadAnim, 1.6, , 0);
}

simulated function bool CanReload ()
{
	if (bPreventReload || ReloadState != RS_None || IsInState('DualAction') || (OtherGun!=None && OtherGun.ReloadState != RS_None) || ( (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1) && (bSecLoaded || Ammo[1].AmmoAmount < 1) ))
		return false;
	return true;
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;
	local array<byte> Loadings[2];

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (bIsPendingHandGun || PendingHandGun!=None)
		return;
	if (Othergun != None)
	{
		if (IsinState('DualAction'))
			return;
	}
	GetAnimParams(channel, seq, frame, rate);
	if (seq == SGLoadAnim)
		return;
		
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (!bSecLoaded && Ammo[1].AmmoAmount > 0)
		Loadings[1] = 1;
	if (Loadings[0] == 0 && Loadings[1] == 0)
		return;

	if (i == 0)
	{
		if (Loadings[0] == 1)
			super.ServerStartReload();
		else
		{
			if (AmmoAmount(1) > 0 && !IsReloadingShotgun())
			{
				if (Othergun!=None)
					GotoState('PendingSGReload');
				else
					LoadShotgun();
				ClientStartReload(1);
			}
			return;
		}
	}
	else
	{
		if (Loadings[1] == 1)
		{
			if (AmmoAmount(1) > 0 && !IsReloadingShotgun())
			{
				if (Othergun!=None)
					GotoState('PendingSGReload');
				else
					LoadShotgun();
				ClientStartReload(1);
			}
			return;
		}
		
		else Super.ServerStartReload();
	}
}

simulated function bool HasMagAmmo(byte Mode)
{
	if (!bNoMag)
	{
		if ((Mode == 255 || Mode == 0) && BFireMode[0] != None && BFireMode[0].bUseWeaponMag && MagAmmo >= FireMode[0].AmmoPerFire)
			return true;
		if ((Mode == 255 || Mode == 1) && bSecLoaded)
			return true;
	}
	return false;
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1)
		{
			if (AmmoAmount(1) > 0 && !IsReloadingShotgun())
			{
				if (Othergun!=None)
					GotoState('PendingSGReload');
				else
					LoadShotgun();
			}
		}
		else
			CommonStartReload(i);
	}
}

simulated function EmptyFire (byte Mode)
{
	if (OtherGun == None)
		Super.EmptyFire(Mode);
	else if ((bNeedReload || !HasAmmoLoaded(Mode)) && ClientState == WS_ReadyToFire && FireCount < 1 && Othergun.FireCount < 1 && Instigator.IsLocallyControlled() &&
		(Othergun.bNeedReload || !Othergun.HasAmmoLoaded(Mode)))
		ServerStartReload(Mode);
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (bDryHeld)
		return false;

	if (IsInState('DualAction') || IsInState('PendingDualAction'))
		return false;
	if (CanSynch(Mode))
		return Super(BallisticWeapon).CheckWeaponMode(Mode);
	if (FireCount >= 1 && (!IsSlave() || Othergun.WeaponModes[Othergun.CurrentWeaponMode].ModeID != "WM_SemiAuto" || Othergun.HandgunGroup == HandgunGroup || LastFireTime > level.TimeSeconds-SingleHeldRate))
		return false;
	if (Othergun != None && CanAlternate(Mode))
	{
		if ( (!Othergun.HasAmmoLoaded(Mode) || Othergun.bNeedCock || Othergun.bNeedReload || LastFireTime <= OtherGun.LastFireTime) && FireCount < 1 && Othergun.FireCount < 1 )
			return true;
		return false;
	}
	return true;
}

simulated function TickFireCounter (float DT)
{
	if (!IsFiring() && (Instigator == None || Instigator.Controller == None || (Instigator.Controller.bFire == 0 && Instigator.Controller.bAltFire == 0)))
	{
		bDryHeld=false;
		FireCount = 0;
	}
}

simulated function ShotgunFired()
{
	if (!class'BallisticReplicationInfo'.default.bNoReloading)
		bSecLoaded = false;

	bRevCocked = false;
	SetBoneRotation('Hammer', rot(0,0,0));
}

simulated function RevolverFired()
{
	SetBoneScale(ShellIndex, 0.0, Shells[ShellIndex].BulletName);
	ShellIndex++;

	CylinderRotation.Roll+=7282;
	SetBoneRotation('Revolver', CylinderRotation,0,1.0);

	bRevCocked = false;
	SetBoneRotation('Hammer', rot(0,0,0));

//	if (class'BallisticReplicationInfo'.default.bNoReloading)
//		NoReloadingCheckUo();
}

simulated function Notify_ClipOutOfSight()
{
	local int i, Empties;
	local vector Start;

	Empties = LoadedChambers - MagAmmo;
	ShellIndex = 0;
	for(i=0;i<NumShells;i++)
		if (AmmoAmount(0)+MagAmmo<=i)
			SetBoneScale(i, 0.0, Shells[i].ShellName);
		else
			SetBoneScale(i, 1.0, Shells[i].ShellName);
	LoadedChambers = Min(NumShells, AmmoAmount(0)+MagAmmo);

	if (Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (class'BallisticMod'.default.bEjectBrass && Level.DetailMode > DM_Low)
		{
			Start = Instigator.Location + Instigator.EyePosition() + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), vect(5,1,-5));
			for(i=0;i<Empties;i++)
				Spawn(class'Brass_Magnum', self,, Start+VRand()*2, Instigator.GetViewRotation() + rot(8192,0,0));
		}
	}
	if (Role == ROLE_Authority && ThirdPersonActor!= None)
	{
		leMatAttachment(ThirdPersonActor).RevolverEjectBrass(Empties);
	}
}

simulated function Notify_CockStart()
{
	bRevCocked=true;
	BFireMode[0].bPlayedDryFire=false;
	BFireMode[1].bPlayedDryFire=false;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Notify_leMatUncock()
{
	bRevCocked=false;
}

simulated function Notify_leMatOpen()
{
	CylinderRotation.Roll = 0;
	SetBoneRotation('Revolver', CylinderRotation);
}

// Animation notify for when the clip is pulled out
simulated function Notify_ClipOut()
{
	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PreClipIn;
	PlayOwnedSound(ClipOutSound.Sound,ClipOutSound.Slot,ClipOutSound.Volume,ClipOutSound.bNoOverride,ClipOutSound.Radius,ClipOutSound.Pitch,ClipOutSound.bAtten);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	SetBoneRotation('Hammer', rot(0,0,0));
	Super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		bLaserOn=false;
		KillLaserDot();
		if (Instigator.IsLocallyControlled())
		{
			bRevCocked=false;
			SetBoneRotation('Hammer', rot(0,0,0));
		}
		return true;
	}
	return false;
}

simulated state Raising
{
Begin:
	OtherGun.SetBoneScale(8, 0.0, OtherGun.SupportHandBone);
	SafePlayAnim(SelectAnim, 1.5, 0.1);
	SetBoneRotation('Hammer', rot(0,0,0));
	FinishAnim();
	OtherGun.HandgunRaised(self);
	HandgunRaised(self);
	if (ClientState == WS_ReadyToFire)
		PlayIdle();
	GotoState('');
}
simulated state Lowering
{
Begin:
	SetBoneRotation('Hammer', rot(0,0,0));
	SafePlayAnim(PutDownAnim, 1.5, 0.1);
	FinishAnim();
	GotoState('Lowered');
}

/*simulated function PlayIdle()
{
	if (!bRevCocked && ClientState != WS_Hidden && SightingState != SS_Active && MagAmmo > 0)
		SafePlayAnim('Cock', 1.0, 0.2);
	else
		super.PlayIdle();
}*/

simulated function CommonCockGun(optional byte Type)
{
	if (Role == ROLE_Authority)
		bServerReloading=false;
	ReloadState = RS_None;
	bNeedCock=false;
	if (!bRevCocked)
		SafePlayAnim(CockAnim, 1.0, 0.2);
}

simulated function UpdateNetAim()
{
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
		LaserDot = Spawn(class'M806LaserDot',,,Loc);
}

simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal;
	local Rotator AimDir;
	local Actor Other;

	if (ClientState != WS_ReadyToFire || !bLaserOn/* || !bScopeView */|| ReloadState != RS_None || IsInState('DualAction') || Level.TimeSeconds - FireMode[0].NextFireTime < 0.2)
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

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

function ServerUpdateLaser(bool bNewLaserOn)
{
	bUseNetAim = default.bUseNetAim || bNewLaserOn;
}

exec simulated function WeaponSpecial(optional byte i)
{
	bLaserOn = !bLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	ServerUpdateLaser(bLaserOn);
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !bSecLoaded && AmmoAmount(1) > 0 && BotShouldReloadShotgun() && !IsReloadingShotgun())
		LoadShotgun();
}

// AI Interface =====
function bool BotShouldReloadShotgun ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!bSecLoaded)
	{
		if (IsReloadingShotgun())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadShotgun())
		{
			LoadShotgun();
			return false;
		}
	}
	return super.CanAttack(Other);
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist, Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (!bSecLoaded)
		return 0;
	if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	if (Dist > 1700)
		return 0;

	Result = FRand()*0.5;

	Result += 1 - Dist / 1700;

	if (Result > 0.5)
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 1536, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =====

defaultproperties
{
	bShouldDualInLoadout=False
	ShellOutSound=Sound'BW_Core_WeaponSound.leMat.LM-ShellOut'
	ShellInSound=Sound'BW_Core_WeaponSound.leMat.LM-ShellIn'
	bSecLoaded=True
	SGLoadAnim="Reload2"
	Shells(0)=(ShellName="Bullet1",BulletName="Slug1")
	Shells(1)=(ShellName="Bullet2",BulletName="Slug2")
	Shells(2)=(ShellName="Bullet3",BulletName="Slug3")
	Shells(3)=(ShellName="Bullet4",BulletName="Slug4")
	Shells(4)=(ShellName="Bullet5",BulletName="Slug5")
	Shells(5)=(ShellName="Bullet6",BulletName="Slug6")
	Shells(6)=(ShellName="Bullet7",BulletName="Slug7")
	Shells(7)=(ShellName="Bullet8",BulletName="Slug8")
	Shells(8)=(ShellName="Bullet9",BulletName="Slug9")
	Shells(9)=(ShellName="shell",BulletName="shell")
	LoadedChambers=9
	HandgunGroup=1
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BW_Core_WeaponTex.leMat.BigIcon_Wilson41DB'
	BigIconCoords=(X1=48,Y1=40,X2=459)
	
	bWT_Bullet=True
	ManualLines(0)="High damage bullet fire. Good range for a handgun and high ammo capacity."
	ManualLines(1)="Fires the single 16-gauge shotgun shell. Strong at very close range."
	ManualLines(2)="Effective at close range."
	SpecialInfo(0)=(Info="120.0;15.0;0.6;50.0;0.9;0.5;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Cock')
	ReloadAnimRate=1.300000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-BulletsOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-BulletsIn')
	ClipInFrame=0.650000
	bAltTriggerReload=True
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,Color1=(B=43,G=91,R=93,A=142),StartSize1=144,StartSize2=15)
    NDCrosshairInfo=(SpreadRatios=(X1=0.750000,Y1=0.750000,X2=0.300000,Y2=0.300000))
     
	bNoCrosshairInScope=True	
	SightOffset=(X=-15.000000,Y=-1.5,Z=15.30000)
	SightDisplayFOV=60.000000
	SightingTime=0.200000
	ParamsClasses(0)=Class'leMatWeaponParamsComp'
	ParamsClasses(1)=Class'leMatWeaponParamsClassic'
	ParamsClasses(2)=Class'leMatWeaponParamsRealistic'
    ParamsClasses(3)=Class'leMatWeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.leMatPrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.leMatSecondaryFire'
	PutDownTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.600000
	Description="An expensive remake of an exceptionally old weapon, the Wilson 41-DB was designed for collectors and procurers of rare items from the early days of human firearms. Manufactured by the Edwinson & Sons arms co, this firearm is of high quality, sparse quantity and very high price. Never used in any military or law enforcement organisation, the Wilson 'DiamondBack', is still capable of causing damage. With a 9 cylinder revolver and single 16 gauge shotgun chamber for desperate moments, this weapon can still stop many opponents."
	Priority=22
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=4
	PickupClass=Class'BallisticProV55.leMatPickup'
	PlayerViewOffset=(X=10.000000,Y=7.000000,Z=-13.000000)
	AttachmentClass=Class'BallisticProV55.leMatAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.leMat.SmallIcon_Wilson41DB'
	IconCoords=(X2=127,Y2=31)
	ItemName="Wilson 41"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_Wilson'
	DrawScale=0.300000
}
