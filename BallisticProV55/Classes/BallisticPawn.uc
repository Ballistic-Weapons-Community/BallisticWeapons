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
var config  bool		bNoViewFlash;       // Toggle the use of the new viewflash effects when u get damaged
var     BCSprintControl Sprinter;
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
var     bool            pawnNetInit;

// Animations -------------------------------------------
var 	name 			ReloadAnim, CockingAnim, MeleeAnim, MeleeOffhandAnim, MeleeAltAnim, MeleeBlockAnim, MeleeWindupAnim, WeaponSpecialAnim, StaggerAnim;
var 	float 				ReloadAnimRate, CockAnimRate, MeleeAnimRate, WeaponSpecialRate, StaggerRate;
var 	bool				bOffhandStrike;

//Sound -------------------------------
var()   float            GruntRadius;
var()   float            FootstepRadius;
// Cover from decorations -----------------------------
var 	array<Actor>		CoverAnchors;

// Flying exploit
var 	bool				bPendingNegation;

// Support for player transparency
var 	array<Material>		OriginalSkins, Fades;
var 	byte				CurFade, penalty;

var 	bool                bTransparencyInitialized;
var 	bool				bTransparencyOn, bOldTransparency;
	
//Killstreak -----------------------------------------------
var 	bool				bActiveKillstreak; // FIXME REMOVE?
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

replication
{
	reliable if (Role == ROLE_Authority)
		ClientHits, HitCounter, ClientSetCrouchAbility;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.default.bNoDodging)
		bCanWallDodge = false;
	if (!class'BallisticReplicationInfo'.default.bBrightPlayers)
	{
		bDramaticLighting=False;
		AmbientGlow=0;
	}

	if (class'BCReplicationInfo'.default.PlayerADSMoveSpeedFactor != WalkingPct)
	{
		WalkingPct = class'BCReplicationInfo'.default.PlayerADSMoveSpeedFactor;
		default.WalkingPct = class'BCReplicationInfo'.default.PlayerADSMoveSpeedFactor;
	}
	
	if (class'BCReplicationInfo'.default.PlayerCrouchSpeedFactor != CrouchedPct)
	{
		CrouchedPct = class'BCReplicationInfo'.default.PlayerCrouchSpeedFactor;
		default.CrouchedPct = class'BCReplicationInfo'.default.PlayerCrouchSpeedFactor;
	}

	if (class'BallisticReplicationInfo'.default.bUseRunningAnims && class'BCReplicationInfo'.default.PlayerADSMoveSpeedFactor >= 0.75)
	{
		default.WalkAnims[0]='RunF';
		default.WalkAnims[1]='RunB';
		default.WalkAnims[2]='RunL';
		default.WalkAnims[3]='RunR';
		WalkAnims[0]='RunF';
		WalkAnims[1]='RunB';
		WalkAnims[2]='RunL';
		WalkAnims[3]='RunR';
	}

    if (class'BallisticReplicationInfo'.default.bUseSloth)
    {
        StrafeScale = class'BallisticReplicationInfo'.default.PlayerStrafeScale;
        BackpedalScale = class'BallisticReplicationInfo'.default.PlayerBackpedalScale;
        GroundSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed;
        AirSpeed = class'BallisticReplicationInfo'.default.PlayerAirSpeed;
        AccelRate = class'BallisticReplicationInfo'.default.PlayerAccelRate;
        JumpZ = class'BallisticReplicationInfo'.default.PlayerJumpZ;
        DodgeSpeedZ = class'BallisticReplicationInfo'.default.PlayerDodgeZ;
        
        default.StrafeScale = class'BallisticReplicationInfo'.default.PlayerStrafeScale;
        default.BackpedalScale = class'BallisticReplicationInfo'.default.PlayerBackpedalScale;
        default.GroundSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed;
        default.AirSpeed = class'BallisticReplicationInfo'.default.PlayerAirSpeed;
        default.AccelRate = class'BallisticReplicationInfo'.default.PlayerAccelRate;
        default.JumpZ = class'BallisticReplicationInfo'.default.PlayerJumpZ;
        default.DodgeSpeedZ = class'BallisticReplicationInfo'.default.PlayerDodgeZ;
    }
	
	if(!pawnNetInit)
    {
        pawnNetInit = true;
        if(Controller != none)
        {
            if(Controller.Adrenaline < Class'BallisticReplicationInfo'.default.iAdrenaline) Controller.Adrenaline = Class'BallisticReplicationInfo'.default.iAdrenaline;
            Controller.AdrenalineMax = Class'BallisticReplicationInfo'.default.iAdrenalineCap;
            BPRI = class'Mut_Ballistic'.static.GetBPRI(Controller.PlayerReplicationInfo);
        }
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
        sprinter = BCSprintControl(NewItem);

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

    if ( (Health > 0) && !bHidden && (Level.TimeSeconds - SplashTime > 0.25) )
        PlayOwnedSound(GetSound(EST_Land), SLOT_Interact, FMin(1, -0.3 * Velocity.Z/JumpZ), true, FootstepRadius + (Velocity.Z * 0.65));
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

	OldBobTime = BobTime;
	Super.CheckBob(DeltaTime,Y);

	if ( (Physics != PHYS_Walking) || (VSize(Velocity) < 10)
		|| ((PlayerController(Controller) != None) && PlayerController(Controller).bBehindView) )
		return;

	m = int(0.5 * Pi + 9.0 * OldBobTime/Pi);
	n = int(0.5 * Pi + 9.0 * BobTime/Pi);

	if (m != n)
		FootStepping(0);
	else if ( !bWeaponBob && bPlayOwnFootsteps && (Level.TimeSeconds - LastFootStepTime > 0.35) )
	{
		LastFootStepTime = Level.TimeSeconds;
		FootStepping(0);
	}
}

