//=============================================================================
// FP9Explosive.
//
// FP9A5 Radio Detonated Plasic Explosive with Laser Motion Detonator.
// PrimaryFire Deploys a bomb on the wall or throws it if there is no wall.
// Aiming at a bomb will cause it to become the ChosenBomb.
// ChosenBomb is highlighted on the HUD and an index number is displayed.
// SecondaryFire detonates ChosenBomb or all of them if there is no ChosenBomb.
// Lasers cause Bombs to detonate if something moves through the beam.
// WeaponSpecial activates LaserMode so next bombs are deployed with laser on.
// WeaponSpecial will toggle an individual bombs laser if it is the ChosenBomb.
// Using a deployed or thrown bomb will pick it up.
// Bombs will explode when damaged
// The last bomb deployed will be set to be the SelectedBomb. A bomb can also
// be Selected by looking at it to make it the ChosenBomb, then pressing the
// SwitchWeaponMode key. Once a bomb is selected, the SwitchWeaponMode function
// can be used to aim its laser wherever you are pointing. It will then be
// deselected. If the laser could not be aimed at the new point, it will not
// move and remain selected. If anotehr bomb is chosen and the laser for the
// currently selected bomb could not be reaimed, then the chosenbomb will
// become selected instead.
//
// New feature:
// Pickup up FP9 bombs become an FP9 weapon with no detonator.
// You can still:
// - Place bomb
// - Throw bomb
// - Change a held bombs laser mine mode
// - Shoot your placed bombs...
// You can't:
// - Remote detonate any bombs
// - Remote toggle laser mode of placed/thrown bombs
// - Adjust laser aim of placed/thrown bombs
// - See any handy extra FP9 HUD elements
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP9Explosive extends BallisticWeapon;

#exec OBJ LOAD FILE=BallisticUI2.utx

var   bool				bLaserMode;			// Deploy bombs with Laser on?
var   Array<FP9Bomb>	Bombs;				// List of all bombs dropped or deployed
var   FP9Bomb			ChosenBomb;			// Bomb currently targeted for individual detonation
var   byte				ChosenBombindex;	// Index of ChosenBomb
var   float				LastAIPickBombTime; // Last time AI picked a bomb to detoante
var() BUtil.FullSound	LaserTweakSound;	// Sound when anim tweak laser lens
var() BUtil.FullSound	Button1Sound;		// Sound when anim pushes button
var() BUtil.FullSound	Button2Sound;		// Sound when anim pushes button
var() BUtil.FullSound	Button3Sound;		// Sound when anim pushes button
var() BUtil.FullSound	DeploySound;		// Sound when bomb gets stuck on wall
var() name				LaserOnAnim;		// Anim for laser mode on
var() name				LaserOffAnim;		// Anim for laser mode off
var() name				BombBone;			// Name of root bomb bone
var() name				HandBone;			// Name of left hand root bone
var   bool				bOutOfBombs;		// Has no ammo, only showing detonator
var() Sound				DetonateSound;		// Sound when detoanter is used
var() Material			LaserScreenMat;		// Material to put on screen when in laser mode
var() Material			ScreenMat;			// Normal screen material
var   FP9Bomb			SelectedBomb;		// Laser Bomb currently selected for aiming
var   float				DetAllStartTime;	// Time when started holding down the DetonateAll key.
var() float				DetAllDelayTime;	// DetonateAll key must be held fown for this long. Safety Device...

var   bool				bHasDetonator;		// Does this weapona ctually have the detonater or is it just a picked up bomd?
var   bool				bOldHasDetonator;	// Had a detonated last tick?
var() name				DetHandBone;		// Bone name of detonator arm

replication
{
	// Things the client should send to the server.
	reliable if(Role<ROLE_Authority)
		ServerSetLaserMode, ServerSwitchBombLaser;
	reliable if(Role==ROLE_Authority)
		ChosenBomb, ChosenBombIndex, SelectedBomb, bHasDetonator;
}

// FP9Detonator = Det Bone
// Bone-Arm		= Right arm bone
// 0.13			= LaserOnAnim start with no detonator precent
// 0.14			= LaserOffAnim start with no detonator precent
// 0.9			= LaserOffAnim start precent for detonator bring up

// Notify_FP9LaserOnHandDown  = Hand down notify for laser On Anim
// Notify_FP9LaserOffHandDown = Hand down notify for laser Off Anim

