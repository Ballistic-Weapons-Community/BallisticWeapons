//=============================================================================
// FC01SmartGun
//
// Advanced weapon that can use multiple methods to lock onto targets.
// Once the gun has a lock, the primary fire projectiles will attempt to seek.
//
// by SK
//=============================================================================
class FC01SmartGun extends BallisticWeapon;

#exec OBJ LOAD File=BWBP_OP_Tex.utx

var   Pawn				Target;
var   float				TargetTime;
var() float				LockOnTime;
var	  bool				bLockedOn, bLockedOld;
var() BUtil.FullSound	LockOnSound;
var() BUtil.FullSound	LockOffSound;
var() BUtil.IntRange	LaserAimSpread;
var() float         TargetUpdateRate;      //How often targeting view updates targeting brackets
var   vector        TargetLoc;             //Used for the targeting view for choppy targeting brackets

var   bool			bLaserOn, bLaserOld;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

var() name			PhotonLoadAnim, PhotonLoadEmptyAnim;	// Anim for reloading photon ammo

var() Sound			PhotonMagOutSound;		// Sounds for Photon reloading
var() Sound			PhotonMagSlideInSound;	//
var() Sound			PhotonMagHitSound;		//
var() Sound			PhotonMagCockSound;		//

var   bool			bSilenced;				// Silencer on. Silenced
var() name			SilencerBone;			// Bone to use for hiding silencer
var() name			SilencerOnAnim;			// Think hard about this one...
var() name			SilencerOffAnim;		//
var() sound			SilencerOnSound;		// Silencer stuck on sound
var() sound			SilencerOffSound;		//
var() sound			SilencerOnTurnSound;	// Silencer screw on sound
var() sound			SilencerOffTurnSound;	//

var rotator ScopeSightPivot;
var vector ScopeSightOffset;

var rotator IronSightPivot;
var vector IronSightOffset;

var Name 			ReloadAltAnim;
var BUtil.FullSound DrumInSound, DrumHitSound, DrumOutSound;
var	bool			bAltNeedCock;			//Should SG cock after reloading

var float StealthRating, StealthImps;

replication
{
	reliable if(Role==ROLE_Authority)
		Target, bLockedOn, bLaserOn;

	reliable if(Role<ROLE_Authority)
		ServerSwitchSilencer;

	unreliable if (ROLE == Role_Authority)
		ClientPhotonPickedUp; 
}

//=====================================================================
// TRACKER CODE
//=====================================================================

//===========================================================================
// GetFlechetteTarget
//
// Find and return the locked on target.
//===========================================================================
simulated event RenderOverlays (Canvas C)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bScopeView)
	    DrawTargeting(C);
	Super.RenderOverlays(C);
	DrawLaserSight(C);
}

simulated function WeaponTick(float DT)
{
	local float BestAim, BestDist;
	local Vector Start;
	local Pawn NewTarget;
	local bool bWasLockedOn;

	Super.WeaponTick(DT);

	//if (Instigator != None && Instigator.IsLocallyControlled())
	//	TickLaser(DT);

	if (!bScopeView || Role < ROLE_Authority)
	{
		TargetTime = 0;
		return;
	}

	bWasLockedOn = TargetTime >= LockOnTime;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	NewTarget = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);
	if (NewTarget != None)
	{
		if (NewTarget != Target)
		{
			Target = NewTarget;
			TargetTime = 0;
		}
		else if (Vehicle(NewTarget) != None)
			TargetTime += 1.2 * DT * (BestAim-0.95) * 20;
		else
			TargetTime += DT * (BestAim-0.95) * 20;
	}
	else
	{
		TargetTime = FMax(0, TargetTime - DT * 0.5);
	}
	if (Instigator.IsLocallyControlled())
	{
		if (!bWasLockedOn && TargetTime >= LockOnTime)
		    class'BUtil'.static.PlayFullSound(self, LockOnSound);
		else if (TargetTime < LockOnTime && bWasLockedOn)
		    class'BUtil'.static.PlayFullSound(self, LockOffSound);
	}
	bLockedOn = TargetTime >= LockOnTime;
	
	if (AIController(Instigator.Controller) != None && !IsPhotonLoaded() && AmmoAmount(1) > 0 && BotShouldReloadPhoton() && !IsReloadingPhoton())
		LoadPhoton();
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != bLaserOld)
	{
		bLaserOld = bLaserOn;
		ClientSwitchLaser();
	}
	if (bLockedOn != bLockedOld)
	{
		bLockedOld = bLockedOn;
		if (bLockedOn)
		    class'BUtil'.static.PlayFullSound(self, LockOnSound);
		else
		    class'BUtil'.static.PlayFullSound(self, LockOffSound);
	}
	Super.PostNetReceive();
}