simulated function FootStepping(int Side)
{
    local int SurfaceNum, i;
	local actor A;
	local material FloorMat;
	local vector HL,HN,Start,End,HitLocation,HitNormal;
	local float SoundScale;
	
	if (bIsCrouched)
		SoundScale = 0.35;
	else if (GroundSpeed > default.GroundSpeed)
		SoundScale = 1.35;
	else SoundScale = 1;

    SurfaceNum = 0;

    for ( i=0; i<Touching.Length; i++ )
		if ( ((PhysicsVolume(Touching[i]) != None) && PhysicsVolume(Touching[i]).bWaterVolume)
			|| (FluidSurfaceInfo(Touching[i]) != None) )
		{
			if ( FRand() < 0.5 )
				PlaySound(sound'PlayerSounds.FootStepWater2', SLOT_Interact, FootstepVolume * SoundScale);
			else
				PlaySound(sound'PlayerSounds.FootStepWater1', SLOT_Interact, FootstepVolume * SoundScale );
				
			if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.NetMode != NM_DedicatedServer)
				&& !Touching[i].TraceThisActor(HitLocation, HitNormal,Location - CollisionHeight*vect(0,0,1.1), Location) )
					Spawn(class'WaterRing',,,HitLocation,rot(16384,0,0));
			return;
		}

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
	PlaySound(SoundFootsteps[SurfaceNum], SLOT_Interact, FootstepVolume * SoundScale,, FootstepRadius * SoundScale );
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
		
		IdleHeavyAnim = BAtt.IdleHeavyAnim;
		IdleRifleAnim = Batt.IdleRifleAnim;
		
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
    if (!bWaitForAnim)
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
			if (ReloadAnim != '')
			{
				AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
				PlayAnim(ReloadAnim, ReloadAnimRate * class'BallisticReplicationInfo'.default.ReloadSpeedScale, 0.25 / class'BallisticReplicationInfo'.default.ReloadSpeedScale, 1);
				FireState=FS_PlayOnce;
				bResetAnimationAction=True;
			}
			else AnimAction = '';
			return;
		}
		if (AnimAction == 'MeleeStrike')
		{
			AnimBlendParams(1, 1, 0, 0.2, FireRootBone);
			PlayAnim(MeleeAnim, 1, 0.05, 1);
			FireState=FS_PlayOnce;
			bResetAnimationAction=True;
			return;
		}
		if (AnimAction == 'Shovel')
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			PlayAnim('Reload_ShovelBottom', 1, 0.25, 1);
			FireState=FS_PlayOnce;
			AnimAction = '';
			//bResetAnimationAction=True;
			return;
		}
		if (AnimAction == 'CockGun')
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
		if (AnimAction == 'WeaponSpecial')
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
		if (AnimAction == 'Stagger')
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
		/*if (AnimAction == 'Blocking')
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			if (FireState == FS_None || FireState == FS_Ready)
				PlayAnim(MeleeBlockAnim,, 0.2, 1);
			IdleWeaponAnim = MeleeBlockAnim;
			FireState = FS_None;
			Instigator.ClientMessage("Blocking");
			return;
		}		
		else */if (AnimAction == 'Raise')
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			if (FireState == FS_None || FireState == FS_Ready)
				PlayAnim(IdleRifleAnim,, 0.2, 1);
			IdleWeaponAnim = IdleRifleAnim;
			FireState = FS_None;
			return;
		}
		else if (AnimAction == 'Lower')
		{
			AnimBlendParams(1, 1, 0.0, 0.2, FireRootBone);
			if (FireState == FS_None || FireState == FS_Ready)
				PlayAnim(IdleHeavyAnim,, 0.2, 1);
			IdleWeaponAnim = IdleHeavyAnim;
			FireState = FS_Ready;
			return;
		}
		
		// End special animations
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
	
	if (BallisticMeleeAttachment(WeaponAttachment) == None)
	{	
		Super.StartFiring(bHeavy, bRapid);
		return;
	}

    if ( HasUDamage() && (Level.TimeSeconds - LastUDamageSoundTime > 0.25) )
    {
        LastUDamageSoundTime = Level.TimeSeconds;
        PlaySound(UDamageSound, SLOT_None, 1.5*TransientSoundVolume,,700);
    }

    if (Physics == PHYS_Swimming)
        return;

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
    else if ( bKeepTaunting && (Channel == 0) )
		PlayVictoryAnimation();
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
		PlayerController(Controller).ReceiveLocalizedMessage(HealBlockMessage, 0, HealPreventer.PlayerReplicationInfo);
	}
}

