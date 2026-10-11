//=============================================================================
// BallisticPawn.
//
// Pawn subclass used by BW to implement certain new features. These Include:
// -The advanced new blood system
// -Archon style deres effects
// -Fix for the frigging crouch bugs
//
// The new Ballistic gore system is rooted here. It is made up 3 main parts:
// Pawn:		 This class. Source of damage, death and all events. Handles
//		spawning and control of body impact, movement and other DB gore.
// BloodManager: Usually accessed through a BallisticDamageType, these handle
//		spawning and control of damage specific gore effects.
// BloodSet:	 Used by pawns, managers and other gore handlers, these hold
//		all the speceis specific gore effects, decals, info, etc.
//
// Net behaviour of hit system:
// SendHitInfo() compresses and adds the hit info to a replicated array.
// HitCounter is incremented and replicated.
// Tick() checks change in HitCounter runs ReceiveHitInfo() for the new hits.
// ReceiveHitInfo() decompresses hit info and sends it to DoHit().
//
// StandAlone/ListenServer hits are recorded until the next tick or the player
// is killed. All hits to a client in the last tick of his life can be treated
// as hits to a corpse. This is done so that weapons like shotguns and other
// multi hitters can dismember multiple limbs.
//
// NOTE: There is no 'pelvis' bone in standard hierachies. This is a keyword to
// tell the gore system about a pelvis hit. The system will still operate on
// the 'spine' bone, but will know to do things very differently...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Couple of edits by Azarael:
// Configurable Walking and Crouching speed.
// Set Movement Anims for "Walking" to "Running" ones.
//=============================================================================
class BallisticPawn extends xPawn;

#EXEC OBJ LOAD File="BallisticThird.ukx"

var	bool				            bResetAnimationAction;

var globalconfig	bool	        bLocalDisableAnimation;
var 				bool	        bDisablePawnAnimation;
var	globalconfig	array<String>   ModelWhitelist;

var Actor					        OldBase;
var float					        LastMoverLeaveTime, MoverLeaveGrace;

// Netcode ------------------------
var RewindCollisionManager          RwColMgr;
// -------------------------------------------------------

// Network support for hit system ------------------------
struct ByteVector			// A low res vector
{
	var() byte X;
	var() byte Y;
	var() byte Z;
};
struct NetHitInfo			// Compressed info for a hit
{
	var() byte				BoneNum;	// Index that tells client which bone was hit
	var() class<DamageType>	DamageType;	// The damagetype. This is very important info
	var() byte				Damage;		// The damage. This is half the actual damage, doubled when decompressed
	var() ByteVector		HitRay;		// The hit direction
	var() ByteVector		HitLoc;		// The hit location
};
var   NetHitInfo	ClientHits[8];			// List of hits replicated to clients

var byte			            Latest;					// Serverside. Used to figure out where in the ClientHits array to add new hits
var byte			            HitCounter, OldHitCounter;// Counter incremented to tell client there are new hits
var int				            LastIndex;				// Last hit played clientside
// -------------------------------------------------------

// StandAlone/Listen hit recording -----------------------
struct HitInfo				// Info for a hit
{
	var() name				Bone;
	var() class<DamageType>	DamageType;
	var() int				Damage;
	var() vector			HitRay;
	var() vector			HitLoc;
};
var   array<HitInfo>	LocalHits;			// A temporary hit record. Hits are delayed so the overal effect of multiple hits in a single
// -------------------------------------------------------

// Gore vars ---------------------------------------------
var Array<Actor>			Stumps;			// List of stumps
var array<Actor>			GoreFX;			// Supposed to be a list of all attached gore effects
var Array<name>				SeveredBones;	// List of bones that have been removed by severing
var class<BallisticBloodSet> BloodSet;		// The BloodSet chosen for this pawn
// -------------------------------------------------------

// Pawn controlled gore effects var ----------------------
var   vector			LastDragLocation;	// Spot where corpse was when last drag mark was placed
var() float				MinDragDistance;	// Minimum distance between drag marks
var() float				MaxPoolVelocity;	// Maximum velocity allowed for making blood pools
var   float				CorpseRestTime;		// Time when corpse came to a rest
var   bool				bBleedingCorpse;	// Is this body bleeding enough to do body impact gore
var	  bool				bBloodPoolSpawned;	// Blood pool has been spawned at current rest position and another is not needed
var   BallisticDecal	BloodPool;			// The expanding pool of blood
var   Emitter			WaterBlood;			// Emitter used for water blood
var() float				HighImpactVelocity;	// Minimum impact velocity required to make high impact marks
var() float				LowImpactVelocity;	// Minimum impact velocity required to make low impact marks
var   float				LastImpactTime;		// Time of last impact mark spawn
var() float				TimeBetweenImpacts;	// Minimum time between impact mark spawning
var   vector			LastImpactNormal;	// Normal of last impact
var   vector			LastImpactLocation;	// Location of last impact
var   BCSprintControl   Sprinter;
var	  float				DodgeReadyTime;		// MoveTime from which the next dodge is allowed
var	  float				DodgeInterval;
// -------------------------------------------------------
var   vector            BloodFlashV, ShieldFlashV;

// New Bw style DeRes vars -------------------------------
var Projector			NewDeResDecal;		// Projector used to great symbol decal on teh floor under the corpse
var Sound				NewDeResSound;		// DeRes sound
var array<Shader>		NewDeResShaders;	// Shaders used to set opacity
var array<FinalBlend>	NewDeResFinalBlends;// FinalBlends' alpha ref is used to create the dissolving effect
// -------------------------------------------------------

//Player
var     BallisticPlayerReplicationInfo BPRI;
var     BallisticReplicationInfo BRI;
var     bool            	pawnNetInit;

// Animations -------------------------------------------
var 	name 				ReloadAnim, CockingAnim, MeleeAnim, MeleeOffhandAnim, MeleeAltAnim, MeleeBlockAnim, MeleeWindupAnim, WeaponSpecialAnim, StaggerAnim;
var 	float 				ReloadAnimRate, CockAnimRate, MeleeAnimRate, WeaponSpecialRate, StaggerRate;
var 	bool				bOffhandStrike;

//Sound -------------------------------
var()   float            	GruntRadius;
var()   float            	FootstepRadius;
// Cover from decorations -----------------------------
var 	array<Actor>		CoverAnchors;

var		int					CrouchEyeHeight;

// Flying exploit
var 	bool				bPendingNegation;

// Support for player transparency
var 	array<Material>		OriginalSkins, Fades;
var 	byte				CurFade, penalty;

var 	bool                bTransparencyInitialized;
var 	bool				bTransparencyOn, bOldTransparency;
	
//Killstreak -----------------------------------------------
var 	bool				bActiveKillstreak; // still used - look to deprecate this.
//Healing------------------------------------------------
var 	float 				NextHealMessageTime;
var		bool				bPreventHealing;
var		Pawn				HealPreventer;
var		int					PreventHealCount;
var 	class<LocalMessage> HealBlockMessage;

var     float               LastDamagedTime;
var		class<DamageType>	LastDamagedType;

//Sloth variables
var 	float 				StrafeScale, BackpedalScale;
var 	float 				MyFriction, OldMovementSpeed;
var     bool                bCanDodge;

// Sliding Variables
var() bool bAllowCrouchSliding; // Whether crouch sliding is allowed
var() float SlideFriction;		 // Friction applied during sliding, affects how quickly the player slows down
var() float SlideCooldownTime;	// Time before the player can slide again after a slide ends
var() float SlidePower;			 // Initial burst power when starting a slide, affects how fast the player accelerates at the start of the slide
var() float SlideLandGraceTime;	// After landing with crouch held, time in which crouching starts a slide at SlideEasyStartSpeed
var() float SlideMomentumTime;	// How long the speed before a sudden drop is remembered as the momentum a slide starts with
var() float SlideDownhillAngle;	// Floor angle in degrees from which moving downhill lets a slide start at SlideEasyStartSpeed
var bool bIsSliding;			 // Is the player currently sliding?
var bool bSlideCrouchHeld;		 // Crouch was held during the last move. A slide starts when this goes from false to true
var bool bBotSlideRequest;		 // An AI controller asked for a slide with StartSlide
var float SlideCooldownEnd;		// MoveTime from which the player can slide again
var float SlideLandGraceEnd;	// MoveTime until which crouching starts a slide at SlideEasyStartSpeed
var vector SlideMomentum;		// Horizontal velocity from before a sudden drop. Landing and releasing sprint both cut speed right before the crouch
var float SlideMomentumEnd;		// MoveTime until which SlideMomentum is remembered
var float SlideStartSpeed;		 // Speed required to start sliding
var float SlideEasyStartSpeed;	 // Speed required to start sliding when landing with crouch held or moving downhill
var float SlideStopSpeed;		 // Speed below which sliding stops
var float MaxSlideSpeed;		// Maximum speed during sliding

// Slide prediction
struct SlideState				// Slide state that the engine neither rewinds nor corrects
{
	var bool	bSliding;
	var bool	bCrouched;
	var bool	bCrouchHeld;
	var float	CooldownEnd;
	var float	LandGraceEnd;
	var vector	Momentum;
	var float	MomentumEnd;
};
var SlideState SavedSlide;		// Client: slide state at the start of the latest move
var bool bSlideMoveStart;		// Client: a move has started and its slide state hasn't been saved yet
var bool bSlideMovePending;		// Client: the controller was holding back the previous move when this one started
var bool bSlideRerunCrouched;	// Client: the move being run again was first run crouched, and the pawn has stood up since
var bool bSlideReplaying;		// Client: saved moves are being replayed after a server correction
var float ReplayMoveTime;		// Client: MoveTime of the move being replayed
var SavedMove ReplayMove;		// Client: the saved move being replayed, or the next one that will be
struct SlideChange				// A change of bIsSliding and the MoveTime of the move it happened in
{
	var float	Stamp;
	var bool	bSliding;
	var bool	bServer;		// Reported by the server. Otherwise it was predicted here
};
var SlideChange SlideLog[8];	// Client: the latest changes, to tell what the slide state was at an earlier move

// Ground speed of past moves
struct SpeedChange				// A change of GroundSpeed between two of the client's moves
{
	var float	Stamp;			// MoveTime of the last move made at OldSpeed
	var float	OldSpeed;
	var float	NewSpeed;
};
var SpeedChange SpeedLog[8];	// Client: the latest changes, to replay moves at the GroundSpeed they were made with
var float LastMoveStamp;		// Client: MoveTime of the latest walking move
var float LastMoveSpeed;		// Client: GroundSpeed it was made with
var float PresentSpeed;			// Client: GroundSpeed from before a replay
var float ReplaySpeed;			// Client: GroundSpeed the replay has set
var bool bReplaySpeedSet;		// Client: GroundSpeed has to go back from ReplaySpeed to PresentSpeed

// Server settings
var bool bGroundSpeedUnsent;	// Client: GroundSpeed is still what this pawn spawned with, so the server may never have sent it
var byte SettingsChecksLeft;	// Client: this pawn arrived before the BallisticReplicationInfo carrying the server's settings. Times left to look for it
var float NextSettingsCheckTime;

// Sliding Animations
var bool  bSlideAnimating;        // slide animations are playing on this machine
var bool  bSlideWaitingStart;     // waiting for start anim to finish
var 	name 		SlideAnims[4]; 
var 	name 		SlideStartAnims[4]; 
var 	name 		SlideEndAnims[4]; 

var() bool  bBotAutoSprint;		 // Pawn auto-manages sprint for bot controllers based on movement context
var() float BotSprintEnemyRange; // Enemy closer than this distance stops auto sprint

//Wall running stuff
//var bool bLockedToSurface; // Tracks if the player is locked to a surface
//var vector LockedSurfaceNormal; // Stores the normal of the locked surface

// --- Crouch/Jump Parameters ---
var float  JumpCrouchEnd;		// MoveTime until which a jump still gets the crouch penalty after standing up
var() float JumpCrouchPenalty;   // Jump height penality when crouch jumping
var() float JumpCrouchTime; 	// Time after we end crouch before jump crouch penalty is removed

// Directional scaling for sliding
var() float BackSlidePowerScale;      // < 1.0 to weaken backward slides
var() float BackMaxSlideSpeedScale;   // < 1.0 to cap backward slide speed lower
var() float BackSlideDotThreshold;    // dot threshold vs forward ( negative means backwards :) )

var bool bRagdollSetup;
var bool bPendingGibFromImpact;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientHits, HitCounter, ClientSetCrouchAbility,
		Sprinter, ClientSlideState;
	// The owning client predicts its own slides. See SyncSlidePrediction
	reliable if (Role == ROLE_Authority && !bNetOwner)
		bIsSliding;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();

	// The server only replicates GroundSpeed when it differs from this class's default over there, which
	// BindDefaultMovement has set to the animation speed. The default of a client's first pawn is another.
	bGroundSpeedUnsent = Role < ROLE_Authority && GroundSpeed == default.GroundSpeed;

	ApplyServerSettings();

	// A client can receive this pawn before the BallisticReplicationInfo that carries the server's settings.
	// Apply them again once it turns up, or the pawn keeps predicting with the wrong ones.
	if (Role < ROLE_Authority && class'BallisticReplicationInfo'.static.GetInstance(self) == None)
		SettingsChecksLeft = 20;

	// FIXME: why is this here? this function is the definition of net init
	if(!pawnNetInit)
    {
        pawnNetInit = true;

        if (Controller != None)
        {
            BPRI = class'Mut_Ballistic'.static.GetBPRI(Controller.PlayerReplicationInfo);
        }
    }
}

simulated function ApplyServerSettings()
{
	if (!class'BallisticReplicationInfo'.default.bBrightPlayers)
	{
		bDramaticLighting=False;
		AmbientGlow=0;
	}

	ApplyMovementOverrides();
	ApplySizeOverrides();

	// replace walk animations if ADS multipliers tend to be high
	if (class'BallisticGameStyles'.static.GetReplicatedStyle().default.bRunInADS)
	{
		WalkAnims[0]='RunF';
		WalkAnims[1]='RunB';
		WalkAnims[2]='RunL';
		WalkAnims[3]='RunR';
	}
}

simulated function vector CalcDrawOffset(inventory Inv)
{
	local vector DrawOffset;

	if ( Controller == None )
		return (Inv.PlayerViewOffset >> Rotation) + BaseEyeHeight * vect(0,0,1);

	DrawOffset = ((0.9/60 * 100 * ModifiedPlayerViewOffset(Inv)) >> GetViewRotation() ); // hardcode displayfov of 60 for offset purposes here. otherwise, scaling breaks in 16:9

	if ( !IsLocallyControlled() )
		DrawOffset.Z += BaseEyeHeight;
	else
	{
		DrawOffset.Z += EyeHeight;
        //if( bWeaponBob )
		DrawOffset += WeaponBob(Inv.BobDamping);
        DrawOffset += CameraShake();
	}

	return DrawOffset;
}

simulated final function BindDefaultMovement()
{
    default.WalkingPct = WalkingPct;
    default.CrouchedPct = CrouchedPct;
    default.StrafeScale = StrafeScale;
    default.BackpedalScale = BackpedalScale;
	// used for animations in C++. do not change
	default.GroundSpeed = class'BallisticReplicationInfo'.default.PlayerAnimationGroundSpeed;
    default.AirSpeed = AirSpeed;
	default.LadderSpeed = LadderSpeed;
    default.AccelRate = AccelRate;
    default.JumpZ = JumpZ;
	default.DodgeSpeedFactor = DodgeSpeedFactor;
    default.DodgeSpeedZ = DodgeSpeedZ;

    default.WalkAnims[0] = WalkAnims[0];
	default.WalkAnims[1] = WalkAnims[1];
	default.WalkAnims[2] = WalkAnims[2];
	default.WalkAnims[3] = WalkAnims[3];
}

simulated function ApplyMovementOverrides()
{ 
	if (!class'BallisticReplicationInfo'.default.bAllowDodging)
    {
		bCanWallDodge = false;
        bCanDodge = false;
    }

    if (!class'BallisticReplicationInfo'.default.bAllowDoubleJump)
    {
        bCanDoubleJump = false;
    }

	bAllowCrouchSliding = class'BallisticReplicationInfo'.default.bAllowCrouchSliding;

	WalkingPct = class'BallisticReplicationInfo'.default.PlayerWalkSpeedFactor;
	CrouchedPct = class'BallisticReplicationInfo'.default.PlayerCrouchSpeedFactor;
	StrafeScale = class'BallisticReplicationInfo'.default.PlayerStrafeScale;
	BackpedalScale = class'BallisticReplicationInfo'.default.PlayerBackpedalScale;

	// prevent fighting with server when using Freon round start locker
	if (Role == ROLE_Authority )
		GroundSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed;

	AirSpeed = class'BallisticReplicationInfo'.default.PlayerAirSpeed;
	LadderSpeed = GroundSpeed * 0.65f;
	AccelRate = class'BallisticReplicationInfo'.default.PlayerAccelRate;
	JumpZ = class'BallisticReplicationInfo'.default.PlayerJumpZ;
	DodgeSpeedFactor = class'BallisticReplicationInfo'.default.PlayerDodgeSpeedFactor;
	DodgeSpeedZ = class'BallisticReplicationInfo'.default.PlayerDodgeZ;

	if (class'BallisticReplicationInfo'.static.IsTactical())
	{
		DodgeInterval = 1.25;
		bCanWallDodge = false;
	}

	BindDefaultMovement();
}

simulated function ApplySizeOverrides()
{
	//I should put this in gamestyleconfig but I'm lazy. Arena applies to non BW games that use BPawn
	if (class'BallisticReplicationInfo'.static.IsArena() || class'BallisticReplicationInfo'.static.IsClassic())
	{
		default.BaseEyeHeight=38.000000; //UT38 (BW30)
		default.CrouchHeight=29.000000; //UT29 (BW32)
	}
}

simulated function CreateColorStyle()
{
	local int i;
	
	local String texDetailString;
	
	for(i = 0;i < Skins.Length;i++)
	{
		OriginalSkins[i] = Skins[i];
		Skins[i] = Fades[curFade]; 
	}
	
	// Spot penalty for using low settings.
	texDetailString = Level.GetLocalPlayerController().ConsoleCommand("get ini:Engine.Engine.ViewportManager TextureDetailWorld");
	
	switch(texDetailString)
	{
		case "UltraLow": penalty = 5; break;
		case "VeryLow": penalty = 5; break;
		case "Low": penalty = 5; break;
		case "Lower": penalty = 4; break;
		case "Normal": penalty = 3; break;
		case "High":	penalty = 2; break;
		case "Higher": penalty = 1; break;
		default: penalty = 0; break;	
	}
	
	if (!bool(Level.GetLocalPlayerController().ConsoleCommand("get ini:Engine.Engine.RenderDevice DetailTextures")))
		penalty += 2;
		
	bTransparencyInitialized = true;

}

exec simulated function AdjustAlphaFade(byte Amount)
{
	local int i;
	local int lastFade;
	
	if (!bTransparencyInitialized)
	{
		if (Amount == 255)
			return;
			
		CreateColorStyle();

		bTransparencyOn = true;
		AmbientGlow = 0;		
		Visibility = 1;
		
		curFade = Min(Amount >> 3, 14);
		
		bDramaticLighting = (curFade > 5);
		
		if (penalty > 0)
		{	
			if (curFade >= penalty)
				curFade -= penalty;
			else curFade = 0;
		}
		
		for(i = 0; i < Skins.Length; ++i)
		{
			if (Skins[i] == None)
				continue;
			Skins[i] = Fades[curFade];				
		}
	}
	
	else if (bTransparencyOn)
	{
		if (Amount == 255)
		{
			Visibility = default.Visibility;
			for(i=0;i<Skins.Length;++i)
				Skins[i] = OriginalSkins[i];
			bTransparencyOn = false;
			bDramaticLighting = true;
		}
		else
		{
			// Update fade
			lastFade = curFade;
			curFade = Min(Amount >> 3, 15);
			
			bDramaticLighting = (curFade > 5);
			
			if (penalty > 0)
			{	
				if (curFade >= penalty)
					curFade -= penalty;
				else curFade = 0;
			}
			
			if (lastFade != curFade)
			{
				for(i = 0; i < Skins.Length; ++i)
				{
					if (Skins[i] == None)
						continue;
					Skins[i] = Fades[curFade];				
				}
			}
		}
	}
	
	else
	{
		if (Amount < 255)
		{
			bTransparencyOn = true;
			AmbientGlow = 0;
			Visibility = 1;
			
			// Update fade
			curFade = Min(Amount >> 3, 15);
			
			bDramaticLighting = (curFade > 5);
			
			if (penalty > 0)
			{	
				if (curFade >= penalty)
					curFade -= penalty;
				else curFade = 0;
			}
			
			for(i = 0; i < Skins.Length; ++i)
			{
				if (Skins[i] == None)
					continue;
				Skins[i] = Fades[curFade];				
			}
		}
	}
}

