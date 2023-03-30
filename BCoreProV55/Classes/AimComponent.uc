//=============================================================================
// AimComponent.
//
// Represents the aim system component of a Ballistic Weapon.
//
// by Azarael 2020
// adapting code written by DarkCarnivour, whose comments are below:
//
// Aim Stuff -----------------------------------------------------------------------------------------------------------
// This is the excessively complicated aiming system.
// Basically, a Rotator(Aim) and rotator generated from the recoil are used to offset the gun from the player's view.
// Aim is the base aim of the gun. Aim is interpolated randomly, within the ranges set by AimSpread. AimAdjustTime is
// used to set how long it takes to shift.
//
// Chaos is applied when the player moves, jumps, turns, etc and greatly ruins a player's ability to aim accurately. The
// faster and more wildly the player moves, the more chaos is aplied to the weapon. When no chaos is applied, the Aim will be
// randomly interpolated whithin the ranges set by AimSpread.Min. When full chaos is applied, the Aim uses the ranges set
// by AimSpread.Max. AimSpread.Min ranges can be used as a minimum spread and AimSpread.Max as the maximum spread. Aim
// spread is adjusted smoothly between AimSpread.Min and AimSpread.Max depending on chaos level.
//=============================================================================
class AimComponent extends Object;

//=============================================================================
// ACTOR/OBJECT REFERENCES
//
// MUST BE CLEANED UP FROM THE WEAPON CODE
//=============================================================================
var 				BallisticWeapon		BW;
var 				LevelInfo			Level;
var() editinline 	AimParams			Params;

//=============================================================================
// MUTABLES
//=============================================================================
//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var BUtil.IntRange		        AimSpread;			    // Range for how far aim can be from crosshair (rotator units) based on chaos value
var float                       AimAdjustTime;
var float				        ChaosDeclineTime;	    // Time it take for chaos to decline from 1 to 0
var int                         ChaosSpeedThreshold;    
var int							ChaosTurnThreshold;
var float                       CrouchMultiplier;
//-----------------------------------------------------------------------------
// Long Gun
//-----------------------------------------------------------------------------
var float					    GunLength;			    // How far weapon extends from player. Used by long-gun check
var Rotator                     LongGunPivot;
var Vector                      LongGunOffset;
//-----------------------------------------------------------------------------
// Displacement
//-----------------------------------------------------------------------------
var	float				        DisplaceEndTime;        // Time when aim displacement effect wears off.
var	float				        DisplaceDurationMult;   // Duration multiplier for aim displacement.
//=============================================================================
// STATE
//=============================================================================
//-----------------------------------------------------------------------------
// Aim
//-----------------------------------------------------------------------------
var private Rotator				Aim;				    // How far aim pointer is from crosshair
var private Rotator				NewAim;				    // New destination for aim pointer
var private Rotator				OldAim;				    // Where aim pointer was before it started moving

var	private float				ReaimTime;			    // Time it should take to move aim pointer to new position
var private float				ReaimPhase;			    // How far along pointer is in its movement from old to new
var private bool				bReaiming;			    // Is the pointer being reaimed?
var	private float				NextZeroAimTime;		// For zeroing aim when scoping
var private float				LastFireChaosTime;		// Last time at which chaos was applied

var private Rotator				AimOffset;			    // Extra Aim offset. Set NewAimOffset and AimOffsetTime to have this move smoothly
var private Rotator				NewAimOffset;		    // This is what AimOffset should be and is adjusted for sprinting and so on
var private Rotator				OldAimOffset;		    // AimOffset before it started shifting. Used for interpolationg AimOffset
var	private float				AimOffsetTime;		    // Time when AimOffset should reach NewAimOffset. Used for interpolationg AimOffset
// var private float            VelocityAimAdjustMult;       // Multiplier on AimAdjustTime, set by ADS

var private Rotator				LastViewPivot;			// Aim saved between ApplyAimToView calls, used to find delta aim
var private float               ViewBindFactor;         // Amount to bind aim offsetting to view

