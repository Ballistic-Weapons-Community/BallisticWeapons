//=============================================================================
// JunkWeapon.
//
// FIXME
// This weapon is the primary controller for the junk weapons. Intead of each
// different piece of junk being a weapon, this is the only weapon and merely
// changes its appearance and properties to behave as different melee and
// throwing weapons.
// Animation is driven by a hand anim. A seperate mesh is attached to the hands
// to represent the junk itself.
// Info for each piece of junk is stored in the form of a JunkObject.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkWeapon extends BallisticWeapon config(BWBP_JWC_Pro) HideDropDown CacheExempt;

var() array<name>			GripAnims;				// All possible Grip style Anims. Order Must match EGripStyle list in JunkBase
var() name					GripRootBone;			// Bone at which grip anims will be applied
var() name					GripRootBone2;			// Grip bone for second hand
var() array<name>			PutAwayAnims;			// All possible PutAway Anims. Order Must match EAnimStyle list in JunkBase
var() array<name>			PullOutAnims;			// All Possible PullOut Anims. Order Must match EAnimStyle list in JunkBase
var() array<name>			IdleAnims;				// All possible Idle Anims. Order Must match EAnimStyle list in JunkBase
var() vector				TwoHandViewOffset;		// Base PlayerViewOffset to use for two handed stuff
var() rotator				TwoHandViewPivot;		// Base PlayerViewPivot to use for two handed stuff
var() vector				OneHandViewOffset;		// Base PlayerViewOffset to use for one handed stuff
var() rotator				OneHandViewPivot;		// Base PlayerViewPivot to use for one handed stuff
var() Mesh					OneHandMesh;			// Anim Mesh to use for one handed stuff
var() Mesh					TwoHandMesh;			// Anim Mesh to use for two handed stuff

var   JunkObject			Junk;					// The Junk Object in use
var   JunkObject			LastJunk;				// The previous Junk
var	  actor					JunkActor;				// The display actor attached to the hand
var   JunkObject			JunkChain;				// A linked list of all avilable junk
var   JunkObject			PendingJunk;			// Junk Object we are switching to
var   bool					bEmptyHanded;			// Junk has been thrown or broken and hand is empty. JunkActor will not be drawn
var   int					JunkAmmo;				// FIXME

var   JunkMeleeFire			MeleeFire;				// The Melee firemode
var   JunkRangedFire		ThrowFire;				// The Ranged firemode

var   bool					bBlocked;				// Currently blocking with junkw eapon
var   float					LastBlockTime;			// Time of last block
var   rotator				LastHitDir;				// Direction (relative to view) that last blocked attack hit

var   JunkShield			Shield;					// The shield inventory item
var   float					ShieldHoldStartTime;	// Time when block key was pressed (used to time block key hold)

var	  bool					bPendingReload;			// FIXME

var   float					BotPickBestTime;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientAddJunk, ClientRemoveJunk, ClientDoBlock, ClientSwitch, ClientBreak, ClientForceJunkAmmo, ClientForceBlock;
	reliable if (Role < ROLE_Authority)
		ServerSwitch, ServerFooFireModes;
	unreliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
		JunkAmmo, Shield;
}

simulated function Notify_JunkReload()
{
	bEmptyHanded = false;
	bPendingReload = false;
	if (level.NetMode == NM_Client)
		Junk.Ammo = JunkAmmo;
	Junk.JunkReload();
	if (Role == ROLE_Authority && Junk.Ammo < 1)
		JunkOutOfAmmo(Junk);
	else if (Instigator.IsLocallyControlled() && PendingJunk != None && !IsFiring())
		ServerSwitch(PendingJunk.class);
}
function JunkOutOfAmmo (JunkObject JO)
{
	if (JO == Junk)
		SwitchJunk(GetSourceJunk(JO));
	KillJunk(JO);
}

function ServerSwitch (class<JunkObject> JC)
{
	SwitchJunk(FindJunkOfClass(JC));
}
function SwitchJunk (JunkObject JO, optional bool bNoSelect)
{
	PendingJunk=None;
	SetJunk(JO);
	if (JO != None)
		ClientSwitch(JO.class, bNoSelect);
	else
		ClientSwitch(None, bNoSelect);
}
simulated function ClientSwitch (class<JunkObject> JC, optional bool bNoSelect)
{
	if (Role != ROLE_Authority)
	{
		PendingJunk=None;
		SetJunk(FindJunkOfClass(JC));
	}
	if (!bNoSelect)
		PlayJunkSelect();
}

function MorphJunk ()
{
	local JunkObject JO;
	ConsumeAmmo(0,1);
	JO = GiveJunk(Junk.MorphedJunk, 1, Junk.NextJunk, true);
	JO.MorphSource = Junk.class;
	SwitchJunk(JO, true);
	if (LastJunk.Ammo < 1)
		JunkOutOfAmmo(LastJunk);
	else
		ClientForceJunkAmmo(LastJunk.class, LastJunk.Ammo);
}

function BreakJunk ()
{
	ClientBreak ();
	ConsumeAmmo(0,1);
}
simulated function ClientBreak()
{
	bEmptyHanded = true;
}

simulated function JunkThrown()
{
	if (Instigator.IsLocallyControlled())
		bEmptyHanded = true;
}

simulated function PlayJunkSelect()
{
	PlayAnim(SelectAnim,SelectAnimRate);
	if (Junk != None && Junk.SelectSound.Sound != None)
		class'BUtil'.static.PlayFullSound(self, Junk.SelectSound);
}

simulated function JunkObject GetSourceJunk(JunkObject Current)
{
	local JunkObject JO;
	JO = FindJunkOfClass(Current.MorphSource);
	if (JO == None)
		JO = GetNextBest(Current);
	if (JO == Junk)
		Jo = None;
	return JO;
}

function JunkHitActor(Actor Other, WeaponFire FM, JunkMeleeFireInfo FI)
{
	if (Junk.HitActor(Other, FI))
		return;
	if ( FI.MorphOn == BT_HitAnything || FI.MorphOn == BT_AnySwipe ||
		(FI.MorphOn == BT_HitWall && (Other.bWorldGeometry || Mover(Other) != None)) ||
		(FI.MorphOn == BT_HitActor && !Other.bWorldGeometry && Mover(Other) == None) )
		MorphJunk();
	else if ( FI.DestroyOn == BT_HitAnything || FI.DestroyOn == BT_AnySwipe ||
		(FI.DestroyOn == BT_HitWall && (Other.bWorldGeometry || Mover(Other) != None)) ||
		(FI.DestroyOn == BT_HitActor && !Other.bWorldGeometry && Mover(Other) == None) )
		BreakJunk();
}

simulated function AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);

	bPendingReload = false;
	if (/*Anim == PutDownAnim && */PendingJunk != None)
	{
		if (Role == ROLE_Authority)
			SwitchJunk(PendingJunk);
		else
			ServerSwitch(PendingJunk.class);
	}
	else if (bEmptyHanded)
	{
		if (Anim == PutDownAnim)
		{
			bEmptyHanded=false;
			PlayAnim(SelectAnim,SelectAnimRate);
		}
		else if (Junk == None || Junk.Ammo < 1)
			Reload();
		else
			PlayAnim(PutDownAnim);
	}
	else
		super.AnimEnd(Channel);
}
// FIXME...
simulated function bool Verify(JunkObject JO)
{
	if (JO == None || JO.Weapon == None)
		return false;
	return true;
}
exec simulated function Reload (optional byte i)
{
	local JunkObject JO, Current;
	if (PendingJunk != None)
		Current = PendingJunk;
	else
		Current = Junk;
	JO = GetNextJunk(Current);
	if (Shield != None && Shield.bActive)
	{
		While (JO != None && JO.bDisallowShield && JO != Current/*((PendingJunk != None && JO != PendingJunk) || (PendingJunk == None && JO != Junk))*/)
			JO = GetNextJunk(JO);
	}
	if (JO != None && JO != Current/*((PendingJunk == None && JO != Junk) || (PendingJunk != None && JO != PendingJunk))*/)
		StartSwitchingTo(JO);
}

simulated function StartSwitchingTo (JunkObject JO)
{
	if (JO == None)
		return;
	if (PendingJunk == None)
		PlayAnim(PutDownAnim,PutDownAnimRate,0.2);
	if (JO.bDisallowShield && Shield!=None && Shield.bActive)
		Shield.Deactivate();
	PendingJunk = JO;
	Instigator.ReceiveLocalizedMessage(class'JunkChangeMessage',,,,PendingJunk);
}

