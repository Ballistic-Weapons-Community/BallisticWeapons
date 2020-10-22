//=============================================================================
// BallisticHandgun.
//
// This base class extends normal BWs and adds support for dual wielding of two
// handguns at once.
// In order for it to work, both guns must be BallisticHandgun subclasses.
// This system works by simultaneousaly using two weapons in the player's
// inventory. One weapon will be the Master and is treated much like a normal
// weapon, the other is the Slave and will not recognised by unreal's system.
// The Master gun is the Pawn.Weapon and is must be used to feed all input,
// rendering and events to the Slave.
// This method allows all weapons to retain their individual properties (i.e.
// ammo, aiming, states, reloading, etc) while being used normally or in dual
// mode, and allows players to wield two different weapons at the same time!
// For reloading and any other actions/anims that require two hands, the other
// gun must be lowered and hidden first.
//
// Features:
// -Master gun controls system and feeds all info to the slave
// -Slave performs using info from master
// -Dual Key (with 1 handgun) to bring up a slave when using a handgun
// -Dual key (with 2 handguns) to swap guns around
// -Dual key (with non handgun) to quickdraw last used dual guns or the 2 best if no last handgun
// -Auto tracking with slave using SightView key
// -Cycling through slaves with next/prev
// -States for guns lowered or busy while other gun is lowered
// -Display slave ammo/wepaonmode info on HUD
// -Hiding of second (support) hand when not needed
// -Reloads alternately, reloading the emptiest of the two first
// -Slave fires 1/2 master's firerate after master starts firing to give alternating effect
// -Non-Semiauto guns fire normally
// -Semiauto guns fire alternately when same group
// -Semiauto groups seperate guns that are too different to alternate nicely in semiauto
// -Semiauto grouping makes master fire one shot and slave fire continuously at predetermined fire rate until trigger released
// -Aim behaviour modified when using 2 guns at once
// -Basic AI features to put dual guns in bot hands
// -Control to prevent sending of fire events to slave and allow slave to ignore fire events received
//
// Styles of Dual Fire:
// -Standard:		Either is not semi-auto
//  Master starts fire, then Slave Starts fire. Fire stops by individual firemodes
// -Alternating:	Both are Semi-Auto and same HandgunGroup
//  One shot is fired from one gun for each click, alternating from one to the other
// -Semi-Auto Hold:	Both are Semi-Atuo and different HandgunGroup
//  Master fires one shot, then Slave fires continually at low rate until released
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticHandgun extends BallisticWeapon
	abstract;

// General vars
var   BallisticHandgun	OtherGun;				// The other Handgun. The gun in the other hand
var   bool				bIsMaster;				// Is this the master
var   BallisticHandgun	PendingHandgun;			// The slave that wil be brought up when the master is ready
var   bool				bIsPendingHandGun;		// This gun is a handgun about to be used as the slave
var   name				SupportHandBone;		// Bone used to hide/show extra hand for reloading and other two hand anims
var   BallisticHandgun	LastSlave;				// Last slave this gun had
var   float				LastMasterTime;			// Time when gun last had slave
var   bool				bSlavePutDown;			// True on slave when its being putdown. Used to let it know to not do normal putdonw
var()	bool			bShouldDualInLoadout; 	//True for a gunclass which should be dual wielded in Loadout gts
var	float				CreationTime;

// Autotracking vars
var   Pawn				Target;					// The guy getting tracked by our gun
var   Rotator			TrackerAim;				// Offset from ViewRotation where the tracking gun is aimed
var   float				TrackSpeed;				// How fast the tracking gun can move (Rotator Units per Second)
var   bool				bIsAutoTracking;		// Can and is tracking. This tells client to track as well.
var   bool				bAutoTrack;				// Track key is down. Try tracking if we can

var   byte				HandgunGroup;			// Grouping used for firing styles. Similar HGs should be the same, e.g. M806/9mm/RS8/Pistols, Magnum/DesertEagle, Uzi/XK2/XRS10/MPs
var() float				SingleHeldRate;			// Time between shots when a fire style allows semi-auto gun to fire continuously while fire key is held

replication
{
	// Variables the server sends to the client.
	reliable if( bNetOwner && bNetDirty && Role == ROLE_Authority )
		Target, bIsAutoTracking;
	// Functions the client calls on the server
	reliable if( Role < ROLE_Authority )
		ServerStartTracking, ServerStopTracking, SetDualGun, ServerSwap, ServerDoQuickDraw, ServerLeaveDualMode;
	// Functions the server calls on the client
	reliable if( Role == ROLE_Authority )
		ClientDualSelect;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	CreationTime = Level.TimeSeconds;
}

// Scope key pressed. Try go into tracking mode
exec simulated function ScopeView()
{
	if (Othergun == None && PendingHandgun == None && !bIsPendingHandGun)
	{
		Super.ScopeView();
		return;
	}
	
	/*
	if (IsMaster())
	{
		Othergun.ScopeView();
		return;
	}
	bAutoTrack = true;
	ServerStartTracking();
	*/
}
// Scope key released. Stop tracking
exec simulated function ScopeViewRelease()
{
	if (Othergun == None)
	{
		Super.ScopeViewRelease();
		return;
	}
	/*
	if (IsMaster())
	{
		Othergun.ScopeViewRelease();
		return;
	}
	bAutoTrack = false;
	ServerStopTracking();
	*/
}

simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
	
	if (IsMaster() || ReloadState != RS_None || (SprintControl != None && SprintControl.bSprinting)) //should stop recoil issues where player takes momentum and knocked out of scope, also helps dodge
	{
		StopScopeView();
		return false;
	}
	
	return true;
}

// Cycle through the various weapon modes
function ServerSwitchWeaponMode (byte NewMode)
{
	Super.ServerSwitchWeaponMode(NewMode);
		
	if (bIsMaster && OtherGun != None && OtherGun.Class == Class)
		OtherGun.ServerSwitchWeaponMode(CurrentWeaponMode);
}