var	private bool				bJumpLock;			    // Prevents ZeroAim from acting when player jumps
var private bool				bForceReaim;		    // Another Reaim event will be forced after current one completes
//-----------------------------------------------------------------------------
// Chaos
//-----------------------------------------------------------------------------
var	private float				Chaos;					// The amount of chaos to be applied to aiming. 0=No Chaos, best aim. 1=Full Chaos, Worst aim
var	private float				NewChaos;				// The Chaos when reaim started. Used for crosshair interpolation.
var	private float				OldChaos;				// The NewChaos from the previous reaim
var private Rotator				OldLookDir;				// Where player was looking last tick. Used to check if player view changed

var private float 				FireChaos; 				// Current conefire expansion factor (this * AimSpread.Max being the current radius)
//-----------------------------------------------------------------------------
// Long gun
//-----------------------------------------------------------------------------
var private float				LongGunFactor;		    // Current percent of long-gun factors applied. Will be interpolated to NewLongGunFactor
var	private float				NewLongGunFactor;	    // What LongGunFactor should be. Set instantly when bumping into obstacles
//-----------------------------------------------------------------------------
// Displacement
//-----------------------------------------------------------------------------
var private bool				bSprintOffset;			// Sprint offset is active.
var	private float				DisplaceFactor;         // Current factor for aim displacement.

//=============================================================
// Accessors
//=============================================================
final simulated function bool IsDisplaced()
{
	return (DisplaceEndTime > Level.TimeSeconds || DisplaceFactor > 0);
}

final simulated function float GetChaos()
{
    return Chaos;
}

final simulated function float GetFireChaos()
{
    return FireChaos;
}

final simulated function bool PendingForcedReaim()
{
    return bForceReaim;
}

// Returns the interpolated base aim with its offset, chaos, etc and view aim removed in the form of a single rotator
final simulated function Rotator GetAimPivot(optional bool bIgnoreViewAim)
{
	if (bIgnoreViewAim || BW.InstigatorController == None || PlayerController(BW.InstigatorController) == None || PlayerController(BW.InstigatorController).bBehindView)
		return AimOffset + Aim + LongGunPivot * FMax(LongGunFactor, DisplaceFactor);
	return AimOffset + Aim * (1-ViewBindFactor) + LongGunPivot * FMax(LongGunFactor, DisplaceFactor);
}

final simulated function Rotator GetViewPivot()
{
    return Aim * ViewBindFactor;
}

//Firemodes use this to convert the portion of ChaosAimSpread not used for movement-related shenanigans
final simulated function float CalcConeInaccuracy()
{
	return AimSpread.Max * (1 - ((360/ChaosSpeedThreshold) * Chaos)) * FireChaos;
}

final simulated function Rotator CalcFutureAim(float ExtraTime, bool bIgnoreViewAim)
{	
    if (bIgnoreViewAim || BW.InstigatorController == None || PlayerController(BW.InstigatorController) == None || PlayerController(BW.InstigatorController).bBehindView)
        return GetFutureAimOffset(ExtraTime) + GetFutureAim(ExtraTime) + GetAimOffsets();
    return GetFutureAimOffset(ExtraTime) + GetFutureAim(ExtraTime) * (1-ViewBindFactor) + GetAimOffsets();
}

private final simulated function Rotator GetAimOffsets()
{
	return AimOffset + LongGunPivot * LongGunFactor;
}

private final simulated function Rotator GetFutureAim(float ExtraTime)
{
	return class'BUtil'.static.RSmerp(FMin((ReaimPhase+ExtraTime)/ReaimTime, 1.0), OldAim, NewAim);
}

private final simulated function Rotator GetFutureAimOffset(float ExtraTime)
{
	return class'BUtil'.static.RSmerp(FMax(0.0,(AimOffsetTime-(Level.TimeSeconds+ExtraTime))/AimAdjustTime), NewAimOffset,OldAimOffset);
}

