//=============================================================================
// RSNovaAttachment.
//
// 3rd person weapon attachment for Nova Staff
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaAttachment extends BallisticAttachment;

var Emitter		FreeZap;
var RSNova_TrackingZap TargetZap;

var actor		ZapTarget, 	  ZapTargetOld;			// Target getting zapped
var byte		TargZapCount, TargZapCountOld;		// Update counters
var byte		FreeZapCount, FreeZapCountOld;
var byte		KillZapCount, KillZapCountOld;
var RSNovaStaff	NovaStaff;							// Access to the staff itself (only available to owner)

var actor		FastMuzzleFlash;
var byte		FastFireCount, FastFireCountOld;

var bool		bHealing;

//var array<actor>			ChainVics;
var byte					ChainVicNum;
var actor					ChainVics[6];
var array<RSNovaChainLink>	ChainLinks;
var byte					KillChainZapsCount, KillChainZapsCountOld;
var byte					FreeChainZapCount, FreeChainZapCountOld;
var byte					ChainZapCount, ChainZapCountOld;
var byte					BigZapCount, BigZapCountOld;
var Emitter					FreeChainZap;

var bool bRampage;
var RSNovaWings Wings;
var float		WingPhase;
var bool		bWingDown;
var() Sound		WingSound;

replication
{
	reliable if (Role==ROLE_Authority && bNetDirty)
		ZapTarget, TargZapCount, FreeZapCount, KillZapCount, FastFireCount, bHealing, BigZapCount, ChainVics, ChainVicNum, ChainZapCount, FreeChainZapCount, KillChainZapsCount, bRampage;
	reliable if (Role==ROLE_Authority && bNetOwner && bNetInitial)
		NovaStaff;
}

simulated event PostNetReceive()
{
	if (!Instigator.IsLocallyControlled())
	{
		if (bRampage && Wings == None)
		{
			Wings = spawn(class'RSNovaWings',Instigator,,Instigator.Location,Instigator.Rotation);
			if (Wings != None)
				Wings.SetBase(Instigator);
		}
		else if (!bRampage && Wings != None)
			Wings.Destroy();
	}

	if (TargZapCount != TargZapCountOld)	{	TargZapCountOld = TargZapCount;
		SetTargetZap(ZapTarget, bHealing);	}
	if (FreeZapCount != FreeZapCountOld)	{	FreeZapCountOld = FreeZapCount;
		SetFreeZap();						}
	if (KillZapCount != KillZapCountOld)	{	KillZapCountOld = KillZapCount;
		KillZap();							}
	if (ChainZapCount != ChainZapCountOld)	{	ChainZapCountOld = ChainZapCount;
		ClientDoChainZap();	}
	if (FreeChainZapCount != FreeChainZapCountOld)	{	FreeChainZapCountOld = FreeChainZapCount;
		SetFreeChainZap();						}
	if (KillChainZapsCount != KillChainZapsCountOld)	{	KillChainZapsCountOld = KillChainZapsCount;
		KillChainZaps();							}
	if (FastFireCount != FastFireCountOld)
	{
		FiringMode = 2;
		ThirdPersonEffects();
		FastFireCountOld = FastFireCount;
	}
	if (BigZapCount != BigZapCountOld)
	{
		FiringMode = 3;
		ThirdPersonEffects();
		BigZapCountOld = BigZapCount;
	}
	super.PostNetReceive();
}

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (FiringMode == 1)
		{
			//Spawn impacts, streaks, etc
			InstantFireEffects(FiringMode);
			//Play pawn anims
			PlayPawnTrackAnim(FiringMode);
		}
		else if (FiringMode == 2)
		{
			//Flash muzzle flash
			FlashMuzzleFlash (FiringMode);
			//Weapon light
			FlashWeaponLight(FiringMode);
			//Play pawn anims
			PlayPawnFiring(FiringMode);
		}
		else if (FiringMode == 3)
		{
			//Spawn impacts, streaks, etc
			BigZapInstantFireEffects();
			//Flash muzzle flash
			FlashMuzzleFlash (FiringMode);
			//Weapon light
			FlashWeaponLight(FiringMode);
			//Play pawn anims
			PlayPawnFiring(FiringMode);
		}
		else
			super.ThirdPersonEffects();
    }
}

simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode == 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	else if (Mode == 2)
	{
		if (FastMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (FastMuzzleFlash, class'RSNovaFastMuzzleFlash', DrawScale*FlashScale, self, FlashBone);
		FastMuzzleFlash.Trigger(self, Instigator);
	}

}