// Find target. Set tracking mode
function ServerStartTracking()
{
	local float BestAim, BestDist;
	local Pawn Targ;
	local vector Start;

	bAutoTrack = true;
	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.95;
	Targ = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 3000);
	if (Targ != None)
	{
		Target = Targ;
		bIsAutoTracking = true;
	}
}
// Stop tracking mode
function ServerStopTracking()
{
	bAutoTrack = false;
	bIsAutoTracking = false;
}

simulated function bool CanTrack ()
{
	return !IsInState('DualAction') && !IsInState('PendingDualAction');
}

// Checks if tracking can continue. Moves TrackerAim around
simulated function TrackerTick (float DT)
{
	local Vector Dir, TBias;
	local Rotator TargetAngle;

	if (Target != None)
	{
		Dir = Normal(Target.Location - (Instigator.Location + Instigator.EyePosition()));
		// Server. Make sure target is still trackable. Tell client with bIsAutoTracking
		if (Role == ROLE_Authority)
		{
			TBias = vect(0.7,-0.7,0);
			if (Instigator.Controller.Handedness < 0)
				TBias.Y *= -1;
			if (bAutoTrack && Target != None && CanTrack() && Target.Health > 0
			 && FastTrace(Target.Location, Instigator.Location + Instigator.EyePosition()) && Dir Dot (TBias>>Instigator.GetViewRotation()) > -0.2)
				bIsAutoTracking = true;
			else
				bIsAutoTracking = false;
		}
		// Client and Server. Move tracker to point at the target
		if (bIsAutoTracking)
		{
			TargetAngle = Rotator(Dir << Instigator.GetViewRotation());
			TrackerAim.Yaw += FClamp(TargetAngle.Yaw - TrackerAim.Yaw, -TrackSpeed*DT, TrackSpeed*DT);
			TrackerAim.Pitch += FClamp(TargetAngle.Pitch - TrackerAim.Pitch, -TrackSpeed*DT, TrackSpeed*DT);
			return;
		}
	}
	// Not tracking. Move back to 0
	TrackerAim.Yaw -= FClamp(TrackerAim.Yaw, -TrackSpeed*DT, TrackSpeed*DT);
	TrackerAim.Pitch -= FClamp(TrackerAim.Pitch, -TrackSpeed*DT, TrackSpeed*DT);
}

simulated function Rotator GetPlayerAim (optional bool bFire)
{
	if (IsSlave())
		return TrackerAim + Instigator.GetViewRotation();
	else
		return Super.GetPlayerAim();
}

simulated function PreDrawFPWeapon()
{
	if (SightingState != SS_None)
		PositionSights();

	if (IsSlave())
		SetRotation(Instigator.GetViewRotation() + TrackerAim * (DisplayFOV / Instigator.Controller.FovAngle));
}

// Rotates the player's view according to Aim
// Split into recoil and aim to accomodate no view decline
simulated function ApplyAimToView()
{
	if (IsSlave())
		return;
	
	Super.ApplyAimToView();
}

simulated function ReloadFinished ()
{
	Super.ReloadFinished();

	if (Instigator != None && AIController(Instigator.Controller) != None && Othergun == None && PendingHandgun == None && !bIsPendingHandgun && ClientState == WS_ReadyToFire)
		DualSelect();

	if (Othergun!= None && Othergun.IsInState('DualAction'))
		Othergun.RaiseHandgun();
}

simulated function bool CanReload ()
{
	if (bPreventReload || ReloadState != RS_None || IsInState('DualAction') || (OtherGun!=None && (OtherGun.ReloadState != RS_None || OtherGun.MeleeState != MS_None)) || MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1)
		return false;
	return true;
}

exec simulated function Reload (optional byte i)
{
	if (bIsPendingHandGun || PendingHandGun != None/* || IsInState('Lowered')*/ || ClientState != WS_ReadyToFire)
		return;
	if (OtherGun == None)
		Super.Reload(i);
	else if (Othergun.ClientState != WS_ReadyToFire)
		return;
	else if (CanReload() && (IsSlave() || float(MagAmmo) / default.MagAmmo <= float(OtherGun.MagAmmo) / OtherGun.default.MagAmmo || !OtherGun.CanReload()))
	{
		Super.Reload(i);
	}
	else if (IsMaster())
		OtherGun.Reload(i);
}

function ServerStartReload (optional byte i)
{
	if (IsSlave() && Othergun.IsFiring())
		OtherGun.ImmediateStopFire();
	Super.ServerStartReload(i);
}

simulated function CommonStartReload (optional byte i)
{
	if (OtherGun == None || OtherGun.IsInState('Lowered'))
	{
		Super.CommonStartReload(i);
		return;
	}
	GotoState('PendingReloading');
}

exec simulated function CockGun(optional byte Type)
{
	if (ReloadState != RS_None || bPreventReload || ClientState != WS_ReadyToFire || IsInState('DualAction') || IsInState('PendingDualAction'))
		return;
	ServerCockGun(Type);
	CommonCockGun(Type);
}

simulated function CommonCockGun(optional byte Type)
{
	if (bIsPendingHandGun)
		return;
	if (PendingHandGun!=None)
		return;
	if (OtherGun == None)						{
		Super.CommonCockGun(Type);	return;		}

	if (OtherGun.IsInState('Lowered'))			{
		Super.CommonCockGun(Type);	return;		}

	if (bNonCocking)
		return;
	GotoState('PendingCocking');
}

simulated event AnimEnd (int Channel)
{
	if (OtherGun == None)	{
		Super.AnimEnd (Channel);	return;
	}
	if (IsInState('DualAction'))
		return;

	Super.AnimEnd (Channel);
}

// Pass on rendering to the slave
simulated event RenderOverlays (Canvas C)
{
	local bool bCenteredHand;
	if (Othergun == None)
	{
		Super.RenderOverlays(C);
		return;
	}
	if (Instigator.Controller.Handedness == 0)
	{
		bCenteredHand = true;
		Instigator.Controller.Handedness = 1;
	}
	if (IsMaster())
	{
		Instigator.Controller.Handedness *= -1;
		OtherGun.RenderOverlays(C);
		Instigator.Controller.Handedness *= -1;
	}
	if (!IsInState('Lowered'))
		Super.RenderOverlays(C);
	if (bCenteredHand)
		Instigator.Controller.Handedness = 0;
}