//=============================================================
// Mutators
//=============================================================
final simulated function Rotator CalcViewPivotDelta()
{
    local Rotator CurViewPivot, DeltaPivot;

    CurViewPivot = GetViewPivot();

    DeltaPivot = CurViewPivot - LastViewPivot;

    LastViewPivot = CurViewPivot;

    return DeltaPivot;
}

final simulated function ForceReaim()
{
    bForceReaim = True;
}

final simulated function SetLastLookDir(Rotator rot)
{
    OldLookDir = rot;
}

// Sets new aimoffset and gets AimOffset to interpolate to it over a period set by ShiftTime
final simulated function SetNewAimOffset(Rotator NewOffset, float ShiftTime)
{
	OldAimOffset = AimOffset;
	NewAimOffset = NewOffset;
	AimOffsetTime = Level.TimeSeconds + ShiftTime;
}

//=============================================================
// Cleanup (hello where are the RAII?)
//=============================================================
final simulated function Cleanup()
{
	BW = None;
	Level = None;

    Params = None;
    
    ChaosDeclineTime = 0;
    AimAdjustTime = 0;
    CrouchMultiplier = 1;

    Aim = rot(0,0,0);
    NewAim = rot(0,0,0);
    OldAim = rot(0,0,0);

    ReaimTime = 0;
    ReaimPhase = 0;
    bReaiming = false;
    NextZeroAimTime = 0;

    AimOffset = rot(0,0,0);
    NewAimOffset = rot(0,0,0);
    OldAimOffset = rot(0,0,0);
    AimOffsetTime = 0;

    LastViewPivot = rot(0,0,0);
    ViewBindFactor = 0;

    bJumpLock = false;
    bForceReaim = false;

    Chaos = 0;
    NewChaos = 0;
    OldChaos = 0;
    OldLookDir = rot(0,0,0);

    FireChaos = 0;
    
    LongGunFactor = 0;
    NewLongGunFactor = 0;

    DisplaceFactor = 0;
    DisplaceEndTime = 0;
    DisplaceDurationMult = 0;

	bSprintOffset=False;
}

//=============================================================
// Gameplay
//=============================================================
final simulated function Recalculate()
{    
    assert(Params != None);
    
    AimSpread           = Params.AimSpread;
    AimAdjustTime       = Params.AimAdjustTime;
    ChaosDeclineTime    = Params.ChaosDeclineTime;
    ChaosSpeedThreshold = Params.ChaosSpeedThreshold;
    ChaosTurnThreshold	= Params.ChaosTurnThreshold;
	CrouchMultiplier    = Params.CrouchMultiplier;

	if (ViewBindFactor == 0)
		ViewBindFactor = Params.ViewBindFactor;

    // VelocityAimAdjustMult = 1;

	BW.OnAimParamsChanged();
}

final simulated function OnPreDrawFPWeapon()
{
    if (LongGunFactor != 0)
        BW.SetLocation(BW.Location + class'BUtil'.static.ViewAlignedOffset(BW, LongGunOffset) * LongGunFactor);
}

final simulated function OnWeaponSelected()
{
	OldLookDir = BW.GetPlayerAim();

	bSprintOffset = (BW.SprintControl != None && BW.SprintControl.bSprintActive);

	AimOffset = CalcNewAimOffset();
	NewAimOffset = AimOffset;
	OldAimOffset = AimOffset;
}

//=============================================================
// ADS
//=============================================================
final simulated function UpdateADSTransition(float delta)
{
    ViewBindFactor = Smerp(delta, Params.ViewBindFactor, 1);
}

final simulated function bool AllowADS()
{
    return NewLongGunFactor == 0 && !IsDisplaced();
}

final simulated function ApplyADSModifiers()
{
	AimSpread.Min = 0;
    AimSpread.Max *= Params.ADSMultiplier;

	/*
    AimSpread.Max = AimSpread.Min;
    VelocityAimAdjustMult = 0.5f;
	*/
}