simulated event DrawTargeting (Canvas C)
{
	local Vector V, X, Y, Z;//, V2;
	local float ScaleFactor, XL, XY;

    if (Target != none && Instigator.Controller.LineOfSightTo(Target))
        TargetLoc = C.WorldToScreen(Target.Location);

    ScaleFactor = C.ClipY / 1200;
	GetViewAxes(X, Y, Z);

	if (Target == none || !Instigator.Controller.LineOfSightTo(Target))
    {
        V.X = C.ClipX/2;
        V.Y = C.ClipY/2;
    }
    else
        V = TargetLoc;

    C.SetDrawColor(75,255,0,255);
    C.StrLen("ACQUIRING TARGET LOCK...", XL, XY);

    if (bNeedCock || MagAmmo == 0)
    {
        C.DrawTextJustified("RELOAD",1, (C.ClipX/2) - XL/2, (C.ClipY/2) + (160*ScaleFactor) - XY/2, C.ClipX/2 + XL/2 ,(C.ClipY/2) + (160*ScaleFactor) + XY/2);
    }
    else if (Target == none)
    {
	    C.DrawTextJustified("DISTANCE: N/A",0, (C.ClipX/2) - XL/2, (C.ClipY/2) + (180*ScaleFactor) - XY/2, C.ClipX/2 + XL/2 ,(C.ClipY/2) + (180*ScaleFactor) + XY/2);
    }
    else
    {

        if (!Instigator.Controller.LineOfSightTo(Target))
        {
	        C.DrawTextJustified("TARGET LOST",1, C.ClipX/2 - 100*ScaleFactor, (C.ClipY/2) + (160*ScaleFactor) - XY/2, C.ClipX/2 + 100*ScaleFactor ,(C.ClipY/2) + (160*ScaleFactor) + XY/2);
            C.DrawTextJustified("DISTANCE: N/A",0, (C.ClipX/2) - XL/2, (C.ClipY/2) + (180*ScaleFactor) - XY/2, C.ClipX/2 + XL/2 ,(C.ClipY/2) + (180*ScaleFactor) + XY/2);
        }
        else
        {
            if (bLockedOn)
            {
                C.SetDrawColor(255,00,0,255);
    	        C.DrawTextJustified("LOCKED",1, C.ClipX/2 - 100*ScaleFactor, (C.ClipY/2) + (160*ScaleFactor) - XY/2, C.ClipX/2 + 100*ScaleFactor ,(C.ClipY/2) + (160*ScaleFactor) + XY/2);
            }
            else
            {
                C.DrawTextJustified("ACQUIRING TARGET LOCK...",1, C.ClipX/2 - 100*ScaleFactor, (C.ClipY/2) + (160*ScaleFactor) - XY/2, C.ClipX/2 + 100*ScaleFactor ,(C.ClipY/2) + (160*ScaleFactor) + XY/2);
            }
            C.DrawTextJustified("DISTANCE: " $ int(VSize(TargetLoc-(Instigator.Location + Instigator.EyePosition()))/50) $ "m",0, (C.ClipX/2) - XL/2, (C.ClipY/2) + (180*ScaleFactor) - XY/2, C.ClipX/2 + XL/2 ,(C.ClipY/2) + (180*ScaleFactor) + XY/2);

            //Center targeting box
            C.SetPos(V.X - 32*ScaleFactor, V.Y - 32*ScaleFactor);
            //C.DrawTile(texture'BallisticUI2.Crosshairs.Misc8', 48 * ScaleFactor, 48 * ScaleFactor, 0, 0, 256, 256);
            //C.DrawTile(Texture'Crosshairs.HUD.Crosshair_Triad1', 64*ScaleFactor, 64*ScaleFactor, 0, 0, 64, 64);
            C.DrawTile(Texture'BW_Core_WeaponTex.G5.G5Targetbox', 64*ScaleFactor, 64*ScaleFactor, 0, 0, 128, 128);
        }
    }

	if (Target != none && !bLockedOn)
    {
        //Targeting brackets
        //Upper Left
        C.SetPos(V.X - (((140 - (C.ClipX/2 - V.X)) * (1-TargetTime/LockonTime) + 36) * ScaleFactor), V.Y - (((140 - (C.ClipY/2 - V.Y)) * (1-TargetTime/LockonTime) + 36) * ScaleFactor));
        C.DrawTile(Texture'BW_Core_WeaponTex.G5.G5LockBox', 36*ScaleFactor, 36*ScaleFactor, 0, 0, 64, 64);

        //Lower Left
        C.SetPos(V.X - (((140 - (C.ClipX/2 - V.X)) * (1-TargetTime/LockonTime) + 36) * ScaleFactor), V.Y + (((140 - (V.Y - C.ClipY/2)) * (1-TargetTime/LockonTime)) * ScaleFactor));
        C.DrawTile(Texture'BW_Core_WeaponTex.G5.G5LockBox', 36*ScaleFactor, 36*ScaleFactor, 0, 64, 64, 64);

        //Upper Right
        C.SetPos(V.X + (((140 - (V.X - C.ClipX/2)) * (1-TargetTime/LockonTime)) * ScaleFactor), V.Y - (((140 - (C.ClipY/2 - V.Y)) * (1-TargetTime/LockonTime) + 36) * ScaleFactor));
        C.DrawTile(Texture'BW_Core_WeaponTex.G5.G5LockBox', 36*ScaleFactor, 36*ScaleFactor, 64, 0, 64, 64);

        //Lower Right
        C.SetPos(V.X + (((140 - (V.X - C.ClipX/2)) * (1-TargetTime/LockonTime)) * ScaleFactor), V.Y + (((140 - (V.Y - C.ClipY/2)) * (1-TargetTime/LockonTime)) * ScaleFactor));
        C.DrawTile(Texture'BW_Core_WeaponTex.G5.G5LockBox', 36*ScaleFactor, 36*ScaleFactor, 64, 64, 64, 64);
    }
}