simulated event WeaponTick(float DT)
{
	local int m;
	
	Super.WeaponTick(DT);
	
	if (IsMaster())
		OtherGun.WeaponTick(DT);

	else if (IsSlave())
	{	
		// Timers and ModeDoFire need to be called manually for slave...
		for (m=0;m<NUM_FIRE_MODES;m++)
		{
			if (FireMode[m].bIsFiring)
			{
				FireMode[m].HoldTime += DT;
				if (!FireMode[m].bFireOnRelease && FireMode[m].NextFireTime <= Level.TimeSeconds)
					FireMode[m].ModeDoFire();
				if (Instigator.IsLocallyControlled() && ((m == 0 && Instigator.Controller.bFire == 0) || (m == 1 && Instigator.Controller.bAltFire == 0)))
					ClientStopFire(m);
			}
			if (FireMode[m].NextTimerPop <= Level.TimeSeconds)
			{
				FireMode[m].Timer();
				if (FireMode[m].bTimerLoop)
					FireMode[m].NextTimerPop = Level.TimeSeconds + FireMode[m].TimerInterval;
				else
					FireMode[m].NextTimerPop = 9999999;
			}
		}
		//TrackerTick(DT);
	}
}
simulated event StopFire(int Mode)
{
	if (AIController(Instigator.Controller) != None)
	{
		if (IsMaster() && OtherGun.IsFiring() && MasterCanSendMode(Mode))
			OtherGun.StopFire(Mode);
	}

	if ( FireMode[Mode].bIsFiring )
	    FireMode[Mode].bInstantStop = true;
    if (Instigator.IsLocallyControlled() && !FireMode[Mode].bFireOnRelease)
        FireMode[Mode].PlayFireEnd();

    FireMode[Mode].bIsFiring = false;
    FireMode[Mode].StopFiring();
	if (FireMode[Mode].bFireOnRelease && IsSlave())
		FireMode[Mode].ModeDoFire();
    if (!FireMode[Mode].bFireOnRelease)
        ZeroFlashCount(Mode);
}

simulated function EmptyFire (byte Mode)
{
	if (OtherGun == None)
		Super.EmptyFire(Mode);
	else if (bNeedReload && ClientState == WS_ReadyToFire && FireCount < 1 && Othergun.FireCount < 1 && Instigator.IsLocallyControlled() &&
		(Othergun.bNeedReload || !Othergun.HasAmmoLoaded(Mode)))
		ServerStartReload(Mode);
}

simulated function PlayScopeUp()
{
	if (HasAnim(ZoomInAnim))
	    SafePlayAnim(ZoomInAnim, 1.0);
	else
		SightingState = SS_Raising;
	if(ZoomType == ZT_Irons)
	PlayerController(Instigator.Controller).bZooming = True;
}

// Fire pressed. Change weapon if out of ammo, reload if empty mag or skip reloading if possible
simulated function FirePressed(float F)
{
	//guns are blocked
	if (IsInState('DualAction') || OtherGun != None && OtherGun.IsInState('DualAction'))
		return;
	if (!HasAmmo() && !IsSlave() && (Othergun == None || !Othergun.HasAmmo()))
		OutOfAmmo();

	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn) || (ReloadState == RS_PreClipOut)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	else if (reloadState == RS_None && !bPreventReload && bNeedCock && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime &&
		(Othergun == None || Othergun.bNeedCock || !Othergun.HasAmmo()))
	{
		CommonCockGun();
		if (Level.NetMode == NM_Client)

			ServerCockGun();
	}
	else if (IsMaster())
		Othergun.FirePressed(F);
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (IsInState('DualAction') || IsInState('PendingDualAction'))
		return false;
	if (CanSynch(Mode))
		return Super.CheckWeaponMode(Mode);
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_FullAuto" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_None")
		return true;
	if (FireCount >= WeaponModes[CurrentWeaponMode].Value && (!IsSlave() || WeaponModes[CurrentWeaponMode].ModeID != "WM_SemiAuto" || Othergun.WeaponModes[Othergun.CurrentWeaponMode].ModeID != "WM_SemiAuto" || Othergun.HandgunGroup == HandgunGroup || LastFireTime > level.TimeSeconds-SingleHeldRate))
		return false;
	if (Othergun != None && CanAlternate(Mode))
	{
		if ( (!Othergun.HasAmmoLoaded(Mode) || Othergun.bNeedCock || Othergun.bNeedReload || LastFireTime <= OtherGun.LastFireTime) && FireCount < 1 && Othergun.FireCount < 1 )
			return true;
		return false;
	}
	return true;
}

// When gun is a slave, should it use this FireMode (e.g; silencer,laser, or toggle type modes false; attacking/firing type modes should be true)
simulated function bool SlaveCanUseMode(int Mode) {return true;}
// When gun is a master, should it try pass this FireMode event on to slave (e.g; silencer,laser, or toggle type modes false; attacking/firing type modes true)
simulated function bool MasterCanSendMode(int Mode) {return true;}

simulated event ClientStartFire(int Mode)
{
	if (IsSlave() && !SlaveCanUseMode(Mode))
		return;
	Super.ClientStartFire(Mode);
	if (IsMaster() && !OtherGun.IsFiring() && MasterCanSendMode(Mode))
		OtherGun.ClientStartFire(Mode);
}

simulated event ClientStopFire(int Mode)
{
	if (IsSlave() && !SlaveCanUseMode(Mode))
		return;
	Super.ClientStopFire(Mode);
}

simulated function bool ReadyToFire(int Mode)
{
    local int alt;

	if (IsInState('DualAction') || IsInState('PendingDualAction'))
		return false;

    if ( Mode == 0 )
        alt = 1;
    else
        alt = 0;

	if (FireMode[Mode] == None)
		return false;

    if ( ((FireMode[alt] != None && FireMode[alt] != FireMode[Mode]) && FireMode[alt].bModeExclusive && FireMode[alt].bIsFiring)
		|| !FireMode[Mode].AllowFire()
		|| (FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].PreFireTime) )
    {
        return false;
    }

	return true;
}