final simulated function OnADSViewStart()
{
    ViewBindFactor = 1.0;
}

final simulated function OnADSViewEnd()
{
    ViewBindFactor = Params.ViewBindFactor;
}

final simulated function OnADSEnd()
{
    Recalculate();

    if (!bJumpLock)
    {
        Reaim(0.1); //Prevent advantage from aim key spam (f.ex to focus hipfire)
        bForceReaim=true;
    }
}

//=============================================================
// Player move events
//=============================================================
final simulated function OnPlayerJumped()
{
	// problematic. we want a consistent basic offset for this, not a reaim.
    Reaim(0.05, AimAdjustTime, Params.JumpChaos, Params.JumpOffset.Yaw, Params.JumpOffset.Pitch);
    bJumpLock = True;
    FireChaos += Params.JumpChaos;
    bForceReaim=true;
}

final simulated function OnPlayerSprint(bool bSprint)
{
	bSprintOffset = bSprint;

    SetNewAimOffset(CalcNewAimOffset(), Params.OffsetAdjustTime);
    Reaim(0.05, AimAdjustTime, Params.SprintChaos);
}

//=============================================================
// Aim
//=============================================================
final simulated function RecoilReaim(float chaos)
{
    if (!bReaiming)
	    Reaim(Level.TimeSeconds-BW.LastRenderTime, , , , , chaos);
}

final simulated function AddFireChaos(float chaos)
{
	FireChaos = FClamp(FireChaos + chaos, 0, 1);
	LastFireChaosTime = Level.TimeSeconds;
}

// This a major part of of the aiming system. It checks on things and interpolates Aim, AimOffset, Chaos,  Recoil, and
// CrosshairScale. Calls Reaim if it detects view change or movement and constantly sets the gun pivot and view rotation.
// Azarael - fixed recoil bug here
final simulated function UpdateAim(float DT)
{
	if (BW.bAimDisabled)
	{
		Aim = rot(0,0,0);
		return;
	}
	
    UpdateReaim(DT);

	// Interpolate the AimOffset
	if (AimOffset != NewAimOffset)
        AimOffset = class'BUtil'.static.RSmerp(FMax(0.0,(AimOffsetTime-Level.TimeSeconds)/Params.OffsetAdjustTime), NewAimOffset, OldAimOffset);
        
    // Chaos decline
	if (Chaos > 0)
    {
        if (BW.Instigator.bIsCrouched)
            Chaos -= FMin(Chaos, DT / (ChaosDeclineTime * CrouchMultiplier));
        else
            Chaos -= FMin(Chaos, DT / ChaosDeclineTime);
    }

    // Fire chaos decline
    if (FireChaos > 0 && LastFireChaosTime + Params.ChaosDeclineDelay < Level.TimeSeconds)
    {
        if (BW.Instigator.bIsCrouched)
            FireChaos -= FMin(FireChaos, DT / (ChaosDeclineTime / CrouchMultiplier));
        else
            FireChaos -= FMin(FireChaos, DT / ChaosDeclineTime);
    }

    // Change aim adjust time for player velocity
	if (BW.Instigator.Base != None)
        AimAdjustTime = (Params.AimAdjustTime * 2) - (Params.AimAdjustTime * (FMin(VSize(BW.Instigator.Velocity - BW.Instigator.Base.Velocity), 375) / 350));
    else
        AimAdjustTime = Params.AimAdjustTime;

	/* Azarael 13/03/2023 - wip sway impl - requires general changes so not done yet
    AimAdjustTime = Params.AimAdjustTime;

    // Change aim adjust time for player velocity
	if (BW.Instigator.Base != None)
        AimAdjustTime *= 1.0f - ((0.66f * (FMin(VSize(BW.Instigator.Velocity - BW.Instigator.Base.Velocity), 260) / 260)) * VelocityAimAdjustMult);
	*/
}

