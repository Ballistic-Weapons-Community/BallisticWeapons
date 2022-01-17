//=============================================================================
// D49Revolver.
//
// A powerful handgun that behaves like a revolver. Primary fire is a single
// powerful round, secondary fire both barrels at once, if possible.
// Info is stored for the state of each of the six chambers in order to ensure
// proper behaviour. This way the dry firing of empty chambers and altering the
// appearance of fired and missing shells is possible.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class D49Revolver extends BallisticHandgun;

// Sounds played at various stages of revolver reload
var() BUtil.FullSound	RevReloadSound;		// Catch release
var() BUtil.FullSound	RevOpenSound;		// Drum swing open
var() BUtil.FullSound	RevCloseSound;		// Drum shut
var() BUtil.FullSound	RevSpinSound;		// Spin drum
var() BUtil.FullSound	DryFireSound;		// Sound for trying to fire empty chamber

var() rotator			CylinderRotation;	// Rotation applied to drum
var	  bool				bRevCocked;			// Is it cocked? (for effect only)

// Type of fire
enum EBarrelMode
{
	BM_Neither,
	BM_Primary,
	BM_Secondary,
	BM_Both
};

// State of a shell (slot in drum)
enum EShellState
{
	SS_Loaded,
	SS_Fired,
	SS_Empty
};

// Info for a single shell in the drum
struct RevShell
{
	var() EShellState	ShellState;
	var() name			BulletName;
	var() name			ShellName;
	var() byte			NextShell;
};

var() RevShell			Shells[6];			// The six shells (ammo slots) and their info
var() byte				PrimaryShell;		// Shell under primary hammer
var() byte				SecondaryShell;		// Shell under secondary hammer

var   EBarrelMode		NetBarrelMode;
var   EBarrelMode		RealBarrelMode;
var   bool				bBarrelModeUsed;
var   byte				BMByte, OldBMByte;

var   Emitter			LaserDot;
var   bool				bLaserOn;

simulated function RevolverFired(EBarrelMode BarrelsFired)
{
	if (BarrelsFired == BM_Neither)
	{
	    class'BUtil'.static.PlayFullSound(self, DryFireSound);
		if (ClientState != WS_Hidden)
			SafePlayAnim('Cock', 1.0, 0.2);
	}
	if ((BarrelsFired == BM_Primary || BarrelsFired == BM_Both) && Shells[PrimaryShell].ShellState == SS_Loaded)
	{
		Shells[PrimaryShell].ShellState = SS_Fired;
		SetBoneScale(PrimaryShell, 0.0, Shells[PrimaryShell].BulletName);
	}
	if ((BarrelsFired >= BM_Secondary) && Shells[SecondaryShell].ShellState == SS_Loaded)
	{
		Shells[SecondaryShell].ShellState = SS_Fired;
		SetBoneScale(SecondaryShell, 0.0, Shells[SecondaryShell].BulletName);
	}
	CylinderRotation.Roll-=10922;
	SetBoneRotation('Revolver', CylinderRotation,0,1.0);

	PrimaryShell = Shells[PrimaryShell].NextShell;
	SecondaryShell = Shells[SecondaryShell].NextShell;

	bRevCocked = false;
	SetBoneRotation('Hammer', rot(0,0,0));

	if (class'BallisticReplicationInfo'.default.bNoReloading)
		NoReloadingCheckUo();
}

simulated function NoReloadingCheckUo()
{
	local int i;

	if (AmmoAmount(0) > 0)
	{
		for (i=0;i<6;i++)
			if (Shells[i].ShellState == SS_Loaded)
				return;

		for(i=0;i<6;i++)
			if (AmmoAmount(0)<=i)
			{
				Shells[i].ShellState = SS_Empty;
				SetBoneScale(i, 0.0, Shells[i].ShellName);
			}
			else
			{
				Shells[i].ShellState = SS_Loaded;
				SetBoneScale(i, 1.0, Shells[i].ShellName);
			}
		PrimaryShell = 0;
		SecondaryShell = 1;
	}
}

simulated function EBarrelMode GetBarrelMode()
{
	local byte b;

	if (Shells[SecondaryShell].ShellState == SS_Loaded)
		b = 2;
	if (Shells[PrimaryShell].ShellState == SS_Loaded)
		b ++;
	return EBarrelMode(b);
}