// Can we do alternating style Semi-Auto firing?
simulated function bool CanAlternate(int Mode)
{
	return Othergun.HandgunGroup == HandgunGroup
		&& WeaponModes[CurrentWeaponMode].ModeID ~= "WM_SemiAuto"
		&& Othergun.WeaponModes[Othergun.CurrentWeaponMode].ModeID ~= "WM_SemiAuto";
}

//Can these two weapons fire simultaneously?
simulated function bool CanSynch(byte Mode)
{
	return false; // (OtherGun != None && OtherGun.Class == Class);
}

simulated function ForceFire(int Mode)
{
/*
	if (!IsSlave())
		return;
	if (StartFire(Mode) && Role < ROLE_Authority)
		ServerStartFire(Mode);
	//FireMode[Mode].ModeDoFire();
*/
}

simulated function bool StartFire(int Mode)
{
    local int alt;

	if (AIController(Instigator.Controller) != None)
	{
		if (IsSlave() && !SlaveCanUseMode(Mode))
			return false;
		if (IsMaster() && !OtherGun.IsFiring() && MasterCanSendMode(Mode))
			OtherGun.StartFire(Mode);
	}

    if (!ReadyToFire(Mode))
        return false;

	if (Mode == 0)
		alt = 1;
	else
		alt = 0;

    FireMode[Mode].bIsFiring = true;
	if (IsSlave() && Othergun.HasAmmoLoaded(Mode) && !CanAlternate(Mode))
    	FireMode[Mode].NextFireTime = Level.TimeSeconds + FireMode[Mode].PreFireTime + OtherGun.GetFireMode(Mode).FireRate * 0.5;
	else
    	FireMode[Mode].NextFireTime = Level.TimeSeconds + FireMode[Mode].PreFireTime;

    if (FireMode[alt] != None && FireMode[alt].bModeExclusive)
        // prevents rapidly alternating fire modes
        FireMode[Mode].NextFireTime = FMax(FireMode[Mode].NextFireTime, FireMode[alt].NextFireTime);

    if (Instigator.IsLocallyControlled())
    {
        if (FireMode[Mode].PreFireTime > 0.0 || FireMode[Mode].bFireOnRelease)
            FireMode[Mode].PlayPreFire();
        FireMode[Mode].FireCount = 0;
    }
    return true;
}

//// server only ////
event ServerStartFire(byte Mode)
{
	if ( (Instigator != None) && (Instigator.Weapon != self) && (BallisticHandGun(Instigator.Weapon) == None || BallisticHandGun(Instigator.Weapon).OtherGun != self))
	{
		if ( Instigator.Weapon == None )
			Instigator.ServerChangedWeapon(None,self);
		else
			Instigator.Weapon.SynchronizeWeapon(self);
		return;
	}

    if ( (FireMode[Mode].NextFireTime <= Level.TimeSeconds + FireMode[Mode].PreFireTime)
		&& StartFire(Mode) )
    {
        FireMode[Mode].ServerStartFireTime = Level.TimeSeconds;
        FireMode[Mode].bServerDelayStartFire = false;
    }
    else if ( FireMode[Mode].AllowFire() )
    {
        FireMode[Mode].bServerDelayStartFire = true;
	}
	else
		ClientForceAmmoUpdate(Mode, AmmoAmount(Mode));
//	}
}

function bool CanAttack(Actor Other)
{
	if (Super.CanAttack(Other) && !IsInState('DualAction'))
		return true;
	if (IsMaster())
		return OtherGun.CanAttack(Other);
	return false;
}

function float GetAIRating()
{
	if (IsSlave())
		return 0;
		
	return Super.GetAIRating();
}

simulated event Timer()
{
	local int Mode;

	if (Instigator != None && AIController(Instigator.Controller) != None && ClientState == WS_BringUp && Othergun == None && PendingHandgun == None && !bIsPendingHandgun)
	{
		Super.Timer();
		if (!bNeedCock)
			DualSelect();
	}
	else if (ClientState == WS_PutDown && IsMaster())
	{
	    SetDualMode(false);
	    if (AIController(Instigator.Controller) != None)
			Super.Timer();
//		bIsMaster = false;
//		OtherGun = None;
	}
	else if (ClientState == WS_PutDown && bSlavePutDown)
    {
   		SetDualMode(false);
    	if (OtherGun != None)
    	{
//			Instigator.ClientMessage(GetHumanreadablename()$"::Timer,bSlavePutDown: OtherGun = "$OtherGun.GetHumanReadableName()$" IsSlave = "$IsSlave()$" OtherGun.Pendinghandgun = "$OtherGun.Pendinghandgun.GetHumanReadableName());
//    		if (!Instigator.IsLocallyControlled())
    		if (Instigator.IsLocallyControlled() && OtherGun.Pendinghandgun == None)
    			OtherGun.ServerLeaveDualMode();
    		if (OtherGun != None)
   				OtherGun.SlavePutDown();
    	}
    	OtherGun=None;
		bSlavePutDown=false;
		ClientState = WS_Hidden;
		for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
			if (FireMode[Mode] != None)
				FireMode[Mode].DestroyEffects();
    }
    else
    {
    	Super.Timer();
    }
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	local Inventory Inv;
	
	Super.BringUp(PrevWeapon);
	GotoState('');
	SetBoneScale(8, 1.0, SupportHandBone);
	bSlavePutDown=false;
	bIsPendingHandGun = false;
	
	if (Level.TimeSeconds > CreationTime + 1)
	{
		if (OtherGun == None && PendingHandgun == None)
		{
			if (LastSlave != None)
				PendingHandgun = LastSlave;
			else
			{
				for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
				{
					if ( Inv != self && Inv.class == class )
					{
						if (Level.TimeSeconds > BallisticHandgun(Inv).CreationTime + 1)
						{
							PendingHandgun = BallisticHandgun(Inv);
							break;
						}
					}
				}
			}
		}
	}
	if (PendingHandgun != None)
	{
		bIsMaster = true;
		OtherGun = PendingHandgun;
		OtherGun.OtherGun = self;
		OtherGun.bIsMaster = false;
		OtherGun.PendingHandgun = None;
		OtherGun.AttachToPawn(Instigator);
		OtherGun.BringUp();
		SetDualMode(true);
		OtherGun.SetDualMode(true);
		PendingHandgun = None;
	}
	else
	{
		bIsMaster = false;
		if (OtherGun != None && !OtherGun.bIsMaster)
			OtherGun = None;
	}
	if (IsSlave())
    	Hand = Othergun.Hand * -1;
}