simulated function bool AllowWeapPrevUI()
{
	return false;
}
simulated function bool AllowWeapNextUI()
{
	return false;
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	local JunkObject JO, PrevJO, CJ;
	local Weapon PrevWeap;

	if (CurrentWeapon == self)
	{
		if (PendingJunk != None)
			CJ = PendingJunk;
		else
			CJ = Junk;
		if (CJ != None)
			JO = PrevJunkInGroup(CJ.InventoryGroup, CJ);
		else
			JO = LastOfGroup(InventoryGroup);
		if (JO != None)
		{
			StartSwitchingTo(JO);
			return None;
		}
	    if ( Inventory == None )
    	    PrevWeap = CurrentChoice;
	    else
			PrevWeap = Inventory.PrevWeapon(CurrentChoice,CurrentWeapon);
        if (PrevWeap != None && PrevWeap.InventoryGroup == InventoryGroup)
        	return PrevWeap;
		PrevJO = LastOfPrevGroup(InventoryGroup);
        if (PrevWeap == None || PrevJO.InventoryGroup == InventoryGroup-1)
		{
			StartSwitchingTo(PrevJO);
			return None;
		}
		if (PrevJO.InventoryGroup < InventoryGroup && (PrevWeap == None || PrevWeap.InventoryGroup > InventoryGroup || PrevWeap.InventoryGroup < PrevJO.InventoryGroup))
		{
			StartSwitchingTo(PrevJO);
			return None;
		}
		if (PrevWeap.InventoryGroup < InventoryGroup && (PrevJO.InventoryGroup > InventoryGroup || PrevJO.InventoryGroup < PrevWeap.InventoryGroup))
        	return PrevWeap;
        if (PrevJO.InventoryGroup > PrevWeap.InventoryGroup)
		{
			StartSwitchingTo(PrevJO);
			return None;
		}
       	return PrevWeap;
	}
    if ( Inventory == None )
   	    PrevWeap = CurrentChoice;
    else
    {
		PrevWeap = Inventory.PrevWeapon(CurrentChoice,CurrentWeapon);
		if (PrevWeap == None && (CurrentChoice != None || (BallisticWeapon(CurrentWeapon) != None && BallisticWeapon(CurrentWeapon).bScopeView && BallisticWeapon(CurrentWeapon).ZoomType == ZT_Smooth)) )
			return None;
	}
	if (JunkChain == None)
		return PrevWeap;
	if (PrevWeap != None && PrevWeap.InventoryGroup == CurrentWeapon.InventoryGroup && PrevWeap != CurrentWeapon && PrevWeap.GroupOffset < CurrentWeapon.GroupOffset)
		return PrevWeap;
	JO = LastOfGroup(CurrentWeapon.InventoryGroup-1);
	if (JO != None)
	{
		ServerSwitch(JO.Class);
		return self;
	}
	if (PrevWeap != None && PrevWeap.InventoryGroup == CurrentWeapon.InventoryGroup-1)
		return PrevWeap;
	PrevJO = LastOfPrevGroup(CurrentWeapon.InventoryGroup);
	if  (PrevJO != None)
	{
		if (PrevWeap == None || PrevJO.InventoryGroup == CurrentWeapon.InventoryGroup-1)
		{
			ServerSwitch(PrevJO.Class);
			return self;
		}
		if (PrevJO.InventoryGroup < CurrentWeapon.InventoryGroup && (PrevWeap.InventoryGroup > CurrentWeapon.InventoryGroup || PrevWeap.InventoryGroup < PrevJO.InventoryGroup))
		{
			ServerSwitch(PrevJO.Class);
			return self;
		}
		if (PrevWeap.InventoryGroup < CurrentWeapon.InventoryGroup && (PrevJO.InventoryGroup > CurrentWeapon.InventoryGroup || PrevJO.InventoryGroup < PrevWeap.InventoryGroup))
			return PrevWeap;
		if (PrevJO.InventoryGroup > PrevWeap.InventoryGroup)
		{
			ServerSwitch(PrevJO.Class);
			return self;
		}
	}
	return PrevWeap;
}

simulated function JunkObject PrevJunkInGroup (byte F, JunkObject Current)
{
	local JunkObject JO;

	if (Current == JunkChain)
		return None;
	for (JO=JunkChain; JO!=None && JO.InventoryGroup<=F; JO=JO.NextJunk)
		if (JO.InventoryGroup == F && JO.NextJunk == Current)
			return JO;
	return None;
}
simulated function JunkObject LastOfGroup (byte F)
{
	local JunkObject JO;

	for (JO=JunkChain;JO!=None;JO=JO.NextJunk)
		if (JO.InventoryGroup == F && (JO.NextJunk == None || JO.NextJunk.InventoryGroup > F))
			return JO;
	return none;
}

simulated function JunkObject LastOfPrevGroup (byte F)
{
	local JunkObject JO;

	for (JO=JunkChain;JO!=None;JO=JO.NextJunk)
		if (JO.NextJunk == None || (JO.InventoryGroup < F && JO.NextJunk.InventoryGroup >= F))
			return JO;
	return none;
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	local JunkObject JO, NextJO, CJ;
	local Weapon NextWeap;

	if (CurrentWeapon == self)
	{
		if (PendingJunk != None)
			CJ = PendingJunk;
		else
			CJ = Junk;
		if (CJ != None)
			JO = NextJunkInGroup(CJ.InventoryGroup, CJ);
		else
			JO = FirstOfGroup(InventoryGroup);
		if (JO != None)
		{
			StartSwitchingTo(JO);
			return None;
		}
	    if ( Inventory == None )
    	    NextWeap = CurrentChoice;
	    else
			NextWeap = Inventory.NextWeapon(CurrentChoice,CurrentWeapon);
        if (NextWeap != None && NextWeap.InventoryGroup == InventoryGroup+1)
        	return NextWeap;
		NextJO = FirstOfNextGroup(InventoryGroup);
        if (NextWeap == None || NextJO.InventoryGroup == InventoryGroup+1)
		{
			StartSwitchingTo(NextJO);
			return None;
		}
		if (NextJO.InventoryGroup > InventoryGroup && (NextWeap == None || NextWeap.InventoryGroup < InventoryGroup || NextWeap.InventoryGroup > NextJO.InventoryGroup))
		{
			StartSwitchingTo(NextJO);
			return None;
		}
		if (NextWeap.InventoryGroup > InventoryGroup && (NextJO.InventoryGroup < InventoryGroup || NextJO.InventoryGroup > NextWeap.InventoryGroup))
        	return NextWeap;
        if (NextJO.InventoryGroup < NextWeap.InventoryGroup)
		{
			StartSwitchingTo(NextJO);
			return None;
		}
       	return NextWeap;
	}
    if ( Inventory == None )
   	    NextWeap = CurrentChoice;
    else
    {
		NextWeap = Inventory.NextWeapon(CurrentChoice,CurrentWeapon);
		if (NextWeap == None && (CurrentChoice != None || (BallisticWeapon(CurrentWeapon) != None && BallisticWeapon(CurrentWeapon).bScopeView && BallisticWeapon(CurrentWeapon).ZoomType == ZT_Smooth)) )
			return None;
	}
    if (JunkChain == None)
		return NextWeap;
	if (NextWeap != None && NextWeap.InventoryGroup == CurrentWeapon.InventoryGroup && NextWeap != CurrentWeapon && NextWeap.GroupOffset > CurrentWeapon.GroupOffset)
		return NextWeap;
	JO = FirstOfGroup(CurrentWeapon.InventoryGroup);
	if (JO != None)
	{
		ServerSwitch(JO.Class);
		return self;
	}
	if (NextWeap != None && NextWeap.InventoryGroup == CurrentWeapon.InventoryGroup+1)
		return NextWeap;
	NextJO = FirstOfNextGroup(CurrentWeapon.InventoryGroup);
	if  (NextJO != None)
	{
		if (NextWeap == None || NextJO.InventoryGroup == CurrentWeapon.InventoryGroup+1)
		{
			ServerSwitch(NextJO.Class);
			return self;
		}
		if (NextJO.InventoryGroup > CurrentWeapon.InventoryGroup && (NextWeap.InventoryGroup < CurrentWeapon.InventoryGroup || NextWeap.InventoryGroup > NextJO.InventoryGroup))
		{
			ServerSwitch(NextJO.Class);
			return self;
		}
		if (NextWeap.InventoryGroup > CurrentWeapon.InventoryGroup && (NextJO.InventoryGroup < CurrentWeapon.InventoryGroup || NextJO.InventoryGroup > NextWeap.InventoryGroup))
			return NextWeap;
		if (NextJO.InventoryGroup < NextWeap.InventoryGroup)
		{
			ServerSwitch(NextJO.Class);
			return self;
		}
	}
	return NextWeap;
}

simulated function JunkObject NextJunkInGroup (byte F, JunkObject JO)
{
	JO = JO.NextJunk;
	if (JO != None && JO.InventoryGroup == F)
		return JO;
	return None;
}
simulated function JunkObject FirstOfGroup (byte F)
{
	local JunkObject JO;

	for (JO=JunkChain;JO!=None;JO=JO.NextJunk)
		if (JO.InventoryGroup == F)
			return JO;
	return none;
}

simulated function JunkObject FirstOfNextGroup (byte F)
{
	local JunkObject JO;

	for (JO=JunkChain;JO!=None;JO=JO.NextJunk)
		if (JO.InventoryGroup > F)
			return JO;
	if (JO == None && JunkChain != None)
		return JunkChain;
	return none;
}