function MessageAttributedHealBlock(Pawn Healer)
{
	if (PlayerController(Controller) != None && NextHealMessageTime < Level.TimeSeconds)
	{
		NextHealMessageTime = Level.TimeSeconds + 1;
		PlayerController(Controller).ReceiveLocalizedMessage(HealBlockMessage, 1, HealPreventer.PlayerReplicationInfo, Healer.PlayerReplicationInfo);

		if (PlayerController(Healer.Controller) != None)
			PlayerController(Healer.Controller).ReceiveLocalizedMessage(HealBlockMessage, 2, HealPreventer.PlayerReplicationInfo, PlayerReplicationInfo);
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
	simulated function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType)
	{
		if (level.Timeseconds == LastPainTime)
			PlayHit(Damage, InstigatedBy, Hitlocation, damageType, Momentum);
		super.TakeDamage( Damage, InstigatedBy, Hitlocation, Momentum, damageType);
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

	Super(UnrealPawn).PlayHit(Damage,InstigatedBy,HitLocation,DamageType,Momentum);

    if ( Damage <= 0 )
		return;
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

	super.Tick(DT);
	
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
}

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

	// Hes dead, we can try dismemberment!
	if (Health <= 0)
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

	// If you're using an advantage-conferring skin you're going to be as bright as the bloody Sun
	if (rec.DefaultName == "July")
		AmbientGlow = 64;
	*/

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
	PlaySound(NewDeResSound, SLOT_Interact, 1.0);


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

// This is a fix for some stupid ass bug that emanates from beyond my reach.
// It causes BaseEyeHeight to be forced to 38 on the server for non local players (unless the server player is first person spectating that client)
simulated function vector EyePosition()
{
	if (Role == ROLE_Authority && bIsCrouched && !IsLocallyControlled() && PlayerController(Controller) != None && !PlayerController(Controller).bBehindView && BaseEyeHeight == default.BaseEyeHeight)
		return (EyeHeight-19) * vect(0,0,1) + WalkBob;
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

    if (class'BCReplicationInfo'.static.IsTactical())
        return CanMantle();

	if (class'BallisticReplicationInfo'.default.bNoDoubleJump)
		return false;

	return super.CanDoubleJump();
}

function bool CanMultiJump()
{
	if (class'BallisticReplicationInfo'.default.bNoDoubleJump)
		return false;
	else
		return super.CanMultiJump();
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
//	if (bNoDodging)
	if (class'BallisticReplicationInfo'.default.bNoDodging)
		return false;
	else
	{
		if (super.Dodge(DoubleClickMove))
		{
			if (Role == ROLE_Authority)
				Inventory.OwnerEvent('Dodged');
			return true;
		}
		else
			return false;
	}
}

function bool DoJump( bool bUpdating )
{
	local float OldJumpZ;
	local bool  bJR;

	OldJumpZ = JumpZ;

	if (BallisticWeapon(Weapon) != None)
    {	
        JumpZ = BallisticWeapon(Weapon).GetModifiedJumpZ(self);
    }

    if ( !bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < 100) && IsLocallyControlled() )
    {
		if ( PlayerController(Controller) != None )
			PlayerController(Controller).bDoubleJump = true;
        DoDoubleJump(bUpdating);
        MultiJumpRemaining -= 1;

        JumpZ = OldJumpZ;
        return true;
    }

    if ( Super(UnrealPawn).DoJump(bUpdating) )
    {
		if ( !bUpdating )
			PlayOwnedSound(GetSound(EST_Jump), SLOT_Pain, GruntVolume, , GruntRadius);

        JumpZ = OldJumpZ;   
        return true;
    }

    // wtb: raii
    JumpZ = OldJumpZ;
    return false;
}