simulated function bool PutDown()
{
    local int Mode;

    if (ClientState == WS_BringUp || ClientState == WS_ReadyToFire)
    {
		if (!IsSlave() && Instigator.PendingWeapon != None && !Instigator.PendingWeapon.bForceSwitch)
        {
            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
            {
                if (FireMode[Mode]!=None && FireMode[Mode].bFireOnRelease && FireMode[Mode].bIsFiring)
                    return false;
            }
        }

        if (Instigator.IsLocallyControlled())
        {
            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
            {
                if (FireMode[Mode]!=None && FireMode[Mode].bIsFiring)
                    ClientStopFire(Mode);
            }

            if (ClientState != WS_BringUp && HasAnim(PutDownAnim))
                PlayAnim(PutDownAnim, PutDownAnimRate, 0.0);
        }
        ClientState = WS_PutDown;

		if (bScopeView)
			StopScopeView(true);

		if (ReloadState != RS_None)
		{
			if (level.NetMode == NM_Client)
				ServerStopReload();
			if (Role == ROLE_Authority)
				bServerReloading=false;
			ReloadState = RS_None;
		}
		bPendingSightUp=false;

		if (PutDownSound.Sound != None)
			class'BUtil'.static.PlayFullSound(self, PutDownSound);

        SetTimer(PutDownTime, false);
    }

	if (IsSlave())
	{
		bSlavePutDown=true;
	}
	else
	{
		if (!bOldCrosshairs && (Instigator.PendingWeapon == None || BallisticWeapon(Instigator.PendingWeapon) == None) && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
			PlayerController(Instigator.Controller).MyHud.bCrosshairShow = PlayerController(Instigator.Controller).MyHud.default.bCrosshairShow;
	}
	if (IsMaster())
	{
		LastMasterTime = level.TimeSeconds;
		LastSlave = OtherGun;
		OtherGun.PutDown();
	}

    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
    {
		if (FireMode[Mode]==None)
			continue;
		FireMode[Mode].bServerDelayStartFire = false;
		FireMode[Mode].bServerDelayStopFire = false;
	}
    Instigator.AmbientSound = None;
	AmbientSound = None;
    OldWeapon = None;
    return true; // return false if preventing weapon switch
}

function DetachFromPawn(Pawn P)
{
	Super.DetachFromPawn(P);

	if (IsMaster())
		Othergun.DetachFromPawn(P);
	if (!Instigator.IsLocallycontrolled())
    	SetDualMode(false);
	bIsMaster = false;
	OtherGun = None;
}

simulated function Reselect()
{
	if (IsMaster())
	{
		OtherGun.PutDown();
		LeaveDualMode();
		if (Role < ROLE_Authority)
			ServerLeaveDualMode();
	}
}

function ServerLeaveDualMode()
{
	LeaveDualMode();
}

simulated function LeaveDualMode()
{
	if (OtherGun != None)
	{
		LastMasterTime = level.TimeSeconds;
		LastSlave = OtherGun;

		OtherGun.DetachFromPawn(Instigator);

		bIsMaster = false;
		OtherGun = None;

   		SetDualMode(false);
	}
}

simulated function SlavePutDown()
{
	if (PendingHandgun != None)
	{
		SetDualGun(PendingHandgun);
		PendingHandgun=None;
	}
	else
	{
		bIsMaster = false;
		SetDualMode(false);
		OtherGun = None;
	}
}

simulated final function SetDualMode (bool bDualMode)
{
	if (bDualMode)
	{
		if (Instigator.IsLocallyControlled() && SightingState == SS_Active)
			StopScopeView();
		SetBoneScale(8, 0.0, SupportHandBone);
		if (AIController(Instigator.Controller) == None)
			bUseSpecialAim = true;
	}
	else
	{
		SetBoneScale(8, 1.0, SupportHandBone);
		bUseSpecialAim = false;
	}

	OnDualModeChanged(bDualMode);
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// OnDualModeChanged
//
// Event raised whenever dual mode is switched.
// Override in subclasses instead of SetDualMode to implement behaviour 
// when changing between modes.
//
// Remember to follow OnRecoilParamsChanged / OnAimParamsChanged pattern 
// as laid out in BallisticWeapon if changing recoil or aim params.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
simulated function OnDualModeChanged(bool bDualMode)
{
	if (bDualMode)
		BFireMode[0].FireRate = BFireMode[0].default.FireRate * 1.5;
	else 
		BFireMode[0].FireRate = BFireMode[0].default.FireRate;
}

/*
simulated function StopScopeView(optional bool bNoAnim)
{
	OldZoomFOV = PlayerController(Instigator.Controller).FovAngle;

	if (ZoomType != ZT_Irons)
	{
		PlayerController(Instigator.Controller).SetFOV(PlayerController(Instigator.Controller).DefaultFOV);
		PlayerController(Instigator.Controller).bZooming = False;
	}
	SetScopeView(false);
	
	//Restore normal crosshairs if the weapon has none in scope view
	if (bOldCrosshairs && bNoCrosshairInScope && bStandardCrosshairOff)
	{
		bStandardCrosshairOff = False;
		PlayerController(Instigator.Controller).myHud.bCrosshairShow = True;
	}
	if (ZoomOutSound.Sound != None)	class'BUtil'.static.PlayFullSound(self, ZoomOutSound);
	PlayScopeDown(bNoAnim);
}
*/

function ServerSwap(BallisticHandgun Other)
{
	if (Other == None)
		return;
	DetachFromPawn(Instigator);
    Other.PendingHandgun = self;
    Other.LowerHandGun();
	Other.SetDualMode(false);
	Other.DetachFromPawn(Instigator);
    Other.OtherGun = None;
    OtherGun = None;
}
function SetDualGun(BallisticHandgun NewSlave)
{
	if (NewSlave == None)
		return;
	if (OtherGun != None)
		OtherGun.DetachFromPawn(Instigator);
	CommonDualSelect(NewSlave);
	ClientDualSelect(NewSlave);
}
simulated function ClientDualSelect(BallisticHandgun NewSlave)
{
	if (level.NetMode == NM_Client) CommonDualSelect(NewSlave);
}
simulated function CommonDualSelect(BallisticHandgun NewSlave)
{
	bIsMaster = true;
	if (Othergun == None)
		SetDualMode(true);
	OtherGun = NewSlave;
	OtherGun.OtherGun = self;
	OtherGun.bIsMaster = false;
	if (Role == ROLE_Authority)
		OtherGun.AttachToPawn(Instigator);
	OtherGun.BringUp();
	OtherGun.SetDualMode(true);
}

simulated function bool PreventSwap()
{
	if (ReloadState != RS_None || IsFiring() || IsInState('DualAction') || PendingHandgun!= None || bIsPendingHandGun)
		return true;
	return false;
}

exec simulated function DualSelect (optional class<Weapon> NewWeaponClass )
{
	local BallisticHandgun Best;
    local Inventory Inv;

	if (ClientState != WS_ReadyToFire || ReloadState != RS_None || IsFiring() || bScopeView || bScopeHeld || (OtherGun!=None && (PreventSwap() || OtherGun.PreventSwap())))
		return;

	if (Othergun != None)
	{
//		if (!Instigator.IsLocallyControlled())
		if (Role < ROLE_Authority)
			ServerSwap(Othergun);
	    Instigator.PendingWeapon = Othergun;
		PendingHandgun = None;
		bIsPendingHandGun = true;
	    OtherGun.PendingHandgun = self;
	    Othergun.LowerHandGun();
		Othergun.SetDualMode(false);
	    OtherGun.OtherGun = None;
	    OtherGun = None;
		PutDown();
		return;
	}
    for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
    {
    	if ( Inv != self && Inv.Class == Class) //ClassIsChildOf(Inv.class, class'BallisticHandgun') )
    	{
    		if (Inv.class == class && BallisticHandgun(Inv).HasAmmoLoaded(255))
    		{
   				Best = BallisticHandgun(Inv);
    			break;
    		}
    		else if ( Best == None || !Best.HasAmmoLoaded(255) || (Best.HandgunGroup != HandgunGroup && BallisticHandgun(Inv).HandgunGroup == HandgunGroup) )
   				Best = BallisticHandgun(Inv);
    	}
    }
	if (Best != None)
		SetDualGun(Best);
}

simulated function DoQuickDraw()
{
	local BallisticHandgun Best;
    local Inventory Inv;

	if (LastSlave != None)
		Best = LastSlave;
	else
	{
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
    	{
    		if ( Inv != self && ClassIsChildOf(Inv.class, class'BallisticHandgun') )
	    	{
    			if (Inv.class == class && BallisticHandgun(Inv).HasAmmoLoaded(255))
    			{
   					Best = BallisticHandgun(Inv);
    				break;
	    		}
    			else if ( Best == None || !Best.HasAmmoLoaded(255) || (Best.HandgunGroup != HandgunGroup && BallisticHandgun(Inv).HandgunGroup == HandgunGroup) )
   					Best = BallisticHandgun(Inv);
	    	}
    	}
    }
	if (Role < ROLE_Authority)
		ServerDoQuickDraw(Best);
    Instigator.PendingWeapon = self;
    PendingHandgun = Best;
    if (Instigator.Weapon != None)
		Instigator.Weapon.PutDown();
	else
		Instigator.ChangedWeapon();
}

function ServerDoQuickDraw(BallisticHandgun Other)
{
    PendingHandgun = Other;
}

simulated function BallisticWeapon FindQuickDraw(BallisticWeapon CurrentChoice, float ChoiceRank)
{
    local Inventory Inv;
    local BallisticWeapon Best;

	if (CurrentChoice == None ||
		BallisticHandgun(CurrentChoice) == None ||
		(LastSlave != None && BallisticHandgun(CurrentChoice).LastSlave == None) ||
		BallisticHandgun(CurrentChoice).LastMasterTime < LastMasterTime)
	{
		CurrentChoice = self;
		ChoiceRank = 1;
	}
	for ( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
		if (BallisticWeapon(Inv) != None)
		{	Best = BallisticWeapon(Inv).FindQuickDraw(CurrentChoice, ChoiceRank);	break;	}

	if (Best == None)
		return CurrentChoice;
	else
		return Best;
}

simulated function bool AllowWeapPrevUI()
{
	if (OtherGun != None)
		return false;
	return Super.AllowWeapPrevUI();
}
simulated function bool AllowWeapNextUI()
{
	if (OtherGun != None)
		return false;
	return Super.AllowWeapNextUI();
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	local BallisticHandgun Best;
    local Inventory Inv;

	if (CurrentWeapon == self && IsMaster())
	{
		if (ReloadState != RS_None || IsInState('DualAction'))
			return None;
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
		{
    		if (Inv != self && ClassIsChildOf(Inv.class, class'BallisticHandgun'))
    		{
    			if (Inv == OtherGun)
				{
					if (Best != None)
						break;
				}
    			else
    				Best = BallisticHandgun(Inv);
    		}
		}
	    if (Best != None)
	    {
			if (Best == OtherGun)
				return none;
	    	PendingHandgun = Best;
	    	if (Othergun.PutDown())
	    	{
				return None;
			}
			else
				PendingHandgun = None;
	    }
	}
	return Super.PrevWeapon(CurrentChoice, CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	local BallisticHandgun Best;
	local bool bFoundOtherOne;
    local Inventory Inv;

	if (CurrentWeapon == self && IsMaster())
	{
		if (ReloadState != RS_None || IsInState('DualAction'))
			return None;
	    for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
    	{
    		if (Inv != self && ClassIsChildOf(Inv.class, class'BallisticHandgun'))
	    	{
	    		if (bFoundOtherOne)
	    		{
					Best = BallisticHandgun(Inv);
					break;
	    		}
    			else if (Inv == OtherGun)
	    			bFoundOtherOne = true;
	    		else if (Best == None)
	    			Best = BallisticHandgun(Inv);
	    	}
	    }
	    if (Best != None)
	    {
			if (Best == OtherGun)
				return none;
			PendingHandgun = Best;
			if (Othergun.PutDown())
		    {
				return None;
			}
			else
				PendingHandgun = None;
	    }
	}
	return Super.NextWeapon(CurrentChoice, CurrentWeapon);
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
	{
		InventoryAttachment(ThirdPersonActor).InitFor(self);
		ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	}

	if (IsSlave())
	{
		BoneName = P.GetOffHandBoneFor(self);
		ThirdPersonActor.SetRelativeRotation(rot(0,32768,0));
	}
	else
		BoneName = P.GetWeaponBoneFor(self);

	if (Othergun != None)
	{	if (HandgunAttachment(ThirdPersonActor) != None)
			HandgunAttachment(ThirdPersonActor).OtherGun = HandgunAttachment(Othergun.ThirdPersonActor);
		if (HandgunAttachment(Othergun.ThirdPersonActor) != None)
			HandgunAttachment(Othergun.ThirdPersonActor).OtherGun = HandgunAttachment(ThirdPersonActor);
	}

	if ( BoneName == '' )
	{
		ThirdPersonActor.SetLocation(P.Location);
		ThirdPersonActor.SetBase(P);
	}
	else
		P.AttachToBone(ThirdPersonActor,BoneName);
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m, Count;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;
	local inventory Inv;

    Instigator = Other;

	bJustSpawned = true;
	for(Inv=Instigator.Inventory; Inv!=None && Count<1000; Inv=Inv.Inventory)
	{
		if (Inv.class == class)
		{
			if (W == None)
				W = Weapon(Inv);
			else
			{
				bJustSpawned = false;
				break;
			}
		}
		Count++;
	}
	if (bJustSpawned || W == None)
	{
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
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

simulated function ClientWeaponThrown()
{
    local int m;

	if (OtherGun != None)
	{
		OtherGun.bIsMaster = false;
		OtherGun.SetDualMode(false);
		OtherGun.OtherGun = None;
		bIsMaster = false;
		SetDualMode(false);
		OtherGun = None;
	}

    if (Instigator != None && PlayerController(Instigator.Controller) != None)
        PlayerController(Instigator.Controller).EndZoom();

    AmbientSound = None;
    Instigator.AmbientSound = None;

    if( Level.NetMode != NM_Client )
        return;

    Instigator.DeleteInventory(self);
    if (Othergun == None && (Instigator == None || Instigator.Health < 1))
    {
	    for (m = 0; m < NUM_FIRE_MODES; m++)
    	{
    	    if (Ammo[m] != None)
            Instigator.DeleteInventory(Ammo[m]);
	    }
	}
}

function DropFrom(vector StartLocation)
{
    local int m;
	local Pickup Pickup;

	if (IsMaster()/* && OtherGun.bCanThrow*/)
	{
		OtherGun.DropFrom(StartLocation);
		if (Instigator.Health > 0)
			return;
	}

    if (!bCanThrow)
        return;

	if (AmbientSound != None)
		AmbientSound = None;

    ClientWeaponThrown();

	if (OtherGun != None)
	{
		OtherGun.bIsMaster = false;
		OtherGun.SetDualMode(false);
		OtherGun.OtherGun = None;
		bIsMaster = false;
		SetDualMode(false);
		OtherGun = None;
	}

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None && FireMode[m].bIsFiring)
            StopFire(m);
    }

	if ( Instigator != None )
		DetachFromPawn(Instigator);

	Pickup = Spawn(PickupClass,self,, StartLocation);
	if ( Pickup != None )
	{
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
    	Pickup.InitDroppedPickupFor(self);
	    Pickup.Velocity = Velocity;
    }
    Destroy();
}

simulated function WeaponSpecialImpl(byte i)
{
	super.WeaponSpecialImpl(i);

	if (IsMaster() && Othergun.Class == Class)
		Othergun.WeaponSpecialImpl(i);
}

simulated function Destroyed()
{
    local int m;

	AmbientSound = None;

	if (!IsSlave())
	{
		if(Instigator != None && Instigator.Controller != None && PlayerController(Instigator.Controller) != None)
		{
			PlayerController(Instigator.Controller).bZooming = False;
			PlayerController(Instigator.Controller).DesiredZoomLevel=0.0;
			
			if (PlayerController(Instigator.Controller).MyHud != None)
			{
				if (bStandardCrosshairOff)
					PlayerController(Instigator.Controller).MyHud.bCrosshairShow = True;
				else PlayerController(Instigator.Controller).MyHud.bCrosshairShow = PlayerController(Instigator.Controller).MyHud.default.bCrosshairShow;
				Instigator.Controller.bRun = 0;
			}
		}
	}

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
		if ( FireMode[m] != None )
			FireMode[m].DestroyEffects();
		if (OtherGun == None && Ammo[m] != None)
		{
		    if (Instigator == None || Instigator.Health < 1)
				Ammo[m].Destroy();
			Ammo[m] = None;
		}
	}
	Super(Inventory).Destroyed();
}

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if (IsMaster())
		OtherGun.SetOverlayMaterial(mat, time, bOverride);
}

// Aim goes bad when player takes damage
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	Super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
	if (IsMaster())
		OtherGun.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function SetHand(float InHand)
{
	if (IsSlave())
    	Hand = InHand * -1;
    else if (IsMaster())
    	OtherGun.SetHand(InHand);
    else
    	Super.SetHand(InHand);
}

// General stuff that happens when a gun if fully lowered
simulated function HandgunLowered (BallisticHandgun Other)
{
	if (Other == Othergun)
		SetBoneScale(8, 1.0, SupportHandBone);
}
simulated function HandgunRaised (BallisticHandgun Other)
{
	if (Other == self)
	{
		if (Role == ROLE_Authority && !bNeedReload && bNeedCock)

			ServerCockGun();
	}
}

simulated function LowerHandGun ()	{	GotoState('Lowering');	}
simulated function RaiseHandGun ()	{	GotoState('Raising');	}
// Special States for gun that is lowered while other is busy
simulated state DualAction
{
}
simulated state Raising extends DualAction
{
Begin:
	OtherGun.SetBoneScale(8, 0.0, OtherGun.SupportHandBone);
	SafePlayAnim(SelectAnim, 2, 0.1);
	FinishAnim();
	OtherGun.HandgunRaised(self);
	HandgunRaised(self);
	if (ClientState == WS_ReadyToFire)
		PlayIdle();
	GotoState('');
}
simulated state Lowering extends DualAction
{
Begin:
	SafePlayAnim(PutDownAnim, 2, 0.1);
	FinishAnim();
	GotoState('Lowered');
}
simulated state Lowered extends DualAction
{
	simulated function BeginState()
	{
		if (OtherGun != None)
			OtherGun.HandgunLowered(self);
	}
}

// States for gun that is performing an action that needs two hands while other gun is lowered.
simulated state PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunRaised (BallisticHandgun Other)	{ if (Other == Othergun) GotoState('');	}
}
// About to reload, waiting for other gun to lower
simulated state PendingReloading extends PendingDualAction
{
//	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) Super.ServerStartReload();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) Super.CommonStartReload();	}
	function ServerStartReload (optional byte i){}
}
// About to start cocking, waiting for other gun to lower
simulated state PendingCocking extends PendingDualAction
{
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) Super.CommonCockGun();	}
	function ServerStartReload (optional byte i){}
}