simulated function CancelTransparency()
{
	local int i;
	
	if (!bTransparencyInitialized)
		return;
		
	for (i=0; i<Skins.length; ++i)
		Skins[i] = OriginalSkins[i];	
		
	bTransparencyInitialized = false;
	bTransparencyOn = false;
}

// Refusue overlays when in transparent mode
simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	if (!bTransparencyOn)
		Super.SetOverlayMaterial(mat,time,bOverride);
}

simulated function TickFX(float DeltaTime)
{
    if ( SimHitFxTicker != HitFxTicker )
    {
        ProcessHitFX();
    }

	if((bInvis && !bOldInvis) || (bTransparencyOn && !bOldTransparency)) // Going invisible
	{
		// Remove/disallow projectors on invisible people
		Projectors.Remove(0, Projectors.Length);
		bAcceptsProjectors = false;

		// Invisible - no shadow
		if(PlayerShadow != None)
			PlayerShadow.bShadowActive = false;

		// No giveaway flames either
		RemoveFlamingEffects();
	}
	else if(!bInvis && bOldInvis || (!bTransparencyOn && bOldTransparency)) // Going visible
	{
		bAcceptsProjectors = Default.bAcceptsProjectors;

		if(PlayerShadow != None)
			PlayerShadow.bShadowActive = true;
	}

	bOldTransparency = bTransparencyOn;

    bDrawCorona = ( !bNoCoronas && !bInvis && !bTransparencyOn && (Level.NetMode != NM_DedicatedServer)	&& !bPlayedDeath && (Level.GRI != None) && Level.GRI.bAllowPlayerLights
					&& (PlayerReplicationInfo != None) );


	if ( bDrawCorona && (PlayerReplicationInfo.Team != None) )
	{
		if ( PlayerReplicationInfo.Team.TeamIndex == 0 )
			Texture = Texture'RedMarker_t';
		else
			Texture = Texture'BlueMarker_t';
	}
}

function bool AddInventory( inventory NewItem )
{
    local bool ret;
    ret = Super.AddInventory(NewItem);

    if(NewItem != none && BCSprintControl(NewItem) != none)
	{
        sprinter = BCSprintControl(NewItem);
		//log("BallisticPawn: AddInventory: Added BCSprintControl " @ sprinter);
	}

    return ret;
}

event HitWall(vector HitNormal, actor Wall)
{
	if (Controller != None)
		Controller.NotifyHitWall(HitNormal, Wall);
	
	if (VSize(Velocity) > 900)
		bPendingNegation=True;
	
}

event Landed(vector HitNormal)
{
	if (bDirectHitWall)
		bDirectHitWall=False;

    super(UnrealPawn).Landed( HitNormal );

    MultiJumpRemaining = MaxMultiJump;

	// ProcessMove skips crouch input during PHYS_Falling, so bWantsToCrouch
	// is never set while airborne (dodge requires crouch=false to initiate).
	// Force crouch intent here so the native Crouch() fires next tick, and
	// let that crouch start a slide off the momentum kept from the fall.
	if (Controller != None && Controller.bDuck > 0 && bCanCrouch)
	{
		bWantsToCrouch = true;
		SlideLandGraceEnd = MoveTime() + SlideLandGraceTime;
	}

	// temporary hardcode
    if ( (Health > 0) && !bHidden && (Level.TimeSeconds - SplashTime > 0.25) )
		PlayOwnedSound(GetSound(EST_Land), SLOT_Interact, 0.5, true, 30);

     //PlayOwnedSound(GetSound(EST_Land), SLOT_Interact, FMin(1, -0.3 * Velocity.Z/JumpZ), true, 1024 + (Velocity.Z * 0.65));
}

function TakeFallingDamage()
{
	local float Shake, EffectiveSpeed;

	if (Velocity.Z < -0.5 * MaxFallSpeed)
	{
		if ( Role == ROLE_Authority )
		{
		    MakeNoise(1.0);
		    if (Velocity.Z < -1 * MaxFallSpeed)
		    {
				EffectiveSpeed = Velocity.Z;
				if ( TouchingWaterVolume() )
					EffectiveSpeed = FMin(0, EffectiveSpeed + 100);
				if ( EffectiveSpeed < -1 * MaxFallSpeed )
				{
					TakeDamage(-100 * (EffectiveSpeed + MaxFallSpeed)/MaxFallSpeed, None, Location, vect(0,0,0), class'Fell');
					if (Health <= 0 && -EffectiveSpeed >= PhysicsVolume.TerminalVelocity - 50.f && class'BloodManager'.default.bGibbableCorpses && !bDeRes)
						bPendingGibFromImpact = true;
				}
		    }
		}
		if ( Controller != None )
		{
			Shake = FMin(1, -1 * Velocity.Z/MaxFallSpeed);
            Controller.DamageShake(Shake);
		}
	}
	else if (Velocity.Z < -1.4 * JumpZ)
		MakeNoise(0.5);
}

//===========================================================================
// PawnCheckBob
// Version of Engine.Pawn CheckBob, but prevents client disabling it
//===========================================================================
function PawnCheckBob(float DeltaTime, vector Y)
{
	local float Speed2D;

    if(bJustLanded || bIsSliding)
    {
		BobTime = 0;
		WalkBob = Vect(0,0,0);
        return;
    }
	Bob = FClamp(Bob, -0.01, 0.01);
	if ( Physics == PHYS_Walking )
	{
		Speed2D = VSize(Velocity);
		if ( Speed2D < 10 )
			BobTime += 0.2 * DeltaTime;
		else
			BobTime += DeltaTime * (0.3 + 0.7 * Speed2D/GroundSpeed);
		WalkBob = Y * Bob * Speed2D * sin(8 * BobTime);
		AppliedBob = AppliedBob * (1 - FMin(1, 16 * deltatime));
		WalkBob.Z = AppliedBob;
		if ( Speed2D > 10 )
			WalkBob.Z = WalkBob.Z + 0.75 * Bob * Speed2D * sin(16 * BobTime);
	}
	else if ( Physics == PHYS_Swimming )
	{
		BobTime += DeltaTime;
		Speed2D = Sqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);
		WalkBob = Y * Bob *  0.5 * Speed2D * sin(4.0 * BobTime);
		WalkBob.Z = Bob * 1.5 * Speed2D * sin(8.0 * BobTime);
	}
	else
	{
		BobTime = 0;
		WalkBob = WalkBob * (1 - FMin(1, 8 * deltatime));
	}
}

//===========================================================================
// CheckBob
// Play footsteps even when crouched or "walking" (aim key)
// Always play own footsteps
//===========================================================================
function CheckBob(float DeltaTime, vector Y)
{
	local float OldBobTime;
	local int m,n;

    DeltaTime *= GroundSpeed / (class'BallisticReplicationInfo'.default.PlayerGroundSpeed * 1.5);
	//log("BallisticPawn: CheckBob: DeltaTime: "$DeltaTime$" GroundSpeed: "$GroundSpeed$" PlayerGroundSpeed: "$class'BallisticReplicationInfo'.default.PlayerGroundSpeed);
	OldBobTime = BobTime;

	PawnCheckBob(DeltaTime,Y);

	if ( (Physics != PHYS_Walking) || bIsCrouched || (VSize(Velocity) < 10) || ((PlayerController(Controller) != None) && PlayerController(Controller).bBehindView) )
		return;

	// BobTime is an accumulator and is never reset.
	// Local footsteps are bound to weapon bob
	m = int(0.5 * Pi + 9.0 * OldBobTime/Pi);
	n = int(0.5 * Pi + 9.0 * BobTime/Pi);

	if (m != n)
	{
		FootStepping(0);
	}

	// always have weapon bob on.
	/*
	else if ( !bWeaponBob && (Level.TimeSeconds - LastFootStepTime > 0.45 * (260.0f / GroundSpeed)) ) // fixme: link to animation speeds
	{
		LastFootStepTime = Level.TimeSeconds;
		FootStepping(0);
	}
	*/
}

simulated final function float FootstepSurfaceScale (int Surf)
{
	switch (Surf)
	{
		Case 0:/*EST_Default*/	return 1.0; 	// bricks, concrete, drywall and such
		Case 1:/*EST_Rock*/		return 1.0;		// rocks
		Case 2:/*EST_Dirt*/		return 1.0;	// sand, etc - we assume it dampens
		Case 3:/*EST_Metal*/	return 2.0;		// metal is damn loud
		Case 4:/*EST_Wood*/		return 1.5;		// we assume floorboards and amp it
		Case 5:/*EST_Plant*/	return 0.75;		// dampens sound well
		Case 6:/*EST_Flesh*/	return 2.0;	 	// disgusting
		Case 7:/*EST_Ice*/		return 1.0;
		Case 8:/*EST_Snow*/		return 1.5;		// compacting snow makes a fair bit of noise
		Case 9:/*EST_Water*/	return 2.0;		// almost never going to see this one
		Case 10:/*EST_Glass*/	return 1.0;		// nor this one
		default:				return 1.0;
	}
}

simulated function ClientPlayLinearSound(Sound sound, ESoundSlot slot, float volume, float radius)
{
	local float dist;

	if (IsLocallyControlled())
		volume *= 0.65f;
	else if (!FastTrace(Location, Level.GetLocalPlayerController().ViewTarget.Location))
	{
		volume *= 0.8f;
		radius *= 0.75f;
	}

	// have to manually calculate a volume and radius in order to bypass NATIVE BULLSHIT
	// we play the sound with the volume we want, 
	// and the radius set exactly to the dist, to make sure we get the full volume at this dist without needing bFullVolume
	// which would cause issues if we change view target while the sound is playing
	dist = FMax(64, VSize(Location - Level.GetLocalPlayerController().ViewTarget.Location));

	//log("Footsteps: Sound Rad: "$FSoundRad$" FootstepRadius: "$FootstepRadius);

	if (dist > radius)
		return;

	volume *= (1f - (dist / radius));

	PlaySound(sound, slot, volume, , dist);
}

simulated function FootStepping(int Side)
{
    local int SurfaceNum, i;
	local actor A;
	local material FloorMat;
	local vector HL,HN,Start,End,HitLocation,HitNormal;
	local float SoundVolumeScale, SoundRadiusScale;

	// crouch - no sound
	if (bIsCrouched)
		return;
		
	// walk/ADS - quieter
	if (bIsWalking)
	{
		SoundVolumeScale = 0.65f;
		SoundRadiusScale = 0.65f;
	}

	// sprint - much louder
	else if (GroundSpeed > class'BallisticReplicationInfo'.default.PlayerGroundSpeed)
	{
		SoundVolumeScale = 1.2f;
		SoundRadiusScale = 1.4f;
	}

	// run - default
	else
	{
		SoundVolumeScale = 1f;
		SoundRadiusScale = 1f;
	}

	// handle water
    for ( i=0; i<Touching.Length; i++ )
	{
		if ( ((PhysicsVolume(Touching[i]) != None) && PhysicsVolume(Touching[i]).bWaterVolume)
			|| (FluidSurfaceInfo(Touching[i]) != None) )
		{
			SoundVolumeScale *= 1.5f;
			SoundRadiusScale *= 1.5f;

			if ( FRand() < 0.5 )
				ClientPlayLinearSound(sound'PlayerSounds.FootStepWater2', SLOT_Interact, FootstepVolume * SoundVolumeScale, FootstepRadius * SoundRadiusScale);
			else
				ClientPlayLinearSound(sound'PlayerSounds.FootStepWater1', SLOT_Interact, FootstepVolume * SoundVolumeScale, FootstepRadius * SoundRadiusScale);
				
			if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.NetMode != NM_DedicatedServer)
				&& !Touching[i].TraceThisActor(HitLocation, HitNormal,Location - CollisionHeight*vect(0,0,1.1), Location) )
					Spawn(class'WaterRing',,,HitLocation,rot(16384,0,0));
			return;
		}
	}

	// handle other surface
	SurfaceNum = 0;

	if ( (Base!=None) && (!Base.IsA('LevelInfo')) && (Base.SurfaceType!=0) )
	{
		SurfaceNum = Base.SurfaceType;
	}
	else
	{
		Start = Location - Vect(0,0,1)*CollisionHeight;
		End = Start - Vect(0,0,16);
		A = Trace(hl,hn,End,Start,false,,FloorMat);
		if (FloorMat !=None)
			SurfaceNum = FloorMat.SurfaceType;
	}

	SoundRadiusScale *= FootstepSurfaceScale(SurfaceNum);

	ClientPlayLinearSound(SoundFootsteps[SurfaceNum], SLOT_Interact, FootstepVolume * SoundVolumeScale, FootstepRadius * SoundRadiusScale);
}

simulated function AssignInitialPose()
{
    local xUtil.PlayerRecord recx;
	local bool bContinue;
	local int i;

    super.AssignInitialPose();

	if ( PlayerReplicationInfo != None )
	{
		recx = class'xUtil'.static.FindPlayerRecord(PlayerReplicationInfo.CharacterName);
		//Don't apply custom animation support to weird meshes with their own animations.
		//These are pretty rare, so check the skeleton to see if they're in use.
		if (Level.NetMode != NM_DedicatedServer && bLocalDisableAnimation)
		{
			bDisablePawnAnimation=True;
			return;
		}
		if (Locs(left(recx.Species, 5)) != "xgame" || recx.Skeleton != "")
		{
			for (i=0; i < ModelWhitelist.Length; i++)
				if (Locs(PlayerReplicationInfo.CharacterName) == Locs(ModelWhitelist[i]))
					bContinue=True;
			if (!bContinue)
			{
				bDisablePawnAnimation=True;
				return;
			}
		}
		//log( "Skeleton "$recx.Skeleton$" Species "$recx.Species );
		if (  recx.Species.default.SpeciesName == "Alien" )
			 LinkSkelAnim(MeshAnimation'BallisticThird.Ballistic3rdAlien');
		else if (  recx.Species.default.SpeciesName == "Juggernaut" )
			 LinkSkelAnim(MeshAnimation'BallisticThird.Ballistic3rd');
		else if ( recx.Sex ~= "Female" && PlayerReplicationInfo.CharacterName != "July")
			LinkSkelAnim(MeshAnimation'BallisticThird.Ballistic3rdFemale');	 
		else LinkSkelAnim(MeshAnimation'BallisticThird.Ballistic3rd');
	}
}

simulated function SetWeaponAttachment(xWeaponAttachment NewAtt)
{
	local BallisticAttachment BAtt;
	
    WeaponAttachment = NewAtt;
	BAtt = BallisticAttachment(newAtt);
	
	if (BAtt != None)
	{
		ReloadAnim = BAtt.ReloadAnim;
		ReloadAnimRate = BAtt.ReloadAnimRate;
		
		CockingAnim = BAtt.CockingAnim;
		CockAnimRate = BAtt.CockAnimRate;
		
		if (HasAnim(BAtt.IdleHeavyAnim))
			IdleHeavyAnim = BAtt.IdleHeavyAnim;
		else
			IdleHeavyAnim = 'Idle_Biggun';
		
		if (HasAnim(BAtt.IdleRifleAnim))
			IdleRifleAnim = Batt.IdleRifleAnim;
		else
			IdleHeavyAnim = 'Idle_Rifle';
		
		FireHeavyBurstAnim = BAtt.SingleFireAnim;
		FireHeavyRapidAnim = BAtt.RapidFireAnim;
	
		FireRifleBurstAnim = BAtt.SingleAimedFireAnim;
		FireRifleRapidAnim = BAtt.RapidAimedFireAnim;
		
		MeleeBlockAnim = Batt.MeleeBlockAnim;
		MeleeWindupAnim = Batt.MeleeWindupAnim;
		
		WeaponSpecialAnim = Batt.WeaponSpecialAnim;
		WeaponSpecialRate = Batt.WeaponSpecialRate;

		StaggerAnim = Batt.StaggerAnim;
		StaggerRate = Batt.StaggerRate;
		
		MeleeAnim = BAtt.MeleeStrikeAnim;
		
		IdleRestAnim = BAtt.IdleHeavyAnim;
	
		if (BallisticMeleeAttachment(NewAtt) != None)
		{
			MeleeAltAnim = BallisticMeleeAttachment(NewAtt).MeleeAltStrikeAnim;
			IdleWeaponAnim = IdleHeavyAnim;
			IdleRifleAnim = BallisticMeleeAttachment(NewAtt).MeleeBlockAnim;
		}

		else 
		{
			IdleWeaponAnim = IdleHeavyAnim;
		}
	}
}

simulated event SetAnimAction(name NewAction)
{
	// A slide only holds the movement animations back. See TickSlideAnim
    if (!bWaitForAnim || bSlideAnimating)
    {
	    AnimAction = NewAction;
		if ( AnimAction == 'Weapon_Switch' )
        {
            AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
            PlayAnim(NewAction,, 0.0, 1);
			return;
        }
		// Special animations for Ballistic Weapons.
		// Covers Reload, Cocking, Weapon Raise and Weapon Lower. More to come.
		if (AnimAction == 'ReloadGun')
		{
			if (ReloadAnim != '' && HasAnim(ReloadAnim))
			{
				AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
				PlayAnim(ReloadAnim, ReloadAnimRate, 0.25, 1);
				FireState=FS_PlayOnce;
				bResetAnimationAction=True;
			}
			else AnimAction = '';
			return;
		}
		if (AnimAction == 'MeleeStrike' && HasAnim(MeleeAnim))
		{
			AnimBlendParams(1, 1, 0, 0.2, FireRootBone);
			PlayAnim(MeleeAnim, 1, 0.05, 1);
			FireState=FS_PlayOnce;
			bResetAnimationAction=True;
			return;
		}
		if (AnimAction == 'Shovel' && HasAnim('Reload_ShovelBottom'))
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			PlayAnim('Reload_ShovelBottom', 1, 0.25, 1);
			FireState=FS_PlayOnce;
			AnimAction = '';
			//bResetAnimationAction=True;
			return;
		}
		if (AnimAction == 'CockGun' && HasAnim(CockingAnim))
		{
			if (CockingAnim != '')
			{
				AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
				PlayAnim(CockingAnim, CockAnimRate, 0.25, 1);
				FireState=FS_PlayOnce;
				bResetAnimationAction=True;
			}
			else AnimAction = '';
			return;
		}
		if (AnimAction == 'WeaponSpecial' && HasAnim(WeaponSpecialAnim))
		{
			if (ReloadAnim != '')
			{
				AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
				PlayAnim(WeaponSpecialAnim, WeaponSpecialRate, 0.25, 1);
				FireState=FS_PlayOnce;
				bResetAnimationAction=True;
			}
			else AnimAction = '';
			return;
		}		
		if (AnimAction == 'Stagger' && HasAnim(StaggerAnim))
		{
			if (ReloadAnim != '')
			{
				AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
				PlayAnim(StaggerAnim, StaggerRate, 0.25, 1);
				FireState=FS_PlayOnce;
				bResetAnimationAction=True;
			}
			else AnimAction = '';
			return;
		}
		// Still here with one of these: the pawn's mesh doesn't have the animation. Don't fall through to playing the action's own name
		if (AnimAction == 'MeleeStrike' || AnimAction == 'Shovel' || AnimAction == 'CockGun' || AnimAction == 'WeaponSpecial' || AnimAction == 'Stagger')
		{
			AnimAction = '';
			return;
		}
		/*if (AnimAction == 'Blocking')
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			if (FireState == FS_None || FireState == FS_Ready)
				PlayAnim(MeleeBlockAnim,, 0.2, 1);
			IdleWeaponAnim = MeleeBlockAnim;
			FireState = FS_None;
			ClientMessage("Blocking");
			return;
		}		
		else */if (AnimAction == 'Raise' && HasAnim(IdleRifleAnim))
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			if (FireState == FS_None || FireState == FS_Ready)
				PlayAnim(IdleRifleAnim,, 0.2, 1);
			IdleWeaponAnim = IdleRifleAnim;
			FireState = FS_None;
			return;
		}
		else if (AnimAction == 'Lower' && HasAnim(IdleHeavyAnim))
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			if (FireState == FS_None || FireState == FS_Ready)
				PlayAnim(IdleHeavyAnim,, 0.2, 1);
			IdleWeaponAnim = IdleHeavyAnim;
			FireState = FS_Ready;
			return;
		}
		
		// End special animations
		// Taunts would take the slide's place
		if (bSlideAnimating)
		{
			AnimAction = '';
			return;
		}
        if ( ((Physics == PHYS_None)|| ((Level.Game != None) && Level.Game.IsInState('MatchOver')))
				&& (DrivenVehicle == None) )
        {
            PlayAnim(AnimAction,,0.1);
			AnimBlendToAlpha(1,0.0,0.05);
        }
        else if ( (DrivenVehicle != None) || (Physics == PHYS_Falling) || ((Physics == PHYS_Walking) && (Velocity.Z != 0)) )
		{
			if ( FindValidTaunt(AnimAction) )
			{
				if (FireState == FS_None || FireState == FS_Ready)
				{
					AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
					PlayAnim(NewAction,, 0.1, 1);
					FireState = FS_Ready;
				}
			}
			else if ( PlayAnim(AnimAction) )
			{
				if ( Physics != PHYS_None )
					bWaitForAnim = true;
			}
			else
				AnimAction = '';
		}
        else if (bIsIdle && !bIsCrouched && (Bot(Controller) == None) ) // standing taunt
        {
            PlayAnim(AnimAction,,0.1);
			AnimBlendToAlpha(1,0.0,0.05);
        }
        else // running taunt
        {
            if (FireState == FS_None || FireState == FS_Ready)
            {
                AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
                PlayAnim(NewAction,, 0.1, 1);
                FireState = FS_Ready;
            }
        }
    }
}