simulated function Weapon WeaponChange( byte F, bool bSilent )
{
	local JunkObject JO, CurrentJunk, Best;
	local float BestRating, ThisRating;

	if (PendingJunk != None)
		CurrentJunk = PendingJunk;
	else
		CurrentJunk = Junk;
	if (Instigator.Weapon != self && CurrentJunk.InventoryGroup == F)
		return self;
	BestRating=-999999;
	for (JO=GetNextJunk(CurrentJunk); JO!=None&&JO!=CurrentJunk; JO=GetNextJunk(JO))
		if (JO.InventoryGroup == F)
		{
			ThisRating = JO.MeleeRating + JO.RangeRating;
			if (Instigator.Weapon == self)
			{
		 		StartSwitchingTo(JO);
		 		return self;
		 	}
			else if (ThisRating > BestRating)
			{
				Best = JO;
				BestRating = ThisRating;
			}
//			return self;
		}
	if (Best != None)
		ServerSwitch(Best.Class);
	if ( Inventory == None )
		return None;
	else
		return Inventory.WeaponChange(F,bSilent);
}
simulated function Reselect()
{
}

simulated function Notify_JunkFireSound()
{
	MeleeFire.AnimSoundNotify();
	ThrowFire.AnimSoundNotify();
}
simulated function Notify_JunkFireHit()
{
	MeleeFire.AnimFireNotify(1);
	ThrowFire.AnimFireNotify(1);
}
simulated function Notify_JunkFireHitEarly()
{
	MeleeFire.AnimFireNotify(2);
	ThrowFire.AnimFireNotify(2);
}

simulated function AddJunkAmmo (JunkObject JO, int Amount)
{
	JO.Ammo = Min(JO.Ammo+Amount, JO.MaxAmmo);
	if (JO == Junk)
		JunkAmmo = JO.Ammo;
}

simulated function JunkObject AddJunk(class<JunkObject> JunkClass, optional JunkObject NextJunk, optional int AmmoAmount, optional bool bQuiet)
{
	local JunkObject JO, NewJunk;

	if (AmmoAmount == 0)
		AmmoAmount = JunkClass.default.Ammo;
	if (!bQuiet)
		AnnounceJunk(JunkClass);
	for( JO=JunkChain; JO != None; JO=JO.NextJunk)
		if (JO.Class == JunkClass)
		{
			AddJunkAmmo(JO, AmmoAmount);
			return JO;
		}
//	NewJunk = JunkObject(level.ObjectPool.AllocateObject(JunkClass));
	NewJunk = Spawn(JunkClass,self);
	NewJunk.InitDefaults();
	NewJunk.Ammo = AmmoAmount;
	NewJunk.Weapon = self;
	// Stick this new Junk somewhere in the chain
	if (JunkChain == None)
		JunkChain = NewJunk;	// No chain yet, this will be the first link
	else if (NextJunk != None)
	{							// The position was manually specified already, stick it there
		for(JO=JunkChain; JO != None; JO=JO.NextJunk)
			if (JO.NextJunk == NextJunk)
			{
				JO.NextJunk = NewJunk;
				break;
			}
		NewJunk.NextJunk = NextJunk;
	}
	else if (JunkChain.InventoryGroup > NewJunk.InventoryGroup || (JunkChain.InventoryGroup == NewJunk.InventoryGroup && JunkChain.MeleeRating+JunkChain.RangeRating < NewJunk.MeleeRating+NewJunk.RangeRating))
	{							// Should go before first link. Make it the first link
		NewJunk.NextJunk = JunkChain;
		JunkChain = NewJunk;
	}
	else
	{							// Goes before junk with higher InventoryGroups, then before junk with lower rating
		for (JO=JunkChain;JO!=None;JO=JO.NextJunk)
		{
			if (JO.NextJunk == None)
			{
				JO.NextJunk = NewJunk;
				break;
			}
			if ( JO.NextJunk.InventoryGroup > NewJunk.InventoryGroup || (JO.NextJunk.InventoryGroup == NewJunk.InventoryGroup && JO.NextJunk.MeleeRating+JO.NextJunk.RangeRating < NewJunk.MeleeRating+NewJunk.RangeRating) )
			{
				NewJunk.NextJunk = JO.NextJunk;
				JO.NextJunk = NewJunk;
				break;
			}
		}
	}

	if (Instigator != None && AIController(Instigator.Controller) != None && ClientState == WS_ReadyToFire)
		PickBestJunk();
	return NewJunk;
}

simulated function RemoveJunk(JunkObject DeadJunk)
{
	local JunkObject JO;

	if (DeadJunk == None)
		return;
	if (DeadJunk == JunkChain)
		JunkChain = DeadJunk.NextJunk;
	else
		for( JO=JunkChain; JO != None; JO=JO.NextJunk)
			if (JO.NextJunk != None && JO.NextJunk == DeadJunk)
			{
				JO.NextJunk = DeadJunk.NextJunk;
				break;
			}
	DeadJunk.Weapon = None;
	DeadJunk.NextJunk = None;
	DeadJunk.Destroy();
//	level.ObjectPool.FreeObject(DeadJunk);
}

simulated function ClientAddJunk(class<JunkObject> JunkClass, optional int Ammo, optional class<JunkObject> NextJunk, optional bool bQuiet)
{
	if (level.NetMode == NM_Client)
		AddJunk(JunkClass, FindJunkOfClass(NextJunk), Ammo, bQuiet);
}
function JunkObject GiveJunk(class<JunkObject> JunkClass, optional int Ammo, optional JunkObject NextJunk, optional bool bQuiet)
{
	local JunkObject JO;
	if (NextJunk == None)
		ClientAddJunk(JunkClass, Ammo, , bQuiet);
	else
		ClientAddJunk(JunkClass, Ammo, NextJunk.class, bQuiet);
	JO = AddJunk(JunkClass, NextJunk, Ammo, bQuiet);
	if (Junk == None && JO != None/* && Instigator.Weapon == self*/)
		SwitchJunk(JO, false);
	return JO;
}
simulated function ClientRemoveJunk(class<JunkObject> JunkClass, optional int Ammo)
{
	if (level.NetMode == NM_Client)
		RemoveJunk(FindJunkOfClass(JunkClass));
}
function KillJunk(JunkObject JO)
{
	if (JO!=None)
	{
		ClientRemoveJunk(JO.class);
		RemoveJunk(JO);
	}
}

simulated function ClientForceJunkAmmo(class<JunkObject> JunkClass, int Amount)
{
	local JunkObject JO;
	if (level.NetMode != NM_Client)
		return;
	JO = FindJunkOfClass(JunkClass);
	if (JO != None)
		JO.Ammo = Amount;
}

simulated function JunkObject GetNextJunk(JunkObject Current)
{
	if (Current != None && Current.NextJunk != None)
		return Current.NextJunk;
	else if (JunkChain != Current)
		return JunkChain;
	else
		return None;
}

simulated function JunkObject GetPrevJunk(JunkObject Current)
{
	local JunkObject JO;
	for (JO=JunkChain;JO!=None;JO=JO.NextJunk)
		if (JO.NextJunk == Current || (JO.NextJunk == None && JO != Current))
			return JO;
	return JO;
}

function DropFrom(vector StartLocation)
{
    local int m;
	local Pickup Pickup;
	local JunkObject OldJunk;

	if (Shield != None && Shield.bActive)
	{
		Shield.Velocity = Velocity + VRand() * 50;
		Shield.DropFrom(StartLocation);
		Shield = None;
        if (Instigator.Health > 0)
			return;
	}

	if (AmbientSound != None)
		AmbientSound = None;

	for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None && FireMode[m].bIsFiring)
            StopFire(m);
    }
    if (JunkChain == None || JunkChain.NextJunk == None || Instigator.Health < 1)
    {
		ClientWeaponThrown();
		if ( Instigator != None )
			DetachFromPawn(Instigator);
	}

	if (Junk != None)
		Pickup = Spawn(PickupClass,self,, StartLocation);
	if ( Pickup != None )
	{
    	Pickup.InitDroppedPickupFor(self);
	    Pickup.Velocity = Velocity;
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
		if (JunkWeaponPickup(Pickup) != None)
		{
			JunkWeaponPickup(Pickup).JunkAmmo = Junk.Ammo;
			JunkWeaponPickup(Pickup).SetJunkClass(Junk.Class);
		}
    }
    if (JunkChain == None || JunkChain.NextJunk == None || Instigator.Health < 1)
	    Destroy();
	else
	{
		OldJunk = Junk;
		SwitchJunk(GetNextJunk(Junk));
		KillJunk(OldJunk);
	}
}

simulated function bool ConsumeAmmo(int Mode, float load, optional bool bAmountNeededIsMax)
{
	if (bAmountNeededIsMax)
		Junk.Ammo = 0;
	else if (load <= 0)
		return true;
	else
		Junk.Ammo -= load;
	JunkAmmo = Junk.Ammo;
	return true;
}

