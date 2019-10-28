//=============================================================================
// HandgunAttachment.
//
// A special attachment class for dual weapons. Master works as normal. The
// slave is attached to the left hand and needs special rotation, location and
// other tweaks.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HandgunAttachment extends BallisticAttachment;

var   BallisticHandgun		HandGun;		// The first person Handgun (only on server)
var() bool					bIsSlave;		// It's the slave (sent to clients)
var() vector				SlaveOffset;	// RelativeLocation if slave
var() rotator				SlavePivot;		// RelativeRotation if slave
var   float					SlaveAlpha;		// A counter for slave firing 'animation'
var   HandgunAttachment		OtherGun;		// The other gun's thirdpersonactor...

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		bIsSlave, OtherGun;
}

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( OtherGun != None  && !bIsSlave && OtherGun.bIsSlave)
		OtherGun.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);

	if (OtherGun != None && !bIsSlave)
		OtherGun.Hide(NewbHidden);
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (HandGun != None)
			C = HandGun.GetBoneCoords('tip');
		else
			C = Instigator.Weapon.GetBoneCoords('tip');
	}
	else
		C = GetBoneCoords('tip');
	if (Instigator != None && VSize(C.Origin - Instigator.Location) > 200)
		return Instigator.Location;
    return C.Origin;
}

simulated function Destroyed()
{
	if (bIsSlave && Instigator != None)
	{
		Instigator.SetBoneDirection(AttachmentBone, Rotation,, 0, 0);
		Instigator.SetBoneDirection('lfarm', Rotation,, 0, 0);
	}
    Super.Destroyed();
}
simulated function FlashMuzzleFlash(byte Mode)
{
	super.FlashMuzzleFlash (Mode);
	if (bIsSlave)
		SlaveAlpha = 1.0;
}
simulated function FlashWeaponLight(byte Mode)
{
	if (LightMode == MU_None || (LightMode == MU_Secondary && Mode == 0) || (LightMode == MU_Primary && Mode != 0))
		return;
	if (Instigator == None || Level.bDropDetail || ((Level.TimeSeconds - LastRenderTime > 0.2) && (PlayerController(Instigator.Controller) == None)))
	{
//		Timer();
		return;
	}
	if (HandGun != None)
		LightWeapon = HandGun;
	else
		LightWeapon = self;

	LightWeapon.bDynamicLight = true;
	SetTimer(WeaponLightTime, false);
}

simulated function Tick(float DT)
{
	local rotator newRot;

	// Poiint arm and slave in pawn view direction
	if (Instigator != None && bIsSlave)
	{
		newRot = Instigator.Rotation;
		// Pitch arm up to make a slave firing anim
		if (SlaveAlpha > 0)
		{
			if (SlaveAlpha >= 0.75)
				newRot.Pitch += 7000 * (1-SlaveAlpha) * 4;
			else
				newRot.Pitch += 7000 * SlaveAlpha * 1.333;
			SlaveAlpha = FMax(0, SlaveAlpha - DT);
		}
		Instigator.SetBoneDirection('lfarm', newRot,, 1.0, 1);

		newRot.Roll += 32768;
		Instigator.SetBoneDirection(AttachmentBone, newRot,, 1.0, 1);
	}
}

simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (Role < ROLE_Authority && bIsSlave)
	{
		if (Instigator!= None && Instigator.Weapon != None && BallisticHandgun(Instigator.Weapon) != None && BallisticHandgun(Instigator.Weapon).OtherGun != None)
			Handgun = BallisticHandgun(Instigator.Weapon).OtherGun;
		SetRelativeRotation(SlavePivot);
		SetRelativeLocation(SlaveOffset);
	}
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticHandgun(I) != None)
	{
		Handgun = BallisticHandgun(I);
		if (Handgun.IsSlave())
		{
			bIsSlave = true;
			SetRelativeRotation(SlavePivot);
			SetRelativeLocation(SlaveOffset);
		}
		else
		{
			bIsSlave = false;
			SetRelativeRotation(default.RelativeRotation);
			SetRelativeLocation(default.RelativeLocation);
		}
	}
}

defaultproperties
{
     SlaveOffset=(X=17.000000,Y=-7.000000,Z=-7.000000)
     SlavePivot=(Yaw=32768)
     IdleHeavyAnim="PistolHip_Idle"
     IdleRifleAnim="PistolAimed_Idle"
     SingleFireAnim="PistolHip_Fire"
     SingleAimedFireAnim="PistolAimed_Fire"
     RapidFireAnim="PistolHip_Burst"
     RapidAimedFireAnim="PistolAimed_Burst"
}