final simulated function UpdateReaim(float DT)
{
    // Currently in aim transition - update.
	if (bReaiming)
	{	
		ReaimPhase += DT;

		if (ReaimPhase >= ReaimTime)
			StopAim();
		else
			Aim = class'BUtil'.static.RSmerp(ReaimPhase/ReaimTime, OldAim, NewAim);
	}

	// Not in aim transition. Queue next move.
	else if (BW.Instigator.Physics == PHYS_Falling)
		Reaim(DT, , Params.FallingChaos);
	
    // Azarael 13/03/2023:
    // We always want to be reaiming.
    // 1) that's how we implement gun sway, and
    // 2) if our last reaim pushed the aim to a rotation that is distant from centre, and our chaos drops in the meantime, we will get a huge 
    // reaim as soon as the player moves their view. This is particularly obnoxious with snipers
	else // if (bForceReaim || BW.GetPlayerAim() != OldLookDir || (BW.Instigator.Physics != PHYS_None && VSize(BW.Instigator.Velocity) > 100))
		Reaim(DT);
}

// Checks up on things and returns what our AimOffset should be
final simulated function Rotator CalcNewAimOffset()
{
	local Rotator R;

    R = rot(0,0,0);
    
    if (BW.IsHoldingMelee())
        return R;

    if (bSprintOffset)
	{
		R.Pitch += Params.SprintOffset.Pitch;
		if (BW.Instigator.Controller.Handedness < 0)
			R.Yaw -= Params.SprintOffset.Yaw;
		else R.Yaw += Params.SprintOffset.Yaw;
	}
		
	return R;
}

// Aim system only handles movement penalties in Pro. Wildness caused by weapon firing is conefire.
// In Classic, the below vars are used
// Sets NewAim, OldAim, interpolation time and adds chaos. Another key part of the aiming system. Entry point for aim system...
// DT 	 		Should be time since last tick,
// TimeMod	 	Set this to use custom time instead of AimAdjustTime,
// ExtraChaos	Extra amount added to chaos
// XMod			Extra Yaw Added to new aim,
// YMod			Extra Pitch Added to new aim,
// BaseChaos	Minimum chaos for new aim. (Player turn chaos and ExtraChaos are still added after this)
final simulated function Reaim (float DT, optional float TimeMod, optional float ExtraChaos, optional float XMod, optional float YMod, optional float BaseChaos)
{
	local int RDist;
	local float VResult, X, Y, T, CAF, XValue, YValue;
	local Rotator ViewOff, R;
	local Vector V;//, Forward, Right, up;

	if (BW.bAimDisabled)
		return;
		
	if (bJumpLock)
		bJumpLock = False;
		
	if (BW.bUseNetAim && BW.Role < ROLE_Authority)
		return;

	bForceReaim=false;

	// Calculate chaos caused by movement
	if (BW.Instigator.Physics != PHYS_None)
	{
		V = BW.Instigator.Velocity;
		if (BW.Instigator.Base != None)

			V -= BW.Instigator.Base.Velocity;
		VResult = VSize(V) / ChaosSpeedThreshold;
	}

	OldChaos = NewChaos;

	//Changed how this is worked out.
	//Uses ChaosSpeedThreshold (VResult) to provide a basic movement penalty.
	if (class'BallisticReplicationInfo'.static.IsArenaOrTactical())
	{
		Chaos = FClamp(VResult, 0, 1 );
		NewChaos = Chaos;
		XValue = FRand();
		YValue = FRand();
	}
	else //classic heavy chaos
	{
		// Figure out how much the view changed
		ViewOff = BW.GetPlayerAim() - OldLookDir;
		R.Yaw = Abs(ViewOff.Yaw);		R.Pitch = Abs(ViewOff.Pitch);
		RDist = int(Sqrt((R.Yaw*R.Yaw) + (R.Pitch*R.Pitch)));
		
		// Add some wildness depending on how much view changed and player movement speed.
		// Chaos is calculated as (BaseChaos + Move Speed Chaos) unleass current chaos is already higher,
		// then it adds (View Change Chaos * CrouchAimFactor) + ExtraChaos.
		if (BW.Instigator.bIsCrouched)	CAF = CrouchMultiplier;	else CAF = 1;
		Chaos = FClamp(FMax(BaseChaos+VResult, Chaos) + ExtraChaos + CAF*((RDist/DT)/ChaosTurnThreshold), 0, 1 );
		NewChaos = Chaos;

		if (PlayerController(BW.Instigator.Controller) != None && RDist > 0)
		{	// Bias new aim according to direction player was turning
			XValue = 0.5 + FRand() * 0.5 * (( (ViewOff.Yaw/R.Yaw)*2 + (FRand()*2 - 1) )/3);
			YValue = 0.5 + FRand() * 0.5 * (( (ViewOff.Pitch/R.Pitch)*2 + (FRand()*2 - 1) )/3);
		}
		else
		{	// Random direction
			XValue = FRand();
			YValue = FRand();
		}
		
	}

	// Calculate new aim
	// The previous section only tracks movement-induced chaos for the sake of an accurately updated crosshair.
	X = XMod + Lerp( XValue, Lerp(Chaos, -AimSpread.Min, -AimSpread.Max), Lerp(Chaos, AimSpread.Min, AimSpread.Max) );
	Y = YMod + Lerp( YValue, Lerp(Chaos, -AimSpread.Min, -AimSpread.Max), Lerp(Chaos, AimSpread.Min, AimSpread.Max) );
	
	if (BW.Instigator.bIsCrouched)
	{
		X *= CrouchMultiplier;
		Y *= CrouchMultiplier;
	}

	if (TimeMod!=0)
		T = TimeMod;
	else
        T = AimAdjustTime;
        
	StartAim(T, X, Y);

	if (BW.bUseNetAim)
		SendNewAim();
}