simulated function int AmmoAmount(int mode)
{
	if (Junk != None)
		return Junk.Ammo;
	return 0;
}
//FIXME: Cap these logs!!!
simulated function SetJunk (JunkObject JO)
{
	LastJunk = Junk;
	bPendingReload = false;
	if (LastJunk != None && LastJunk != JO)
		LastJunk.Uninitialize(JO);
	Junk = JO;
	if (Junk != None)
	   	InventoryGroup = Junk.InventoryGroup;
	else
		InventoryGroup = default.InventoryGroup;
//	GroupOffset = 255;
	if (JO == None)
	{
		JunkAmmo = 0;
		if (JunkWeaponAttachment(ThirdPersonActor) != None)
			JunkWeaponAttachment(ThirdPersonActor).SetJunk(None);
		return;
	}
	if (!JO.Initialize(LastJunk))
	{
		JunkAmmo = Junk.Ammo;
		SwitchFireModes (Junk);
		UpdateJunkWeapon(JO);
		UpdateJunkActor(JO);
 		if (Instigator != None && Instigator.Weapon == self)
	 		UpdateJunkAtachment(JO);
		if (Shield != None && Shield.bActive && Junk.bDisallowShield)
			Shield.Deactivate();
	}
	JO.PostInitialize(JunkActor);
}

simulated function SwitchFireModes (JunkObject JO)
{
	if (JO == None)
		return;
	MeleeFire.AssignFireInfo(JO.MeleeAFireInfo, JO);
	ThrowFire.AssignFireInfo(JO.ThrowFireInfo, JO);
	if (!JO.bCanThrow && JO.bCanHoldMelee/* && ThrowFire != None*/)
		ThrowFire.SwitchToMelee(JO.MeleeBFireInfo);
	else// if (ThrowFire.IsInState('Melee'))
		ThrowFire.SwitchToRanged(JO.MeleeAFireInfo);
}

simulated function UpdateJunkWeapon (JunkObject JO)
{
	// Adjust PlayerViewOffset and PlayerViewPivot for the new junk
	if (JO.HandStyle == HS_TwoHanded)
	{
	    if (Role < ROLE_Authority || (Instigator != None && Instigator.IsLocallyControlled() && Instigator.IsHumanControlled()))
		{
			default.PlayerViewOffset = TwoHandViewOffset + JO.HandOffset;
			default.PlayerViewPivot = TwoHandViewPivot + JO.HandPivot;
		}
		if (mesh != TwoHandMesh)
			LinkMesh(TwoHandMesh);
	}
	else
	{
	    if (Role < ROLE_Authority || (Instigator != None && Instigator.IsLocallyControlled() && Instigator.IsHumanControlled()))
		{
			default.PlayerViewOffset = OneHandViewOffset + JO.HandOffset;
			default.PlayerViewPivot = OneHandViewPivot + JO.HandPivot;
		}
		if (mesh != OneHandMesh)
			LinkMesh(OneHandMesh);
	}
	SetDrawScale(default.DrawScale * JO.HandScale);
	DisplayFOV = JO.HandFOV;
	// Use anims and sounds of new junk
	BringUpSound = JO.SelectSound;
	SelectAnimRate = JO.PullOutRate;
	SelectAnim = GetSelectAnim(JO);
	IdleAnim = GetIdleAnim(JO);
	PutDownAnimRate = JO.PutAwayRate;
	PutDownAnim = GetPutAwayAnim(JO);
	// Change grip style
	AnimBlendParams(1, 1.0, 0.0, 0.2, GripRootBone);
	LoopAnim(GripAnims[JO.RightGripStyle],, 0.0, 1);
	if (JO.HandStyle == HS_Twohanded)
	{
		AnimBlendParams(2, 1.0, 0.0, 0.2, GripRootBone2);
		LoopAnim(GripAnims[JO.LeftGripStyle],, 0.0, 2);
	}
}
// Update third person actor
function UpdateJunkAtachment (JunkObject JO)
{
	if (Role < ROLE_Authority)
		return;
	if (ThirdPersonActor == None || JO.ThirdPersonActorClass != ThirdPersonActor.class)
	{
		DetachFromPawn(Instigator);
		AttachmentClass = JO.ThirdPersonActorClass;
		AttachToPawn(Instigator);
	}
	if (JunkWeaponAttachment(ThirdPersonActor) != None)
		JunkWeaponAttachment(ThirdPersonActor).SetJunk(JO.class);
}
// Update the JunkActor
simulated function UpdateJunkActor (JunkObject JO)
{
	//FIXME
	if (JunkActor != None && !JunkActor.bDeleteMe && JunkActor.Class != JO.JunkActorClass)
		JunkActor.Destroy();
	if (Instigator != None && !Instigator.IsHumanControlled())
		return;
	if (JunkActor == None || JunkActor.bDeleteMe)
		JunkActor = Spawn(JO.JunkActorClass, self, , , );
	if (JunkActor == None)
		return;

	if (JO.StaticMesh != None)
	{
		JunkActor.SetDrawType	(DT_StaticMesh);
		JunkActor.SetStaticMesh	(JO.StaticMesh);
	}
	else if (JO.Mesh != None)
	{
		JunkActor.SetDrawType	(DT_Mesh);
		JunkActor.LinkMesh		(JO.Mesh);
	}
	JunkActor.SetDrawScale		(JO.DrawScale*DrawScale);
}

simulated event RenderOverlays( Canvas Canvas )
{
	local vector V, newScale3d;
	local rotator R;

	if ( Instigator.Controller != None )
		Hand = Instigator.Controller.Handedness;

	super.RenderOverlays(Canvas);

	if (JunkActor != None && Junk != None && (Hand >= -1.0) && (Hand <= 1.0))
	{
	    if (Hand != Junk.RenderedHand)
    	{
	    	if (Hand < 0.0)
    		{
				Junk.BlockLeftAnim = Junk.Default.BlockRightAnim;
				Junk.BlockRightAnim = Junk.Default.BlockleftAnim;
			}
			else
			{
				Junk.BlockLeftAnim = Junk.Default.BlockLeftAnim;
				Junk.BlockRightAnim = Junk.Default.BlockRightAnim;
			}
			Junk.AttachOffset = Junk.Default.AttachOffset;
			Junk.AttachPivot = Junk.Default.AttachPivot;
			if (Hand != 0)
			{
				Junk.AttachOffset.Y = Junk.Default.AttachOffset.Y * Hand;
				Junk.AttachPivot.Roll = Junk.Default.AttachPivot.Roll * Hand;
				Junk.AttachPivot.Yaw = Junk.Default.AttachPivot.Yaw * Hand;
			}
			if (JunkActor != None)
			{
				newScale3D = JunkActor.Default.DrawScale3D;
				if (Hand != 0)
					newScale3D.Y *= Hand;
				JunkActor.SetDrawScale3D(newScale3D);
			}
			Junk.RenderedHand = Hand;
		}
		R = GetBoneRotation(Junk.AttachBone);
		if (Hand < 0.0)
		{
			R.Roll *= -1;
			R.Roll += 32768;
		}
		V = GetBoneCoords(Junk.AttachBone).Origin + class'bUtil'.static.AlignedOffset(R, Junk.AttachOffset);
		JunkActor.SetLocation(V);
//		JunkActor.SetRotation(R);
		JunkActor.SetRotation(class'bUtil'.static.RotateAboutAxis(R, Junk.AttachPivot));

		if (!Junk.JunkRenderOverlays(Canvas))
		{
			if (!bEmptyHanded)
				Canvas.DrawActor(JunkActor, false, false, DisplayFOV);
		}
	}
 	if (Shield != None)
		Shield.RenderOverlays(Canvas);
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	Super.NewDrawWeaponInfo(C, YPos);
	if (Junk != none)
		Junk.DrawWeaponInfo(C);
	if (Shield != None)
		Shield.DrawShieldInfo(C);
}

simulated function bool ReadyToFire(int Mode)
{
	if (Junk == None)
		return false;
	return super.ReadyToFire(Mode);
}

simulated function bool StartFire(int Mode)
{
	if (!Instigator.IsHumanControlled())
	{
		if (Junk.bCanThrow && !ThrowFire.IsInState('Ranged'))
			ThrowFire.SwitchToRanged(Junk.MeleeAFireInfo);
	}
	return Super.StartFire(Mode);
}

simulated event ClientStartFire(int Mode)
{
    if ( Pawn(Owner).Controller.IsInState('GameEnded') || Pawn(Owner).Controller.IsInState('RoundEnded') )
        return;
    FooFireModes(Mode);
    if (Role < ROLE_Authority)
    {
	    ServerFooFireModes(Mode);
        if (StartFire(Mode))
            ServerStartFire(Mode);
    }
    else
        StartFire(Mode);
}
//FIXME
simulated function FooFireModes (byte Mode)
{
	local int OtherMode;

	if(Junk == None)
		return;
	OtherMode = int(Mode == 0);
	if ( JunkRangedFire(FireMode[Mode]) != None )
	{
		if ( FireMode[OtherMode].bIsFiring)
		{
			if (Junk.bCanThrow && (!Junk.bSwapSecondary || !Junk.bCanHoldMelee))
				ThrowFire.SwitchToRanged(Junk.MeleeAFireInfo);
			else if (Junk.bCanHoldMelee && (Junk.bSwapSecondary || !Junk.bCanThrow))
				ThrowFire.SwitchToMelee(Junk.MeleeBFireInfo);
			FireMode[OtherMode].bIsFiring=false;
			JunkMeleeFire(FireMode[OtherMode]).bWaitingForFireNotify = false;
		}
		else
		{
			if (Junk.bCanHoldMelee && (!Junk.bSwapSecondary || !Junk.bCanThrow))
				ThrowFire.SwitchToMelee(Junk.MeleeBFireInfo);
			else if (Junk.bCanThrow && (Junk.bSwapSecondary || !Junk.bCanHoldMelee))
				ThrowFire.SwitchToRanged(Junk.MeleeAFireInfo);
		}
	}
    else
    {
		if (FireMode[OtherMode].bIsFiring)
		{
			if (Junk.bCanThrow && (!Junk.bSwapSecondary || !Junk.bCanHoldMelee))
				ThrowFire.SwitchToRanged(Junk.MeleeAFireInfo);
			else if (Junk.bCanHoldMelee && (Junk.bSwapSecondary || !Junk.bCanThrow))
				ThrowFire.SwitchToMelee(Junk.MeleeBFireInfo);
		}
		else
		{
			MeleeFire.AssignHitInfo(Junk.MeleeAFireInfo);
		}
	}
}
function ServerFooFireModes(byte Mode)
{
	FooFireModes(Mode);
}
//function ServerSetTri ()
//function ServerClearTri ()
//function ServerAssureMeleeFire ()