function bool AddShieldStrength(int ShieldAmount)
{
	local BallisticArmor BA;
	local int OldShieldStrength;

	BA = BallisticArmor(FindInventoryType(class'BallisticArmor'));
	if (BA != None)
	{
		OldShieldStrength = BA.Charge;
		BA.Charge = Min(BA.Charge + ShieldAmount, BA.MaxCharge);
		BA.SetShieldDisplay(BA.Charge);
	}
	else
	{
		BA = spawn(class'BallisticArmor',self);
		BA.Charge = ShieldAmount;
		BA.GiveTo (self, none);
	}
	if (BA == None)
		return super.AddShieldStrength(ShieldAmount);

	return (BA.Charge != OldShieldStrength);
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
            
		TakeFallingDamage();
        if (Velocity.Z < -DodgeSpeedZ*0.5)
			Velocity.Z += DodgeSpeedZ*0.5;
    }

    VelocityZ = Velocity.Z;

    DodgeGroundSpeed = GroundSpeed;

    // arena allows increased dodge distance when sprint is on
    if (class'BCReplicationInfo'.default.GameStyle != 0 && default.GroundSpeed < GroundSpeed)
    {
        DodgeGroundSpeed = default.GroundSpeed;
    }

    Velocity = DodgeSpeedFactor*DodgeGroundSpeed*Dir + (Velocity Dot Cross)*Cross;

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

function CalcSpeedUp(float SpeedFactor)
{
	local float NewSpeed;
	
	NewSpeed = Instigator.default.GroundSpeed * SpeedFactor;
	if (ComboSpeed(CurrentCombo) != None)
		NewSpeed *= 1.4;
	if (BallisticWeapon(Weapon) != None && (BallisticWeapon(Weapon).PlayerSpeedFactor <= 1 || SpeedFactor <= 1))
		NewSpeed *= BallisticWeapon(Weapon).PlayerSpeedFactor;
	GroundSpeed = NewSpeed;
	Inventory.OwnerEvent('SpeedChange');
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
 
function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
		local int actualDamage;
		local Controller Killer;
		local vector HitLocationMatchZ;
		
        local Vector SelfToHit, SelfToInstigator, CrossPlaneNormal;
        local float W;
        local float YawDir;
		
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
		
		if (class'BCReplicationInfo'.default.GameStyle != 1) //Classic lets you take off into orbit
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
			if (class'BCReplicationInfo'.default.GameStyle != 1 && class'BCReplicationInfo'.default.GameStyle != 2) //Classic/Realism: Taking damage arrests movement
			{
				if (class<BallisticDamageType>(damageType) != None && class<BallisticDamageType>(damageType).default.bNegatesMomentum)
				{
					HitLocationMatchZ = Velocity;
					HitLocationMatchZ.Z = 0;
					AddVelocity( momentum - HitLocationMatchZ);
				}
				else
					AddVelocity( momentum );
			}
			else
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
			}
			if (VSize(Momentum) > 50000)
				bPendingNegation=True;
			if ( Controller != None )
				Controller.NotifyTakeHit(instigatedBy, HitLocation, actualDamage, DamageType, Momentum);
			if ( instigatedBy != None && instigatedBy != self )
				LastHitBy = instigatedBy.Controller;
            if (BallisticPlayer(Controller) != None)
                HandleViewFlash(actualDamage);
		}
		MakeNoise(1.0);
}