// Add old bombs to list
function GiveTo( pawn Other, optional Pickup Pickup )
{
	local FP9Bomb E;
	local Actor A;

	super.GiveTo(Other, Pickup);

	ForEach DynamicActors(class'Actor',A)
	{
		if (FP9Bomb(A) == None)
			continue;
		E = FP9Bomb(A);
		if (E.InstigatorController != None && E.InstigatorController == Instigator.Controller)
		{
			Bombs[Bombs.length] = E;
			E.Instigator = Instigator;
		}
	}
	bHasDetonator = true;
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (!bHasDetonator)
		return;
	if (SelectedBomb != None)
		ShiftBombLaser();
	else if (ChosenBomb != None)
		SelectedBomb = ChosenBomb;
}

simulated function ShiftBombLaser ()
{
	local Actor T;
	local vector HitLoc, HitNorm, Start, End;

	if (!bHasDetonator)
		return;

	if (SelectedBomb != None)
	{
		Start = Instigator.Location + Instigator.EyePosition();
		End = Start + Vector(Instigator.GetViewRotation()) * 5000;
		T = Trace(HitLoc, HitNorm, End, Start, true);
		if (T == SelectedBomb)
		{
			SelectedBomb = None;
			return;
		}
		if (Vector(SelectedBomb.Rotation) Dot Normal(HitLoc - SelectedBomb.Location) > 0.4 && FastTrace(HitLoc, SelectedBomb.Location))
		{
			SelectedBomb.OldLaserRange = -1;
			SelectedBomb.SetLaserDir(Rotator(HitLoc - SelectedBomb.Location));
			SelectedBomb = None;
		}
		else if (ChosenBomb != None)
		{
			if (ChosenBomb == SelectedBomb)
				SelectedBomb = None;
			else
				SelectedBomb = ChosenBomb;
		}
	}
}

function ServerSetLaserMode(bool bNewValue)
{
	bLaserMode = bNewValue;
}
function ServerSwitchBombLaser()
{
	if (ChosenBomb != None && bHasDetonator)
		ChosenBomb.ToggleLaserMode();
}

exec simulated function WeaponSpecial(optional byte i)
{
 	if (AmmoAmount(0) > 0)
		SetBoneScale (0, 1.0, BombBone);
	/*
	if (ChosenBomb == None && AmmoAmount(0) > 0)
	{
		SetBoneScale (1, 1.0, DetHandBone);
		if (!bLaserMode)
		{
			PlayAnim(LaserOnAnim, 1.0, 0.1);
			if (!bHasDetonator)
				SetAnimFrame(0.13);
		}
		else
		{
			PlayAnim(LaserOffAnim, 1.0, 0.1);
			if (!bHasDetonator)
				SetAnimFrame(0.14);
		}
	}
	else if (bHasDetonator)
		ServerSwitchBombLaser();
	*/
}

exec simulated function Reload (optional byte i)
{
	if (!bHasDetonator)
		return;
	ServerStartReload(i);
	if (level.NetMode == NM_Client)
		DetAllStartTime = Level.TimeSeconds;
}
function ServerStartReload(optional byte i)
{
	if (!bHasDetonator)
		return;
	DetAllStartTime = Level.TimeSeconds;
}
exec simulated function ReloadRelease (optional byte i)
{
	if (!bHasDetonator)
		return;
	ServerReloadRelease(i);
	if (level.NetMode == NM_Client)
		CommonReloadRelease(i);
}
function ServerReloadRelease(optional byte i)
{
	if (!bHasDetonator)
		return;
	CommonReloadRelease(i);
}
simulated function CommonReloadRelease(optional byte i)
{
 	if (AIController(Instigator.Controller) == None && Level.TimeSeconds - DetAllStartTime > DetAllDelayTime)
		Detonate(true);
	DetAllStartTime = 0;
}