//Draw slave weapon info on the HUD
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local float		ScaleFactor, XL, YL, YL2;
	local string	Temp;

	if (Othergun == None || bSkipDrawWeaponInfo)
	{
		Super.NewDrawWeaponInfo (C, YPos);
		return;
	}
	if (IsMaster())
	{
		Super.NewDrawWeaponInfo (C, YPos);
		OtherGun.NewDrawWeaponInfo(C, YPos);
		return;
	}

	ScaleFactor = C.ClipX / 1600;
	C.Font = GetFontSizeIndex(C, -1 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	// Draw MagAmmo
	if (bNoMag)
		C.TextSize(Ammo[0].AmmoAmount, XL, YL);
	else
		C.TextSize(MagAmmo, XL, YL);
	C.CurX = C.OrgX + 20 * ScaleFactor * class'HUD'.default.HudScale;
	C.CurY = C.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
	if (bNoMag)
		C.DrawText(Ammo[0].AmmoAmount, false);
	else
		C.DrawText(MagAmmo, false);
	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.OrgX + 20 * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 196 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	// Draw the secondary ammo amount
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.OrgX + 160 * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 196 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	// Draw weapon fireing mode
	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.OrgX + 15 * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 196 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
	}
}

simulated final function bool IsMaster()
{	
	return (OtherGun != None && bIsMaster);	
}