//============================================================
// Laser management
//============================================================

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;

	FC01Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
	OnLaserSwitched();
}

simulated function ClientSwitchLaser()
{
	//TickLaser (0.05);
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}
	PlayIdle();
	OnLaserSwitched();
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
	AimComponent.AimSpread.Max *= 0.8f;
	AimComponent.AimAdjustTime *= 1.5f;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
}

// Draw a laser beam and dot to show exact path of bullets before they're fired, point it at the tracked dude
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc, AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || !bLaserOn || bScopeView || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	Loc = GetBoneCoords('tip2').Origin;

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs), or closest target
	Laser.SetLocation(Loc);
	if (!bLockedOn) //Calc from barrel to wall
	{
		AimDir = BallisticFire(FireMode[0]).GetFireDir(Start);
		End = Start + Normal(AimDir)*10000;
		Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
		if (Other == None)
			HitLocation = End;
		if ( ThirdPersonActor != None )
			FC01Attachment(ThirdPersonActor).LaserEndLoc = HitLocation;
	}
	else //Calc to target
	{
		HitLocation = ConvertFOVs(TargetLoc, Instigator.Controller.FovAngle, DisplayFOV, 400);
		if ( ThirdPersonActor != None )
			FC01Attachment(ThirdPersonActor).LaserEndLoc = TargetLoc;
	}
	
	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	
	if (LaserDot != None && !bLockedOn)
		LaserDot.SetLocation(HitLocation);
	else
		LaserDot.SetLocation(TargetLoc);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire /* && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2*/)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
		Laser.SetRotation(GetBoneRotation('tip2'));

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
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
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
}