simulated function StartFiring(bool bHeavy, bool bRapid)
{
    local name FireAnim;
	
	if ( HasUDamage() && (Level.TimeSeconds - LastUDamageSoundTime > 0.25) )
	{
		LastUDamageSoundTime = Level.TimeSeconds;
		PlaySound(UDamageSound, SLOT_None, 1.5*TransientSoundVolume,,700);
	}

	if (Physics == PHYS_Swimming)
		return;
	
	if (BallisticMeleeAttachment(WeaponAttachment) == None)
	{	

		if (bHeavy)
		{
			if (bRapid)
			{
				if (HasAnim(FireHeavyRapidAnim))
					FireAnim = FireHeavyRapidAnim;
				else
					FireAnim = 'Biggun_Burst';
			}
			else
			{
				if (HasAnim(FireHeavyBurstAnim))
					FireAnim = FireHeavyBurstAnim;
				else
					FireAnim = 'Biggun_Aimed';
			}
		}
		else
		{
			if (bRapid)
			{
				if (HasAnim(FireRifleRapidAnim))
					FireAnim = FireRifleRapidAnim;
				else
					FireAnim = 'Rifle_Burst';
			}
			else
			{
				if (HasAnim(FireRifleBurstAnim))
					FireAnim = FireRifleBurstAnim;
				else
					FireAnim = 'Rifle_Aimed';
			}
		}

		AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);

		if (bRapid)
		{
			if (FireState != FS_Looping)
			{
				LoopAnim(FireAnim,, 0.0, 1);
				FireState = FS_Looping;
			}
		}
		else
		{
			PlayAnim(FireAnim,, 0.0, 1);
			FireState = FS_PlayOnce;
		}

		IdleTime = Level.TimeSeconds;
		return;
	}

	//Melee specific
	if (!bHeavy)
	{
		if (MeleeOffhandAnim != '')
		{
			if (!bOffhandStrike)
				FireAnim = MeleeAnim;
			else FireAnim = MeleeOffhandAnim;
			bOffhandStrike = !bOffhandStrike;
		}
		else FireAnim = MeleeAnim;
	}
	else
		FireAnim = MeleeAltAnim;


    AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);

	PlayAnim(FireAnim,, 0.0, 1);
	FireState = FS_PlayOnce;

    IdleTime = Level.TimeSeconds;
}

simulated function AnimEnd(int Channel)
{
	local name anim;
	local float frame, rate;
	
    if (Channel == 1)
    {
		GetAnimParams(1, anim, frame, rate);
		
		if (IdleWeaponAnim == IdleRifleAnim && FireState != FS_Looping)
		{
			LoopAnim(IdleWeaponAnim,, 0.2, 1);
			FireState = FS_None;
		}
        else if (FireState == FS_Ready)
        {
            AnimBlendToAlpha(1, 0.0, 0.12);
            FireState = FS_None;
        }
        else if (FireState == FS_PlayOnce)
        {
			PlayAnim(IdleWeaponAnim,, 0.2, 1);
            FireState = FS_Ready;
            IdleTime = Level.TimeSeconds;
        }
        else if (FireState != FS_Looping)
            AnimBlendToAlpha(1, 0.0, 0.12);
			
		GetAnimParams(1, anim, frame, rate);
		
		//if (anim == ReloadAnim || anim == CockingAnim)
		if (bResetAnimationAction)
		{
			bResetAnimationAction = False;
			AnimAction = '';
		}
    }
    else if (Channel == 0)
    {
        if (bSlideWaitingStart)
        {
            bSlideWaitingStart = false;
            if (bSlideAnimating)
                LoopSlideAnim();
        }

        if ( bKeepTaunting )
            PlayVictoryAnimation();
    }
}

function HealBlock(Pawn Instigator, class<LocalMessage> BlockMessageClass)
{
	PreventHealCount++;

	bPreventHealing = true;

	HealPreventer = Instigator;

	HealBlockMessage = BlockMessageClass;
}

function ReleaseHealBlock()
{
	PreventHealCount--;

	if (PreventHealCount == 0)
		bPreventHealing = false;
}

//Tracks the person who healed us
function bool GiveAttributedHealth(int HealAmount, int HealMax, Pawn Healer, optional bool bOverheal)
{
	local int OldHealth;
	
	if (bPreventHealing && bProjTarget)
	{
		MessageAttributedHealBlock(Healer);
		return false;
	}
	
	OldHealth = Health;
	
	if (Health < HealMax)
		Health = Min(HealMax, Health + HealAmount);
		
	HealAmount -= (Health - OldHealth);
	
	if (HealAmount > 0 && bOverheal && Health >= SuperHealthMax)
	{
		AddShieldStrength(HealAmount);
		if (Healer != none && Healer != self)
			MessageHeal(Healer, 1);
		return true;
	}

	if (OldHealth == Health)
		return false;
	if (Healer != none && Healer != self)
		MessageHeal(Healer, 0);
    return true;
}

//Tracks the person who healed us
function bool GiveAttributedShield(int HealAmount, Pawn Healer)
{
	local int OldShield;
	
	if (bPreventHealing && bProjTarget)
	{
		MessageAttributedHealBlock(Healer);
		return false;
	}

	AddShieldStrength(HealAmount);

	if (OldShield == ShieldStrength)
		return false;

	if (Healer != none && Healer != self)
		MessageHeal(Healer, 1);

    return true;
}

function bool GiveHealth(int HealAmount, int HealMax)
{
	if (bPreventHealing && bProjTarget)
	{
		MessageHealBlock();
		return false;
	}
	
	return Super.GiveHealth(HealAmount, HealMax);	
}

function MessageHeal (Pawn Healer, int index)
{
	if (PlayerController(Controller) != None && NextHealMessageTime < Level.TimeSeconds)
	{
		NextHealMessageTime = Level.TimeSeconds + 1;
		PlayerController(Controller).ReceiveLocalizedMessage(class'BallisticHealMessage', index, Healer.PlayerReplicationInfo);
	}
}

function MessageHealBlock()
{
	if (PlayerController(Controller) != None && NextHealMessageTime < Level.TimeSeconds)
	{
		NextHealMessageTime = Level.TimeSeconds + 1;
		if (HealPreventer != None)
		PlayerController(Controller).ReceiveLocalizedMessage(HealBlockMessage, 0, HealPreventer.PlayerReplicationInfo);
	}
}

function MessageAttributedHealBlock(Pawn Healer)
{
	local PlayerReplicationInfo PreventerPRI;

	// Issue #258: HealPreventer can be cleared (or never set) between the time
	// the block was triggered and this message runs. Fall back gracefully.
	if (HealPreventer != None)
		PreventerPRI = HealPreventer.PlayerReplicationInfo;

	if (PlayerController(Controller) != None && NextHealMessageTime < Level.TimeSeconds)
	{
		NextHealMessageTime = Level.TimeSeconds + 1;
		PlayerController(Controller).ReceiveLocalizedMessage(HealBlockMessage, 1, PreventerPRI, Healer.PlayerReplicationInfo);

		if (PlayerController(Healer.Controller) != None)
			PlayerController(Healer.Controller).ReceiveLocalizedMessage(HealBlockMessage, 2, PreventerPRI, PlayerReplicationInfo);
	}
}

simulated event PhysicsVolumeChange( PhysicsVolume NewVolume )
{
    Super.PhysicsVolumeChange(NewVolume);
	// Blood clouds in water
	if (NewVolume.bWaterVolume)
	{
		if (BloodPool != None)	{	BloodPool.StopExpanding ();	BloodPool = None;}
		bBloodPoolSpawned=false;
		if (class'BWBloodControl'.default.bUseBloodPools && bBleedingCorpse && WaterBlood == None)
		{
			WaterBlood = Spawn(BloodSet.default.WaterBloodClass,self,, Location, Rotation);
			WaterBlood.SetBase(self);
		}
	}
	else if (WaterBlood != None)
	{
		WaterBlood.Kill();
		WaterBlood = None;
	}
}

// Implement blood effects when dead bodies impact with stuff
// FIXME: Maybe blood manager should do this?
simulated event KImpact(actor other, vector pos, vector impactVel, vector impactNorm)
{
	local float Speed, ImpDir, ImpScale;
	local BallisticDecal D;

	super.KImpact(other, pos, impactVel, impactNorm);

	if (class'BWBloodControl'.default.bUseBloodImpacts && !class'GameInfo'.static.UseLowGore())
	{
		if (!(level.TimeSeconds - LastImpactTime > TimeBetweenImpacts || impactNorm Dot LastImpactNormal < 0.7 || VSize(pos - LastImpactLocation) > 100))
			return;

		Speed = VSize(ImpactVel);
		if (Speed < LowImpactVelocity)
			return;

		LastImpactTime = level.TimeSeconds;
		LastImpactNormal = impactNorm;
		LastImpactLocation = pos;
		if (Speed >= HighImpactVelocity)
		{
			if (Normal(Velocity) Dot ImpactNorm > -0.5)
			{
				ImpScale = 0.1 + FMin((Speed - HighImpactVelocity) / 800, 0.9);
			}
			else
			{
				ImpDir = Normal(Velocity) Dot Normal(pos-Location);
				if (ImpDir > 0.5)
					ImpScale = 0.6 + impDir * 0.4;
				else
					ImpScale = 0.4 + impDir * 0.4;
				ImpScale *= 0.5 + FMin((Speed - HighImpactVelocity) / 600, 1.0);
			}
			if (ImpScale < 0.1)
				return;

			class<BallisticDecal>(BloodSet.default.HighImpactDecal).default.bWaitForInit = true;
			D = BallisticDecal(Spawn(BloodSet.default.HighImpactDecal ,self, , pos, Rotator(-impactNorm)));
			if (D!= None)
			{
				D.SetDrawScale(D.DrawScale * ImpScale);
				D.InitDecal();
			}
			class<BallisticDecal>(BloodSet.default.HighImpactDecal).default.bWaitForInit = false;
			// Destroy body on next tick to prevent karma crashes 
			if (Role == ROLE_Authority && ImpactNorm.Z > 0.7 && Health <= 0 && VSize(impactVel) >= PhysicsVolume.TerminalVelocity - 50.f 
				&& class'BloodManager'.default.bGibbableCorpses && !bDeRes && !bSkeletized)
				bPendingGibFromImpact = true;
		}
		else
		{
			if (Normal(Velocity) Dot ImpactNorm > -0.5)
			{
				ImpScale = 0.1 + FMin((Speed - HighImpactVelocity) / 800, 0.9);
			}
			else
			{
				ImpDir = Normal(Velocity) Dot Normal(pos-Location);
				if (ImpDir > 0.5)
					ImpScale = 0.6 + impDir * 0.4;
				else
					ImpScale = 0.4 + impDir * 0.4;
				ImpScale *= 0.5 + FMin((Speed - LowImpactVelocity) / 500, 0.5);
			}

			if (ImpScale < 0.1)
				return;

			class<BallisticDecal>(BloodSet.default.LowImpactDecal).default.bWaitForInit = true;
			D = BallisticDecal(Spawn(BloodSet.default.LowImpactDecal ,self, , pos, Rotator(-impactNorm)));
			if (D!= None)
			{
				D.SetDrawScale(D.DrawScale * ImpScale);
				D.InitDecal();
			}
			class<BallisticDecal>(BloodSet.default.LowImpactDecal).default.bWaitForInit = false;
		}
		LastDragLocation = Location;
	}
}

// Tick for handling gore effects
simulated function TickGore(float DT)
{
	local rotator R;
	local int i;

	if (level.NetMode == NM_DedicatedServer || class'GameInfo'.static.NoBlood())
		return;

	for (i=0;i<LocalHits.length;i++)
		DoHit(LocalHits[i].Bone, LocalHits[i].DamageType, LocalHits[i].HitRay, LocalHits[i].HitLoc, LocalHits[i].Damage);
	LocalHits.length = 0;

	// Spawn drag marks
	if (VSize(Location - LastDragLocation) > MinDragDistance)
	{
		if (BloodPool != None)
		{
			BloodPool.StopExpanding ();
			BloodPool = None;
		}
		bBloodPoolSpawned=false;
		if (LastDragLocation == vect(0,0,0))
			LastDragLocation = Location;
		else if (class'BWBloodControl'.default.bUseBloodDrags && !class'GameInfo'.static.UseLowGore() && bBleedingCorpse && (!FastTrace(Location - vect(0,0,30), Location)) &&
			level.DetailMode > DM_Low && BloodSet.default.DragDecal != None)
		{
			R = Rotator(Location - LastDragLocation);
			R.Pitch = -16384;
			Spawn(BloodSet.default.DragDecal,self,,Location, R);
		}
		LastDragLocation = Location;
		CorpseRestTime = 0;
	}
	// Spawn blood pools
	else if (class'BWBloodControl'.default.bUseBloodPools && bBleedingCorpse && BloodSet.default.BloodPool != None && !PhysicsVolume.bWaterVolume && VSize(Velocity) < MaxPoolVelocity/* && bInitialized*/)
	{
		if (/*BloodPool == None*/ !bBloodPoolSpawned && CorpseRestTime > 0.5)
		{
			BloodPool = Spawn(BloodSet.default.BloodPool,,, Location, Rotator(vect(0,0,-1)));
			bBloodPoolSpawned = true;
		}
		CorpseRestTime += DT;
	}
}

// Get the standard number for the bone name (used when compressing/decomressing hit info)
simulated function byte GetHitBoneIndex (name BoneName)
{
	switch (BoneName)
	{
		case 'head':		return 1;
		case 'spine':		return 2;
		case 'rshoulder':	return 3;
		case 'lshoulder':	return 4;
		case 'righthand':	return 5;
		case 'rhand':		return 6;
		case 'rfarm':		return 7;
		case 'lhand':		return 8;
		case 'lfarm':		return 9;
		case 'rfoot':		return 10;
		case 'rthigh':		return 11;
		case 'lfoot':		return 12;
		case 'lthigh':		return 13;
		default :			return 0;
	}
}
// Get the standard bone name for the index number (used when compressing/decomressing hit info)
simulated function name GetHitBoneName (byte BoneIndex)
{
	switch (BoneIndex)
	{
		case 1 :	return 'head';
		case 2 :	return 'spine';
		case 3 :	return 'rshoulder';
		case 4 :	return 'lshoulder';
		case 5 :	return 'righthand';
		case 6 :	return 'rhand';
		case 7 :	return 'rfarm';
		case 8 :	return 'lhand';
		case 9 :	return 'lfarm';
		case 10 :	return 'rfoot';
		case 11 :	return 'rthigh';
		case 12 :	return 'lfoot';
		case 13 :	return 'lthigh';
		default :	return 'none';
	}
}

function CalcHitLoc( Vector hitLoc, Vector hitRay, out Name boneName, out float dist )
{
    boneName = GetClosestBone( hitLoc, hitRay, dist );
    if (BoneName == 'spine' && GetBoneCoords(BoneName).Origin.Z > HitLoc.Z + HitRay.Z*dist)
    	BoneName = 'pelvis';
}

State Dying
{
	//Allows gibbable corpses
	simulated function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType)
	{
		local Vector shotDir, PushLinVel, PushAngVel;

		if (bFrozenBody || bRubbery)
			return;

		if (bRagdollSetup)
			return;

		if (Physics == PHYS_KarmaRagdoll)
		{
			if (bDeRes)
				return;

			// Accumulate corpse damage and gib when threshold exceeded
			Health -= Damage;
			if (class'BloodManager'.default.bGibbableCorpses && !bSkeletized && (Health < -200 && (DamageType != None && DamageType.default.bCausesBlood && 
			(DamageType.default.bAlwaysGibs || 
			ClassIsChildOf(DamageType, class'DT_BWExplode') ||
			ClassIsChildOf(DamageType, class'Gibbed') ||
			ClassIsChildOf(DamageType, class'Fell') ||
			ClassIsChildOf(DamageType, class'DamTypeRocket') ||
			ClassIsChildOf(DamageType, class'DamTypeFlakShell') ||
			ClassIsChildOf(DamageType, class'DamTypeSuperShockBeam') ||
			ClassIsChildOf(DamageType, class'DamTypeRedeemer') ||
			ClassIsChildOf(DamageType, class'DamTypeTankShell') ||
			ClassIsChildOf(DamageType, class'DamTypeAttackCraftMissle') ||
			ClassIsChildOf(DamageType, class'DamTypeShockCombo') ||
			ClassIsChildOf(DamageType, class'DamTypeMASCannon') ||
			ClassIsChildOf(DamageType, class'DamTypeTeleFrag') ||
			ClassIsChildOf(DamageType, class'DamTypeIonBlast') ||
			ClassIsChildOf(DamageType, class'DamTypeTeleFragged') ||
			ClassIsChildOf(DamageType, class'DamTypeIonCannonBlast') ))))
			{
				//SpawnGibs(Rotation, DamageType.default.GibPerterbation);
				ChunkUp(Rotator(Momentum), DamageType.default.GibPerterbation);
				return;
			}
			// Apply ragdoll physics
			if (DamageType != None && DamageType.Default.bThrowRagdoll)
			{
				shotDir = Normal(Momentum);
				PushLinVel = (RagDeathVel * shotDir) + vect(0, 0, 250);
				PushAngVel = Normal(shotDir Cross vect(0, 0, 1)) * -18000;
				KSetSkelVel(PushLinVel, PushAngVel);
			}
			else if (DamageType != None && DamageType.Default.bRagdollBullet)
			{
				if (Momentum == vect(0,0,0) && InstigatedBy != None)
					Momentum = HitLocation - InstigatedBy.Location;
				if (FRand() < 0.65)
				{
					if (Velocity.Z <= 0)
						PushLinVel = vect(0,0,40);
					PushAngVel = Normal(Normal(Momentum) Cross vect(0, 0, 1)) * -8000;
					PushAngVel.X *= 0.5;
					PushAngVel.Y *= 0.5;
					PushAngVel.Z *= 4;
					KSetSkelVel(PushLinVel, PushAngVel);
				}
				PushLinVel = RagShootStrength * Normal(Momentum);
				KAddImpulse(PushLinVel, HitLocation);
				if ((LifeSpan > 0) && (LifeSpan < DeResTime + 2))
					LifeSpan += 0.2;
			}
			else
			{
				PushLinVel = RagShootStrength * Normal(Momentum);
				KAddImpulse(PushLinVel, HitLocation);
			}
		}

		PlayHit(Damage, InstigatedBy, Hitlocation, damageType, Momentum);

		if (DamageType != None && DamageType.default.DamageOverlayMaterial != None && Level.DetailMode != DM_Low && !Level.bDropDetail)
			SetOverlayMaterial(DamageType.default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, true);
	}

    simulated function Timer()
	{
		local KarmaParamsSkel skelParams;

		// If we are running out of life, bute we still haven't come to rest, force the de-res.
		// unless pawn is the viewtarget of a player who used to own it
		if ( LifeSpan <= DeResTime && bDeRes == false )
		{
			skelParams = KarmaParamsSkel(KParams);

			// check not viewtarget
			if ( (PlayerController(OldController) != None) && (PlayerController(OldController).ViewTarget == self)
				&& (Viewport(PlayerController(OldController).Player) != None) )
			{
				skelParams.bKImportantRagdoll = true;
				LifeSpan = FMax(LifeSpan,DeResTime + 2.0);
				SetTimer(1.0, false);
				return;
			}
			else
			{
				skelParams.bKImportantRagdoll = false;
			}
            // spawn derez
            StartDeRes();
        }
		else
        {
			SetTimer(1.0, false);
        }
	}

	// We shorten the lifetime when the guys comes to rest.
	event KVelDropBelow()
	{
	}
}