simulated function JunkObject GetNextBest(JunkObject Current)
{
	local JunkObject Best, Next;
	local bool bRanged, bMelee;

	if (Current == None)
		return JunkChain;
	if (JunkChain == None)
		return None;

	if (Current.bCanThrow)
	{
		if (Current.MeleeRating < Current.RangeRating && Current.MeleeRating / Current.RangeRating < 0.5)
			bRanged = true;
		else if (Current.MeleeRating > Current.RangeRating && (Current.MeleeRating / Current.RangeRating > 1.5 || Current.MeleeRating / Current.RangeRating == 0))
			bMelee = true;
		else
		{	bRanged=true; bMelee=true;	}
	}
	else
		bMelee=true;

	Best = JunkChain;
	for(Next=JunkChain.NextJunk; Next!=None; Next=Next.NextJunk)
	{
		if (Next == Current)
			continue;
		if (bRanged && bMelee)
		{	if (Next.RangeRating + Next.MeleeRating > Best.RangeRating + Next.MeleeRating
			|| (Next==Current.NextJunk && Next.RangeRating + Next.MeleeRating == Best.RangeRating + Next.MeleeRating) )
				Best = Next;	}
		else if (bRanged)
		{	if (Next.RangeRating > Best.RangeRating || (Next==Current.NextJunk && Next.RangeRating == Best.RangeRating) )
				Best = Next;	}
		else if (bMelee)
		{	if (Next.MeleeRating > Best.MeleeRating || (Next==Current.NextJunk && Next.MeleeRating == Best.MeleeRating) )
				Best = Next;	}
	}
	return Best;
}

simulated function class<JunkObject> GetRandomJunkClass ()
{
	local array<string>			JunkNameList;
	local class<JunkObject>		JC;
	local int i, j, By;

	GetAllInt("JunkObject", JunkNameList);
	i = Rand(JunkNameList.length);
	JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
	if (!JC.default.bListed)
	{
		if (FRand() > 0.5)
			By = -1;
		Else
			By = 1;
		while(j < JunkNameList.length-1)
		{
			i = class'BUtil'.static.Loop(i, By, JunkNameList.length-1);
			JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
			if (JC.default.bListed)
				break;
			j++;
		}
	}
	return JC;
//	return class<JunkObject>(DynamicLoadObject(JunkNameList[Rand(JunkNameList.length)], class'Class'));
}

simulated function JunkObject FindJunkOfClass (class<JunkObject> JC)
{
	local JunkObject JO;
	if (JC != None)
		for( JO=JunkChain; JO != None; JO=JO.NextJunk)
			if (JO.Class == JC)
				return JO;
	return None;
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		if (Junk!= None)
			Junk.Uninitialize(None);
		PendingJunk=None;
		If (Shield != None && Shield.bActive)
			Shield.Deactivate();
		return true;
	}
	return false;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);
	PendingJunk=None;
	if (Role == ROLE_Authority)
	{
		if (Junk == None && JunkChain != None)
			SwitchJunk(JunkChain, false);
		else if (Junk != None)
			SwitchJunk (Junk, true);
	}
	if (AIController(Instigator.Controller) != None)
		PickBestJunk();
}

simulated function PostBeginPlay()
{
	local Material Mat;

	// If we can find BWv2.0, we can use its new hand skins...
	Mat = Material(DynamicLoadObject("BW_Core_WeaponTex.Hands.Hands-Shiny", class'Material'));
	if (Mat != None)
		Skins[0] = Mat;
	Mat = Material(DynamicLoadObject("BW_Core_WeaponTex.Hands.RedHand-Shiny", class'Material'));
	if (Mat != None)
		TeamSkins[0].RedTex = Mat;
	Mat = Material(DynamicLoadObject("BW_Core_WeaponTex.Hands.BlueHand-Shiny", class'Material'));
	if (Mat != None)
		TeamSkins[0].BlueTex = Mat;

	super.PostBeginPlay();
	// FIXME
	bOldCrosshairs = true;
	MeleeFire = JunkMeleeFire(FireMode[0]);
	ThrowFire = JunkRangedFire(FireMode[1]);
}

simulated function Destroyed()
{
    local int m;
//	local Ammunition A;

	if (Junk != None)
		Junk.Uninitialize(None);
	if (JunkActor != None)
		JunkActor.Destroy();
	if (Shield != None && !Shield.bDeleteMe)
		Shield.Deactivate();

	Junk = None;
//	MeleeFire.Junk = None;
//	ThrowFire.Junk = None;
	KillJunkChain();

//	MeleeFire = None;
//	ThrowFire = None;

	AmbientSound = None;

	if (PlayerSpeedUp && Instigator != None)
	{
		Instigator.GroundSpeed *= (1/PlayerSpeedFactor);
		PlayerSpeedUp=false;
	}

	if (Instigator != None && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
		PlayerController(Instigator.Controller).MyHud.bCrosshairShow = PlayerController(Instigator.Controller).MyHud.default.bCrosshairShow;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
		if ( FireMode[m] != None )
			FireMode[m].DestroyEffects();
		if (Ammo[m] != None)
		{
/*		    if (Instigator != None && Instigator.Health > 0)
			{
			    A = Spawn(Ammo[m].Class, Instigator);
				A.AmmoAmount = Ammo[m].AmmoAmount;
	            Instigator.AddInventory(A);
			}
*/			Ammo[m].Destroy();
			Ammo[m] = None;
		}
	}
	Super(Inventory).Destroyed();
}

simulated function KillJunkChain()
{
	local JunkObject JO;

	while (JunkChain != None)
	{
		JO = JunkChain;
		JunkChain = JO.NextJunk;
//		JO.Destroy();
		JO.Weapon = None;
		JO.NextJunk = None;
		JO.Destroy();
//		level.ObjectPool.FreeObject(JO);
	}
}

simulated function AnnounceJunk (class<JunkObject> JunkClass)
{
	if (Instigator != None && Instigator.IsLocallyControlled())
		Instigator.ReceiveLocalizedMessage(class'JunkPickupMessage',,,,JunkClass);
}
simulated function GetAmmoCount(out float MaxAmmoPrimary, out float CurAmmoPrimary)
{
	if (Junk != None)
	{
		MaxAmmoPrimary = Junk.MaxAmmo;
		CurAmmoPrimary = Junk.Ammo;
	}
}

function bool HandlePickupQuery( pickup Item )
{
    local JunkObject JO;

	if (JunkWeaponPickup(Item) != None)
    {
	    JO = FindJunkOfClass(JunkWeaponPickup(Item).JunkClass);
    	if (JO != None && JO.Ammo >= JO.MaxAmmo)
			return true;
    }
    if ( Inventory == None )
		return false;
	return Inventory.HandlePickupQuery(Item);
}

simulated function name GetSelectAnim (JunkObject JO)
{
	return PullOutAnims[JO.PullOutStyle];
}
simulated function name GetIdleAnim (JunkObject JO)
{
	return IdleAnims[JO.IdleStyle];
}
simulated function name GetPutAwayAnim (JunkObject JO)
{
	return PutAwayAnims[JO.PutAwayStyle];
}

simulated function JunkAttacked()
{
	LastFireTime = Level.TimeSeconds;
	PendingJunk=None;
	if (Shield != None)
	{
		if (Junk != None && Junk.bDisallowShield && Shield.bActive)
			Shield.Deactivate();
		else
			Shield.WeaponFired();
	}
}
simulated function ClientDoBlock (byte Side)
{
	if (Side == 0 && HasAnim(Junk.BlockLeftAnim))	// Left
		SafePlayAnim(Junk.BlockLeftAnim,1.0);
	else if (HasAnim(Junk.BlockRightAnim))	// Right and Center
		SafePlayAnim(Junk.BlockRightAnim,1.0);
}
// FIXME
// This should be expanded in subclasses if needed
simulated function bool CanPlayAnim (name Sequence, optional int Channel, optional string AnimID)
{
	if (bPendingReload && AnimID != "FIRE")
		return false;
	return super.CanPlayAnim(Sequence, Channel, AnimID);
}

function BlockDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local class<BallisticDamageType> BDT;
	local float BlockFactor;