// Detonate chosen bomb, or all of them if none
simulated function Detonate(optional bool bAll)
{
	local int i;
	local array<int> DetonatedBombs;

	if (!bHasDetonator)
		return;
 	if (AmmoAmount(0) > 0)
		SetBoneScale (0, 1.0, BombBone);
	PlayAnim('Fire');
    if (Instigator.IsLocallyControlled())
		PlaySound(DetonateSound,,0.5);

	if (Role < ROLE_Authority)
		return;
	if (bAll)
	{
		for (i=0;i<Bombs.length;i++)
		{
			if (Bombs[i] != None && Level.TimeSeconds >= Bombs[i].DetonateTime)
			{
				Bombs[i].Detonate();
				DetonatedBombs[DetonatedBombs.length]=i;
			}
		}
		for(i=DetonatedBombs.length-1; i > -1; i--)
			Bombs.Remove(DetonatedBombs[i],1);
	}
	else if (ChosenBomb != None && Level.TimeSeconds >= ChosenBomb.DetonateTime)
	{
		ChosenBomb.Detonate();
		for (i=0;i<Bombs.length;i++)
			if (Bombs[i] != None)
				break;
		if (i >= Bombs.length)
			Bombs.length = 0;

	}
}

function AddBomb (FP9Bomb Bomb)
{
	Bombs[Bombs.length] = Bomb;
//	if (Bomb.bDeployed)
		SelectedBomb = Bomb;
}

simulated function Notify_FP9LaserOnHandDown()
{
	if (!bHasDetonator)
	{
		AnimEnd(0);
		SetBoneScale (1, 0.0, DetHandBone);
		SetBoneScale (2, 0.0, 'FP9Detonator');
	}
}

simulated function Notify_FP9LaserOffHandDown()
{
	if (!bHasDetonator)
	{
		AnimEnd(0);
		SetBoneScale (1, 0.0, DetHandBone);
		SetBoneScale (2, 0.0, 'FP9Detonator');
	}
}

simulated function Notify_FP9Button1()
{
    class'BUtil'.static.PlayFullSound(self, Button1Sound);
}
simulated function Notify_FP9Button2()
{
    if (!Instigator.IsLocallyControlled())
    	return;
    class'BUtil'.static.PlayFullSound(self, Button2Sound);
    Skins[2] = LaserScreenMat;
	if (Level.NetMode == NM_Client)
		bLaserMode = true;
	ServerSetLaserMode(true);
}
simulated function Notify_FP9Button3()
{
    if (!Instigator.IsLocallyControlled())
    	return;
    class'BUtil'.static.PlayFullSound(self, Button3Sound);
    Skins[2] = ScreenMat;
	if (Level.NetMode == NM_Client)
		bLaserMode = false;
	ServerSetLaserMode(false);
}
simulated function Notify_FP9LaserFiddle()
{
    class'BUtil'.static.PlayFullSound(self, LaserTweakSound);
}
simulated function Notify_FP9Thrown()
{
	SetBoneScale (0, 0.0, BombBone);
}
simulated function Notify_FP9Deploy()
{
	SetBoneScale (0, 0.0, BombBone);
    class'BUtil'.static.PlayFullSound(self, DeploySound);
}
simulated function Notify_FP9HandDown()
{
	if (AmmoAmount(0) > 0)
		SetBoneScale (0, 1.0, BombBone);
	else
	{
//		SetBoneScale (0, 0.0, HandBone);
		bOutOfBombs=true;
	}
}
simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (bHasDetonator)
	{
		SetBoneScale (1, 1.0, DetHandBone);
		SetBoneScale (2, 1.0, 'FP9Detonator');
	}
	else
	{
		SetBoneScale (1, 0.0, DetHandBone);
		SetBoneScale (2, 0.0, 'FP9Detonator');
	}

	if (AmmoAmount(0) < 1)
	{
//		SetBoneScale (0, 0.0, HandBone);
		bOutOfBombs=true;
	}
	if (bLaserMode)
	    Skins[2] = LaserScreenMat;
	else
	    Skins[2] = ScreenMat;
}