// Line up hits to be fired at DoHit()
function PlayHit(float Damage, Pawn InstigatedBy, vector HitLocation, class<DamageType> DamageType, vector Momentum)
{
    local Vector HitRay;
    local Name HitBone;
    local float HitBoneDist;
    local HitInfo H;
    local int i;

    if ( Damage <= 0 )
		return;

	Super(UnrealPawn).PlayHit(Damage,InstigatedBy,HitLocation,DamageType,Momentum);
	// Try figure out the hitray after bExtraMomentumZ fked up the momentum
	if (DamageType.default.bExtraMomentumZ && HitLocation != Location)
	{
		if (InstigatedBy != None && DamageType.default.bInstantHit)
			HitRay = Normal(HitLocation - InstigatedBy.Location);
		else
		{
			HitRay = Normal(Momentum);
			if (HitRay.Z < 0.6 * VSize(HitRay*vect(1,1,0)))
				HitRay.Z *= 0.5;
		}
	}
	else
    	HitRay = Normal(Momentum);

	// Which bone?
	if (DamageType.default.bAlwaysSevers && DamageType.default.bSpecial )
        HitBone = 'head';
	else if( DamageType.default.bLocationalHit )
        CalcHitLoc( HitLocation, HitRay, HitBone, HitBoneDist ); //can return pelvis, beware
	else
        HitBone = 'None';
	// BallisticDamageType has the privilege of being able to change hit info. (e.g. Railgun dismemberment spreads up the bone tree)
	if (class<BallisticDamageType>(DamageType) != None)
        class<BallisticDamageType>(DamageType).static.ModifyHit(self, Damage, Momentum, HitLocation, HitRay, HitBone);

	if (HitBone == 'righthand')
		HitBone = 'rfarm';

    if (level.NetMode != NM_DedicatedServer)
    {
    	if (Health > 0)	// Record hit for now. It will be sent to DoHit later
    	{
	    	H.Bone = HitBone;
    		H.DamageType = DamageType;
    		H.HitRay = HitRay;
	    	H.HitLoc = HitLocation;
    		H.Damage = Damage;
    		LocalHits[LocalHits.length] = H;
    	}
    	else			// Ok, hes dead now. Play all the recorded hits and this new one here. They'll all be considdered hits to a corpse
    	{
			for (i=0;i<LocalHits.length;i++)
				DoHit(LocalHits[i].Bone, LocalHits[i].DamageType, LocalHits[i].HitRay, LocalHits[i].HitLoc, LocalHits[i].Damage);
			LocalHits.length = 0;
			DoHit(HitBone, DamageType, HitRay, HitLocation, Damage);
		}
    }
    // The clients might want to see it as well...
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		SendHitInfo(HitBone, DamageType, HitLocation, HitRay, Damage);

	if (DamageType.default.DamageOverlayMaterial != None && Damage > 0 ) // additional check in case shield absorbed
		SetOverlayMaterial( DamageType.default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, false );
}

// Compress hit info and get it on its way to the clients
function SendHitInfo(name BoneName, class<DamageType> DamageType, vector HitLoc, vector HitRay, int Damage)
{
	local NetHitInfo PHI;

	Latest = class'BUtil'.static.Loop(Latest, 1, 7, 0);

	PHI.DamageType	= DamageType;
	PHI.BoneNum		= GetHitBoneIndex(BoneName);
	PHI.HitRay.X	= 128 * (HitRay.X+1);
	PHI.HitRay.Y	= 128 * (HitRay.Y+1);
	PHI.HitRay.Z	= 128 * (HitRay.Z+1);
	HitLoc -= Location;
	PHI.HitLoc.X	= 128 + Clamp(HitLoc.X / 2, -128, 127);
	PHI.HitLoc.Y	= 128 + Clamp(HitLoc.Y / 2, -128, 127);
	PHI.HitLoc.Z	= 128 + Clamp(HitLoc.Z / 2, -128, 127);
	if (Damage < 1)
		PHI.Damage	= 0;
	else
		PHI.Damage	= Clamp(Damage / 2, 1, 255);

	ClientHits[Latest] = PHI;
	HitCounter++;
}
// Decompress a NetHitInfo and send it on to DoHit()
simulated function ReceiveHitInfo(NetHitInfo PHI)
{
	local vector HitRay, HitLoc;

	HitRay.X = (PHI.HitRay.X / 128) - 1;
	HitRay.Y = (PHI.HitRay.Y / 128) - 1;
	HitRay.Z = (PHI.HitRay.Z / 128) - 1;

	HitLoc.X = (PHI.HitLoc.X - 128) * 2;
	HitLoc.Y = (PHI.HitLoc.Y - 128) * 2;
	HitLoc.Z = (PHI.HitLoc.Z - 128) * 2;
	HitLoc += Location;

	DoHit(GetHitBoneName(PHI.BoneNum),
		PHI.DamageType,
		HitRay,
		HitLoc,
		PHI.Damage * 2);
}

// HitCounting, gore tick and deres texture fading
simulated event Tick(float DT)
{
	local int Index, i, Diff;
	//local vector TraceStart, TraceEnd, HitLocation, HitNormal;
    //local Actor HitActor;
	//local Vector X,Y,Z;

	super.Tick(DT);

	TickSlideAnim();

	// The sprint control knows the speed the server has set, and only reaches the pawn's owner
	if (bGroundSpeedUnsent && Sprinter != None && Sprinter.BaseGroundSpeed > 0)
	{
		bGroundSpeedUnsent = false;
		GroundSpeed = Sprinter.SprintGroundSpeed(Sprinter.bSprintActive);
	}

	if (SettingsChecksLeft > 0 && Level.TimeSeconds >= NextSettingsCheckTime)
	{
		NextSettingsCheckTime = Level.TimeSeconds + 0.25;
		SettingsChecksLeft--;
		if (class'BallisticReplicationInfo'.static.GetInstance(self) != None)
		{
			SettingsChecksLeft = 0;
			ApplyServerSettings();
		}
	}

	//GetAxes(Rotation, X, Y, Z);
	
	if (bPendingNegation)
	{
		if (Physics == PHYS_Falling)
			Velocity.Z = FMin(Velocity.Z, 900);
		bPendingNegation=False;
	}

	// Check for new hits on clients
	if (level.NetMode == NM_Client && HitCounter != OldHitCounter)
	{
		if (HitCounter < OldHitCounter)
			Diff = (HitCounter + 256) - OldHitCounter;
		else
			Diff = HitCounter - OldHitCounter;
		Diff = Min(8, Diff);

		Index = LastIndex;
		for (i=0; i < Diff; i++)
		{
			Index = class'BUtil'.static.Loop(Index, 1, 7, 0);
			ReceiveHitInfo(ClientHits[Index]);
		}
		LastIndex = Index;

		OldHitCounter = HitCounter;
	}
	// Gore tick
	TickGore(DT);

	if (bPendingGibFromImpact && Role == ROLE_Authority)
	{
		if (bDeRes || bSkeletized)
			bPendingGibFromImpact = false;
		else
		{
			bPendingGibFromImpact = false;
			//SpawnGibs(Rotation, 0.25);
			ChunkUp(Rotator(-Velocity), 0.25);
		}
	}

	// Dissolve DeRes corpses
	if (bDeRes)
	{
		Index = Clamp(255 - 255.0 * (LifeSpan / DeResTime), 0, 255);
		for (i=0;i<NewDeResFinalBlends.length;i++)
		{
			if (NewDeResFinalBlends[i] != None)
				NewDeResFinalBlends[i].AlphaRef = Index;
		}
	}
	/* 
	if (bLockedToSurface)
	{
		// Perform a trace to check if the player is still near the wall
		TraceStart = Location + CollisionHeight * vect(0, 0, 1);
		TraceEnd = Location - LockedSurfaceNormal * CollisionRadius * 2; // Trace towards the locked surface
		HitActor = Trace(HitLocation, HitNormal, TraceEnd, TraceStart, false, vect(1,1,1));
		if (HitActor != None && (HitActor.bWorldGeometry || Mover(HitActor) != None) 
		&& Normal(Velocity) dot X > 0 && LockedSurfaceNormal dot HitNormal > 0.95 && VSize(Velocity) > 50.0)
		{			
			// Slow descent
			Velocity.Z = FMax(Velocity.Z, -100.0); 
			//AirControl = 0.8; // Higher air control for smoother movement
			MultiJumpRemaining = MaxMultiJump; // Reset multi-jump count
		}
		else
		{
			StopWallRun();
		}
	}
	*/
}
/* 
simulated function StopWallRun()
{
	bLockedToSurface = false;
	LockedSurfaceNormal = vect(0, 0, 0);
	//AirControl = default.AirControl; // Reset air control
}
*/
// Return true if the input bone is already dismembered
simulated function bool BoneDismembered (name Bone)
{
	local int i;

	if (SeveredBones.length == 0)
		return false;

	if (Bone == 'none')
		return SeveredBones.length > 0;
	else
		for (i=0;i<SeveredBones.length;i++)
			if (SeveredBones[i] == Bone)
				return true;
	return false;
}

// This hack will give the gore system a BW equivalent to an old DT
simulated function class<BallisticDamageType> UpgradeDamagetypeForGore (class<DamageType> DT)
{
	if (ClassIsChildOf(DT, class'BallisticDamageType'))
		return class<BallisticDamageType>(DT);

	return None;
}

// Get the best blood manager for the damagetype
simulated function class<BloodManager> GetBloodManagerForGore (class<DamageType> DT)
{
	if (DT == None)
		return class'BloodMan_General';

	if (class<BallisticDamageType>(DT) != None)
	{
		if ( class<BallisticDamageType>(DT).static.GetBloodManager()!= None)
			return class<BallisticDamageType>(DT).default.BloodManager;
	}
	else
	{
		if (ClassIsChildOf(DT, class'DamTypeSuperShockBeam'))
			return class'BloodMan_FireExploded';

		if (DT.default.bAlwaysGibs ||
			ClassIsChildOf(DT, class'Gibbed') ||
			ClassIsChildOf(DT, class'DamTypeRocket') ||
			ClassIsChildOf(DT, class'DamTypeFlakShell') ||
			ClassIsChildOf(DT, class'DamTypeRedeemer') ||
			ClassIsChildOf(DT, class'DamTypeTankShell') ||
			ClassIsChildOf(DT, class'DamTypeAttackCraftMissle') ||
			ClassIsChildOf(DT, class'DamTypeShockCombo') ||
			ClassIsChildOf(DT, class'DamTypeMASCannon') ||
			ClassIsChildOf(DT, class'DamTypeTeleFrag') ||
			ClassIsChildOf(DT, class'DamTypeIonBlast') ||
			ClassIsChildOf(DT, class'DamTypeTeleFragged') ||
			ClassIsChildOf(DT, class'DamTypeIonCannonBlast') )
			return class'BloodMan_Exploded';
	}
	if (DT.default.bBulletHit)
		return class'BloodMan_Bullet';
	if (DT.default.bThrowRagdoll)
	{
		if (DT.default.bFlaming)
			return class'BloodMan_FireExploded';
		else
			return class'BloodMan_Exploded';
	}
	if (DT.default.bFlaming)
		return class'BloodMan_Fire';

	return class'BloodMan_General';
}

simulated function AttachEffect( class<xEmitter> EmitterClass, Name BoneName, Vector Location, Rotator Rotation )
{
    local Actor a;
    local int i;
	local bool bRot;

    if( bSkeletized || (BoneName == 'None') )
        return;
		
	if (BoneName == 'pelvis')
	{
		BoneName = 'spine';
		bRot=True;
	}

    for( i = 0; i < Attached.Length; i++ )
    {
        if( Attached[i] == None )
            continue;

        if( Attached[i].AttachmentBone != BoneName )
            continue;

        if( ClassIsChildOf( EmitterClass, Attached[i].Class ) )
            return;
    }

    a = Spawn( EmitterClass,,, Location, Rotation);
	if (bRot)
		a.SetRelativeRotation(rot(32768, 0, 0));

    if( !AttachToBone( a, BoneName ) )
    {
        log( "Couldn't attach "$EmitterClass$" to "$BoneName, 'Error' );
        a.Destroy();
        return;
    }

    for( i = 0; i < Attached.length; i++ )
    {
        if( Attached[i] == a )
            break;
    }

    a.SetRelativeRotation( Rotation );
}