// Start aim interpolation
private final simulated function StartAim(float Time, float Yaw, float Pitch)
{
	bReaiming = true;
	OldAim = Aim;
	ReaimTime = Time;
	ReaimPhase = 0;
	NewAim.Yaw = Yaw;
	NewAim.Pitch = Pitch;
}

// Stop interpolating the aim and set it to the end point
private final simulated function StopAim()
{
	bReaiming = false;
	Aim = NewAim;
	ReaimPhase = 0;
}

final simulated function ZeroAim(float TimeMod)
{
    if (Level.TimeSeconds < NextZeroAimTime || bJumpLock)
        return;

    StartAim(TimeMod, 0, 0);

	if (BW.bUseNetAim)
        SendNewAim();
}

final simulated function UpdateDisplacements(float delta)
{
	if (class'BallisticReplicationInfo'.default.bLongWeaponOffsetting && GunLength > 0)
        TickLongGun(delta);
        
	if (IsDisplaced())
		TickDisplacement(delta);
}

//=============================================================
// Long Gun
//=============================================================
private final simulated function TickLongGun (float DT)
{
	local Actor		T;
	local Vector	HitLoc, HitNorm, Start;
	local float		Dist;

	LongGunFactor += FClamp(NewLongGunFactor - LongGunFactor, -DT/Params.OffsetAdjustTime, DT/Params.OffsetAdjustTime);

	Start = BW.Instigator.Location + BW.Instigator.EyePosition();
    T = BW.Trace(HitLoc, HitNorm, Start + vector(BW.Instigator.GetViewRotation()) * (GunLength+BW.Instigator.CollisionRadius), Start, true);
	
	if (T == None || T.Base == BW.Instigator || (Pawn(T) == None && T.Owner == BW.Instigator) || BW.MeleeState != MS_None)
	{
        BW.OnDisplaceEnd();
		NewLongGunFactor = 0;
	}
	else
	{
		Dist = FMax(0, VSize(HitLoc - Start)-BW.Instigator.CollisionRadius);
		if (Dist < GunLength)
		{
            BW.OnDisplaceStart();
			NewLongGunFactor = Acos(Dist / GunLength)/1.570796;
		}
	}
}