function AIPickBomb()
{
	local Bot B;
	local float Best;
	local Controller C;
	local int i;

	B = Bot(Instigator.Controller);
	if (B == None)
		return;

	if (Level.TimeSeconds > LastAIPickBombTime + 2.0)
		ChosenBomb = None;

	if (Bombs.Length > 0)
	{
		Best = 500 - 28 * B.Skill;
		for (i=0;i<Bombs.length;i++)
			if (Bombs[i] != None && !Bombs[i].bDetonate && !Bombs[i].bDamaged)
				for (C=Level.ControllerList;C!=None;C=C.NextController)
					if (C != None && C.Pawn != None && !Instigator.Controller.SameTeamAs(C) && VSize(C.Pawn.Location - Bombs[i].Location) < Best
					 && (VSize(Instigator.Location - Bombs[i].Location) > 300 || B.Skill <= Rand(7)) && Instigator.Controller.CanSee(C.Pawn) )
					 {
					 	Best = VSize(C.Pawn.Location - Bombs[i].Location);
					 	ChosenBomb = Bombs[i];
						LastAIPickBombTime = Level.TimeSeconds;
					 	if (B.Enemy != None && C.Pawn == B.Enemy)
					 		Best *= 0.5;
					 }
	}
}
simulated event Tick(float DT)
{
	super.Tick(DT);

 	if (Instigator != None && AIController(Instigator.Controller) != None)
		AIPickBomb();
}