simulated function DoHit (name Bone, class<DamageType> DamageType, vector HitRay, vector HitLocation, int Damage)
{
	local bool bCanDoPelvis, bCanDoSpine, bHitBoneSevered, bSpineGone, bPelvisGone;
	local class<BallisticDamageType> BDT;
	local int i;

	if (DamageType == None)
		return;

	BDT = class<BallisticDamageType>(DamageType);
	// Hack to use cool gore with old DTs
	if (BDT == None)
		BDT = UpgradeDamagetypeForGore(DamageType);

	if (BDT != None)
		BDT.static.LocalHitEffects(self, Bone, HitLocation, HitRay, Damage);

	// Hes dead, we can try dismemberment! Once the body is a corpse, only allow this if gibbable corpses are enabled.
	if (Health <= 0 && (!bPlayedDeath || class'BloodManager'.default.bGibbableCorpses))
	{
        if (!DamageType.default.bNeverSevers && !class'GameInfo'.static.UseLowGore())
		{
			bFlaming = DamageType.Default.bFlaming;
			// MultiSever: We try to dislodge as many bones as possible, not just the one that was hit
			if (Bone == 'none' || (BDT!=None && BDT.default.bMultiSever))
			{
				if (!BoneDismembered('pelvis'))
				{
					bCanDoPelvis = CanDismemberBone('pelvis', DamageType, Damage, HitLocation, HitRay, false);
					if (BoneDismembered('spine'))
						bSpineGone = true;
				}
				else
					bPelvisGone = true;

				if (bCanDoPelvis)
					DoDismember('pelvis', DamageType, HitRay, HitLocation, Damage);
				else if (!bSpineGone && CanDismemberBone('spine', DamageType, Damage, HitLocation, HitRay, false))
				{
					bCanDoSpine = true;
					DoDismember('spine', DamageType, HitRay, HitLocation, Damage);
				}
				if (!bCanDoSpine && !bSpineGone)
				{
					if (!BoneDismembered('head') && CanDismemberBone('head', DamageType, Damage, HitLocation, HitRay, false))
						DoDismember('head', DamageType, HitRay, HitLocation, Damage);
					if (!BoneDismembered('lshoulder'))
					{
						if (CanDismemberBone('lshoulder', DamageType, Damage, HitLocation, HitRay, false))
							DoDismember('lshoulder', DamageType, HitRay, HitLocation, Damage);
						else if (!BoneDismembered('lrarm') && CanDismemberBone('lrarm', DamageType, Damage, HitLocation, HitRay, false))
							DoDismember('lrarm', DamageType, HitRay, HitLocation, Damage);
//						else if (CanDismemberBone('lhand', DamageType, Damage, HitLocation, HitRay, false))
//							DoDismember('lhand', DamageType, HitRay, HitLocation, Damage);
					}
					if (!BoneDismembered('rshoulder'))
					{
						if (CanDismemberBone('rshoulder', DamageType, Damage, HitLocation, HitRay, false))
							DoDismember('rshoulder', DamageType, HitRay, HitLocation, Damage);
						else if (!BoneDismembered('rfarm'))
						{
						 	if (CanDismemberBone('rfarm', DamageType, Damage, HitLocation, HitRay, false))
								DoDismember('rfarm', DamageType, HitRay, HitLocation, Damage);
//							else if (!BoneDismembered('righthand') && CanDismemberBone('righthand', DamageType, Damage, HitLocation, HitRay, false))
//								DoDismember('righthand', DamageType, HitRay, HitLocation, Damage);
//							else if (CanDismemberBone('rhand', DamageType, Damage, HitLocation, HitRay, false))
//								DoDismember('rhand', DamageType, HitRay, HitLocation, Damage);
						}
					}
				}
				if (!bCanDoPelvis && !bPelvisGone)
				{
					if (!BoneDismembered('lthigh'))
					{
						if (CanDismemberBone('lthigh', DamageType, Damage, HitLocation, HitRay, false))
							DoDismember('lthigh', DamageType, HitRay, HitLocation, Damage);
						else if (!BoneDismembered('lfoot') && CanDismemberBone('lfoot', DamageType, Damage, HitLocation, HitRay, false))
							DoDismember('lfoot', DamageType, HitRay, HitLocation, Damage);
					}
					if (!BoneDismembered('rthigh'))
					{
						if (CanDismemberBone('rthigh', DamageType, Damage, HitLocation, HitRay, false))
							DoDismember('rthigh', DamageType, HitRay, HitLocation, Damage);
						else if (!BoneDismembered('rfoot') && CanDismemberBone('rfoot', DamageType, Damage, HitLocation, HitRay, false))
							DoDismember('rfoot', DamageType, HitRay, HitLocation, Damage);
					}
				}
			}
			else if (!BoneDismembered(Bone) && CanDismemberBone(Bone, DamageType, Damage, HitLocation, HitRay, true))
				DoDismember(Bone, DamageType, HitRay, HitLocation, Damage);
		}
	}
	// Blood effects
	if (DamageType.default.bCausesBlood)
	{
		if (Bone == 'none')
			bHitBoneSevered = SeveredBones.length > 0;
		else
			for (i=0;i<SeveredBones.length;i++)
				if (SeveredBones[i] == Bone)		{
					bHitBoneSevered = true; break;	}

		if (!bHitBoneSevered || BDT == None || !BDT.default.bSeverPreventsBlood)
		{
			HitLocation += HitRay * CollisionRadius * 0.5;
			if (BDT == None || !BDT.static.DoBloodHit(self, Bone, HitLocation, HitRay, Damage))
				GetBloodManagerForGore(DamageType).static.DoBloodHit(self, Bone, HitLocation, HitRay, Damage);
		}
		if (Health <= 0 && !class'GameInfo'.static.NoBlood())
		{
			bBleedingCorpse=true;
			if (PhysicsVolume.bWaterVolume && WaterBlood == None && class'BWBloodControl'.default.bUseBloodPools)
			{
				WaterBlood = Spawn(BloodSet.default.WaterBloodClass,self,, Location, Rotation);
				WaterBlood.SetBase(self);
			}
		}
	}
}
// Calculate and decided if a particular bone should be severed depending on damage factors
simulated function bool CanDismemberBone (name Bone, class<DamageType> DamageType, int Damage, vector Hitloc, vector HitRay, bool bDirectHit)
{
	local byte DTCanSever;

	if (Level.Game != None && Level.Game.PreventSever(self, Bone, Damage, DamageType))
		return false;

	// BallisticDamageTypes can override the descision
	if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).static.OverrideCanSever(self, Bone, Damage, HitLoc, HitRay, bDirectHit, DTCanSever))
		return DTCanSever != 0;

	// Bone was hit directly
	if (bDirectHit)
	{
		if (Bone == 'pelvis' || Bone == 'spine')
		{	return ((class<BallisticDamageType>(DamageType) == None || !class<BallisticDamageType>(DamageType).default.bOnlySeverLimbs) &&
				(DamageType.default.bAlwaysSevers || Damage * DamageType.default.GibModifier + Health > 40 + Rand(40)) );
		}
		else if (DamageType.default.bAlwaysSevers)
			return true;
		switch (Bone)
		{
//		case 'pelvis'	:	case 'spine':
//			return ((class<BallisticDamageType>(DamageType) == None || !class<BallisticDamageType>(DamageType).default.bOnlySeverLimbs) &&
//					Damage * DamageType.default.GibModifier + Health		> 40 + Rand(40));
		case 'head'		:	return (Damage * DamageType.default.GibModifier + Health*0.5	> 10 + Rand(20));
		case 'lshoulder':	case 'rshoulder':
			return (Damage * DamageType.default.GibModifier - Health*0.5	> 30 + Rand(30));
		case 'lfarm'	:	case 'rfarm'	:
			return (Damage * DamageType.default.GibModifier - Health*0.5	> 15 + Rand(20));
		case 'righthand'	:	case 'lhand'	:	case 'rhand'	:
			return (Damage * DamageType.default.GibModifier - Health*0.5	> 10 + Rand(10));
		case 'lthigh'	:	case 'rthigh'	:
			return (Damage * DamageType.default.GibModifier - Health*0.5	> 20 + Rand(20));
		case 'lfoot'	:	case 'rfoot'	:
			return (Damage * DamageType.default.GibModifier - Health*0.5	> 10 + Rand(15));
		}
	}
	// We're trying multi sever
	else
	{
		switch (Bone)
		{
		case 'pelvis'	: return ((class<BallisticDamageType>(DamageType) == None || !class<BallisticDamageType>(DamageType).default.bOnlySeverLimbs) &&
								  200 + Rand(150) < Damage * DamageType.default.GibModifier * (HitRay.Z*2+2));
		case 'spine'	: return ((class<BallisticDamageType>(DamageType) == None || !class<BallisticDamageType>(DamageType).default.bOnlySeverLimbs) &&
								  200 + Rand(150) < Damage * DamageType.default.GibModifier * (-HitRay.Z+1));
		case 'head'		: return (50 + Rand(50) < Damage * DamageType.default.GibModifier * (-HitRay.Z+1));
		case 'lshoulder': return (60 + Rand(60) < Damage * DamageType.default.GibModifier * ((HitRay << Rotation).Y+1) * (-HitRay.Z*0.5+1));
		case 'rshoulder': return (60 + Rand(60) < Damage * DamageType.default.GibModifier * (-(HitRay << Rotation).Y+1) * (-HitRay.Z*0.5+1));
		case 'lfarm'	: return (30 + Rand(30) < Damage * DamageType.default.GibModifier * ((HitRay << Rotation).Y+1) * (-HitRay.Z*0.5+1));
		case 'rfarm'	: return (30 + Rand(30) < Damage * DamageType.default.GibModifier * (-(HitRay << Rotation).Y+1) * (-HitRay.Z*0.5+1));
		case 'lhand'	: return (20 + Rand(20) < Damage * DamageType.default.GibModifier * ((HitRay << Rotation).Y+1) * (-HitRay.Z*0.35+1));
		case 'righthand': return (20 + Rand(20) < Damage * DamageType.default.GibModifier * (-(HitRay << Rotation).Y+1) * (-HitRay.Z*0.35+1));
		case 'rhand'	: return (20 + Rand(20) < Damage * DamageType.default.GibModifier * (-(HitRay << Rotation).Y+1) * (-HitRay.Z*0.35+1));
		case 'lthigh'	: return (60 + Rand(60) < Damage * DamageType.default.GibModifier * ((HitRay << Rotation).Y*0.5+1) * (HitRay.Z*0.75+1));
		case 'rthigh'	: return (60 + Rand(60) < Damage * DamageType.default.GibModifier * (-(HitRay << Rotation).Y*0.5+1) * (HitRay.Z*0.75+1));
		case 'lfoot'	: return (20 + Rand(20) < Damage * DamageType.default.GibModifier * ((HitRay << Rotation).Y*0.5+1) * (HitRay.Z*0.75+1));
		case 'rfoot'	: return (20 + Rand(20) < Damage * DamageType.default.GibModifier * (-(HitRay << Rotation).Y*0.5+1) * (HitRay.Z*0.75+1));
		}
	}
	return false;
}
// Sever bone and all its sub-bones
simulated function DoDismember (name Bone, class<DamageType> DamageType, vector HitRay, vector HitLocation, int Damage)
{
	switch (Bone)
	{
		case 'none' :
			DismemberSub ('lthigh', HitRay, DamageType, Damage);
			DismemberSub ('rthigh', HitRay, DamageType, Damage);
			DismemberSub ('lfoot', HitRay, DamageType, Damage);
			DismemberSub ('rfoot', HitRay, DamageType, Damage);
		case 'spine' :
			DismemberSub ('spine', HitRay, DamageType, Damage);
			DismemberSub ('lshoulder', HitRay, DamageType, Damage);
			DismemberSub ('rshoulder', HitRay, DamageType, Damage);
			DismemberSub ('lfarm', HitRay, DamageType, Damage);
			DismemberSub ('rfarm', HitRay, DamageType, Damage);
			DismemberSub ('righthand', HitRay, DamageType, Damage);
//			DismemberSub ('lhand', HitRay, DamageType, Damage);
//			DismemberSub ('rhand', HitRay, DamageType, Damage);
		case 'head' :
			DismemberSub ('head', HitRay, DamageType, Damage);
			break;

		case 'lshoulder' :
			DismemberSub ('lshoulder', HitRay, DamageType, Damage);
		case 'lfarm' :
			DismemberSub ('lfarm', HitRay, DamageType, Damage);
//		case 'lhand' :
//			DismemberSub ('lhand', HitRay, DamageType, Damage);
			break;

		case 'rshoulder' :
			DismemberSub ('rshoulder', HitRay, DamageType, Damage);
		case 'rfarm' :
			DismemberSub ('rfarm', HitRay, DamageType, Damage);
		case 'righthand' :
			DismemberSub ('righthand', HitRay, DamageType, Damage);
//		case 'rhand' :
//			DismemberSub ('rhand', HitRay, DamageType, Damage);
			break;

		case 'lthigh' :
			DismemberSub ('lthigh', HitRay, DamageType, Damage);
		case 'lfoot' :
			DismemberSub ('lfoot', HitRay, DamageType, Damage);
			break;

		case 'rthigh' :
			DismemberSub ('rthigh', HitRay, DamageType, Damage);
		case 'rfoot' :
			DismemberSub ('rfoot', HitRay, DamageType, Damage);
			break;

		case 'pelvis' :
			DismemberSub ('pelvis', HitRay, DamageType, Damage);
			DismemberSub ('lthigh', HitRay, DamageType, Damage);
			DismemberSub ('rthigh', HitRay, DamageType, Damage);
			DismemberSub ('lfoot', HitRay, DamageType, Damage);
			DismemberSub ('rfoot', HitRay, DamageType, Damage);
			break;
	}
	DismemberRoot (Bone, HitRay, DamageType, Damage);
}
// Do effects common to root bone and sub bones of a sever (e.g. Sever effects, gibs)
simulated function DismemberSub (name Bone, vector HitRay, class<DamageType> DamageType, int Damage)
{
	if (BoneDismembered(Bone))
		return;
	SeveredBones[SeveredBones.length] = Bone;
	if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).static.DoSeverEffect(self, Bone, HitRay, Damage))
		return;

	GetBloodManagerForGore(DamageType).static.DoSeverEffects(self, Bone, HitRay, Damage, DamageType.default.GibPerterbation);
//	class'BloodMan_General'.static.DoSeverEffects(self, Bone, HitRay, Damage, DamageType.default.GibPerterbation);
}
// Do things for only the root bone of the sever (e.g. Spawn stump, hidebone)
simulated function DismemberRoot (name Bone, vector HitRay, class<DamageType> DamageType, int Damage)
{
	FreeSubs(Bone);
	if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).static.DoSeverStump(self, Bone, HitRay, Damage))
		return;
	GetBloodManagerForGore(DamageType).static.DoSeverStump(self, Bone, HitRay, Damage);
}

simulated function bool BoneIsSubOf (name SubBone, name RootBone)
{
	if (RootBone == 'head' || RootBone == 'lfoot' || RootBone == 'rfoot' || RootBone == 'lfarm' || RootBone == 'rfarm')
		return false;
	if (SubBone == 'spine' || SubBone == 'pelvis')
		return false;
	switch (RootBone)
	{
	case 'spine'	:	if (SubBone == 'lshoulder' || SubBone == 'rshoulder' || SubBone == 'lfarm' || SubBone == 'rfarm' || SubBone == 'head') return true;
		break;
	case 'lshoulder':	if (SubBone == 'lfarm') return true;
		break;
	case 'rshoulder':	if (SubBone == 'rfarm') return true;
		break;
	case 'rshoulder':	if (SubBone == 'rfarm') return true;
		break;
	case 'pelvis'	:	if (SubBone == 'lthigh' || SubBone == 'rthigh' || SubBone == 'lfoot' || SubBone == 'rfoot') return true;
		break;
	case 'lthigh'	:	if (SubBone == 'lfoot') return true;
		break;
	case 'rthigh'	:	if (SubBone == 'rfoot') return true;
		break;
	}
	return false;
}

simulated function FreeSubs (name RootBone)
{
	local int i;

	if (SeveredBones.length == 0)
		return;

	for (i=0;i<Attached.length;i++)
		if (BoneIsSubOf(Attached[i].AttachmentBone, RootBone))
		{
			if (Emitter(Attached[i]) != None)
				Emitter(Attached[i]).Kill();
			else if (BallisticStump(Attached[i]) != None)
				Attached[i].Destroy();
			else
				DetachFromBone(Attached[i]);
		}
}

simulated function SpawnGibs(Rotator HitRotation, float ChunkPerterbation)
{
	local vector HitRay;

	bGibbed = true;
	PlayDyingSound();

	HitRay = vector(HitRotation);

//	GetBloodManagerForGore(None).static.DoSeverStump(self, Bone, HitRay, Damage);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'lthigh', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'rthigh', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'lfoot', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'rfoot', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'spine', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'pelvis', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'lshoulder', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'rshoulder', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'lfarm', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'rfarm', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'righthand', HitRay, ChunkPerterbation, 100);
	GetBloodManagerForGore(None).static.DoSeverEffects(self, 'head', HitRay, ChunkPerterbation, 100);
}

function PlayDyingAnimation(class<DamageType> DamageType, vector HitLoc)
{
	bRagdollSetup = true;
	Super.PlayDyingAnimation(DamageType, HitLoc);
	bRagdollSetup = false;
}

function PlayDyingSound()
{
	// Dont play dying sound if a skeleton. Tricky without vocal chords.
	if ( bSkeletized )
		return;

	if ( bGibbed )
	{
        PlaySound(GibGroupClass.static.GibSound(), SLOT_Pain,3.5*TransientSoundVolume,true,500);
		return;
	}

    if ( HeadVolume.bWaterVolume )
    {
        PlaySound(GetSound(EST_Drown), SLOT_Pain,2.5*TransientSoundVolume,true,500);
        return;
    }
	
	//don't play dying sound for headshots.
	if (class<BallisticDamageType>(HitDamageType) != None && class<BallisticDamageType>(HitDamageType).default.bHeaddie)
		return;
		
	PlaySound(SoundGroupClass.static.GetDeathSound(), SLOT_Pain,2.5*TransientSoundVolume, true,500);
}

// Called by the HUD right after it has drawn the first person weapon and before it draws itself (bSpecialHUD)
simulated function DrawHUD(Canvas C)
{
	if (BallisticPlayer(Controller) != None)
		BallisticPlayer(Controller).DrawScreenFlash(C);
}

simulated function Setup(xUtil.PlayerRecord rec, optional bool bLoadNow)
{
	//Exclude Matrix because it's cheap. Treat incoming Jakobs as the default character.
	/*if ( (rec.Species == None) || (PlayerReplicationInfo.CharacterName ~= "Matrix") || (PlayerReplicationInfo.CharacterName ~= "Enigma") || ForceDefaultCharacter() )
		rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
		
	if (PlayerReplicationInfo.CharacterName ~= "Abaddon")
		rec = class'xUtil'.static.FindPlayerRecord("AbaddonB");

    else if (PlayerReplicationInfo.CharacterName ~= "Kaela")
		rec = class'xUtil'.static.FindPlayerRecord("KaelaB");

    else if (PlayerReplicationInfo.CharacterName ~= "Zarina")
		rec = class'xUtil'.static.FindPlayerRecord("ZarinaB");

    else if (PlayerReplicationInfo.CharacterName ~= "Jakob")
		rec = class'xUtil'.static.FindPlayerRecord("JakobB");
	*/

	// If you're using an advantage-conferring skin you're going to be as bright as the bloody Sun
    // this check is fine - it won't break clients and I guarantee they won't even notice it
	if (rec.DefaultName == "July")
		AmbientGlow = 64;

    Species = rec.Species;
	RagdollOverride = rec.Ragdoll;

	if ( !Species.static.Setup(self,rec) )
	{
		rec = class'xUtil'.static.FindPlayerRecord(GetDefaultCharacter());
		if ( !Species.static.Setup(self,rec) )
			return;
	}
	ResetPhysicsBasedAnim();

	BloodSet = class'BWBloodSetHunter'.static.GetBloodSetFor(self);
}

function PlayTeleportEffect( bool bOut, bool bSound)
{
	if ( !bSpawnIn && (Level.TimeSeconds - SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime) )
	{
		bSpawnIn = true;
//		SetOverlayMaterial( ShieldHitMat, DeathMatch(Level.Game).SpawnProtectionTime, false );
//	    if ( (PlayerReplicationInfo == None) || (PlayerReplicationInfo.Team == None) || (PlayerReplicationInfo.Team.TeamIndex == 0) )
//		    Spawn(TransEffects[0],,,Location + CollisionHeight * vect(0,0,0.75));
//	    else
//		    Spawn(TransEffects[1],,,Location + CollisionHeight * vect(0,0,0.75));
		Spawn(class'BWPlayerSpawnFX',,,Location);
	}
	else if ( bOut )
		DoTranslocateOut(Location);
	else if ( (PlayerReplicationInfo == None) || (PlayerReplicationInfo.Team == None) || (PlayerReplicationInfo.Team.TeamIndex == 0) )
		Spawn(TransEffects[0],self,,Location + CollisionHeight * vect(0,0,0.75));
	else
		Spawn(TransEffects[1],self,,Location + CollisionHeight * vect(0,0,0.75));
    Super(UnrealPlayer).PlayTeleportEffect( bOut, bSound );
}

simulated function StartDeRes()
{
	local KarmaParamsSkel skelParams;
	local int i, j, k;

    if( Level.NetMode == NM_DedicatedServer )
        return;

	if (BloodPool != None)
		BloodPool.StopExpanding();
	for (i=Stumps.length-1;i>=0;i--)
		if (Stumps[i] != None)
			Stumps[i].Destroy();

	// Wicked new BW DeRes ---------
	Spawn(class'BWDeresFX',self,, Location);
	NewDeResDecal = Spawn(class'BWDeResDecal', self, , Location, rot(-16384,0,0));
	PlaySound(NewDeResSound, SLOT_Interact, 0.8,, 40);


	for (i=0;i<Skins.Length;i++)
	{
		if (Skins[i]==None)
			continue;
		if (bTransparencyInitialized && Skins[i] != OriginalSkins[i])
			Skins[i] = OriginalSkins[i];
		j = NewDeResShaders.length;
		k = NewDeResFinalBlends.length;
	 	NewDeResShaders[j] = Shader(Level.ObjectPool.AllocateObject(class'BWDeResShader'));
		if ( NewDeResShaders[j] != None )
		{
			if (FinalBlend(Skins[i]) != None && FinalBlend(Skins[i]).Material != None)
				NewDeResShaders[j].Diffuse = FinalBlend(Skins[i]).Material;
			else
				NewDeResShaders[j].Diffuse = Skins[i];

//			if (Shader(Skins[i]) != None && Shader(Skins[i]).Diffuse != None)
//				NewDeResShaders[j].Diffuse = Shader(Skins[i]).Diffuse;

			if (Shader(NewDeResShaders[j].Diffuse) != None && Shader(NewDeResShaders[j].Diffuse).Diffuse != None)
				NewDeResShaders[j].Diffuse = Shader(NewDeResShaders[j].Diffuse).Diffuse;

		 	NewDeResFinalBlends[k] = FinalBlend(Level.ObjectPool.AllocateObject(class'FinalBlend'));
			if ( NewDeResFinalBlends[k] != None )
			{
				NewDeResFinalBlends[k].Material = NewDeResShaders[j];
				NewDeResFinalBlends[k].FrameBufferBlending = FB_OverWrite;
				NewDeResFinalBlends[k].TwoSided = false;
				NewDeResFinalBlends[k].ZWrite = true;
				NewDeResFinalBlends[k].ZTest = true;
				NewDeResFinalBlends[k].AlphaTest = true;
				NewDeResFinalBlends[k].AlphaRef = 0;

				Skins[i] = NewDeResFinalBlends[k];
			}
		}
	}
	// -----------------------------

    if( Physics == PHYS_KarmaRagdoll )
    {
		// Turn off gravity while de-res-ing
		KSetActorGravScale(DeResGravScale);

        // Turn off collision with the world for the ragdoll.
        KSetBlockKarma(false);

        // Turn off convulsions during de-res
        skelParams = KarmaParamsSkel(KParams);
		skelParams.bKDoConvulsions = false;
    }

//    AmbientSound = Sound'GeneralAmbience.Texture19';
    SoundRadius = 40.0;

	// Turn off collision when we de-res (avoids rockets etc. hitting corpse!)
	SetCollision(false, false, false);

	// Remove/disallow projectors
	Projectors.Remove(0, Projectors.Length);
	bAcceptsProjectors = false;

	// Remove shadow
	if(PlayerShadow != None)
		PlayerShadow.bShadowActive = false;

	// Remove flames
	RemoveFlamingEffects();

	// Turn off any overlays
	SetOverlayMaterial(None, 0.0f, true);

    bDeRes = true;
}

simulated function ListGoreEffect(actor NewEffect)
{
	local int i;

	for (i=0;i<GoreFX.length;i++)
	{
		if (GoreFX[i] == None)
		{
			GoreFX.remove(i, 1);
			i--;
			continue;
		}
	}
	GoreFX[GoreFX.length] = NewEffect;
}

simulated event Destroyed()
{
	local int i;
	
	if (bTransparencyInitialized)
	{
		for (i=0; i<Skins.length; ++i)
			Skins[i] = OriginalSkins[i];	
	}

	for (i=0;i<NewDeResFinalBlends.length;i++)
		if (NewDeResFinalBlends[i] != None)
		{
			Level.ObjectPool.FreeObject(NewDeResFinalBlends[i]);
			NewDeResFinalBlends[i] = None;
		}
	NewDeResFinalBlends.length=0;

	for (i=0;i<NewDeResShaders.length;i++)
		if (NewDeResShaders[i] != None)
		{
			Level.ObjectPool.FreeObject(NewDeResShaders[i]);
			NewDeResShaders[i] = None;
		}
	NewDeResShaders.length=0;

	if (WaterBlood != None)
		WaterBlood.Kill();
	if (BloodPool != None)
		BloodPool.StopExpanding();
	for (i=Stumps.length-1;i>=0;i--)
	{
		if (Stumps[i] != None)
			Stumps[i].Destroy();
		Stumps.length = i;
	}

	for (i=0;i<GoreFX.length;i++)
	{
		if (GoreFX[i] == None)
			continue;
		if (Emitter(GoreFX[i]) != None)
			Emitter(GoreFX[i]).Kill();
		else
			GoreFX[i].Destroy();
	}

    if (RwColMgr != None)
    {
        RwColMgr.UnregisterPawn(self);
        RwColMgr = None;
    }

	super.Destroyed();
}