function HandleViewFlash(int damage)
{
    local int rnd;

    if (damage == 0)
        return;

	if (bNoViewFlash)
        return;
		
    rnd = FClamp(damage, 25, 70);

	if (ShieldStrength > 0)
    {
        BallisticPlayer(Controller).ClientDmgFlash( -0.019 * rnd, ShieldFlashV);
    }
    else 
    {
		BallisticPlayer(Controller).ClientDmgFlash( -0.019 * rnd, rnd * BloodFlashV);  
    }     
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
	T = "Floor "$Floor$" DesiredSpeed "$DesiredSpeed$" Crouched "$bIsCrouched$" Try to uncrouch "$UncrouchTime;
	if ( (OnLadder != None) || (Physics == PHYS_Ladder) )
		T=T$" on ladder "$OnLadder;
	Canvas.DrawText(T);
	YPos += YL;
	Canvas.SetPos(4,YPos);
	Canvas.DrawText("EyeHeight "$Eyeheight$" BaseEyeHeight "$BaseEyeHeight$" Physics Anim "$bPhysicsAnimUpdate);
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

	//Scaling movement speed
	if (Physics == PHYS_Walking)
	{
		GetAxes(GetViewRotation(),X,Y,Z);
		MaxStrafeSpeed = GroundSpeed * StrafeScale;
		MaxBackSpeed = GroundSpeed * BackpedalScale;
		XSpeed = Abs(X dot Velocity);
		
		if (XSpeed > MaxBackSpeed && (x dot Velocity) < 0)
		{
			//limiting backspeed
			dir = Normal(Velocity);
			CosAngle = Abs(X dot dir);
			Velocity = dir * (MaxBackSpeed / CosAngle);
		}
		
		YSpeed = Abs(Y dot velocity);
		if (YSpeed > MaxStrafeSpeed)
		{
			//limiting strafespeed
			dir = Normal(Velocity);
			CosAngle = Abs(Y dot dir);
			Velocity = dir * (MaxStrafeSpeed / CosAngle);
		}

		//ClientMessage("Speed:"$string(VSize(Velocity) / GroundSpeed));
	}
	 
	if (Physics==PHYS_Walking)
	{
		FSpeed = Vsize(Velocity);
		 
		if (VSize(Acceleration) < 1.00 && FSpeed > 1.00)
		{
			Control = FMin(100, FSpeed);
				
			Drop = Control * DeltaTime * MyFriction;
			NewSpeed = FSpeed + drop;
			NewSpeed = FClamp(NewSpeed, 0, OldMovementSpeed*0.97) / FSpeed;
			Velocity *= NewSpeed;

		}
		
		OldMovementSpeed = Vsize(Velocity);
	}
}

defaultproperties
{
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

	 BloodFlashV=(X=26.5,Y=4.5,Z=4.5)
     ShieldFlashV=(X=400.000000,Y=400.000000,Z=400.000000)

     FootstepVolume=0.350000
     FootstepRadius=400.000000

     CollisionRadius=19.000000

     GruntVolume=0.2
     GruntRadius=300.000000
	 bNoViewFlash=True
     DeResTime=4.000000
     RagDeathUpKick=0.000000
     bCanWalkOffLedges=True
     bSpecialHUD=True
     Visibility=64
     HeadRadius=13.000000
     TransientSoundVolume=0.300000
	 
	 StrafeScale=1.000000
     BackpedalScale=1.000000
     //MyFriction=4.000000
     RagdollLifeSpan=20.000000
     GroundSpeed=360.000000
	 LadderSpeed=280.000000
     WaterSpeed=150.000000
     //AirSpeed=270.000000
     WalkingPct=0.900000
	 CrouchedPct=0.350000
     //DodgeSpeedFactor=1.200000
     //DodgeSpeedZ=190.000000

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