// Pick the chosen bomb
simulated event WeaponTick(float DT)
{
	local int i, Best;
	local float BestDot, ThisDot;

	super.WeaponTick(DT);

 	if (AIController(Instigator.Controller) != None)
 		return;

 	if (AmmoAmount(0) > 0 && bOutOfBombs)
	{
//		SetBoneScale (0, 1.0, HandBone);
		SetBoneScale (0, 1.0, BombBone);
		bOutOfBombs = false;
		if (ClientState == WS_ReadyToFire)
		{
			PlayAnim('Place');
			SetAnimFrame(0.659);
		}
	}

	if (bHasDetonator)
	{
		if (!bOldHasDetonator)
		{
			SetBoneScale (1, 1.0, DetHandBone);
			SetBoneScale (2, 1.0, 'FP9Detonator');
			if (ClientState == WS_ReadyToFire)
			{
				PlayAnim(LaserOffAnim);
				SetAnimFrame(0.9);
			}
			bOldHasDetonator=true;
		}
	}
	else
		bOldHasDetonator=false;

	if (Role < ROLE_Authority)
		return;

	for (i=0;i<Bombs.length;i++)
	{
		if (Bombs[i] != None && Bombs[i].StartDelay == 0)
		{
			ThisDot = Normal(Bombs[i].Location - (Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation());
			if (ThisDot > 0.98 && ThisDot > BestDot)
			{
				Best = i;
				BestDot = ThisDot;
			}
		}
	}
	if (BestDot < 0.98)
	{
		ChosenBombIndex = 0;
		ChosenBomb = None;
	}
	else if (ChosenBombIndex != Best+1)
	{
		ChosenBombIndex = Best+1;
		ChosenBomb = Bombs[Best];
	}
}

// Draw box to show chosen bomb
simulated event RenderOverlays (Canvas C)
{
	local Vector V, V2, X, Y, Z;
	local float ScaleFactor, XL, YL;

	Super.RenderOverlays(C);

	if (ChosenBomb == None && SelectedBomb == None)
		return;
	if (!bHasDetonator)
		return;

	ScaleFactor = C.ClipX / 1600;
	GetViewAxes(X, Y, Z);
	// Draw Box to show chosen bomb
	if (ChosenBomb != None)
	{
		V  = C.WorldToScreen(ChosenBomb.Location - Y*ChosenBomb.CollisionRadius + Z*ChosenBomb.CollisionHeight);
		C.SetPos(V.X-16*ScaleFactor, V.Y-16*ScaleFactor);
		V2 = C.WorldToScreen(ChosenBomb.Location + Y*ChosenBomb.CollisionRadius - Z*ChosenBomb.CollisionHeight);
		C.SetDrawColor(255,255,255,255);
		C.DrawTileStretched(Texture'BallisticUI2.G5.G5Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);
		// Draw number to indicate which bomb it is
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.StrLen(ChosenBombIndex, XL, YL);
		C.SetPos(V.X + (V2.X-V.X)/2 - XL/2, V.Y + (V2.Y-V.Y)/2 - YL/2);
		if((Level.NetMode != NM_Client && ChosenBomb.bLaserMode) || ChosenBomb.bNetLaserOn)
			C.SetDrawColor(64,255,192,255);
		else
			C.SetDrawColor(255,192,0,255);
		C.DrawText(ChosenBombIndex);
	}
	if (SelectedBomb != None && SelectedBomb.StartDelay == 0 && Normal(SelectedBomb.Location - Instigator.Location) Dot Vector(Instigator.GetViewRotation()) > 0.4)
	{
		V  = C.WorldToScreen(SelectedBomb.Location - Y*SelectedBomb.CollisionRadius + Z*SelectedBomb.CollisionHeight);
		C.SetPos(V.X-32*ScaleFactor, V.Y-32*ScaleFactor);
		V2 = C.WorldToScreen(SelectedBomb.Location + Y*SelectedBomb.CollisionRadius - Z*SelectedBomb.CollisionHeight);
		C.SetDrawColor(0,255,0,255);
		C.DrawTile(Texture'BallisticUI2.Crosshairs.M50Out', (V2.X - V.X) + 64*ScaleFactor, (V2.Y - V.Y) + 64*ScaleFactor, 0, 0, 128, 128);
	}
}

// Charging bar shows throw strength
simulated function float ChargeBar()
{
	if (DetAllStartTime > 0)
		return FMin(level.TimeSeconds-DetAllStartTime, 1) / DetAllDelayTime;

	return FClamp(FireMode[0].HoldTime - 0.3,  0, 1) / 1;
}

simulated function bool HasAmmo()
{
	return true;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{

	if (AmmoAmount(0) < 1 || ChosenBomb != None)
		return 1;
/*	if (Bombs.Length > 0)
	{
		for (i=0;i<Bombs.length;i++)
			if (Bombs[i] != None && !Bombs[i].bDetonate && !Bombs[i].bDamaged)
				for (C=Level.ControllerList;C!=None;C=C.NextController)
					if (C != None && C.Pawn != None && !Instigator.Controller.SameTeamAs(C) && VSize(C.Pawn.Location - Bombs[i].Location) < 300)
					 	return 1;
	}
*/	return 0;
}
// Bots like this weapon if
// They have no enemy or enemy is far away or
// They have bombs deployed and
// a bomb is near an enemy
// and the bomb is not near themselves.
// A deployed bomb is even better if the current enemy is near it
function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if (B == None)
		return Super.GetAIRating();

	if (B.Enemy != None)
	{
		Dir = B.Enemy.Location - Instigator.Location;
		Dist = VSize(Dir);
	}
	if (ChosenBomb != None)
	{
		Result = 1.0;
	 	if (B.Enemy != None && VSize(B.Enemy.Location - ChosenBomb.Location) < 300)
	 		Result = 2.0;
	}
/*	Best = 300;
	if (Bombs.Length > 0 && B.Skill >= Rand(5))
	{
		for (i=0;i<Bombs.length;i++)
			if (Bombs[i] != None && !Bombs[i].bDetonate && !Bombs[i].bDamaged)
				for (C=Level.ControllerList;C!=None;C=C.NextController)
					if (C != None && C.Pawn != None && !Instigator.Controller.SameTeamAs(C) && VSize(C.Pawn.Location - Bombs[i].Location) < Best
					 && (VSize(Instigator.Location - Bombs[i].Location) > 300 || B.Skill <= Rand(7)) )
					 {
					 	Best = VSize(C.Pawn.Location - Bombs[i].Location);
					 	ChosenBomb = Bombs[i];
					 	Result = 1.0;
					 	if (B.Enemy != None && C.Pawn == B.Enemy)
					 	{
					 		Result *= 2.0;
					 		Best *= 0.5;
					 	}
					 }
	}
*/	else
	{
		if (AmmoAmount(0) < 1)
			return 0;
		if (B.Enemy == None)
			Result = 1.0;
		else if (Dist > 1000)
			Result = 0.4 - 0.3 * (Dist/1000-1);
		else
			Result = Super.GetAIRating();
	}
	if (Dist < 300 && B.Skill > Rand(7))
		Result *= 0.5;

	return Result;
}
function bool CanAttack(Actor Other)
{
	local Bot B;
	if (ChosenBomb != None)
		return true;
	if (AmmoAmount(0) > 0)
	{
		B = Bot(Instigator.Controller);
		if (B != None && B.Enemy != None)
		{
			if (VSize(Instigator.Location - B.Enemy.Location) < 1000)
				return true;
			return FRand() > 0.5;
		}
		return FRand() > 0.8;
	}
	return false;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	If (ChosenBomb == None && FRand() > 0.6) return 0.7; return -1.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
	LaserTweakSound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-LaserTurn',Volume=0.500000,Radius=48.000000,Pitch=1.000000)
	Button1Sound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-Button1',Volume=0.500000,Radius=48.000000,Pitch=1.000000)
	Button2Sound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-Button2',Volume=0.500000,Radius=48.000000,Pitch=1.000000)
	Button3Sound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-Button3',Volume=0.500000,Radius=48.000000,Pitch=1.000000)
	DeploySound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-Place',Volume=1.000000,Radius=256.000000,Pitch=1.000000)
	LaserOnAnim="LaserOn"
	LaserOffAnim="LaserOff"
	BombBone="FP9Bomb"
	HandBone="LeftHand"
	DetonateSound=Sound'BallisticSounds2.FP9A5.FP9-Detonate'
	LaserScreenMat=Shader'BallisticWeapons2.FP9A5.FP9LCDActiveSD'
	ScreenMat=Shader'BallisticWeapons2.FP9A5.FP9LCDArmedSD'
	DetAllDelayTime=0.300000
	bHasDetonator=True
	bOldHasDetonator=True
	DetHandBone="Bone-Arm"
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_FP9A5'
	BigIconCoords=(Y1=24,Y2=235)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	InventorySize=2
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Grenade=True
	bWT_Trap=True
	ManualLines(0)="Places an FP9 explosive device. If used close to a wall or surface, the weapon will attach itself to the surface: otherwise the bomb falls to the floor. If the laser tripmine is activated, enemies walking into the beam will set off the bomb. If not, the user must detonate the bomb manually by facing it and using the altfire. Bombs may be picked up with the Use key."
	ManualLines(1)="Detonates the FP9. The user must be facing the mine to detonate, which will be displayed surrounded by a red box."
	ManualLines(2)="The FP9 has a number of special functions.||When not facing a placed bomb:|The Weapon Function key toggles whether the next bomb placed will use the laser tripwire.||When facing a placed bomb:|The Weapon Function key toggles whether the placed bomb will use the laser tripwire.|The Switch Fire Mode key selects the faced bomb, highlighting it in green.||With a bomb highlighted:|Targeting an area and pressing Switch Weapon Mode will cause the endpoint of the selected bomb's laser, if active, to shift to the targeted location."
	SpecialInfo(0)=(Info="180.0;10.0;0.4;-1.0;0.0;0.0;0.5")
	BringUpSound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-Pullout')
	PutDownSound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-Putaway')
	bNoMag=True
	WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bUseSights=False
	GunLength=0.000000
	bAimDisabled=True

	Begin Object Class=RecoilParams Name=UniversalRecoilParams
		PitchFactor=0.000000
		YawFactor=0.000000
	End Object
	RecoilParamsList(0)=RecoilParams'UniversalRecoilParams'

	Begin Object Class=AimParams Name=UniversalAimParams
	End Object
	AimParamsList(0)=AimParams'UniversalAimParams'

	FireModeClass(0)=Class'BallisticProV55.FP9PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.FP9SecondaryFire'
	PutDownTime=0.700000
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.200000
	CurrentRating=0.200000
	bShowChargingBar=True
	Description="NDTR's versatile FP9 is a favourite UTC weapon of high quality and extensive use. The FP9A5 greatly enhances the standard explosive by incorporating many tactical features to make it an incredibly versatile bomb. The soldier can deploy or toss the device, and wait to manually detonate it by means of a radio frequency controller, or activate the laser feature, and wait for an unsuspecting foe to walk into the beam. As well as this, the latest model now has the ability to activate the laser mode when the bomb is already deployed, making it even more effective. This allows the user to deactivate the beam, pick it up, and place it elsewhere, or merely to allow oneself to walk past the device without incident."
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=0
	GroupOffset=18
	PickupClass=Class'BallisticProV55.FP9Pickup'
	PlayerViewOffset=(X=10.000000,Y=-1.000000,Z=-6.000000)
	AttachmentClass=Class'BallisticProV55.FP9Attachment'
	IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_FP9Explosive'
	IconCoords=(X2=127,Y2=31)
	ItemName="FP9A5 Explosive Device"
	Mesh=SkeletalMesh'BallisticAnims2.FP9Bomb'
	DrawScale=0.200000
	Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	Skins(1)=Texture'BallisticWeapons2.FP9A5.FP9Bomb'
}