simulated function HideBone(name boneName)
{
	local int BoneScaleSlot;

    if( boneName == 'lthigh' )
		boneScaleSlot = 0;
	else if ( boneName == 'rthigh' )
		boneScaleSlot = 1;
	else if( boneName == 'rfarm' )
		boneScaleSlot = 2;
	else if ( boneName == 'lfarm' )
		boneScaleSlot = 3;
	else if ( boneName == 'head' )
		boneScaleSlot = 4;
	else if ( boneName == 'spine' )
		boneScaleSlot = 5;
	else if ( boneName == 'righthand' )
		boneScaleSlot = 6;
	else if ( boneName == 'rhand' )
		return;
//		boneScaleSlot = 6;
	else if ( boneName == 'lhand' )
		return;
//		boneScaleSlot = 7;
	else if ( boneName == 'rfoot' )
		boneScaleSlot = 8;
	else if ( boneName == 'lfoot' )
		boneScaleSlot = 9;
	else if ( boneName == 'rshoulder' )
		boneScaleSlot = 10;
	else if ( boneName == 'lshoulder' )
		boneScaleSlot = 11;
	else if ( boneName == 'pelvis' )
	{
		SetBoneScale(12, 0.01, 'Bip01');
		SetBoneScale(5, 100, 'spine');
		return;
	}

    SetBoneScale(BoneScaleSlot, 0.01, BoneName);
}

// Eye height
// Override crouch eye height - don't want it at the top of the cylinder...
simulated function SetBaseEyeheight()
{
	if ( !bIsCrouched )
		BaseEyeheight = Default.BaseEyeheight;
	else
		BaseEyeheight = CrouchEyeHeight;

	Eyeheight = BaseEyeheight;
}

// Stub events called when physics actually allows crouch to begin or end
// use these for changing the animation (if script controlled)
event StartCrouch(float HeightAdjust)
{
	EyeHeight += HeightAdjust;
	OldZ -= HeightAdjust;
	BaseEyeheight = CrouchEyeHeight;
}

event EndCrouch(float HeightAdjust)
{
	EyeHeight -= HeightAdjust;
	OldZ += HeightAdjust;
	BaseEyeHeight = Default.BaseEyeHeight;
	JumpCrouchEnd = MoveTime() + JumpCrouchTime;
}

// The player's controller calls this from ProcessMove at the start of every walking move,
// before it decides whether to combine the move with the one it was holding back.
function ShouldCrouch(bool Crouch)
{
	local PlayerController PC;

	Super.ShouldCrouch(Crouch);

	PC = PlayerController(Controller);
	if (Role != ROLE_AutonomousProxy || PC == None)
		return;

	bSlideMoveStart = true;
	bSlideMovePending = PC.PendingMove != None;

	// The controller replays moves at whatever GroundSpeed there is now. A replay that goes back
	// past a sprint change would run the moves from before it at the wrong speed.
	if (PC.bUpdating)
	{
		if (!bReplaySpeedSet)
		{
			bReplaySpeedSet = true;
			PresentSpeed = GroundSpeed;
		}
		ReplaySpeed = GroundSpeedAfter(MoveTime());
		GroundSpeed = ReplaySpeed;
		return;
	}

	if (bReplaySpeedSet)
	{
		bReplaySpeedSet = false;
		if (GroundSpeed == ReplaySpeed)
			GroundSpeed = PresentSpeed;
	}

	// A late GroundSpeed from the server mustn't get into a move while a sprint change is being predicted
	if (Sprinter != None && Sprinter.PredictEndTime > 0)
		Sprinter.ClientUpdateSpeed();

	if (GroundSpeed != LastMoveSpeed && LastMoveSpeed > 0)
		LogSpeedChange(LastMoveStamp, LastMoveSpeed, GroundSpeed);
	LastMoveStamp = Level.TimeSeconds;
	LastMoveSpeed = GroundSpeed;
}

function LogSpeedChange(float TimeStamp, float OldSpeed, float NewSpeed)
{
	local int i, Oldest;

	for (i = 1; i < ArrayCount(SpeedLog); i++)
		if (SpeedLog[i].Stamp < SpeedLog[Oldest].Stamp)
			Oldest = i;

	SpeedLog[Oldest].Stamp = TimeStamp;
	SpeedLog[Oldest].OldSpeed = OldSpeed;
	SpeedLog[Oldest].NewSpeed = NewSpeed;
}

// Client: the GroundSpeed of the move that was made after the one with this MoveTime
function float GroundSpeedAfter(float TimeStamp)
{
	local int i, Last, Next;

	Last = -1;
	Next = -1;
	for (i = 0; i < ArrayCount(SpeedLog); i++)
	{
		if (SpeedLog[i].Stamp <= 0)
			continue;
		if (SpeedLog[i].Stamp <= TimeStamp)
		{
			if (Last < 0 || SpeedLog[i].Stamp > SpeedLog[Last].Stamp)
				Last = i;
		}
		else if (Next < 0 || SpeedLog[i].Stamp < SpeedLog[Next].Stamp)
			Next = i;
	}

	if (Last >= 0)
		return SpeedLog[Last].NewSpeed;
	if (Next >= 0)
		return SpeedLog[Next].OldSpeed;
	return PresentSpeed;
}

// This is a fix for some stupid ass bug that emanates from beyond my reach.
// It causes BaseEyeHeight to be forced to 38 on the server for non local players (unless the server player is first person spectating that client)
simulated function vector EyePosition()
{
	if (Role == ROLE_Authority && bIsCrouched && !IsLocallyControlled() && PlayerController(Controller) != None && !PlayerController(Controller).bBehindView && BaseEyeHeight == default.BaseEyeHeight)
		return CrouchEyeHeight * vect(0,0,1) + WalkBob;

	return super.EyePosition();
}

function DoDoubleJump( bool bUpdating )
{
    PlayDoubleJump();

    if ( !bIsCrouched && !bWantsToCrouch )
    {
		if ( !IsLocallyControlled() || (AIController(Controller) != None) )
			MultiJumpRemaining -= 1;
        Velocity.Z = JumpZ + MultiJumpBoost;
        SetPhysics(PHYS_Falling);
        if ( !bUpdating )
			PlayOwnedSound(GetSound(EST_DoubleJump), SLOT_Pain, GruntVolume, , GruntRadius);
		//StopWallRun();
    }

	if (Role == ROLE_Authority)
		Inventory.OwnerEvent('Jumped');
}

singular event BaseChange()
{
	local float decorMass;

	if ( bInterpolating )
		return;
		
	//Check for lift immunity from a jump.
	if (Mover(OldBase) != None && Base == None)
		LastMoverLeaveTime = Level.TimeSeconds;
	else LastMoverLeaveTime = 0.0f;
	
	if ( (base == None) && (Physics == PHYS_None) )
		SetPhysics(PHYS_Falling);
		
	// Pawns can only set base to non-pawns, or pawns which specifically allow it.
	// Otherwise we do some damage and jump off.
	else if ( Pawn(Base) != None && Base != DrivenVehicle )
	{
		if ( !Pawn(Base).bCanBeBaseForPawns )
		{
			Base.TakeDamage( (1-Velocity.Z/100)* Mass/Base.Mass, Self,Location,0.5 * Velocity , class'Crushed');
			JumpOffPawn();
		}
	}
	else if (Sandbag(Base) != None) //hack fixme
		JumpOffPawn();
	
	else if ( (Decoration(Base) != None) && (Velocity.Z < -400) )
	{
		decorMass = FMax(Decoration(Base).Mass, 1);
		Base.TakeDamage((-2* Mass/decorMass * Velocity.Z/400), Self, Location, 0.5 * Velocity, class'Crushed');
	}
	
	OldBase = Base;
}

//==============================================================================
// CanMantle
//
// Used for a cheap hack in Tactical mode, which allows a player to double jump
// when a wall is in front of them
//
// TODO/FIXME:
// We can use code similar to deploy in order to determine whether this wall 
// should be mantled. We can then modify the double jump height based on what 
// we find. Would need to check replication to maintain server synch.
//==============================================================================
final function bool CanMantle()
{
    local vector X,Y,Z, TraceStart, TraceEnd, HitLocation, HitNormal;
    local Actor HitActor;
	local rotator TurnRot;

	if (MultiJumpRemaining == 0 || Physics != PHYS_Falling)
        return false;

	TurnRot.Yaw = Rotation.Yaw;
    GetAxes(TurnRot,X,Y,Z);

    TraceEnd = X;

    TraceStart = Location - CollisionHeight*Vect(0,0,1) + TraceEnd*CollisionRadius;
    TraceEnd = TraceStart + TraceEnd*32.0;

    HitActor = Trace(HitLocation, HitNormal, TraceEnd, TraceStart, false, vect(1,1,1));
    
    return HitActor != None && HitActor.bWorldGeometry || (Mover(HitActor) != None);
}

function bool CanDoubleJump()
{
	if(BallisticWeapon(Weapon) != None && BallisticWeapon(Weapon).bScopeView)
		return false;

    if (class'BallisticReplicationInfo'.static.IsTactical())
        return CanMantle();

	if (!bCanDoubleJump)
		return false;

	return super.CanDoubleJump();
}

function bool CanMultiJump()
{
	if (!bCanDoubleJump)
		return false;

	return super.CanMultiJump();
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
    //local vector X, Y, Z, TraceStart, TraceEnd, Dir, HitLocation, HitNormal;
    //local Actor HitActor;
    //local rotator TurnRot;

	if (!bCanDodge)
		return false;

	// A replayed dodge already passed this check when the move was first made
	if (MoveTime() < DodgeReadyTime && !IsReplayingMoves())
		return false;

    if (super.Dodge(DoubleClickMove))
    {
		if (!IsReplayingMoves())
			DodgeReadyTime = MoveTime() + DodgeInterval;

        if (Role == ROLE_Authority)
            Inventory.OwnerEvent('Dodged');
        return true;
    }

	/* 
    TurnRot.Yaw = Rotation.Yaw;
    GetAxes(TurnRot, X, Y, Z);

    if (Physics == PHYS_Falling)
    {
        // Determine direction for wall trace based on input
        if (DoubleClickMove == DCLICK_Left)
            Dir = -Y; // Left
        else if (DoubleClickMove == DCLICK_Right)
            Dir = Y; // Right

        // Perform wall trace
        TraceStart = Location - CollisionHeight * vect(0, 0, 1);
        TraceEnd = TraceStart + Dir * CollisionRadius * 2; // Extend trace outward
        HitActor = Trace(HitLocation, HitNormal, TraceEnd, TraceStart, false, vect(1, 1, 1));
        // Check if wall is valid
        if (HitActor != None && (HitActor.bWorldGeometry || Mover(HitActor) != None))
        {
            // Initiate wall running
            bLockedToSurface = true;
            LockedSurfaceNormal = HitNormal;
        }
    }
	*/

    return false;
}

function bool DoJump( bool bUpdating )
{
	local float OldJumpZ;

	OldJumpZ = JumpZ;
	
	if (BallisticWeapon(Weapon) != None)
        JumpZ = BallisticWeapon(Weapon).GetModifiedJumpZ(self);

    if ( !bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < 100) && IsLocallyControlled() )
    {
		if ( PlayerController(Controller) != None )
			PlayerController(Controller).bDoubleJump = true;
        DoDoubleJump(bUpdating);
        MultiJumpRemaining -= 1;

        JumpZ = OldJumpZ;
        return true;
    }
	//Allow crouch jumping
	if ( ((Physics == PHYS_Walking) || (Physics == PHYS_Ladder) || (Physics == PHYS_Spider)) )
	{
		if ( Role == ROLE_Authority )
		{
			if ( (Level.Game != None) && (Level.Game.GameDifficulty > 2) )
				MakeNoise(0.1 * Level.Game.GameDifficulty);
			if ( bCountJumps && (Inventory != None) )
				Inventory.OwnerEvent('Jumped');
		}
		if ( Physics == PHYS_Spider )
			Velocity = JumpZ * Floor;
		else if ( Physics == PHYS_Ladder )
			Velocity.Z = 0;
		else if ( bIsWalking )
			Velocity.Z = Default.JumpZ;
		else
			Velocity.Z = JumpZ;
		if ( (Base != None) && !Base.bWorldGeometry )
			Velocity += Base.Velocity;

        if( bIsCrouched || bWantsToCrouch || MoveTime() < JumpCrouchEnd )
            Velocity.Z -= JumpZ * JumpCrouchPenalty;
	
		SetPhysics(PHYS_Falling);
		if ( !bUpdating )
			PlayOwnedSound(GetSound(EST_Jump), SLOT_Pain, GruntVolume,,GruntRadius);
		JumpZ = OldJumpZ;
		//StopWallRun();
        return true;
	}
	JumpZ = OldJumpZ;
	//log("2 JumpZ after weapon modification: " @ JumpZ);
    return false;
}

//========================================================================
// AddShieldStrength
//
// Create an armor to do hit effects, if none exists
//========================================================================
function bool AddShieldStrength(int ShieldAmount)
{
	local BallisticArmor BA;

	BA = BallisticArmor(FindInventoryType(class'BallisticArmor'));
	
	if (BA == None)
	{
		BA = spawn(class'BallisticArmor',self);
		BA.GiveTo(self, none);
	}

	return super.AddShieldStrength(ShieldAmount);
}

function bool PerformDodge(eDoubleClickDir DoubleClickMove, vector Dir, vector Cross)
{
    local float VelocityZ;
    local name Anim;
	local float DodgeGroundSpeed;

    if ( Physics == PHYS_Falling )
    {
        if (DoubleClickMove == DCLICK_Forward)
            Anim = WallDodgeAnims[0];
        else if (DoubleClickMove == DCLICK_Back)
            Anim = WallDodgeAnims[1];
        else if (DoubleClickMove == DCLICK_Left)
            Anim = WallDodgeAnims[2];
        else if (DoubleClickMove == DCLICK_Right)
            Anim = WallDodgeAnims[3];

        if ( PlayAnim(Anim, 1.0, 0.1) )
            bWaitForAnim = true;
            AnimAction = Anim;
            
		//TakeFallingDamage();
        if (Velocity.Z < -DodgeSpeedZ*0.5)
			Velocity.Z += DodgeSpeedZ*0.5;
    }

    VelocityZ = Velocity.Z;

    DodgeGroundSpeed = GroundSpeed;

    // prevent boost dodging with sprint
    if ((class'BallisticReplicationInfo'.static.IsTactical() || class'BallisticReplicationInfo'.static.IsRealism()) && class'BallisticReplicationInfo'.default.PlayerGroundSpeed < GroundSpeed)
    {
        DodgeGroundSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed;
    }
    Velocity = DodgeSpeedFactor * DodgeGroundSpeed * Dir + (Velocity Dot Cross) * Cross;

	// clamp dodge speed in realism and tactical
	if (class'BallisticReplicationInfo'.static.IsTactical() || class'BallisticReplicationInfo'.static.IsRealism())
	{
		if (VSize(Velocity) > DodgeGroundSpeed * DodgeSpeedFactor)
			Velocity = Normal(Velocity) * DodgeGroundSpeed * DodgeSpeedFactor;
	}

	if ( !bCanDodgeDoubleJump )
		MultiJumpRemaining = 0;

	if ( bCanBoostDodge || (Velocity.Z < -100) )
		Velocity.Z = VelocityZ + DodgeSpeedZ;
	else
		Velocity.Z = DodgeSpeedZ;

    CurrentDir = DoubleClickMove;
    SetPhysics(PHYS_Falling);
    PlayOwnedSound(GetSound(EST_Dodge), SLOT_Pain, GruntVolume, , GruntRadius);
    return true;
}

//Used by BW's fix of PintSize
simulated function ClientSetMovable(bool bNew)
{
	bMovable = bNew;
}

//===========================================================================
//2k4 bug fixes
//===========================================================================
function TakeDrowningDamage()
{
	if (Controller != None)
		Super.TakeDrowningDamage();
}

//Used by BW's fix of PintSize
simulated function ClientSetCrouchAbility(bool bCrouch)
{
	bCanCrouch = bCrouch;
}

simulated function ChangedWeapon()
{
    Super(Pawn).ChangedWeapon();
    if (Weapon != None && Role < ROLE_Authority)
    {
        if (bBerserk)
            Weapon.StartBerserk();
        else if ( Weapon.bBerserk )
			Weapon.StopBerserk();
    }
}

//===========================================================================
//Various fixes and support for things outside of BW.
//===========================================================================

//Hitstats (3SPN)
function IncrementBWKill(PlayerReplicationInfo PRI, string damageIdent)
{
	local BallisticPlayerReplicationInfo BWPRI;
	
	if (PRI == None || damageIdent == "Unknown" || damageIdent == "Melee")
		return;
		
	BWPRI = class'Mut_Ballistic'.static.GetBPRI(PRI);
	
	if (BWPRI == None)
		return;
	
	switch(Caps(damageIdent))
	{
				case "GRENADE":
						BWPRI.Hitstats[0].Kills++;
						break;
					   
				case "STREAK":
						BWPRI.Hitstats[1].Kills++;
						break;
					   
				case "PISTOL":
						BWPRI.Hitstats[2].Kills++;
						break;
					   
				case "SMG":
						BWPRI.Hitstats[3].Kills++;
						break;
					   
				case "ASSAULT":
						BWPRI.Hitstats[4].Kills++;
						break;
					   
				case "ENERGY":
						BWPRI.Hitstats[5].Kills++;
						break;
					   
				case "MACHINEGUN":
						BWPRI.Hitstats[6].Kills++;
						break;
					   
				case "SHOTGUN":
						BWPRI.Hitstats[7].Kills++;
						break;
					   
				case "ORDNANCE":
						BWPRI.Hitstats[8].Kills++;
						break;
					   
				case "SNIPER":
						BWPRI.Hitstats[9].Kills++;
						break;
		}
}

function IncrementBWDeathsWith()
{
	local BallisticPlayerReplicationInfo BWPRI;
	local byte WepGroup;
	
	if (PlayerReplicationInfo == None || Weapon == None)
		return;
	   
	BWPRI = class'Mut_Ballistic'.static.GetBPRI(PlayerReplicationInfo);
	   
	if (BWPRI == None)
		return;
		
	if (Weapon.InventoryGroup == 10)
		WepGroup = 1;
	else WepGroup = Weapon.InventoryGroup;
	
	// Weapons from outside BW can be in groups the stats have no slot for
	if (WepGroup < 10)
		BWPRI.Hitstats[WepGroup].DeathsWith++;
}
	

function SetBWHitStats(PlayerReplicationInfo PRI, string damageIndent, int damage)
{
		local BallisticPlayerReplicationInfo BWPRI;
	   
		if (PRI == None || damageIndent == "Unknown" || damage <= 0)
				return;
	   
		BWPRI = class'Mut_Ballistic'.static.GetBPRI(PRI);
	   
		if (BWPRI == None)
				return;
	   
		switch(Caps(damageIndent))
		{
				case "GRENADE":
						BWPRI.Hitstats[0].Hit++;
						BWPRI.Hitstats[0].Damage += damage;
						break;
					   
				case "STREAK":
						BWPRI.Hitstats[1].Hit++;
						BWPRI.Hitstats[1].Damage += damage;
						break;
					   
				case "PISTOL":
						BWPRI.Hitstats[2].Hit++;
						BWPRI.Hitstats[2].Damage += damage;
						break;
					   
				case "SMG":
						BWPRI.Hitstats[3].Hit++;
						BWPRI.Hitstats[3].Damage += damage;
						break;
					   
				case "ASSAULT":
						BWPRI.Hitstats[4].Hit++;
						BWPRI.Hitstats[4].Damage += damage;
						break;
					   
				case "ENERGY":
						BWPRI.Hitstats[5].Hit++;
						BWPRI.Hitstats[5].Damage += damage;
						break;
					   
				case "MACHINEGUN":
						BWPRI.Hitstats[6].Hit++;
						BWPRI.Hitstats[6].Damage += damage;
						break;
					   
				case "SHOTGUN":
						BWPRI.Hitstats[7].Hit++;
						BWPRI.Hitstats[7].Damage += damage;
						break;
					   
				case "ORDNANCE":
						BWPRI.Hitstats[8].Hit++;
						BWPRI.Hitstats[8].Damage += damage;
						break;
					   
				case "SNIPER":
						BWPRI.Hitstats[9].Hit++;
						BWPRI.Hitstats[9].Damage += damage;
						break;
						
				case "MELEE":
						BWPRI.SGDamage += Damage;
						break;
		}
}
//===========================================================================
// Cover handling
//===========================================================================
function RemoveCoverAnchor(Actor A)
{
	local int i;
	
	for (i=0; i < CoverAnchors.Length && CoverAnchors[i] != A; i++);
	
	if (i < CoverAnchors.Length)
		CoverAnchors.Remove(i, 1);
}
//===========================================================================
// ShieldAbsorb
//
// Armor stops full damage
// Don't play hit effects (BallisticArmor will do it)
//===========================================================================
function int ShieldAbsorb( int dam )
{
    local float Absorption;

    if (ShieldStrength == 0)
        return dam;

    Absorption = FMin(ShieldStrength, dam);

	// flash shield only if we absorbed all of the damage
	if (Absorption == dam)
		ShieldViewFlash(Absorption);
   
    dam -= Absorption;
    ShieldStrength -= Absorption;

    return dam;
}
 
