//=============================================================================
// AimComponent.
//
// Represents the aim system component of a Ballistic Weapon.
//
// by Azarael 2020
// adapting code written by DarkCarnivour, whose comments are below:
//
// Aim Stuff -----------------------------------------------------------------------------------------------------------
// This is the eccessivly complicated aiming system.
// Basically, a Rotator(Aim) and rotator generated from the recoil are used to offset the gun from the player's view.
// Aim is the base aim of the gun. Aim is interpolated randomly, within the ranges set by AimSpread. AimAdjustTime is
// used to set how long it takes to shift. Aim only changes when the player turns of moves.
//
// Chaos is applied when the player moves, jumps, turns, etc and greatly ruins a players ability to aim accurately. The
// faster and more wildly the player moves, the more chaos is aplied to the weapon. When no chaos is applied the Aim will be
// randomly interpolated whithin the ranges set by AimSpread.Min. When full chaos is applied, the Aim uses the ranges set
// by AimSpread.Max. AimSpread.Min ranges can be used as a minimum spread and AimSpread.Max as the maximum spread. Aim
// spread is adjusted smoothly between AimSpread.Min and AimSpread.Max depedning on chaos level.
//=============================================================================
class AimComponent extends Object;

//=============================================================================
// ACTOR/OBJECT REFERENCES
//
// MUST BE CLEANED UP FROM THE WEAPON CODE
//=============================================================================
var BallisticWeapon				Weapon;
var LevelInfo					Level;
var Pawn						Instigator;
var AimParams				    Params;

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
var private Rotator				OldAim;				    // Where aim poitner was before it started moving

var	private float				ReaimTime;			    // Time it should take to move aim pointer to new position
var private float				ReaimPhase;			    // How far along pointer is in its movement from old to new
var private bool				bReaiming;			    // Is the pointer being reaimed?
var	private float				NextZeroAimTime;		// For zeroing aim when scoping

var private Rotator				AimOffset;			    // Extra Aim offset. Set NewAimOffset and AimOffsetTime to have this move smoothly
var private Rotator				NewAimOffset;		    // This is what AimOffset should be and is adjusted for sprinting and so on
var private Rotator				OldAimOffset;		    // AimOffset before it started shifting. Used for interpolationg AimOffset
var	private float				AimOffsetTime;		    // Time when AimOffset should reach NewAimOffset. Used for interpolationg AimOffset

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
var	private float				DisplaceFactor;         // Current factor for aim displacement.

//=============================================================
// Accessors
//=============================================================
final simulated function bool IsDisplaced()
{
	return (DisplaceEndTime > Level.TimeSeconds || DisplaceFactor > 0);
}

final simulated function bool PendingForcedReaim()
{
    return bForceReaim;
}

// Returns the interpolated base aim with its offset, chaos, etc and view aim removed in the form of a single rotator
final simulated function Rotator GetAimPivot(optional bool bIgnoreViewAim)
{
	if (bIgnoreViewAim || Instigator.Controller == None || PlayerController(Instigator.Controller) == None || PlayerController(Instigator.Controller).bBehindView)
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
	Weapon = None;
	Level = None;
	Instigator = None;

    Params = None;
    
    ChaosDeclineTime = 0;
    AimAdjustTime = 0;

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
}

//=============================================================
// Gameplay
//=============================================================
final simulated function Recalculate()
{
    AimSpread           = Params.AimSpread;
    AimAdjustTime       = Params.AimAdjustTime;
    ChaosDeclineTime    = Params.ChaosDeclineTime;
    ChaosSpeedThreshold = Params.ChaosSpeedThreshold;

	Weapon.OnAimParamsChanged();
}

final simulated function OnPreDrawFPWeapon()
{
    if (LongGunFactor != 0)
        Weapon.SetLocation(Weapon.Location + class'BUtil'.static.ViewAlignedOffset(Weapon, LongGunOffset) * LongGunFactor);
}