simulated function PlayIdle()
{
	Super.PlayIdle();
	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

//=====================================================================
// SUPPRESSOR CODE
//=====================================================================
function ServerSwitchSilencer(bool bNewValue)
{
	if (bSilenced == bNewValue)
		return;

	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);

	StealthImpulse(0.1);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);

	OnSuppressorSwitched();
}

simulated function OnRecoilParamsChanged()
{
	Super.OnRecoilParamsChanged();

	if (bSilenced)
		ApplySuppressorRecoil();
}

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.25;
	AimComponent.AimSpread.Max *= 1.25;
}

function ApplySuppressorRecoil()
{
	RcComponent.XRandFactor *= 0.7f;
	RcComponent.YRandFactor *= 0.7f;
}

simulated function StealthImpulse(float Amount)
{
	if (Instigator.IsLocallyControlled())
		StealthImps = FMin(1.0, StealthImps + Amount);
}

simulated function OnSuppressorSwitched()
{
	if (bSilenced)
	{
		ApplySuppressorAim();
		SightingTime *= 1.25;
	}
	else
	{
		AimComponent.Recalculate();
		SightingTime = default.SightingTime;
	}
}

simulated function Notify_SilencerAdd()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}

simulated function Notify_SilencerRemove()
{
	PlaySound(SilencerOffSound,,0.5);
}

simulated function Notify_SilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}

simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}

simulated function Notify_SilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}
simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	//targetting laser
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_G5Painter');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();

	if ( ThirdPersonActor != None )
		FC01Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}
	

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();

		if (ThirdPersonActor != None)
			FC01Attachment(ThirdPersonActor).bLaserOn = false;
		Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = false;
		return true;
	}
	return false;
}

//===========================================================================
// Extra ammo type code
//===========================================================================

// Notifys for greande loading sounds
simulated function Notify_AltClipOut()			{	PlaySound(PhotonMagOutSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_AltClipSlideIn()		{	PlaySound(PhotonMagSlideInSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_SGCock()				{	PlaySound(PhotonMagCockSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_AltClipIn()	
{	
	PlaySound(PhotonMagHitSound, SLOT_Misc, 0.5, ,64);
	if (Ammo[1].AmmoAmount < FC01PrimaryFire(FireMode[0]).default.PhotonCharge)
		FC01PrimaryFire(FireMode[0]).PhotonCharge = Ammo[1].AmmoAmount;
	else
		FC01PrimaryFire(FireMode[0]).PhotonCharge = FC01PrimaryFire(FireMode[0]).default.PhotonCharge;
}

// Photon has just been picked up. Loads one in if we're empty
function PhotonPickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadPhoton();
		else
		{
			if (Ammo[1].AmmoAmount < FC01PrimaryFire(FireMode[0]).default.PhotonCharge)
				FC01PrimaryFire(FireMode[0]).PhotonCharge = Ammo[1].AmmoAmount;
			else
				FC01PrimaryFire(FireMode[0]).PhotonCharge = FC01PrimaryFire(FireMode[0]).default.PhotonCharge;
		}
	}
	if (!Instigator.IsLocallyControlled())
		ClientPhotonPickedUp();
}

simulated function ClientPhotonPickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadPhoton();
		else
		{
			if (Ammo[1].AmmoAmount < FC01PrimaryFire(FireMode[0]).default.PhotonCharge)
				FC01PrimaryFire(FireMode[0]).PhotonCharge = Ammo[1].AmmoAmount;
			else
				FC01PrimaryFire(FireMode[0]).PhotonCharge = FC01PrimaryFire(FireMode[0]).default.PhotonCharge;
		}
	}
}

simulated function bool IsPhotonLoaded()
{
	if (FC01PrimaryFire(FireMode[0]).PhotonCharge > 0)
		return true;
	else 
		return false;
}

function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_FC01Alt(Ammo[1]) != None)
		Ammo_FC01Alt(Ammo[1]).Gun = self;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == PhotonLoadAnim || anim == PhotonLoadEmptyAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
		
	Super.AnimEnd(Channel);
}

// Load in rockets
//if reserve ammo is above mag size, just need to check if the number of rockets is below the default
//if reserve ammo is less or equal to mag size, check if the number of rockets is below the reserve ammo