function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
		local int actualDamage;
		local Controller Killer;
		local vector HitLocationMatchZ;
		
		/*
        local Vector SelfToHit, SelfToInstigator, CrossPlaneNormal;
        local float W;
        local float YawDir;
		*/

		if( Controller!=None && Controller.bGodMode )
			return;
		
		if ( damagetype == None )
		{
			if ( InstigatedBy != None )
				warn("No damagetype for damage by "$instigatedby$" with weapon "$InstigatedBy.Weapon);
			DamageType = class'DamageType';
		}
 
		if ( Role < ROLE_Authority )
		{
			log(self$" client damage type "$damageType$" by "$instigatedBy);
			return;
		}
 
		if ( Health <= 0 )
			return;
			
		if (Mover(Base) != None || Level.TimeSeconds < LastMoverLeaveTime + MoverLeaveGrace)
		{
			if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.bIgnoredOnLifts)
				return;
		}
 
		if ((instigatedBy == None || instigatedBy.Controller == None) && DamageType.default.bDelayedDamage && DelayedDamageInstigatorController != None)
			instigatedBy = DelayedDamageInstigatorController.Pawn;
 
		if ( (Physics == PHYS_None) && (DrivenVehicle == None) )
			SetMovementPhysics();
		
		if (true /*!class'BallisticReplicationInfo'.static.IsClassic()*/) // Classic lets you take off into orbit
		{
			if (Physics == PHYS_Walking && damageType.default.bExtraMomentumZ)
				momentum.Z = FMax(momentum.Z, 0.4 * VSize(momentum));

			if ( instigatedBy == self )
				momentum *= 0.6;

			momentum = momentum/Mass;
			
			if (Momentum.Z > 950)
				Momentum.Z = 950;
			if (Momentum.Z < -300)
				Momentum *= (-300 / Momentum.Z);
		}
		if (Weapon != None)
			Weapon.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );
		
        if (DrivenVehicle != None)
			DrivenVehicle.AdjustDriverDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );
		
        if ( (InstigatedBy != None) && InstigatedBy.HasUDamage() )
			Damage *= 2;

		actualDamage = Level.Game.ReduceDamage(Damage, self, instigatedBy, HitLocation, Momentum, DamageType);
			   
		if (instigatedBy != None && instigatedBy != self && class<BallisticDamageType>(damageType) != None)
		{
			if (!Level.Game.bTeamGame || (instigatedBy.GetTeamNum() != GetTeamNum() && GetTeamNum() != 255))
				SetBWHitStats(instigatedBy.PlayerReplicationInfo, class<BallisticDamageType>(DamageType).default.DamageIdent, actualDamage);
		}

        // If we're attached to a cover object, share the damage from frontal locational hits to that object instead
		if (CoverAnchors.Length > 0 && DamageType.default.bArmorStops)
		{
			while (CoverAnchors[0] == None && CoverAnchors.Length > 0)
				CoverAnchors.Remove(0, 1);

			HitLocationMatchZ = HitLocation;
			HitLocationMatchZ.Z = Location.Z;
			
			if ( (DamageType.default.bInstantHit && Normal(instigatedBy.Location - Location) dot Vector(Rotation) > 0) || (Normal(HitLocationMatchZ - Location) dot Vector(Rotation) > 0))
			{
				CoverAnchors[0].TakeDamage(actualDamage * 0.8, instigatedby, CoverAnchors[0].Location, vect(0,0,0), DamageType);
				actualDamage *= 0.2;
			}
		}

		if( DamageType.default.bArmorStops && (actualDamage > 0) )
			actualDamage = ShieldAbsorb(actualDamage);
				
		Health -= actualDamage;

        if (Damage > 0 && (instigatedBy == None || instigatedBy.GetTeamNum() != GetTeamNum() || GetTeamNum() == 255))
		{
		    LastDamagedTime = Level.TimeSeconds;
			LastDamagedType = damageType;
		}

		if ( HitLocation == vect(0,0,0) )
			HitLocation = Location;
 
		PlayHit(actualDamage,InstigatedBy, hitLocation, damageType, Momentum);

		if ( Health <= 0 )
		{
			// pawn died
			if ( DamageType.default.bCausedByWorld && (instigatedBy == None || instigatedBy == self) && LastHitBy != None )
					Killer = LastHitBy;
			else if ( instigatedBy != None )
					Killer = instigatedBy.GetKillerController();
			if ( Killer == None && DamageType.Default.bDelayedDamage )
					Killer = DelayedDamageInstigatorController;
			if ( bPhysicsAnimUpdate )
					TearOffMomentum = momentum;
			if (instigatedBy != None && instigatedBy != self && class<BallisticDamageType>(damageType) != None)
			{
				if (!Level.Game.bTeamGame || (instigatedBy.GetTeamNum() != GetTeamNum() && GetTeamNum() != 255))
					IncrementBWKill(instigatedBy.PlayerReplicationInfo, class<BallisticDamageType>(DamageType).default.DamageIdent);
			}
			
			if (Weapon != None)
				IncrementBWDeathsWith();
				
			CancelTransparency();
			
			Died(Killer, damageType, HitLocation);
		}
		else
		{
			//if (class'BallisticReplicationInfo'.static.IsArenaOrTactical())
			//{
				if (class<BallisticDamageType>(damageType) != None && class<BallisticDamageType>(damageType).default.bNegatesMomentum)
				{
					HitLocationMatchZ = Velocity;
					HitLocationMatchZ.Z = 0;
					AddVelocity( momentum - HitLocationMatchZ);
				}
				else
					AddVelocity( momentum );
			//}
			/*else  //Classic/Realism: Taking damage arrests movement
			{
				if ( InstigatedBy != None )
				{
					// Figure out which direction to spin:
					if( InstigatedBy.Location != Location )
					{
						SelfToInstigator = InstigatedBy.Location - Location;
						SelfToHit = HitLocation - Location;

						CrossPlaneNormal = Normal( SelfToInstigator cross Vect(0,0,1) );
						W = CrossPlaneNormal dot Location;

						if( HitLocation dot CrossPlaneNormal < W )
							YawDir = -1.0;
						else
							YawDir = 1.0;
					}
				}
				
				if( VSize(Momentum) < 10 )
				{
					Momentum = - Normal(SelfToInstigator) * Damage * 1000.0;
					Momentum.Z = Abs( Momentum.Z );
				}

				SetPhysics(PHYS_Falling);
				Momentum = Momentum / Mass;
				AddVelocity( Momentum );
				bBounce = true;
			}*/
			if (VSize(Momentum) > 50000)
				bPendingNegation=True;
			if ( Controller != None )
				Controller.NotifyTakeHit(instigatedBy, HitLocation, actualDamage, DamageType, Momentum);
			if ( instigatedBy != None && instigatedBy != self )
				LastHitBy = instigatedBy.Controller;
                
            DamageViewFlash(actualDamage);
		}
		MakeNoise(1.0);
}

function ShieldViewFlash(int damage)
{
    local int rnd;

    if (BallisticPlayer(Controller) == None || damage == 0 || Controller.bGodMode)
        return;

    rnd = FClamp(damage / 2, 25, 50);

	BallisticPlayer(Controller).ClientDmgFlash( -0.017 * rnd, ShieldFlashV);    
}

function DamageViewFlash(int damage)
{
    local int rnd;

    if (BallisticPlayer(Controller) == None || damage == 0 || Controller.bGodMode)
        return;

    rnd = FClamp(damage / 2, 25, 50);

	BallisticPlayer(Controller).ClientDmgFlash( -0.017 * rnd, BloodFlashV);    
}

exec simulated function TestFlash(int damage)
{
    DamageViewFlash(damage);
}

simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	local string T;
	local name anim;
	local float frame, rate;
	
	Super(Actor).DisplayDebug(Canvas, YL, YPos);

	Canvas.SetDrawColor(255,255,255);

	GetAnimParams(1, anim, frame, rate);
	Canvas.DrawText("Channel 1:"@anim@"Frame:"@frame@"Rate:"@rate);
	YPos += YL;
	Canvas.SetPos(4,YPos);
	Canvas.DrawText("Animation Action "$AnimAction$" Health "$Health);
	YPos += YL;
	Canvas.SetPos(4,YPos);
	Canvas.DrawText("Anchor "$Anchor$" Serpentine Dist "$SerpentineDist$" Time "$SerpentineTime);
	YPos += YL;
	Canvas.SetPos(4,YPos);
	Canvas.DrawText("FireState:"@GetEnum(enum'EFireAnimState', FireState));
	YPos += YL;
	Canvas.SetPos(4,YPos);
	T = "Floor "$Floor$" DesiredSpeed "$DesiredSpeed$" Crouched "$bIsCrouched$" Try to uncrouch "$UncrouchTime$ " GroundSpeed "$GroundSpeed$ " CrouchedPct "$CrouchedPct;
	if ( (OnLadder != None) || (Physics == PHYS_Ladder) )
		T=T$" on ladder "$OnLadder;
	Canvas.DrawText(T);
	YPos += YL;
	Canvas.SetPos(4,YPos);
	Canvas.DrawText("EyeHeight "$Eyeheight$" BaseEyeHeight "$BaseEyeHeight$" Physics Anim "$bPhysicsAnimUpdate$ " Sliding "$bIsSliding$" SlideCooldownEnd "$SlideCooldownEnd$" SlideStartSpeed "$SlideStartSpeed$" SlideStopSpeed "$SlideStopSpeed$" MaxSlideSpeed "$MaxSlideSpeed);
	YPos += YL;
	Canvas.SetPos(4,YPos);

	if ( Controller == None )
	{
		Canvas.SetDrawColor(255,0,0);
		Canvas.DrawText("NO CONTROLLER");
		YPos += YL;
		Canvas.SetPos(4,YPos);
	}
	else
	{
		if ( Controller.PlayerReplicationInfo != None )
		{
			Canvas.SetDrawColor(255,0,0);
			Canvas.DrawText("Owned by "$Controller.PlayerReplicationInfo.PlayerName);
			YPos += YL;
			Canvas.SetPos(4,YPos);
		}
		Controller.DisplayDebug(Canvas,YL,YPos);
	}
	if ( Weapon == None )
	{
		Canvas.SetDrawColor(0,255,0);
		Canvas.DrawText("NO WEAPON");
		YPos += YL;
		Canvas.SetPos(4,YPos);
	}
	else
		Weapon.DisplayDebug(Canvas,YL,YPos);
}

//===========================================================================
//Sloth Handling
//===========================================================================

simulated event ModifyVelocity(float DeltaTime, vector OldVelocity)
{
	local Vector X, Y, Z, dir;
	local float FSpeed, Control, NewSpeed, Drop, XSpeed, YSpeed, CosAngle, MaxStrafeSpeed, MaxBackSpeed;

	if (Controller == none)
		return;

	SyncSlidePrediction(DeltaTime, OldVelocity);

	if (Physics == PHYS_Walking)
	{
		// constrains strafe move
		if (StrafeScale < 1f || BackpedalScale < 1f)
		{
			GetAxes(GetViewRotation(),X,Y,Z);
			MaxStrafeSpeed = GroundSpeed * StrafeScale;
			MaxBackSpeed = GroundSpeed * BackpedalScale;

			// backwards speed limit
			XSpeed = Abs(X dot Velocity);
			
			if (XSpeed > MaxBackSpeed && (x dot Velocity) < 0)
			{
				//limiting backspeed
				dir = Normal(Velocity);
				CosAngle = Abs(X dot dir);
				Velocity = dir * (MaxBackSpeed / CosAngle);
			}
			
			// strafe speed limit
			YSpeed = Abs(Y dot velocity);

			if (YSpeed > MaxStrafeSpeed)
			{
				//limiting strafespeed
				dir = Normal(Velocity);
				CosAngle = Abs(Y dot dir);
				Velocity = dir * (MaxStrafeSpeed / CosAngle);
			}
		}

		//ClientMessage("Speed:"$string(VSize(Velocity) / GroundSpeed));
			
		// Applies decelerative friction
		if (class'BallisticReplicationInfo'.default.bPlayerDeceleration)
		{
			FSpeed = VSize(Velocity);
				
			if (VSize(Acceleration) < 1.00 && FSpeed > 1.00 && !bIsSliding) //We don't want this when sliding
			{
				Control = FMin(100, FSpeed);
					
				Drop = Control * DeltaTime * MyFriction;
				NewSpeed = FSpeed + drop;
				NewSpeed = FClamp(NewSpeed, 0, OldMovementSpeed*0.97) / FSpeed;
				Velocity *= NewSpeed;
			}
		}

		TickSlide(DeltaTime, OldVelocity);

		OldMovementSpeed = VSize(Velocity);
	}
	else
	{
		// Slides need the ground, and crouch has to be pressed again after leaving it
		if (bIsSliding)
			EndSlide();
		bSlideCrouchHeld = false;

		// Keep the peak horizontal speed seen during this fall so dodge-slide
		// uses the launch velocity, not the decayed landing-subtick velocity.
		if (Physics == PHYS_Falling)
			TrackSlideMomentum(Velocity);
	}

	if (Bot(Controller) != None)
		BotAutoManageSprint();
}

function BotAutoManageSprint()
{
	local Bot B;

	if (!bBotAutoSprint || Sprinter == None)
		return;

	B = Bot(Controller);
	if (B == None)
		return;

	if (bIsSliding || bIsCrouched
		|| B.MoveTarget == None
		|| Physics != PHYS_Walking
		|| (B.Enemy != None && VSize(B.Enemy.Location - Location) <= BotSprintEnemyRange)
		|| Controller.bFire > 0 || Controller.bAltFire > 0)
	{
		if (Sprinter.bSprintActive)
			Sprinter.StopSprint();
	}
	else
	{
		Sprinter.StartSprint();
	}
}

//===========================================================================
// Crouch sliding
//
// Pressing crouch on the ground while moving fast enough starts a slide. A
// sliding pawn ignores its acceleration and coasts on the velocity it has,
// losing speed to friction and gaining it down slopes, until crouch is let
// go or it gets too slow.
//
// Net behaviour:
// The owning client predicts its slides. A slide has no velocity of its own,
// it runs on the pawn's Velocity, which the engine already rewinds and
// corrects for us. SyncSlidePrediction does the same for the rest of the
// slide state, and everything timed is timed with MoveTime.
//===========================================================================

// True while the owning client replays its saved moves after a server correction
simulated final function bool IsReplayingMoves()
{
	return PlayerController(Controller) != None && PlayerController(Controller).bUpdating;
}

// The time of the move being run, as stamped by the client that made it. The client, its replays
// of the move and the server all get the same answer, which Level.TimeSeconds can't give them.
simulated function float MoveTime()
{
	local PlayerController PC;

	PC = PlayerController(Controller);
	if (PC != None)
	{
		if (Role == ROLE_Authority)
		{
			if (!IsLocallyControlled())
				return PC.CurrentTimeStamp;
		}
		else if (PC.bUpdating)
		{
			// Until the replay's first move has run its physics, it is still at the corrected move
			if (bSlideReplaying)
				return ReplayMoveTime;
			return PC.CurrentTimeStamp;
		}
	}
	return Level.TimeSeconds;
}

// Client: moves the replay's clock on by the part of a move that is being run.
// Added up, the durations of the moves drift away from their timestamps by rounding. Everything
// timed was timed with those timestamps, so a move that is done gets its own.
simulated final function AdvanceReplayTime(float DeltaTime)
{
	ReplayMoveTime += DeltaTime;

	while (ReplayMove != None && ReplayMove.TimeStamp < ReplayMoveTime - 0.0005)
		ReplayMove = ReplayMove.NextMove;
	if (ReplayMove != None && ReplayMove.TimeStamp < ReplayMoveTime + 0.0005)
		ReplayMoveTime = ReplayMove.TimeStamp;
}

simulated final function SaveSlideState()
{
	SavedSlide.bSliding = bIsSliding;
	SavedSlide.bCrouched = bIsCrouched;
	SavedSlide.bCrouchHeld = bSlideCrouchHeld;
	SavedSlide.CooldownEnd = SlideCooldownEnd;
	SavedSlide.LandGraceEnd = SlideLandGraceEnd;
	SavedSlide.Momentum = SlideMomentum;
	SavedSlide.MomentumEnd = SlideMomentumEnd;
}

simulated final function RestoreSlideState()
{
	bIsSliding = SavedSlide.bSliding;
	bSlideCrouchHeld = SavedSlide.bCrouchHeld;
	SlideCooldownEnd = SavedSlide.CooldownEnd;
	SlideLandGraceEnd = SavedSlide.LandGraceEnd;
	SlideMomentum = SavedSlide.Momentum;
	SlideMomentumEnd = SavedSlide.MomentumEnd;
}

// Keeps the owning client's slide state in step with its Location and Velocity.
// The player's controller only knows about those two, and changes them behind the slide's back:
// - To send fewer moves it holds one back and then runs it again as part of the next,
//   from the Location and Velocity the held back move started with.
// - When the server corrects the client, it puts the pawn back where the server had it
//   and replays the moves made since.
simulated function SyncSlidePrediction(float DeltaTime, vector OldVelocity)
{
	local PlayerController PC;

	if (Role != ROLE_AutonomousProxy)
		return;
	PC = PlayerController(Controller);
	if (PC == None)
		return;

	if (!PC.bUpdating)
		bSlideReplaying = false;
	else if (bSlideReplaying)
		AdvanceReplayTime(DeltaTime);
	else
	{
		bSlideReplaying = true;
		ReplayMoveTime = PC.CurrentTimeStamp;
		// The controller has dropped the moves the server has seen, so the list starts with this one
		ReplayMove = PC.SavedMoves;
		AdoptSlideStateAt(PC.CurrentTimeStamp, OldVelocity);
		AdvanceReplayTime(DeltaTime);
	}

	if (!bSlideMoveStart)
		return;
	bSlideMoveStart = false;

	// The move that was being held back is gone, so it is being run again as part of this one
	if (bSlideMovePending && PC.PendingMove == None && !PC.bUpdating)
	{
		// Pawns stand up at the end of a move, so this one may have stood up since
		bSlideRerunCrouched = SavedSlide.bCrouched && !bIsCrouched;
		// It gets to start its slide again, at the same stamina and for the same cost
		if (bIsSliding && !SavedSlide.bSliding)
			UndoSlideStart();
		RestoreSlideState();
	}
	else
	{
		bSlideRerunCrouched = false;
		SaveSlideState();
	}
}

// Server to owning client: bIsSliding changed while the server ran the client's move with this timestamp
simulated function ClientSlideState(bool bSliding, float TimeStamp)
{
	LogSlideChange(bSliding, TimeStamp, true);
}

// Tells the owning client about a slide change, which also remembers the ones it predicts itself
simulated function NotifySlideChanged()
{
	if (Role == ROLE_AutonomousProxy)
	{
		// The slide's stamina cost is paid once, when the start is first predicted
		if (LogSlideChange(bIsSliding, MoveTime(), false) && bIsSliding && !IsReplayingMoves() && Sprinter != None)
			Sprinter.PredictJumped();
	}
	else if (Role == ROLE_Authority && PlayerController(Controller) != None && !IsLocallyControlled())
		ClientSlideState(bIsSliding, MoveTime());
}