//=============================================================
// Weapon Displacement
//=============================================================
final simulated function DisplaceAim(float Duration)
{
    Duration = FMin(2.0f, Duration * DisplaceDurationMult);

    if (Level.TimeSeconds + Duration <= DisplaceEndTime)
        return;

    DisplaceEndTime = Level.TimeSeconds + Duration;

    BW.OnWeaponDisplaced();

    if (BW.Role == ROLE_Authority)
        BW.ClientDisplaceAim(Duration);
}

private final simulated function TickDisplacement(float DT)
{
	if (DisplaceEndTime > Level.TimeSeconds)
	{
        DisplaceFactor = FMin (DisplaceFactor + DT/0.2, 0.75);
        
		if (!BW.bServerReloading)
            BW.bServerReloading = True;
    }
        
	else 
	{
        DisplaceFactor = FMax(DisplaceFactor-DT/0.35, 0);
        
		if (BW.bServerReloading)
            BW.bServerReloading=False;
	}
}

//=============================================================
// Replication
//=============================================================
private final function SendNewAim()
{
    local float Yaw, Pitch, Time;

	Yaw = NewAim.Yaw;
	Pitch = NewAim.Pitch;
    Time = ReaimTime;
    
	BW.ReceiveNetAim(Yaw, Pitch, Time, OldChaos, NewChaos);
}

final simulated function ReceiveNetAim(float Yaw, float Pitch, float Time, float oChaos, float nChaos)
{
	if (!BW.bUseNetAim || BW.Role == ROLE_Authority)
		return;

	bReaiming=true;
	OldAim = Aim;
	OldChaos = oChaos;
	NewChaos = nChaos;
	ReaimPhase = 0;
	ReaimTime = Time;
	NewAim.Yaw = Yaw;
	NewAim.Pitch = Pitch;
}

final simulated function ApplyDamageFactor(int Damage)
{
    local float DF;

    DF = FMin(1, (float(Damage)/Params.AimDamageThreshold) * BW.AimKnockScale);

	Reaim(0.1, 0.3*AimAdjustTime, DF*2, DF*2*(-3500 + 7000 * FRand()), DF*2*(-3000 + 6000 * FRand()));
    bForceReaim = True;
    
    if (BW.Role == ROLE_Authority)
        BW.ClientPlayerDamaged(Damage);
}

final simulated function float CalcCrosshairOffset(Canvas C)
{
    local float OffsetAdjustment;

    if (AimSpread.Max <= 32)
        return 0;

    OffsetAdjustment = C.ClipX / 2;
    
    if (bReaiming)
        OffsetAdjustment *= tan ((AimSpread.Min + ((AimSpread.Max - AimSpread.Min) * FClamp(Lerp(ReaimPhase/ReaimTime, OldChaos, NewChaos) + ((1 - (360/Params.ChaosSpeedThreshold)* NewChaos) * FireChaos), 0, 1))) * 0.000095873799) / tan((BW.InstigatorController.FovAngle/2) * 0.01745329252);
    else
        OffsetAdjustment *= tan ((AimSpread.Min + ((AimSpread.Max - AimSpread.Min) * FClamp(NewChaos + ((1 - (360/Params.ChaosSpeedThreshold) * NewChaos) * FireChaos), 0, 1))) * 0.000095873799) / tan((BW.InstigatorController.FovAngle/2) * 0.01745329252);

    return OffsetAdjustment;
}

//=============================================================
// Debug
//=============================================================
final simulated function DrawDebug(Canvas Canvas)
{
    Canvas.DrawText("AimComponent: Chaos: "$Chaos$", ReaimPhase: "$ReaimPhase$", Aim: "$Aim.Yaw$","$Aim.Pitch$" Aim Adjust Time: "$AimAdjustTime);
}