simulated function LoadPhoton()
{
	if (Ammo[1].AmmoAmount > FC01PrimaryFire(FireMode[0]).default.PhotonCharge && FC01PrimaryFire(FireMode[0]).PhotonCharge >= FC01PrimaryFire(FireMode[0]).default.PhotonCharge)
		return;
		
	if (Ammo[1].AmmoAmount <= FC01PrimaryFire(FireMode[0]).default.PhotonCharge && FC01PrimaryFire(FireMode[0]).PhotonCharge >= Ammo[1].AmmoAmount)
		return;
		
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		
		if (bScopeView && Instigator.IsLocallyControlled())
			TemporaryScopeDown(Default.SightingTime);
		
		if (FC01PrimaryFire(FireMode[0]).PhotonCharge < 1 && HasAnim(PhotonLoadEmptyAnim))
			PlayAnim(PhotonLoadEmptyAnim, 0.75, , 0);
		else
			PlayAnim(PhotonLoadAnim, 0.75, , 0);
	}		
}

simulated function bool IsReloadingPhoton()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == PhotonLoadAnim || Anim == PhotonLoadEmptyAnim)
 		return true;
	return false;
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	
	if (seq == PhotonLoadAnim || seq == PhotonLoadEmptyAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingPhoton())
		{
			LoadPhoton();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingPhoton())
				LoadPhoton();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (CurrentWeaponMode == 1)
		return FireCount <= FC01PrimaryFire(FireMode[0]).default.PhotonCharge;
		
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadPhoton()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	//consume ammo from other mode
	if (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false && CurrentWeaponMode == 1)
		ConsumeAmmo(CurrentWeaponMode, Load, bAmountNeededIsMax);
	else
		super.ConsumeMagAmmo(Mode, Load, bAmountNeededIsMax);
		
	return true;
}

//===========================================================================
// Dual scoping
//===========================================================================
exec simulated function ScopeView()
{
	if (ZoomType == ZT_Fixed && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		if (ZoomType == ZT_Fixed)
		{
			SightPivot = IronSightPivot;
			SightOffset = IronSightOffset;
			ZoomType = ZT_Irons;
			ScopeViewTex = None;
			SightingTime = default.SightingTime;
		}
	}
	
	Super.ScopeView();
}

exec simulated function ScopeViewRelease()
{
	if (ZoomType != ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

simulated function ScopeViewTwo()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		ScopeViewTex = Texture'BWBP_OP_Tex.ProtoLMG.ProtoScope1';
		if (ZoomType == ZT_Irons)
		{
			SightPivot = ScopeSightPivot;
			SightOffset = ScopeSightOffset;
			ZoomType = ZT_Fixed;
			SightingTime = 0.4;
		}
	}
	
	Super.ScopeView();
}

simulated function ScopeViewTwoRelease()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

// Swap sighted offset and pivot for left handers
simulated function SetHand(float InHand)
{
	IronSightPivot = default.SightPivot;
	IronSightOffset = default.SightOffset;

	super.SetHand(InHand);
	if (Hand < 0)
	{
		if (ZoomType != ZT_Irons)
		{
			ScopeSightOffset.Y = ScopeSightOffset.Y * -1;
			ScopeSightPivot.Roll = ScopeSightPivot.Roll * -1;
			ScopeSightPivot.Yaw = ScopeSightPivot.Yaw * -1;
		}
		else
		{
			IronSightOffset.Y = IronSightOffset.Y * -1;
			IronSightPivot.Roll = IronSightPivot.Roll * -1;
			IronSightPivot.Yaw = IronSightPivot.Yaw * -1;
		}
	}
}

//=====================================================================
// Photon Fire
//=====================================================================
simulated function float ChargeBar()
{
	return float(FC01PrimaryFire(BFireMode[0]).PhotonCharge)/float(FC01PrimaryFire(BFireMode[0]).default.PhotonCharge);
}

//=====================================================================
// AI INTERFACE CODE
//=====================================================================
simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}