//	class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.bCanBeBlocked

	// FIXME: let object do blocking stuff...
	// FIXME: Let damage do stuff if it gets blocked...
	if (Junk.BlockDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType))
		return;

	BDT = class<BallisticDamageType>(DamageType);
	if (BDT!=None && BDT.default.bCanBeBlocked && (BDT.static.IsDamage(",Blunt,") || BDT.static.IsDamage(",Slash,") || BDT.static.IsDamage(",Stab,") || BDT.static.IsDamage(",Hack,")))
	{
		if (BDT.default.ShieldDamage >= Junk.NoUseThreshold)
			BlockFactor = 1.0;
		else if (BDT.default.ShieldDamage > Junk.PainThreshold)
			BlockFactor = float(BDT.default.ShieldDamage-Junk.PainThreshold) / (Junk.NoUseThreshold-Junk.PainThreshold);
		Damage *= BlockFactor;
		Momentum *= BlockFactor;
	}
}

function DoBlocking( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local vector X,Y,Z, HitNormal;
		local float Rightness;

	// FIXME Implement blocking strength stuff here...
	BlockDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);

	LastBlockTime = level.TimeSeconds;
	HitNormal = Normal(HitLocation-(Instigator.Location+Instigator.EyePosition()));
	LastHitDir = Rotator(HitNormal)-Instigator.GetViewRotation();
	JunkWeaponAttachment(ThirdPersonActor).JunkBlockHit(HitLocation, DamageType);
	GetAxes(Instigator.GetViewRotation(), X,Y,Z);

	Rightness = Y Dot HitNormal;
//	MeleeFire.bWaitingForFireNotify=false;
//	ThrowFire.bWaitingForFireNotify=false;
	if (Rightness < 0.0)
		ClientDoBlock(0);
	else// if (Rightness >= 0.0)
		ClientDoBlock(1);