function NovaUpdateHit(byte WeaponMode)
{
	if (WeaponMode == 0)
	{
		FiringMode = 0;
		FireCount++;
		NetUpdateTime = Level.TimeSeconds - 1;
		ThirdPersonEffects();
	}
	else if (WeaponMode == 1)
	{
		FiringMode = 2;
		FastFireCount++;
		NetUpdateTime = Level.TimeSeconds - 1;
		ThirdPersonEffects();
	}
}

// Update Hit stuff. This just adds the surface info
function BigZapUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf)
{
	mHitSurf = HitSurf;
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 3;
	BigZapCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonEffects();
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function BigZapInstantFireEffects()
{
	local Vector HitLocation, Dir, Start;
//	local Material HitMat;
	local RSNova_OneShotZap Zap;

	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;
	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, true);
	}
	// Server has all the info already...
 	else
		HitLocation = mHitLocation;

	Zap = spawn(class'RSNova_OneShotZap', Instigator, , GetTipLocation());

	if (mHitActor == None)
		Zap.SetTarget(HitLocation, false);
	else
		Zap.SetTarget(HitLocation, true);
}


simulated function UpdateChainZap ()
{
	local int i;
	local vector Prev;

	Prev = GetTipLocation();
	for (i=0;i<ChainVicNum;i++)
	{
		if (ChainVics[i] != None)
		{
			if (ChainLinks.length <= i || ChainLinks[i]==None)
				ChainLinks[i] = spawn(class'RSNovaChainLink', self);

			ChainLinks[i].SetPoints(Prev, ChainVics[i].Location);
			Prev = ChainVics[i].Location;
		}
		else if (ChainLinks[i] != None)
		{
			ChainLinks[i].Kill();
			ChainLinks[i] = None;
		}
	}
}

simulated function ClientDoChainZap ()
{
	xPawn(Instigator).StartFiring(bHeavy, true);
	StartMuzzleZap();
	KillFreeChainZap();

	UpdateChainZap();
}

function SetChainZap (RSNovaPrimaryFire FM)
{
	local bool bDoChange;
	local int i, j;

	for (i=0;i<FM.ChainVics.length&&i<6;i++)
	{
		if (FM.ChainVics[i].ZapVic != None)
		{
			if (j >= ChainVicNum || FM.ChainVics[i].ZapVic != ChainVics[j])
			{
				bDoChange = true;
				break;
			}
			j++;
		}
	}

	if (bDoChange)
	{
		ChainVicNum = 0;
		for (i=0;i<FM.ChainVics.length&&i<6;i++)
			if (FM.ChainVics[i].ZapVic != None)
			{
				ChainVics[ChainVicNum] = FM.ChainVics[i].ZapVic;
				ChainVicNum++;
			}
	}

	ChainZapCount++;

	if (level.NetMode != NM_DedicatedServer)
		ClientDoChainZap();
}

simulated function SetFreeChainZap ()
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		FreeChainZapCount++;
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StartFiring(bHeavy, true);
	StartMuzzleZap();
	KillChainZap();
	if (FreeChainZap == None)
	{
		FreeChainZap = spawn(class'RSNova_FreeChainZap', self);
		AttachToBone(FreeChainZap, 'tip');
	}
	if (level.NetMode == NM_Client && NovaStaff != None)
		NovaStaff.SetFreeChainZap();
}

simulated function KillChainZaps ()
{
	if (Role == ROLE_Authority)
		KillChainZapsCount++;
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StopFiring();
	StopMuzzleZap();
	KillChainZap();
	KillFreeChainZap();
	if (level.NetMode == NM_Client && NovaStaff != None)
		NovaStaff.KillChainZaps();
}

simulated function KillChainZap()
{
	local int i;

	ChainVicNum=0;
	for (i=0;i<ChainLinks.length;i++)
	{
		if (ChainLinks[i] != None)
			ChainLinks[i].Kill();
	}
	ChainLinks.length = 0;
}
simulated function KillFreeChainZap()
{
	if (FreeChainZap != None)
	{
		FreeChainZap.Kill();
		FreeChainZap = None;
		if (level.NetMode == NM_Client && NovaStaff != None)
			NovaStaff.KillFreeChainZap();
	}
}




function InitFor(Inventory I)
{
	Super.InitFor(I);
	if (I != None && RSNovaStaff(I) != None)
		NovaStaff = RSNovaStaff(I);
}

simulated function SetTargetZap(Actor Targ, bool bHeal)
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
	{
		bHealing = bHeal;
		ZapTarget = Targ;
		TargZapCount++;
	}
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StartFiring(bHeavy, true);
	StartMuzzleZap();
	KillFreeZap();
	if (TargetZap == None)
	{
		TargetZap = spawn(class'RSNova_TrackingZap', self);
		AttachToBone(TargetZap, 'tip');
		TargetZap.SetTarget(Targ, bHeal);
		TargetZap.UpdateTargets();
	}
	else
		TargetZap.SetTarget(Targ, bHeal);
}