function bool CanAttack(Actor Other)
{
	if (!IsPhotonLoaded())
	{
		if (IsReloadingPhoton())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadPhoton())
		{
			LoadPhoton();
			return false;
		}
	}
	return super.CanAttack(Other);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticProInstantFire(BFireMode[0]).DecayRange.Min, BallisticProInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
	LockOnTime=1.500000
	LockOnSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-TargetOn',Volume=0.500000,Pitch=1.000000)
	LockOffSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-TargetOff',Volume=0.500000,Pitch=1.000000)
	
	PhotonMagOutSound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff'
	PhotonMagSlideInSound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn'
	PhotonMagHitSound=Sound'BW_Core_WeaponSound.A73.A73-PipeIn'
	PhotonMagCockSound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-Cock'
	PhotonLoadAnim="ReloadAlt"
	PhotonLoadEmptyAnim="ReloadEmptyAlt"
	
	ScopeSightPivot=(Roll=-4096)
	ScopeSightOffset=(X=15.000000,Y=-3.000000,Z=24.000000)
	
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
	SilencerOnTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	SilencerOffTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	//AltClipOutSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	//AltClipInSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	//AltClipSlideInSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_OP_Tex.ProtoLMG.BigIcon_ProtoLMG'
	BigIconCoords=(X1=16,Y1=30)
	bWT_Bullet=True
	bWT_Shotgun=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic 7.62mm fire. High power, but shorter effective range and suffers from high recoil."
	ManualLines(1)="Burst Fire Enables a Photon Burst, allowing for a forced faster rate of fire for the longer range engagement"
	ManualLines(2)="Effective at close to medium to long range. With the addition of the Scope, Red Dot Sight & the attachable Silencer"
	SpecialInfo(0)=(Info="240.0;25.0;0.9;85.0;0.1;0.9;0.4")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout',Volume=0.220000) 
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway',Volume=0.220000)
	MagAmmo=50
	CockAnimPostReload="Cock"
	CockAnimRate=1.400000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-Cock',Volume=2.000000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipHit')
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagOut',Volume=2.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagIn',Volume=2.000000)
	ClipInFrame=0.700000
	bAltTriggerReload=True
	WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Photon Burst",ModeID="WM_Burst",Value=3.000000,bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.R78OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,R=255,A=255),Color2=(B=255,G=52,R=59,A=255),StartSize1=96,StartSize2=96)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)

	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightPivot=(Pitch=128)
	SightOffset=(X=0.000000,Y=-0.950000,Z=24.950000)
	GunLength=16.000000
	ParamsClasses(0)=Class'FC01WeaponParams' 
	ParamsClasses(1)=Class'FC01WeaponParamsClassic' 
	ParamsClasses(2)=Class'FC01WeaponParamsRealistic' 
	ParamsClasses(3)=Class'FC01WeaponParamsTactical' 
	//AmmoClass[0]=Class'BWBP_OP_Pro.Ammo_Proto'
	//AmmoClass[1]=Class'BWBP_OP_Pro.Ammo_ProtoAlt'
	FireModeClass(0)=Class'BWBP_OP_Pro.FC01PrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.FC01ScopeFire'
	SelectAnimRate=1.000000
	PutDownAnimRate=1.000000
	PutDownTime=1.000000
	BringUpTime=1.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.750000
	CurrentRating=0.750000
	Description="After the restrictions of photon based weaponry was lifted, several manufacturers began working on making new weapons with the technology in mind.  One such company was NDTR Industries, who saw the development of the EP90 and decided to make a PDW like that on their own, utilizing the old P90 as their inspiration.  Now known as the FCO1-B Smart PDW, as the name implies, it's still a prototype with only a few 100 being made for testing.  Still relatively potent thanks to an integral silencer and a unique second magazine that is actually a photon battery, powering a special burst that disorients and disables any organic or mechanized target."
	Priority=41
	HudColor=(B=135)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=10
	PickupClass=Class'BWBP_OP_Pro.FC01Pickup'
	PlayerViewOffset=(X=5.000000,Y=6.000000,Z=-18.000000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_OP_Pro.FC01Attachment'
	IconMaterial=Texture'BWBP_OP_Tex.ProtoLMG.SmallIcon_ProtoLMG'
	IconCoords=(X2=127,Y2=31)
	ItemName="FC-01 Smartgun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	bShowChargingBar=True
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Proto'
	DrawScale=0.400000
}