simulated function Notify_ClipOutOfSight()
{
	local int i, Empties;
	local vector Start;

	for (i=0;i<6;i++)
		if (Shells[i].ShellState == SS_Fired)
			Empties++;
	for(i=0;i<6;i++)
		if (AmmoAmount(0)+MagAmmo<=i)
		{
			Shells[i].ShellState = SS_Empty;
			SetBoneScale(i, 0.0, Shells[i].ShellName);
		}
		else
		{
			Shells[i].ShellState = SS_Loaded;
			SetBoneScale(i, 1.0, Shells[i].ShellName);
		}
	PrimaryShell = 0;
	SecondaryShell = 1;

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
		D49Attachment(ThirdPersonActor).RevolverEjectBrass(Empties);
}

simulated function Notify_D49Uncock() 
{	
	bRevCocked=false;	
}

simulated function Notify_D49Cock()
{	
	bRevCocked=true;

	class'BUtil'.static.PlayFullSound(self, CockSound);	
}

simulated function Notify_D49CockAfterPullout()
{	
	Notify_D49Cock();	
}

simulated function Notify_D49CockAfterFire()
{	
	Notify_D49Cock();	
}

simulated function Notify_D49StartReload()
{    
	class'BUtil'.static.PlayFullSound(self, RevReloadSound);	
}

simulated function Notify_D49SwingOpen()
{
    class'BUtil'.static.PlayFullSound(self, RevOpenSound);
	CylinderRotation.Roll = 0;
	SetBoneRotation('Revolver', CylinderRotation);
	if (ReloadState != RS_None && Shells[0].ShellState==SS_Empty)
	{
		ReloadState = RS_PreClipIn;
		SetAnimFrame(0.38, 0);
	}
}

simulated function Notify_D49SwingClosed()
{	
	class'BUtil'.static.PlayFullSound(self, RevCloseSound);	
}