simulated function SetFreeZap ()
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		FreeZapCount++;
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StartFiring(bHeavy, true);
	StartMuzzleZap();
	KillTargetZap();
	if (FreeZap == None)
	{
		FreeZap = spawn(class'RSNova_FreeZap', self);
		UpdateFreeZap();
		AttachToBone(FreeZap, 'tip');
	}
	if (level.NetMode == NM_Client && NovaStaff != None)
		NovaStaff.SetFreeZap();
}

simulated function KillZap ()
{
	if (Role == ROLE_Authority)
		KillZapCount++;
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StopFiring();
	StopMuzzleZap();
	KillTargetZap();
	KillFreeZap();
	if (level.NetMode == NM_Client && NovaStaff != None)
		NovaStaff.KillZap();
}

simulated function KillTargetZap()
{
	if (TargetZap != None)
	{
		TargetZap.KillFlashes();
		TargetZap.Kill();
		TargetZap = None;
	}
}
simulated function KillFreeZap()
{
	if (FreeZAp != None)
	{
		FreeZap.Kill();
		FreeZap = None;
		if (level.NetMode == NM_Client && NovaStaff != None)
			NovaStaff.KillFreeZap();
	}
}

simulated function StartMuzzleZap()
{
	if (MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, class'RSNovaLightMuzzleFlash', DrawScale*FlashScale, self, 'tip');
}
simulated function StopMuzzleZap()
{
	if (MuzzleFlash != None)
	{
		Emitter(MuzzleFlash).Kill();
		MuzzleFlash = None;
	}
}

simulated event Tick (float DT)
{
	super.Tick(DT);

	if (Instigator != None && Instigator.IsFirstPerson())
		return;

	if (bRampage && Wings != None)
	{
		if (bWingDown)
		{
			WingPhase += DT * 2;
			if (WingPhase >= 1.0)
			{
				WingPhase = 1.0;
				bWingDown = false;
				PlaySound(WingSound, SLOT_None, 1.0);
			}
		}
		else
		{
			WingPhase -= DT * 4;
			if (WingPhase <= -1.0)
			{
				WingPhase = -1.0;
				bWingDown = true;
			}
		}
		if (Wings != None)
			Wings.UpdateWings(WingPhase);
	}

	if (TargetZap != None)
	{
		if (TargetZap.base != self)
		{
			AttachToBone(TargetZap, 'tip');
			TargetZap.bHidden = false;
		}
		TargetZap.UpdateTargets();
	}
	UpdateFreeZap();

	UpdateChainZap();
}

simulated function UpdateFreeZap()
{
	local vector End, X,Y,Z;
	if (FreeZap != None)
	{
		GetAxes(Instigator.GetViewRotation(), X,Y,Z);
		End = X * 1000;
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Min -= 500 * Abs(X.Z);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Max += 500 * Abs(X.Z);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Min -= 500 * Abs(X.X);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Max += 500 * Abs(X.X);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Min -= 500 * (1-Abs(X.Z));
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Max += 500 * (1-Abs(X.Z));

		BeamEmitter(FreeZap.Emitters[2]).BeamEndPoints[0].Offset = BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset;
	}
}

simulated function Destroyed()
{
	local int i;

	if (FreeZap != None)
		FreeZap.Kill();
	if (TargetZap != None)
	{	TargetZap.KillFlashes();	TargetZap.Kill();	}
	if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	if (FastMuzzleFlash != None)
		FastMuzzleFlash.Destroy();
	if (Wings != None)
		Wings.Destroy();
	if (FreeChainZap != None)
		FreeChainZap.Kill();
	for (i=0;i<ChainLinks.length;i++)
		if (ChainLinks[i] != None)
			ChainLinks[i].Kill();
	super.Destroyed();
}

defaultproperties
{
     WingSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Flying'
     MuzzleFlashClass=Class'BallisticProV55.RSNovaLightMuzzleFlash'
     AltMuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
     ImpactManager=Class'BallisticProV55.IM_NovaStaffBlades'
     FlashScale=0.450000
     BrassMode=MU_None
     InstantMode=MU_Secondary
     LightMode=MU_Both
     ReloadAnim="Reload_MG"
     ReloadAnimRate=0.800000
	 MeleeStrikeAnim="Melee_Stab"
     MeleeAnimRate=1.000000
     TrackNum(1)=0
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.NovaStaff_TPm'
     DrawScale=0.650000
}