// Client: takes back what predicting the latest slide start has done outside of the slide state
simulated function UndoSlideStart()
{
	local int i, Newest;

	Newest = -1;
	for (i = 0; i < ArrayCount(SlideLog); i++)
		if (SlideLog[i].Stamp > 0 && !SlideLog[i].bServer && (Newest < 0 || SlideLog[i].Stamp > SlideLog[Newest].Stamp))
			Newest = i;

	if (Newest < 0 || !SlideLog[Newest].bSliding)
		return;

	SlideLog[Newest].Stamp = 0;
	if (Sprinter != None)
		Sprinter.UnpredictJumped();
}

// Returns false for a change that was already in the log
simulated function bool LogSlideChange(bool bSliding, float TimeStamp, bool bServer)
{
	local int i, Oldest, Newest;
	local bool bNew;

	Newest = -1;
	for (i = 0; i < ArrayCount(SlideLog); i++)
	{
		if (SlideLog[i].Stamp < SlideLog[Oldest].Stamp)
			Oldest = i;
		if (SlideLog[i].Stamp > 0 && SlideLog[i].bServer == bServer && (Newest < 0 || SlideLog[i].Stamp > SlideLog[Newest].Stamp))
			Newest = i;
	}

	// A move that is run again as part of the next one predicts the same change twice
	bNew = bServer || Newest < 0 || SlideLog[Newest].bSliding != bSliding;
	if (!bNew)
		Oldest = Newest;

	SlideLog[Oldest].Stamp = TimeStamp;
	SlideLog[Oldest].bSliding = bSliding;
	SlideLog[Oldest].bServer = bServer;
	return bNew;
}

// Client: bIsSliding after the move with this timestamp, according to the server or to this client's own prediction
simulated function bool SlideStateAt(float TimeStamp, bool bServer, out float ChangeStamp)
{
	local int i, Last, Next;

	Last = -1;
	Next = -1;
	for (i = 0; i < ArrayCount(SlideLog); i++)
	{
		if (SlideLog[i].Stamp <= 0 || SlideLog[i].bServer != bServer)
			continue;
		if (SlideLog[i].Stamp <= TimeStamp)
		{
			if (Last < 0 || SlideLog[i].Stamp > SlideLog[Last].Stamp)
				Last = i;
		}
		else if (Next < 0 || SlideLog[i].Stamp < SlideLog[Next].Stamp)
			Next = i;
	}

	if (Last >= 0)
	{
		ChangeStamp = SlideLog[Last].Stamp;
		return SlideLog[Last].bSliding;
	}

	// Only later changes are known. Before the first of them it was the other way round
	ChangeStamp = 0;
	return Next >= 0 && !SlideLog[Next].bSliding;
}

// Client: start a replay with the slide state of the move the server corrected.
// ServerVel is the velocity the server ended that move with.
simulated function AdoptSlideStateAt(float TimeStamp, vector ServerVel)
{
	local PlayerController PC;
	local int i;
	local float ServerStamp, ClientStamp, LastChange;
	local bool bServerSliding, bClientSliding, bSlidesLater;
	local vector PredictedVel;

	bServerSliding = SlideStateAt(TimeStamp, true, ServerStamp);
	bClientSliding = SlideStateAt(TimeStamp, false, ClientStamp);
	LastChange = FMax(ServerStamp, ClientStamp);
	ServerVel.Z = 0;

	// The speed and the landing remembered from moves after this one belong to what the server
	// has just corrected. The replay runs those moves again and remembers its own.
	if (SlideMomentumEnd - SlideMomentumTime > TimeStamp + 0.001)
	{
		SlideMomentum = ServerVel;
		SlideMomentumEnd = TimeStamp + SlideMomentumTime;
	}
	if (SlideLandGraceEnd - SlideLandGraceTime > TimeStamp + 0.001)
		SlideLandGraceEnd = 0;

	// The server has the last word. But when the latest change was predicted here, the server's
	// report of it may still be on its way, and if it was wrong the slide ends itself anyway.
	if (ServerStamp >= ClientStamp)
		bIsSliding = bServerSliding;
	else
		bIsSliding = bClientSliding || bServerSliding;

	// A predicted slide start without the server's report, and the server ended this move a lot
	// slower than it was predicted to: it hasn't started that slide. The server starts a slide
	// late when the move it was predicted in got lost. The replay may start the slide again.
	PC = PlayerController(Controller);
	if (bIsSliding && !bServerSliding && PC != None && PC.SavedMoves != None)
	{
		// The first move of the replay started with the velocity that was predicted for the corrected move
		PredictedVel = PC.SavedMoves.StartVelocity;
		PredictedVel.Z = 0;
		if (VSize(PredictedVel) - VSize(ServerVel) > SlidePower * 0.125)
		{
			bIsSliding = false;
			bSlidesLater = true;
			LastChange = ServerStamp;
			for (i = 0; i < ArrayCount(SlideLog); i++)
				if (!SlideLog[i].bServer && SlideLog[i].Stamp == ClientStamp)
					SlideLog[i].Stamp = 0;
		}
	}

	SlideCooldownEnd = 0;
	if (!bIsSliding && LastChange > 0)
		SlideCooldownEnd = LastChange + SlideCooldownTime;

	// The replay predicts everything after this move again
	for (i = 0; i < ArrayCount(SlideLog); i++)
		if (SlideLog[i].Stamp > TimeStamp)
		{
			bSlidesLater = bSlidesLater || SlideLog[i].bSliding;
			if (!SlideLog[i].bServer)
				SlideLog[i].Stamp = 0;
		}

	// If a slide starts later on, the replay has to find that crouch press again
	bSlideCrouchHeld = bIsCrouched && bWantsToCrouch && !bSlidesLater;
}

// Remembers the speed there was before a sudden drop for a moment
simulated function TrackSlideMomentum(vector NewVelocity)
{
	NewVelocity.Z = 0;
	if (MoveTime() >= SlideMomentumEnd || VSize(NewVelocity) >= VSize(SlideMomentum) * 0.95)
	{
		SlideMomentum = NewVelocity;
		SlideMomentumEnd = MoveTime() + SlideMomentumTime;
	}
}

// Runs once per walking move on the server and the owning client
simulated function TickSlide(float DeltaTime, vector OldVelocity)
{
	local vector SlideVel;
	local float MoveGroundSpeed;
	local bool bCrouchHeld, bCrouchPressed;

	SlideStartSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed * 1.1;
	SlideEasyStartSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed * 0.8;
	SlideStopSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed * default.CrouchedPct;
	MaxSlideSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed * 2.5;

	// The engine has already read this move's speed limit from GroundSpeed
	MoveGroundSpeed = FMax(GroundSpeed, 1.0);

	// OldVelocity is what the last move really ended with. Sliding on that, instead of on a
	// velocity of its own, makes the slide lose the speed it loses by running into things.
	SlideVel = OldVelocity;
	SlideVel.Z = 0;

	// Letting go of crouch ends a slide at once, the pawn only stands up after the move
	bCrouchHeld = bIsCrouched && bWantsToCrouch;
	bCrouchPressed = bCrouchHeld && !bSlideCrouchHeld;
	bSlideCrouchHeld = bCrouchHeld;

	if (bIsSliding)
	{
		if (!bCrouchHeld)
			EndSlide();
	}
	else
	{
		TrackSlideMomentum(SlideVel);
		if (bCrouchPressed)
			BeginSlide(SlideVel);

		// An AI that asked for a slide and didn't get one shouldn't be left crouching
		if (bBotSlideRequest && bCrouchHeld && !bIsSliding)
		{
			bBotSlideRequest = false;
			bWantsToCrouch = false;
		}
	}

	if (bIsSliding)
	{
		HandleSliding(DeltaTime, SlideVel);
		Velocity = SlideVel;
		if (VSize(SlideVel) < SlideStopSpeed)
			EndSlide();
	}

	// The engine limits this move to GroundSpeed * CrouchedPct after this event. GroundSpeed is
	// replicated to the owning client and arrives late, so the slide only changes CrouchedPct.
	if (bIsSliding)
		CrouchedPct = MaxSlideSpeed / MoveGroundSpeed;
	else if (bIsCrouched || bSlideRerunCrouched)
	{
		// Gradually reduce the ground speed towards the crouch speed
		CrouchedPct = FClamp(VSize(SlideVel) / MoveGroundSpeed - DeltaTime * 5.0, default.CrouchedPct, 1.0);

		// The engine only applies CrouchedPct to a crouched pawn. The server still has this move crouched
		if (!bIsCrouched && VSize(Velocity) > MoveGroundSpeed * CrouchedPct)
			Velocity = Normal(Velocity) * MoveGroundSpeed * CrouchedPct;
	}
	else
		CrouchedPct = 1.0;
}

// AI controllers have no crouch key to press, so they ask for a slide with this
function StartSlide()
{
	if (AIController(Controller) == None || bIsSliding)
		return;

	bBotSlideRequest = true;
	bWantsToCrouch = true;
}

// A floor's normal leans the way the floor drops
simulated function bool IsMovingDownhill(vector Dir)
{
	return Acos(FClamp(Floor.Z, -1.0, 1.0)) * (180.0 / Pi) >= SlideDownhillAngle && (Dir dot Floor) > 0.0;
}

// Starts a slide if the pawn is moving fast enough. SlideVel comes in as the pawn's
// horizontal velocity and goes out as the velocity the slide starts with.
simulated function BeginSlide(out vector SlideVel)
{
	local vector X, Y, Z, Dir;
	local float Speed, EffSlidePower, EffMaxSlideSpeed, StaminaPct;

	if (!bAllowCrouchSliding || MoveTime() < SlideCooldownEnd)
		return;

	if (Controller.bDuck == 0 && !bBotSlideRequest)
		return;

	Speed = VSize(SlideVel);
	if (Speed > 1.0)
		Dir = SlideVel / Speed;
	else
		Dir = Normal(SlideMomentum);
	Speed = FMax(Speed, VSize(SlideMomentum));

	if (MoveTime() < SlideLandGraceEnd || IsMovingDownhill(Dir))
	{
		if (Speed < SlideEasyStartSpeed)
			return;
	}
	else if (Speed < SlideStartSpeed)
		return;

	// Effective power and max speed
	EffSlidePower = SlidePower;
	EffMaxSlideSpeed = MaxSlideSpeed;

	// If mostly moving backwards relative to facing, weaken it
	GetAxes(GetViewRotation(), X, Y, Z);
	if ((Dir dot X) < BackSlideDotThreshold)
	{
		EffSlidePower *= BackSlidePowerScale;
		EffMaxSlideSpeed *= BackMaxSlideSpeedScale;
	}

	// Apply initial impulse scaled by the stamina left after the slide's cost. Client and server each
	// keep their own stamina and differ by a fraction of a percent, so it counts in steps of 5%
	// to give the slide the server starts the same speed as the one the client predicted.
	if (Sprinter != None)
	{
		StaminaPct = FMax(0.0, Sprinter.Stamina - Sprinter.JumpDrain) / Sprinter.MaxStamina;
		StaminaPct = Round(StaminaPct * 20.0) / 20.0;
		EffSlidePower = FMax(EffSlidePower * 0.25, EffSlidePower * StaminaPct);
	}

	SlideVel = Dir * FMin(Speed + EffSlidePower, EffMaxSlideSpeed);

	// The landing grace and the momentum are left as they are: a replay that starts
	// before this move has to be able to start the slide again.
	bIsSliding = true;

	if (Sprinter != None)
	{
		if (Role == ROLE_Authority)
		{
			Sprinter.Jumped();
			Sprinter.ClientJumped();
			Sprinter.StopSprint();
		}
		else
			Sprinter.PredictStopSprint();
	}

	NotifySlideChanged();
}

simulated function EndSlide()
{
    if (!bIsSliding)
        return;

	if (Bot(Controller) != None)
	{
		bBotSlideRequest = false;
		bWantsToCrouch = false;
	}

	bIsSliding = false;
	SlideCooldownEnd = MoveTime() + SlideCooldownTime;

	NotifySlideChanged();
}

// Friction and slope gravity for one move of a slide
simulated function HandleSliding(float DT, out vector SlideVel)
{
	local vector DownSlopeVect;
	local float SlopeAngleRad, SlopeAngleDeg, Gravity, DynamicFriction;

	Gravity = -PhysicsVolume.Gravity.Z;
	DownSlopeVect = Normal(vect(0,0,-1) - (Floor dot vect(0,0,-1)) * Floor);
	SlopeAngleRad = Acos(FClamp(Floor.Z, -1.0, 1.0));
	SlopeAngleDeg = SlopeAngleRad * (180.0 / Pi);

	DynamicFriction = SlideFriction;
	// Reduce friction on steep slopes for more sliding
	if ((SlideVel dot DownSlopeVect) > 0) // Downhill
		DynamicFriction *= FClamp(1.0 - (SlopeAngleDeg / 60.0), 0.2, 1.0);
	else  // Uphill
		DynamicFriction *= FClamp(1.0 + (SlopeAngleDeg / 45.0), 1.0, 2.5);

	SlideVel += DownSlopeVect * (Gravity * Sin(SlopeAngleRad) * 1.5 * DT);
	SlideVel.Z = 0;
	SlideVel = Normal(SlideVel) * FClamp(VSize(SlideVel) - DynamicFriction * Gravity * Cos(SlopeAngleRad) * DT, 0.0, MaxSlideSpeed);
}

// Slide animations. Every machine works them out for itself from bIsSliding,
// so they don't depend on what the pawn's owner predicts or replays.
simulated function TickSlideAnim()
{
	local name Anim;

	if (Level.NetMode == NM_DedicatedServer || bPlayedDeath)
		return;

	if (bIsSliding)
	{
		if (!bSlideAnimating)
		{
			// Not every mesh is linked to the Ballistic animations
			Anim = SlideStartAnims[Get4WayDirection()];
			if (!HasAnim(Anim))
				return;

			bSlideAnimating = true;
			bSlideWaitingStart = PlayAnim(Anim, 2.0);
		}
		if (!bSlideWaitingStart)
			LoopSlideAnim();
		// Keeps the movement animations from taking over
		bWaitForAnim = true;
	}
	else if (bSlideAnimating)
	{
		bSlideAnimating = false;
		bSlideWaitingStart = false;
		bWaitForAnim = false;

		//Play this if standing up so it looks natural
		Anim = SlideEndAnims[Get4WayDirection()];
		if (!bIsCrouched && Physics == PHYS_Walking && HasAnim(Anim) && PlayAnim(Anim, 2.0))
			bWaitForAnim = true;
	}
}

simulated function LoopSlideAnim()
{
    local name LoopName, CurAnim;
    local float Frame, Rate;

    LoopName = SlideAnims[Get4WayDirection()];
    if (LoopName == '' || !HasAnim(LoopName))
        return;
    GetAnimParams(0, CurAnim, Frame, Rate);
    if (CurAnim != LoopName)
        LoopAnim(LoopName,, 0.20);
}

defaultproperties
{
	bAlwaysRelevant=True
	bCanDodge=True
	bCanDoubleJump=True
	bAllowCrouchSliding=True
	bBotAutoSprint=True
	BotSprintEnemyRange=600.0
	MoverLeaveGrace=1.000000
	MinDragDistance=40.000000
	MaxPoolVelocity=20.000000
	HighImpactVelocity=1000.000000
	LowImpactVelocity=500.000000
	TimeBetweenImpacts=1.000000
	//MinTimeBetweenPainSounds=0.600000
	NewDeResSound=SoundGroup'BW_Core_WeaponSound.Misc.DeRes'
	MeleeAnim="Melee_Smack"
	Fades(0)=Texture'BW_Core_WeaponTex.Icons.stealth_8'
	Fades(1)=Texture'BW_Core_WeaponTex.Icons.stealth_16'
	Fades(2)=Texture'BW_Core_WeaponTex.Icons.stealth_24'
	Fades(3)=Texture'BW_Core_WeaponTex.Icons.stealth_32'
	Fades(4)=Texture'BW_Core_WeaponTex.Icons.stealth_40'
	Fades(5)=Texture'BW_Core_WeaponTex.Icons.stealth_48'
	Fades(6)=Texture'BW_Core_WeaponTex.Icons.stealth_56'
	Fades(7)=Texture'BW_Core_WeaponTex.Icons.stealth_64'
	Fades(8)=Texture'BW_Core_WeaponTex.Icons.stealth_72'
	Fades(9)=Texture'BW_Core_WeaponTex.Icons.stealth_80'
	Fades(10)=Texture'BW_Core_WeaponTex.Icons.stealth_88'
	Fades(11)=Texture'BW_Core_WeaponTex.Icons.stealth_96'
	Fades(12)=Texture'BW_Core_WeaponTex.Icons.stealth_104'
	Fades(13)=Texture'BW_Core_WeaponTex.Icons.stealth_112'
	Fades(14)=Texture'BW_Core_WeaponTex.Icons.stealth_120'
	Fades(15)=Texture'BW_Core_WeaponTex.Icons.stealth_128'
	UDamageSound=Sound'BW_Core_WeaponSound.Udamage.UDamageFire'

	BloodFlashV=(X=1000,Y=250,Z=250)
	ShieldFlashV=(X=750,Y=500,Z=350)

	FootstepVolume=0.25
	FootstepRadius=1536.000000
	GruntVolume=0.25
	GruntRadius=28.000000

	// used to play footsteps at consistent volume regardless of position
	// the fine sound controls, like occlusion factors and rolloff curves, are native
	// so we're forced into this to get the footstep behaviour we want
	// thankfully, it won't affect sounds we play through our weapons or attachments
	SoundOcclusion=OCCLUSION_None

	BaseEyeHeight=30
	CrouchEyeHeight=19
	CrouchHeight=32

	CollisionRadius=22.000000
	HeadRadius=13.000000

	DeResTime=4.000000
	RagDeathUpKick=0.000000
	bCanWalkOffLedges=True
	bSpecialHUD=True
	Visibility=64

	TransientSoundVolume=0.300000
	
	StrafeScale=1.000000
	BackpedalScale=1.000000
	//MyFriction=4.000000
	RagdollLifeSpan=20.000000

// the default value of this variable is used by C++ to work out move animation rates.
// do not use or change the default in code - use class'BallisticReplicationInfo'.default.PlayerGroundSpeed instead.
// the default value is assigned from game styles as PlayerAnimationGroundSpeed
	GroundSpeed=360.000000

	LadderSpeed=280.000000
	WaterSpeed=150.000000
	//AirSpeed=270.000000
	WalkingPct=0.900000
	CrouchedPct=0.350000
	JumpCrouchPenalty=0.350000 
	JumpCrouchTime=0.300000 
	//DodgeSpeedFactor=1.200000
	//DodgeSpeedZ=190.000000

	SlideFriction=1.100000
	SlideCooldownTime=0.600000
	SlidePower=350.000000
	SlideLandGraceTime=0.200000
	SlideMomentumTime=0.200000
	SlideDownhillAngle=5.000000
	BackSlidePowerScale=0.60
	BackMaxSlideSpeedScale=0.75
	BackSlideDotThreshold=-0.25
	SlideAnims(0)="SlideF"
	SlideAnims(1)="SlideL"
	SlideAnims(2)="SlideR"
	SlideAnims(3)="SlideB"
	SlideStartAnims(0)="SlideFStart"
	SlideStartAnims(1)="SlideLStart"
	SlideStartAnims(2)="SlideRStart"
	SlideStartAnims(3)="SlideBStart"
	SlideEndAnims(0)="SlideFEnd"
	SlideEndAnims(1)="SlideLEnd"
	SlideEndAnims(2)="SlideREnd"
	SlideEndAnims(3)="SlideBEnd"
	//ControllerClass=Class'BallisticProV55.BallisticBot'
	Begin Object Class=KarmaParamsSkel Name=PawnKParams
		KConvulseSpacing=(Max=2.200000)
		KLinearDamping=0.150000
		KAngularDamping=0.050000
		KBuoyancy=1.000000
		KStartEnabled=True
		KVelDropBelowThreshold=-1.000000
		bHighDetailOnly=False
		KFriction=0.600000
		KRestitution=0.300000
		KImpactThreshold=500.000000
	End Object
	KParams=KarmaParamsSkel'BallisticProV55.BallisticPawn.PawnKParams'
}