simulated final function bool IsSlave()
{	
	return (OtherGun != None && !bIsMaster);
}

simulated final function bool IsInDualMode() 
{ 
	return OtherGun != None;
}

simulated function BallisticHandgun	GetMaster()
{
	if (OtherGun == None || bIsMaster)
		return self;
	return Othergun;
}

simulated function BallisticHandgun	GetSlave()
{
	if (IsSlave())
		return self;
	else if (OtherGun != None)
		return Othergun;
	return None;
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local string s;
    local name Anim;
    local float frame,rate;

	if (OtherGun == None)
	{
		Super.DisplayDebug(Canvas, YL, YPos);
		return;
	}
	if (IsMaster())
		super(Weapon).DisplayDebug(Canvas, YL, YPos);
		
	if (IsSlave())
    	Canvas.SetDrawColor(128,128,255);
	else
    	Canvas.SetDrawColor(255,128,0);


    s = "Ballistic Weapon: ReloadeState: ";
	Switch( ReloadState )
	{
	   	case RS_None: s=s$"None"; break;
    	case RS_PreClipOut: s=s$"PreClipOut"; break;
		case RS_PreClipIn: s=s$"PreClipIn"; break;
 		case RS_PostClipIn: s=s$"PostClipIn"; break;
		case RS_StartShovel: s=s$"StartShovel"; break;
		case RS_Shovel: s=s$"Shovel"; break;
		case RS_PostShellIn: s=s$"PostShellIn"; break;
		case RS_EndShovel: s=s$"EndShovel"; break;
		case RS_Cocking: s=s$"Cocking"; break;
	}
	s = s $ ", MagAmmo="$MagAmmo$",State="$GetStateName();
	Canvas.DrawText(s);

    YPos += YL;
	Canvas.SetPos(4,YPos);
	RcComponent.DrawDebug(Canvas);
	
    YPos += YL;
	Canvas.SetPos(4,YPos);
	AimComponent.DrawDebug(Canvas);

	YPos += YL;
    Canvas.SetPos(4,YPos);

	Switch( ClientState )
	{
		case WS_None: s="None"; break;
		case WS_Hidden: s="Hidden"; break;
		case WS_BringUp: s="BringUp"; break;
		case WS_PutDown: s="PutDown"; break;
		case WS_ReadyToFire: s="ReadyToFire"; break;
	}

	GetAnimParams(0,Anim,frame,rate);

	Canvas.DrawText("ClientState="$s$", PendingHandgun="$PendingHandgun$", Anim="$Anim$":"$frame$", Othergun="$Othergun$", bIsMaster="$bIsMaster);
    YPos += YL;
    Canvas.SetPos(4,YPos);

	if (IsMaster())
		Othergun.DisplayDebug(Canvas, YL, YPos);
}

simulated function MeleeHoldImpl()
{
	super.MeleeHoldImpl();
	
	if (IsMaster())
		Othergun.MeleeHoldImpl();
}

simulated function MeleeReleaseImpl()
{
	super.MeleeReleaseImpl();
	
	if (IsMaster())
		Othergun.MeleeReleaseImpl();
}

defaultproperties
{
	 DisplaceDurationMult=0.5
     SupportHandBone="Root01"
     bShouldDualInLoadout=True
     TrackSpeed=18000.000000
     SingleHeldRate=0.300000
     PlayerSpeedFactor=1.100000
     InventorySize=3
     bWT_Sidearm=True
     SightZoomFactor=0.85
     GunLength=16.000000
     LongGunPivot=(Pitch=5000,Yaw=6000)
}
