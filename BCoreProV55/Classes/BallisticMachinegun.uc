//=============================================================================
// BallisticMachinegun.
//
// A base class for standard sort of machinegun weapons that have a belt in a
// box for ammo.
// Once upon a time this was host to the old stand mode system used by MGs...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticMachinegun extends BallisticWeapon abstract;

/*
	ReloadStart:		Open, ClipOut, BoxOff
	ReloadStartFew:		Open, BoxOff, ClipOut
	ReloadStartNone:	Open
	ReloadStartShell:	Open, ClipOut
	ReloadStartBox:		Open, BoxOff
	ReloadFinish:		BoxOn, ClipIn, Close
	ReloadFinishFew:	ClipIn Close
*/

var() Array<name>		BeltBones;		// List of the names of all the bullets
var() int				BeltLength;		// Number of bullets outside of belt(including hidden one in chamber)
var() name				BoxBone;		// Name of the ammo box bone
var   bool				bNoBox;			// Is the Ammo box not being used currently
var() BUtil.FullSound	BoxOnSound;		// Sound to play when box clips on
var() BUtil.FullSound	BoxOffSound;	// Sound to play when box comes off
var() BUtil.FullSound	FlapUpSound;	// Sound to play when cover opens
var() BUtil.FullSound	FlapDownSound;	// Sound to play when cover closes
var() Sound				HandleOnSound;	//
var() Sound				HandleOffSound;	//

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	SetBeltVisibility(MagAmmo);
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Channel == 0 && (ReloadState == RS_PreClipIn || ReloadState == RS_PreClipOut))
	{
		PlayReloadFinish();
		return;
	}
	else if (anim == FireMode[0].FireAnim || anim == BFireMode[0].AimedFireAnim)
		SetBeltVisibility(MagAmmo);
	Super(BallisticWeapon).AnimEnd(Channel);
}

// Play different reload starting anims depending on the situation
simulated function PlayReload()
{
	if (bNoBox)
	{
		if (MagAmmo < 2)		// No Box, No Belt
			PlayAnim('ReloadStartNone', ReloadAnimRate, , 0.25);
		else					// No Box, Belt present
			PlayAnim('ReloadStartShell', ReloadAnimRate, , 0.25);
	}
	else
	{
		if (MagAmmo < 2)		// Box Present, No Belt
			PlayAnim('ReloadStartBox', ReloadAnimRate, , 0.25);
		else if (MagAmmo < 12)	// Box Present, Belt too short to be attached to Box
			PlayAnim('ReloadStartFew', ReloadAnimRate, , 0.25);
		else					// Box and Belt Present and attached
			PlayAnim('ReloadStart', ReloadAnimRate, , 0.25);
	}
}
// Play second half of reload anim. It will be different depending on how many bullets are being loaded
simulated function PlayReloadFinish()
{
	SetBoxVisibility();
	SetBeltVisibility(Ammo[0].AmmoAmount+MagAmmo+1);
	if (Ammo[0].AmmoAmount+MagAmmo < BeltLength+1)// Belt with no Box
		PlayAnim('ReloadFinishFew', ReloadAnimRate, ,0.0);
	else						// Full Box and Belt
		PlayAnim('ReloadFinish', ReloadAnimRate, ,0.0);
}
// Remove tween when playing idle
simulated function PlayIdle()
{
	IdleAnim = default.IdleAnim;
	Super.PlayIdle();
}

//Hides the ammo box if needed
simulated function SetBoxVisibility()
{
	bNoBox = (Ammo[0].AmmoAmount+MagAmmo < BeltLength+1);
	if (bNoBox)
		SetBoneScale(1, 0.0, BoxBone);
	else
		SetBoneScale(1, 1.0, BoxBone);
}

// Hides bullets on the visible belt
simulated function SetBeltVisibility(int Amount)
{
	if (Amount < BeltLength)
		SetBoneScale(0, 0.0, BeltBones[Max(0,Amount-1)]);
	else
		SetBoneScale(0, 1.0, BeltBones[0]);
}
simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

// Run to give hand opportinity to go to stand mode handle instead of playing to end of normal reload anim
simulated function Notify_M353GoToHandle()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
}

simulated function Notify_CockGoToHandle()
{
}
// Run when cover is opened
simulated function Notify_M353Open()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(FlapUpSound.Sound,FlapUpSound.Slot,FlapUpSound.Volume,FlapUpSound.bNoOverride,FlapUpSound.Radius,FlapUpSound.Pitch,FlapUpSound.bAtten);
	else
	    class'BUtil'.static.PlayFullSound(self, FlapUpSound);
}
// Run when cover is closed
simulated function Notify_M353Close()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(FlapDownSound.Sound,FlapDownSound.Slot,FlapDownSound.Volume,FlapDownSound.bNoOverride,FlapDownSound.Radius,FlapDownSound.Pitch,FlapDownSound.bAtten);
	else
		class'BUtil'.static.PlayFullSound(self, FlapDownSound);
}
// Run ammo Box is pulled off
simulated function Notify_M353BoxOff()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(BoxOffSound.Sound,BoxOffSound.Slot,BoxOffSound.Volume,BoxOffSound.bNoOverride,BoxOffSound.Radius,BoxOffSound.Pitch,BoxOffSound.bAtten);
	else
		class'BUtil'.static.PlayFullSound(self, BoxOffSound);
}
// Run when ammo box is clipped on
simulated function Notify_M353BoxOn()
{
	if (Level.NetMode != NM_Client)
		PlayOwnedSound(BoxOnSound.Sound,BoxOnSound.Slot,BoxOnSound.Volume,BoxOnSound.bNoOverride,BoxOnSound.Radius,BoxOnSound.Pitch,BoxOnSound.bAtten);
	else
		class'BUtil'.static.PlayFullSound(self, BoxOnSound);
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	return 0;
}
function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super(BallisticWeapon).GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super(BallisticWeapon).GetAIRating();
	if (Dist > 1000)
		Result -= (Dist-1000) / 3000;
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.2;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.4;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
     BeltBones(0)="Bullet1"
     BeltBones(1)="Bullet2"
     BeltBones(2)="Bullet3"
     BeltBones(3)="Bullet4"
     BeltBones(4)="Bullet5"
     BeltBones(5)="Bullet6"
     BeltBones(6)="Bullet7"
     BeltBones(7)="Bullet8"
     BeltBones(8)="Bullet9"
     BeltBones(9)="Bullet10"
     BeltLength=11
     BoxBone="AmmoBox"
     BoxOnSound=(Volume=0.500000,Radius=24.000000,Pitch=1.000000,bAtten=True)
     BoxOffSound=(Volume=0.500000,Radius=24.000000,Pitch=1.000000,bAtten=True)
     FlapUpSound=(Volume=0.500000,Radius=24.000000,Pitch=1.000000,bAtten=True)
     FlapDownSound=(Volume=0.500000,Radius=24.000000,Pitch=1.000000,bAtten=True)
     IdleTweenTime=0.000000
}