simulated function Notify_D49Spin()
{	
	class'BUtil'.static.PlayFullSound(self, RevSpinSound);	
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
	local int i;

	if (PrimaryShell == SecondaryShell)
	{
		for(i=0;i<6;i++)
			if (MagAmmo<=i)
			{
				Shells[i].ShellState = SS_Empty;
				SetBoneScale(i, 0.0, Shells[i].ShellName);
			}
			else
			{
				Shells[i].ShellState = SS_Loaded;
				SetBoneScale(i, 1.0, Shells[i].ShellName);
			}
		PrimaryShell = 0;
		SecondaryShell = 1;
	}

	SetBoneRotation('Hammer', rot(0,0,0));
	Super.BringUp(PrevWeapon);

	if (IsSlave())
		HandgunGroup = Othergun.HandgunGroup;
	else
		HandgunGroup = default.HandgunGroup;
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

simulated function PlayIdle()
{
	if (!bRevCocked && ClientState != WS_Hidden && SightingState != SS_Active && MagAmmo > 0)
		SafePlayAnim('Cock', 1.0, 0.2);
	else
		super.PlayIdle();
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (bRevCocked && Anim == CockAnim)
	{
		SetBoneRotation('Hammer', rot(-5734,0,0));
		IdleTweenTime=0.0;
	}
	Super.AnimEnd(Channel);
	IdleTweenTime = default.IdleTweenTime;
}

simulated function CommonCockGun(optional byte Type)
{
	if (Role == ROLE_Authority)
		bServerReloading=false;
	ReloadState = RS_None;
	bNeedCock=false;
	if (!bRevCocked)
		SafePlayAnim('Cock', 1.0, 0.2);
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (IsInState('DualAction') || IsInState('PendingDualAction'))
		return false;
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_FullAuto" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_None")
		return true;
	if (Mode > 0 && OtherGun != None && D49Revolver(OtherGun) != None && FireCount < 1)
		return true;
	if (FireCount >= WeaponModes[CurrentWeaponMode].Value && (!IsSlave() || WeaponModes[CurrentWeaponMode].ModeID != "WM_SemiAuto" || Othergun.WeaponModes[Othergun.CurrentWeaponMode].ModeID != "WM_SemiAuto" || Othergun.HandgunGroup == HandgunGroup || LastFireTime > level.TimeSeconds-SingleHeldRate))
		return false;
	if (Othergun != None && CanAlternate(Mode) && Mode == 0)
	{
		if ( (!Othergun.HasAmmoLoaded(Mode) || LastFireTime <= OtherGun.LastFireTime) && FireCount < 1 && Othergun.FireCount < 1 )
			return true;
		return false;
	}
	return true;
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
	
	if (bLaserOn && !IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

exec simulated function WeaponSpecial(optional byte i)
{
	bLaserOn = !bLaserOn;
	
	if (!bLaserOn)
		KillLaserDot();
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.Skill > Rand(6))
	{
		if (AimComponent.GetChaos() < 0.1 || AimComponent.GetChaos() < 0.5 && VSize(B.Enemy.Location - Instigator.Location) < 500)
			return 1;
	}
	else if (FRand() > 0.75)
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 768, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}
// End AI Stuff =====

defaultproperties
{
	RevReloadSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Click',Volume=0.400000,Radius=48.000000,Pitch=1.000000)
	RevOpenSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Open',Volume=0.500000,Radius=48.000000,Pitch=1.000000)
	RevCloseSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Close',Volume=0.500000,Radius=48.000000,Pitch=1.000000)
	RevSpinSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Spin',Volume=0.500000,Radius=48.000000,Pitch=1.000000)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
	Shells(0)=(BulletName="Bullet1",ShellName="Shell1",NextShell=2)
	Shells(1)=(BulletName="Bullet4",ShellName="Shell4",NextShell=3)
	Shells(2)=(BulletName="Bullet2",ShellName="Shell2",NextShell=4)
	Shells(3)=(BulletName="Bullet5",ShellName="Shell5",NextShell=5)
	Shells(4)=(BulletName="Bullet3",ShellName="Shell3",NextShell=1)
	Shells(5)=(BulletName="Bullet6",ShellName="Shell6")
	bShouldDualInLoadout=False
	HandgunGroup=1
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_D49'
	SightFXClass=Class'BallisticProV55.D49SightLEDs'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Fires from a single barrel. Powerful, but short-ranged and has high recoil."
	ManualLines(1)="Fires both barrels at once. Twice as much recoil as the single fire with lower sustained damage output."
	ManualLines(2)="The D49 is very effective at close range. However, it suffers from a cripplingly long reload time. When dual wielded, both pistols will fire simultaneously, allowing the altfire to be used for an extremely powerful attack."
	SpecialInfo(0)=(Info="120.0;10.0;0.6;50.0;1.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	CockAnimRate=1.750000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Cock')
	ReloadAnimRate=1.750000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-ShellOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-ShellIn')
	ClipInFrame=0.650000
	bAltTriggerReload=True
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightOffset=(X=-30.000000,Y=-0.400000,Z=14.500000)
	ParamsClasses(0)=Class'D49WeaponParams'
	ParamsClasses(1)=Class'D49WeaponParamsClassic'
	FireModeClass(0)=Class'BallisticProV55.D49PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.D49SecondaryFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,Color1=(A=142),StartSize1=144,StartSize2=15)
    NDCrosshairInfo=(SpreadRatios=(X1=0.750000,Y1=0.750000,X2=0.300000,Y2=0.300000))
	
	PutDownAnimRate=1.250000
	PutDownTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.600000
	bSniping=True
	Description="Another fine weapon designed by the acclaimed 'Black & Wood' company, the D49 revolver is a true hand cannon. Based on weapons of old, the D49 was intended for non-military use, but rather for self defense and civilian purposes. The dual-barrel design has made it a favourite among it's users, capable of causing massive damage if used correctly, able to easily kill an armored Terran."
	DisplayFOV=50.000000
	Priority=22
	HudColor=(B=255,G=200,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=2
	PickupClass=Class'BallisticProV55.D49Pickup'
	PlayerViewOffset=(X=-2.000000,Y=13.000000,Z=-12.000000)
	PlayerViewPivot=(Pitch=512)
	AttachmentClass=Class'BallisticProV55.D49Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_D49'
	IconCoords=(X2=127,Y2=31)
	ItemName="D49 Revolver"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_D49'
	DrawScale=0.220000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BW_Core_WeaponTex.D49.D49-Shiney'
	Skins(2)=Shader'BW_Core_WeaponTex.D49.D49Shells-Shiney'
}