//	else
//		ClientDoBlock(2);
}
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local float NextTime;

	if (Shield != None && Shield.bActive)
	{
		Shield.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
		return;
	}
	if (!bBlocked)
		return;

	if (GetFireMode(1) != None && GetFireMode(1).NextFireTime > GetFireMode(0).NextFireTime)
		NextTime = GetFireMode(1).NextFireTime - GetFireMode(1).FireRate + FMax(Junk.BlockRate*0.8, GetFireMode(1).FireRate);
	else
		NextTime = GetFireMode(0).NextFireTime - GetFireMode(0).FireRate + FMax(Junk.BlockRate*0.8, GetFireMode(0).FireRate);

	if (/*!Weapon.IsFiring() && */level.TimeSeconds >= NextTime)
	{
		if (level.TimeSeconds > LastBlockTime + Junk.BlockRate)
		{
			if (Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()/*+UpDir*/) > 0.5)
				DoBlocking(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
		}
		else if (Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()+LastHitDir) > 0.8)
			DoBlocking(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
	}
	else if (Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()/*+DownDir*/) > 0.8)
		DoBlocking(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

exec simulated function WeaponSpecial(optional byte i)
{
	ShieldHoldStartTime = level.TimeSeconds;

	if (Shield != None && !Junk.bDisallowShield && Shield.bActive)
	{
		Shield.ShieldUp();
		return;
	}
	if (Junk == None || !Junk.bCanBlock)
		return;
	SafePlayAnim(Junk.BlockStartAnim, 1.0, 0.0);
	ServerWeaponSpecial(i);
	bBlocked=true;
}
function ServerWeaponSpecial(optional byte i)
{
	if(Instigator.IsLocallyControlled())
		return;
	bBlocked=true;
}
exec simulated function WeaponSpecialRelease(optional byte i)
{
	if (Shield != None && (Junk == None || !Junk.bDisallowShield))
	{
		if (level.TimeSeconds - ShieldHoldStartTime < 0.3)
		{
			if (Shield.bActive)
				Shield.Deactivate();
			else
				Shield.Activate();
		}
		else
			Shield.ShieldDown();
	}
	ServerWeaponSpecialRelease(i);
	if (bBlocked)
		EndBlock();
}
function ServerWeaponSpecialRelease(optional byte i)
{
	local Inventory inv;
	if (Shield == None)
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
			if (JunkShield(Inv) != None)
			{	Shield = JunkShield(Inv);
				Shield.Weapon = self;
				break;
			}
	if(Instigator.IsLocallyControlled())
		return;
	if (bBlocked)
		EndBlock();
}
simulated function EndBlock()
{
    local name Anim;
	local float Frame, Rate;
    GetAnimParams(0, Anim, Frame, Rate);

    if (Anim == Junk.BlockStartAnim)
    {
		SafePlayAnim(Junk.BlockEndAnim, 1.0, 0.2);
    	SetAnimFrame(1-Frame, 0);
    }
    else
		SafePlayAnim(Junk.BlockEndAnim, 1.0, 0.1);
	bBlocked=false;
}

simulated function ClientForceBlock(bool bNewBlocking)
{
	if (bNewBlocking && !bBlocked && Junk.bCanBlock)
	{
		SafePlayAnim(Junk.BlockStartAnim, 1.0, 0.0);
		bBlocked=true;
	}
	else if (bBlocked)
		EndBlock();
}

simulated function PlayIdle()
{
	if (bBlocked)
	    SafeLoopAnim(Junk.BlockIdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
	else
	    SafeLoopAnim(IdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
}

function GiveTo( pawn Other, optional Pickup Pickup )
{
	local Inventory Inv;

	super.GiveTo(Other, Pickup);

	if (Shield == None)
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
			if (JunkShield(Inv) != None)
			{	JunkShield(Inv).Weapon = self;
				Shield = JunkShield(Inv);
				break;	}


	if (Other != None)
	{
		if (Other.Weapon == None && Other.Controller!=None)
			Other.Controller.ClientSetWeapon(class);
	}
}


simulated function String GetHumanReadableName()
{
	if (Junk != None)
		return Junk.FriendlyName;
	return super.GetHumanReadableName();
}

// AI Interface =====
// return false if out of range, can't see target, etc.
function bool CanAttack(Actor Other)
{
	local Bot B;
    local float Dist;

    if ( (Instigator == None) || (Instigator.Controller == None) )
		return false;
	if (Junk == None)
	{
		if (JunkChain != none)
			PickBestJunk();
		return false;
	}

	B = Bot(Instigator.Controller);
	if (B != None && Shield != None && Shield.bActive)
	{
		if (Shield.bBlocking && (B.Enemy == None/* || Rand(7) > B.Skill*/))
			Shield.ShieldDown();
		else if (!Shield.bBlocking && (B.Enemy != None && Rand(7) < B.Skill))
			Shield.ShieldUp();
	}

    // check that target is within range
    Dist = VSize(Instigator.Location - Other.Location);

	if (Dist > FireMode[0].MaxRange()*1.2 + Other.CollisionRadius  && (!Junk.bCanThrow || Dist > FireMode[1].MaxRange() || FRand() > Dist/1000 || Junk.Ammo < 2))
	{
		if (level.TimeSeconds > BotPickBestTime + 5.0)
		{
			PickBestJunk();
			BotPickBestTime = level.TimeSeconds;
		}
		return false;
	}

    // check that can see target
    if (!Instigator.Controller.LineOfSightTo(Other) )
        return false;

	return true;
}

// FIXME: Give junk override funcs???
function PickBestJunk()
{
	local JunkObject JO, Best;
	local float ThisRating, BestRating, Dist, EnemyShieldRating, Aggressiveness, CombatStyle;
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( B != None && B.Enemy != None)
		Dist = VSize(Instigator.Location - B.Enemy.Location);
	if (Dist == 0)
		Dist=500;

	if (B != None)
	{
		if (B.Enemy != None && B.Enemy.Weapon != None && JunkWeapon(B.Enemy.Weapon) != None && JunkWeapon(B.Enemy.Weapon).Shield != None && JunkWeapon(B.Enemy.Weapon).Shield.bActive)
			EnemyShieldRating = JunkWeapon(B.Enemy.Weapon).Shield.Rating;
		Aggressiveness = B.Aggressiveness;
		CombatStyle = B.CombatStyle;
	}
	BestRating = -9999;
	for ( JO=JunkChain; JO!=None; JO=JO.NextJunk )
	{
		ThisRating = ( JO.MeleeRating * (0.7+Aggressiveness) * (1+CombatStyle*0.75) * (1+EnemyShieldRating/50) * (500/Dist) );
		if (JO.bCanThrow && JO.Ammo > 0)
			ThisRating += ( JO.RangeRating * (1.3-Aggressiveness) * (1+CombatStyle*-0.75) * (1+50/EnemyShieldRating) * (Dist/500) );
		if (Shield != None && !JO.bDisallowShield)
			ThisRating *= (1+Shield.Rating/50);
//		if (JO.bCanThrow)
//			ThisRating = JO.MeleeRating * (Dist/1000) + JO.RangeRating * (Dist/500);
//		else
//			ThisRating = JO.MeleeRating * (500/Dist);
		ThisRating *= 0.8 + FRand()*0.4;
		if (ThisRating > BestRating)
		{
			BestRating = ThisRating;
			Best = JO;
		}
	}
	if (Best != Junk)
	{
		if (Shield != None)
		{
			if (Best.bDisallowShield && Shield.bActive)
				Shield.Deactivate();
			else if (!Best.bDisallowShield && !Shield.bActive)
				Shield.Activate();
		}
		StartSwitchingTo(Best);
	}
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	if (Junk == None)
		return 0;
	B = Bot(Instigator.Controller);
	if ( B == None)
		return 0;

	if (B.Enemy == None)
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Junk.bCanThrow && Dist > FireMode[0].MaxRange() * (1 + FRand()*0.3) && (JunkChain != Junk || Junk.NextJunk != None || Junk.Ammo > 1))
		return 1;
	else
		return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	if (Junk == None)
		return Super.GetAIRating();
	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();

	if (JunkChain == None)
		return 0;

	if (Dist > 1500)
		Result -= (Dist-1500) / 1500;
	else if (Dist < 500)
		Result += 0.5;
	if (Junk != None)
	{
		if (Dist > 500)
			Result += Junk.RangeRating/200;
		if (Dist < 1000)
			Result += Junk.MeleeRating/200;
	}
	else if (level.TimeSeconds > BotPickBestTime + 2.0)
	{
		PickBestJunk();
		BotPickBestTime = level.TimeSeconds;
	}
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (Junk == None || Junk.Ammo < 1)
		return -3;
	if (Junk.bCanThrow && Junk.RangeRating > 50 && BotMode == 1 && Junk.Ammo > 1)
		return 0.5;
	return 1.2;
}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	if (Junk == None || (Junk.bCanThrow && Junk.RangeRating > 50))
		return 1.2;
	return -0.5;
}
// End AI Stuff =====


// Junk Exec Commands --------------------------------------------------------------------------------------------------
// Cheats >>>>>>>>>>>>>>>>>>>>
//Cheat to get a single junk item
exec simulated function JunkMe(string JunkName)
{
	local class<JunkObject> JC;

	if (level.NetMode != NM_Standalone || Instigator == None)
		return;

	JC = class<JunkObject>(DynamicLoadObject(JunkName, class'Class'));
	if (JC != None)
		GiveJunk(JC);
	else
		Instigator.ClientMessage("Bad junk class name: "$JunkName);
}

//Cheat to get all junk items
exec simulated function Junked()
{
	local int i;
	local class<JunkObject> JC;
	local array<string> JunkNames;

	if (level.NetMode != NM_Standalone || Instigator == None)
		return;

	GetAllInt("JunkObject", JunkNames);
	for(i=0;i<JunkNames.length;i++)
	{
		JC = class<JunkObject>(DynamicLoadObject(JunkNames[i], class'Class'));
		if (JC != None)
			GiveJunk(JC);
	}
}

// Cheat to give lots of ammo to all junk in inventory
exec simulated function AllTheBits(optional int ForcedAmount)
{
	local JunkObject JO;

	if (level.NetMode != NM_Standalone || Instigator == None)
		return;
	if (ForcedAmount == 0)
		ForcedAmount = 999;
	for( JO=JunkChain; JO != None; JO=JO.NextJunk)
		JO.Ammo = ForcedAmount;
}
// End Cheats <<<<<<<<<<<<<<<<

// Utilities >>>>>>>>>>>>>>>>>
/* These are commented out in release builds

// Adjust AttachOffset and AttachPivot of current Junk
exec function JunkOffset (vector V)	{	Junk.default.AttachOffset = V;	Junk.AttachOffset = V;	UpdateJunkActor(Junk);		}
exec function JunkPivot (rotator R)	{	Junk.default.AttachPivot = R;	Junk.AttachPivot = R;	UpdateJunkActor(Junk);		}
exec function JunkScale (float f)	{	Junk.SetDrawScale(f);		UpdateJunkActor(Junk);		}
// Commands to Adjust HandOffset, HandPivot, HandFOV and HandScale of current Junk
exec function HandOffset (vector V)	{	Junk.default.HandOffset = V;	Junk.HandOffset = V;	UpdateJunkWeapon(Junk);		}
exec function HandPivot (rotator R)	{	Junk.default.HandPivot = R;		Junk.HandPivot = R;		UpdateJunkWeapon(Junk);		}
exec function HandFOV (float f)		{	Junk.HandFOV = f;		UpdateJunkWeapon(Junk);		}
exec function HandScale (float f)	{	Junk.HandScale = f;		UpdateJunkWeapon(Junk);	UpdateJunkActor(Junk);	}
// Print current settings in console
exec function JunkPrint ()
{
	Instigator.ClientMessage("AttachOffset="$Junk.AttachOffset$", AttachPivot="$Junk.AttachPivot$", DrawScale="$Junk.DrawScale);
	Instigator.ClientMessage("RightGripStyle="$getenum(enum'EGripStyle', Junk.RightGripStyle)$", LeftGripStyle="$getenum(enum'EGripStyle', Junk.LeftGripStyle));
	Instigator.ClientMessage("HandOffset="$Junk.HandOffset$", HandPivot="$Junk.HandPivot$", HandScale="$Junk.HandScale$", HandFOV="$Junk.HandFOV);
}
// Dump AttachOffset and AttachPivot of all junk in inventory
exec function DumpJunkInfo()
{
	local JunkObject JO;
	local FileLog TempLog;

	log("Dumping Junk Info to JunkWar_DumpedJunkInfo.txt");
	TempLog = spawn(class 'FileLog');
	if (TempLog!=None)
	{
		TempLog.OpenLog("JunkWar_DumpedJunkInfo","txt");

		TempLog.Logf("Junk Properties Dump:");
		for( JO=JunkChain; JO != None; JO=JO.NextJunk)
		{
			TempLog.Logf(JO.FriendlyName$" - "$JO.Class);
			TempLog.Logf("    AttachOffset=(X="$JO.AttachOffset.X$",Y="$JO.AttachOffset.Y$",Z="$JO.AttachOffset.Z$")");
			TempLog.Logf("    AttachPivot=(Pitch="$JO.AttachPivot.Pitch$",Yaw="$JO.AttachPivot.Yaw$",Roll="$JO.AttachPivot.Roll$")");
			TempLog.Logf("    DrawScale="$JO.DrawScale);
			TempLog.Logf("    HandOffset=(X="$JO.HandOffset.X$",Y="$JO.HandOffset.Y$",Z="$JO.HandOffset.Z$")");
			TempLog.Logf("    HandPivot=(Pitch="$JO.HandPivot.Pitch$",Yaw="$JO.HandPivot.Yaw$",Roll="$JO.HandPivot.Roll$")");
			TempLog.Logf("    HandFOV="$JO.HandFOV);
			TempLog.Logf("    HandScale="$JO.HandScale);
			TempLog.Logf("    RightGripStyle="$getenum(enum'EGripStyle', JO.RightGripStyle));
			if (JO.HandStyle == HS_TwoHanded)
			TempLog.Logf("    LeftGripStyle="$getenum(enum'EGripStyle', JO.LeftGripStyle));
			if (Jo.MeleeAFireInfo != None)	{
			TempLog.Logf("  MeleeAFireInfo:");
			TempLog.Logf("       Damage=(Misc=(Min="$JO.MeleeAFireInfo.Damage.Misc.Min$",Max="$JO.MeleeAFireInfo.Damage.Misc.Max$"),Head=(Min="$JO.MeleeAFireInfo.Damage.Head.Min$",Max="$JO.MeleeAFireInfo.Damage.Head.Max$"),Limb=(Min="$JO.MeleeAFireInfo.Damage.Limb.Min$",Max="$JO.MeleeAFireInfo.Damage.Limb.Max$"))");	}
			if (Jo.MeleeBFireInfo != None)	{
			TempLog.Logf("  MeleeBFireInfo:");
			TempLog.Logf("       Damage=(Misc=(Min="$JO.MeleeBFireInfo.Damage.Misc.Min$",Max="$JO.MeleeBFireInfo.Damage.Misc.Max$"),Head=(Min="$JO.MeleeBFireInfo.Damage.Head.Min$",Max="$JO.MeleeBFireInfo.Damage.Head.Max$"),Limb=(Min="$JO.MeleeBFireInfo.Damage.Limb.Min$",Max="$JO.MeleeBFireInfo.Damage.Limb.Max$"))");	}
			if (Jo.ThrowFireInfo != None)	{
			TempLog.Logf("  ThrowFireInfo:");
			TempLog.Logf("       Damage=(Misc=(Min="$JO.ThrowFireInfo.Damage.Misc.Min$",Max="$JO.ThrowFireInfo.Damage.Misc.Max$"),Head=(Min="$JO.ThrowFireInfo.Damage.Head.Min$",Max="$JO.ThrowFireInfo.Damage.Head.Max$"),Limb=(Min="$JO.ThrowFireInfo.Damage.Limb.Min$",Max="$JO.ThrowFireInfo.Damage.Limb.Max$"))");	}
			TempLog.Logf("");
		}
		TempLog.Destroy();
		Instigator.ClientMessage("Junk Info Dumped to JunkWar_DumpedJunkInfo.txt");
	}
	else
		Warn("Could not create junk info dump file");
}
// Command to get help for junk commands...
exec function JunkHelp()
{
	Instigator.ClientMessage("JunkWeapon Command Help:");
	Instigator.ClientMessage("JunkOffset <Vector>:  Sets the AttachOffset for current Junk");
	Instigator.ClientMessage("JunkPivot <Rotator>:  Sets the AttachPivot for current Junk");
	Instigator.ClientMessage("HandOffset <Vector>:  Sets the HandOffset which is the weapon's PlayerViewOffset for current Junk");
	Instigator.ClientMessage("HandPivot <Rotator>:  Sets the HandPivot which is the weapon's PlayerViewPivot for current Junk");
	Instigator.ClientMessage("HandFOV <Float>:      Sets the HandFOV which is the weapon's DisplayFOV for current Junk");
	Instigator.ClientMessage("HandScale <Float>:    Sets the HandScale which scales the weapon's DrawScale for current Junk");
	Instigator.ClientMessage("JunkMeleeDamage <Range,Range,Range>: Sets Misc, Head, Limb damage for MeleeAFireInfo");
	Instigator.ClientMessage("JunkHeldDamage <Range,Range,Range>:  Sets Misc, Head, Limb specific damage for MeleeBFireInfo");
	Instigator.ClientMessage("JunkThrowDamage <Range,Range,Range>: Sets Misc, Head, Limb specific damage for ThrowFireInfo fire");
	Instigator.ClientMessage("JunkGrip <string,bool>: Sets GripStyle. Blank for grip list. Set 2nd param for left hand");
	Instigator.ClientMessage("JunkPrint:            Shows junk settings");
	Instigator.ClientMessage("DumpJunkInfo:         Dump all junk info to file, JunkWar_DumpedJunkInfo.txt");
}
exec function JunkMeleeDamage(Range Damage, optional Range Head, optional Range Limb)
{
	Junk.MeleeAFireInfo.Damage.Misc = Damage;
	Junk.MeleeAFireInfo.Damage.Head = Head;
	Junk.MeleeAFireInfo.Damage.Limb = Limb;
	SwitchFireModes(Junk);
}
exec function JunkHeldDamage(Range Damage, optional Range Head, optional Range Limb)
{
	Junk.MeleeBFireInfo.Damage.Misc = Damage;
	Junk.MeleeBFireInfo.Damage.Head = Head;
	Junk.MeleeBFireInfo.Damage.Limb = Limb;
	SwitchFireModes(Junk);
}
exec function JunkThrowDamage(Range Damage, optional Range Head, optional Range Limb)
{
	Junk.ThrowFireInfo.Damage.Misc = Damage;
	Junk.ThrowFireInfo.Damage.Head = Head;
	Junk.ThrowFireInfo.Damage.Limb = Limb;
	SwitchFireModes(Junk);
}
exec function JunkGrip (optional string s, optional bool bLeft)
{
	local int i;
	switch (s)
	{
		case "GS_Average": 	if (bLeft)Junk.LeftGripStyle = GS_Average; else Junk.RightGripStyle = GS_Average; break;
		case "GS_Small": 	if (bLeft)Junk.LeftGripStyle = GS_Small; else Junk.RightGripStyle = GS_Small; break;
		case "GS_Large": 	if (bLeft)Junk.LeftGripStyle = GS_Large; else Junk.RightGripStyle = GS_Large; break;
		case "GS_Ball": 	if (bLeft)Junk.LeftGripStyle = GS_Ball; else Junk.RightGripStyle = GS_Ball; break;
		case "GS_Bowl": 	if (bLeft)Junk.LeftGripStyle = GS_Bowl; else Junk.RightGripStyle = GS_Bowl; break;
		case "GS_Axe": 		if (bLeft)Junk.LeftGripStyle = GS_Axe; else Junk.RightGripStyle = GS_Axe; break;
		case "GS_Thin": 	if (bLeft)Junk.LeftGripStyle = GS_Thin; else Junk.RightGripStyle = GS_Thin; break;
		case "GS_Crowbar": 	if (bLeft)Junk.LeftGripStyle = GS_Crowbar; else Junk.RightGripStyle = GS_Crowbar; break;
		case "GS_2x4": 		if (bLeft)Junk.LeftGripStyle = GS_2x4; else Junk.RightGripStyle = GS_2x4; break;
		case "GS_Capacitor":if (bLeft)Junk.LeftGripStyle = GS_Capacitor; else Junk.RightGripStyle = GS_Capacitor; break;
		case "GS_IcePick": 	if (bLeft)Junk.LeftGripStyle = GS_IcePick; else Junk.RightGripStyle = GS_IcePick; break;
		case "GS_DualAverage": 	if (bLeft)Junk.LeftGripStyle = GS_DualAverage; else Junk.RightGripStyle = GS_DualAverage; break;
		case "GS_DualBig": 	if (bLeft)Junk.LeftGripStyle = GS_DualBig; else Junk.RightGripStyle = GS_DualBig; break;
		default:
			for (i=0;i<GripAnims.length;i++)
				Instigator.ClientMessage(getenum(enum'EGripStyle',i));
			return;
	}
	UpdateJunkWeapon(Junk);
}
*/
// End Utils <<<<<<<<<<<<<<<<<
// End Exec Commands ---------------------------------------------------------------------------------------------------

defaultproperties
{
     GripAnims(0)="GripAvg"
     GripAnims(1)="GripLight"
     GripAnims(2)="GripLoose"
     GripAnims(3)="GripThrow"
     GripAnims(4)="GripSwing"
     GripAnims(5)="GripAxe"
     GripAnims(6)="GripLever"
     GripAnims(7)="GripCrowbar"
     GripAnims(8)="Grip2x4"
     GripAnims(9)="GripCap"
     GripAnims(10)="GripIcepick"
     GripAnims(11)="Grip2Avg"
     GripAnims(12)="Grip2Big"
     GripRootBone="Gripper"
     GripRootBone2="Gripper2"
     PutAwayAnims(0)="AvgPutaway"
     PutAwayAnims(1)="LightPutaway"
     PutAwayAnims(2)="HeavyPutaway"
     PutAwayAnims(3)="WidePutaway"
     PutAwayAnims(4)="SwingPutaway"
     PutAwayAnims(5)="ThrowPutaway"
     PutAwayAnims(6)="StabPutaway"
     PutAwayAnims(7)="Avg2Putaway"
     PutAwayAnims(8)="Big2Putaway"
     PutAwayAnims(9)="Poke2Putaway"
     PullOutAnims(0)="AvgPullout"
     PullOutAnims(1)="LightPullout"
     PullOutAnims(2)="HeavyPullout"
     PullOutAnims(3)="WidePullout"
     PullOutAnims(4)="SwingPullout"
     PullOutAnims(5)="ThrowPullout"
     PullOutAnims(6)="StabPullout"
     PullOutAnims(7)="Avg2Pullout"
     PullOutAnims(8)="Big2Pullout"
     PullOutAnims(9)="Poke2Pullout"
     IdleAnims(0)="AvgIdle"
     IdleAnims(1)="LightIdle"
     IdleAnims(2)="HeavyIdle"
     IdleAnims(3)="WideIdle"
     IdleAnims(4)="SwingIdle"
     IdleAnims(5)="ThrowIdle"
     IdleAnims(6)="StabIdle"
     IdleAnims(7)="Avg2Idle"
     IdleAnims(8)="Big2Idle"
     IdleAnims(9)="Poke2Idle"
     TwoHandViewOffset=(X=-9.000000,Y=7.000000,Z=-11.000000)
     OneHandViewOffset=(X=-20.000000,Y=8.000000,Z=-14.000000)
     OneHandMesh=SkeletalMesh'BWBP_JW_Anim.JunkHands'
     TwoHandMesh=SkeletalMesh'BWBP_JW_Anim.DualJunkHands'
     TeamSkins(0)=(RedTex=Shader'BWBP_JW_Tex.Hands.RedHandsShiny',BlueTex=Shader'BWBP_JW_Tex.Hands.BlueHandsShiny')
     BringUpSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Small')
     MagAmmo=1
     bNoMag=True
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bUseSights=False
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BWBP_JWC_Pro.JunkMeleeFire'
     FireModeClass(1)=Class'BWBP_JWC_Pro.JunkRangedFire'
     IdleAnim="AvgIdle"
     SelectAnim="AvgPullout"
     PutDownAnim="AvgPutaway"
     PutDownTime=0.500000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.370000
     CurrentRating=0.370000
     bMeleeWeapon=True
     bNoInstagibReplace=True
     Description="JunkWar Weapons|All manner of junk items that are scattered throughout the arena and can be picked up and used as weapons to kill enemies. These artefacts may range from old beer bottles, rusted piping and discarded building material to industrial tools, kitchenware and electircal weapons."
     Priority=5
     CenteredOffsetY=7.000000
     CenteredRoll=0
     GroupOffset=5
     PickupClass=Class'BWBP_JWC_Pro.JunkWeaponPickup'
     PlayerViewOffset=(X=-20.000000,Y=8.000000,Z=-14.000000)
     AttachmentClass=Class'BWBP_JWC_Pro.JunkWeaponAttachment'
     IconMaterial=Texture'BWBP_JW_Tex.ui.SmallIcon-PC'
     IconCoords=(X2=127,Y2=31)
     ItemName="Junk"
     Mesh=SkeletalMesh'BWBP_JW_Anim.JunkHands'
     DrawScale=0.280000
}