final simulated function OnWeaponSelected()
{
	OldLookDir = Weapon.GetPlayerAim();
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

final simulated function OnADSStart()
{
    AimSpread.Min = 0;
    AimSpread.Max *= Params.ADSMultiplier;
    
    ChaosDeclineTime *= 2.0;
    ChaosSpeedThreshold *= 0.7;
}

final simulated function OnADSViewStart()
{
    ViewBindFactor = 1.0;
}

final simulated function OnADSViewEnd()
{
    // BallisticWeapon's PositionSights will handle this for clients
    if (Level.NetMode == NM_DedicatedServer)
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
    Reaim(0.05, AimAdjustTime, Params.JumpChaos, Params.JumpOffset.Yaw, Params.JumpOffset.Pitch);
    bJumpLock = True;
    FireChaos += Params.JumpChaos;
    Weapon.LastFireTime = Level.TimeSeconds;
    bForceReaim=true;
}

final simulated function OnPlayerSprint()
{
    SetNewAimOffset(CalcNewAimOffset(), Params.OffsetAdjustTime);
    Reaim(0.05, AimAdjustTime, Params.SprintChaos);
}

//=============================================================
// Aim
//=============================================================
final simulated function AddFireChaos(float chaos)
{
    if (!bReaiming)
	    Reaim(Level.TimeSeconds-Weapon.LastRenderTime, , , , , chaos);
}

// This a major part of of the aiming system. It checks on things and interpolates Aim, AimOffset, Chaos,  Recoil, and
// CrosshairScale. Calls Reaim if it detects view change or movement and constantly sets the gun pivot and view rotation.
// Azarael - fixed recoil bug here
final simulated function UpdateAim(float DT)
{
	if (Weapon.bAimDisabled)
	{
		Aim = rot(0,0,0);
		return;
	}
	
	// Interpolate aim
	if (bReaiming)
	{	
		ReaimPhase += DT;
		if (ReaimPhase >= ReaimTime)
			StopAim();
		else
			Aim = class'BUtil'.static.RSmerp(ReaimPhase/ReaimTime, OldAim, NewAim);
	}

	// Fell, Reaim
	else if (Instigator.Physics == PHYS_Falling)
		Reaim(DT, , Params.FallingChaos);
	
	// Moved, Reaim
	else if (bForceReaim || Weapon.GetPlayerAim() != OldLookDir || (Instigator.Physics != PHYS_None && VSize(Instigator.Velocity) > 100))
		Reaim(DT);

	// Interpolate the AimOffset
	if (AimOffset != NewAimOffset)
        AimOffset = class'BUtil'.static.RSmerp(FMax(0.0,(AimOffsetTime-Level.TimeSeconds)/Params.OffsetAdjustTime), NewAimOffset, OldAimOffset);
        
    // Chaos decline
	if (Chaos > 0)
    {
        if (Instigator.bIsCrouched)
            Chaos -= FMin(Chaos, DT / (ChaosDeclineTime * Params.CrouchMultiplier));
        else
            Chaos -= FMin(Chaos, DT / ChaosDeclineTime);
    }

    // Fire chaos decline
    if (FireChaos > 0 && Weapon.LastFireTime + Params.ChaosDeclineDelay < Level.TimeSeconds)
    {
        if (Instigator.bIsCrouched)
            FireChaos -= FMin(FireChaos, DT / (ChaosDeclineTime / Params.CrouchMultiplier));
        else
            FireChaos -= FMin(FireChaos, DT / ChaosDeclineTime);
    }

    // Change aim adjust time for player velocity
	if (Instigator.Base != none)
        AimAdjustTime = (default.AimAdjustTime * 2) - (default.AimAdjustTime * (FMin(VSize(Instigator.Velocity - Instigator.Base.Velocity), 375) / 350));
    else
        AimAdjustTime = default.AimAdjustTime;
}

// Checks up on things and returns what our AimOffset should be
final simulated function Rotator CalcNewAimOffset()
{
	local Rotator R;

    R = rot(0,0,0);
    
    if (Weapon.IsHoldingMelee())
        return R;

    if (Weapon.SprintActive())
	{
		R.Pitch += Params.SprintOffset.Pitch;
		if (Instigator.Controller.Handedness < 0)
			R.Yaw -= Params.SprintOffset.Yaw;
		else R.Yaw += Params.SprintOffset.Yaw;
	}
		
	return R;
}

//Aim system only handles movement penalties in Pro. Wildness caused by weapon firing is conefire.
final simulated function Reaim (float DT, optional float TimeMod, optional float ExtraChaos, optional float XMod, optional float YMod, optional float BaseChaos)
{
	local float VResult, X, Y, T;
	local Vector V;//, Forward, Right, up;

	if (Weapon.bAimDisabled)
		return;
		
	if (bJumpLock)
		bJumpLock = False;
		
	if (Weapon.bUseNetAim && Weapon.Role < ROLE_Authority)
		return;

	bForceReaim=false;

	// Calculate chaos caused by movement
	if (Instigator.Physics != PHYS_None)
	{
		V = Instigator.Velocity;
		if (Instigator.Base != None)

			V -= Instigator.Base.Velocity;
		VResult = VSize(V) / Params.ChaosSpeedThreshold;
	}

	OldChaos = NewChaos;

	//Changed how this is worked out.
	//Uses ChaosSpeedThreshold (VResult) to provide a basic movement penalty.
	Chaos = FClamp(VResult, 0, 1 );
	NewChaos = Chaos;

	// Calculate new aim
	// The previous section only tracks movement-induced chaos for the sake of an accurately updated crosshair.
	X = XMod + Lerp( FRand(), Lerp(Chaos, -AimSpread.Min, -AimSpread.Max), Lerp(Chaos, AimSpread.Min, AimSpread.Max) );
	Y = YMod + Lerp( FRand(), Lerp(Chaos, -AimSpread.Min, -AimSpread.Max), Lerp(Chaos, AimSpread.Min, AimSpread.Max) );
	
	if (Instigator.bIsCrouched)
	{
		X *= Params.CrouchMultiplier;
		Y *= Params.CrouchMultiplier;
	}

	if (TimeMod!=0)
		T = TimeMod;
	else
        T = AimAdjustTime;
        
	StartAim(T, X, Y);

	if (Weapon.bUseNetAim)
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

	if (Weapon.bUseNetAim)
        SendNewAim();
}

final simulated function UpdateDisplacements(float delta)
{
	if (!class'BCReplicationInfo'.default.bNoLongGun && GunLength > 0)
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

	Start = Instigator.Location + Instigator.EyePosition();
    T = Weapon.Trace(HitLoc, HitNorm, Start + vector(Instigator.GetViewRotation()) * (GunLength+Instigator.CollisionRadius), Start, true);
    
	if (T == None || T.Base == Instigator)
	{
        Weapon.OnDisplaceEnd();
		NewLongGunFactor = 0;
	}
	else
	{
		Dist = FMax(0, VSize(HitLoc - Start)-Instigator.CollisionRadius);
		if (Dist < GunLength)
		{
            Weapon.OnDisplaceStart();
			NewLongGunFactor = Acos(Dist / GunLength)/1.570796;
		}
	}
}

//=============================================================
// Weapon Displacement
//=============================================================
final simulated function DisplaceAim(int Damage, int DamageThreshold, float Duration)
{
    local float DisplaceDuration;

    if (Level.TimeSeconds + Duration <= DisplaceEndTime)
        return;

    DisplaceDuration = FMin(2.0f, Duration * DisplaceDurationMult);

    if (DamageThreshold > 0)
        DisplaceDuration *= float(Damage) / float(DamageThreshold);

    if (Level.TimeSeconds + DisplaceDuration > DisplaceEndTime)
    {
        DisplaceEndTime = Level.TimeSeconds + DisplaceDuration;

        Weapon.OnWeaponDisplaced();

        if (Weapon.Role == ROLE_Authority)
            Weapon.ClientDisplaceAim(DisplaceDuration);
    }
}

private final simulated function TickDisplacement(float DT)
{
	if (DisplaceEndTime > Level.TimeSeconds)
	{
        DisplaceFactor = FMin (DisplaceFactor + DT/0.2, 0.75);
        
		if (!Weapon.bServerReloading)
            Weapon.bServerReloading = True;
    }
        
	else 
	{
        DisplaceFactor = FMax(DisplaceFactor-DT/0.35, 0);
        
		if (Weapon.bServerReloading)
            Weapon.bServerReloading=False;
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
    
	Weapon.ReceiveNetAim(Yaw, Pitch, Time, OldChaos, NewChaos);
}

final simulated function ReceiveNetAim(float Yaw, float Pitch, float Time, float oChaos, float nChaos)
{
	if (!Weapon.bUseNetAim || Weapon.Role == ROLE_Authority)
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

    DF = FMin(1, (float(Damage)/Params.AimDamageThreshold) * Weapon.AimKnockScale);

	Reaim(0.1, 0.3*AimAdjustTime, DF*2, DF*2*(-3500 + 7000 * FRand()), DF*2*(-3000 + 6000 * FRand()));
    bForceReaim = True;
    
    if (Weapon.Role == ROLE_Authority)
        Weapon.ClientPlayerDamaged(Damage);
}

final simulated function float CalcCrosshairOffset(Canvas C)
{
    local float OffsetAdjustment;

    if (AimSpread.Max <= 32)
        return 0;

    OffsetAdjustment = C.ClipX / 2;
    
    if (bReaiming)
        OffsetAdjustment *= tan ((AimSpread.Min + ((AimSpread.Max - AimSpread.Min) * FClamp(Lerp(ReaimPhase/ReaimTime, OldChaos, NewChaos) + ((1 - (360/Params.ChaosSpeedThreshold)* NewChaos) * FireChaos), 0, 1))) * 0.000095873799) / tan((Weapon.InstigatorController.FovAngle/2) * 0.01745329252);
    else
        OffsetAdjustment *= tan ((AimSpread.Min + ((AimSpread.Max - AimSpread.Min) * FClamp(NewChaos + ((1 - (360/Params.ChaosSpeedThreshold) * NewChaos) * FireChaos), 0, 1))) * 0.000095873799) / tan((Weapon.InstigatorController.FovAngle/2) * 0.01745329252);

    return OffsetAdjustment;
}

//=============================================================
// Debug
//=============================================================
final simulated function DrawDebug(Canvas Canvas)
{
    Canvas.DrawText("AimComponent: Chaos: "$Chaos$", ReaimPhase: "$ReaimPhase$", Aim: "$Aim.Yaw$","$Aim.Pitch);
}