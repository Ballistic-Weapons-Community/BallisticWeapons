//=============================================================================
// RiotAttachment
//
// Attachment for the riot shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticShieldAttachment extends BallisticMeleeAttachment;

var Actor ShieldWeapon;

// The police and junk layouts' models on the hand bones. They are not built the way the riot shield and its hammer are
var() vector	PoliceShieldLocation, JunkShieldLocation;
var() rotator	JunkShieldRotation;
var() rotator	ClubRotation;		// the truncheon and the club in the fist

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Instigator != None)
	{
		ShieldWeapon = Spawn(class'BallisticShieldHammer');
		Instigator.AttachToBone(ShieldWeapon,'righthand');
		SetShieldWeaponMesh();
	}
}

simulated function ApplyModel()
{
	Super.ApplyModel();

	SetShieldWeaponMesh();
}

// The police shield comes with a truncheon and the junk shield with a club, and both sit in the hands their own way.
// The server gets here before the shield is on its bone; the offsets hold because AttachmentBone is set from the start
simulated function SetShieldWeaponMesh()
{
	local Mesh HandMesh;

	if (Mesh == class'JWRiotShieldAttachment'.default.Mesh)
	{
		HandMesh = class'JWRiotShieldTruncheon'.default.Mesh;
		SetRelativeLocation(PoliceShieldLocation);
	}
	else if (Mesh == class'JWJunkShieldAttachment'.default.Mesh)
	{
		HandMesh = class'JWJunkShieldBoard'.default.Mesh;
		SetRelativeLocation(JunkShieldLocation);
		SetRelativeRotation(JunkShieldRotation);
	}
	else
		return;

	if (ShieldWeapon != None)
	{
		ShieldWeapon.LinkMesh(HandMesh);
		ShieldWeapon.SetRelativeRotation(ClubRotation);
	}
}

simulated function Destroyed()
{
	if (ShieldWeapon != None)
		ShieldWeapon.Destroy();

	super.Destroyed();
}

defaultproperties
{
	PoliceShieldLocation=(X=-10.000000,Y=10.000000)
	JunkShieldLocation=(X=-10.000000,Y=12.000000)
	JunkShieldRotation=(Yaw=32768,Roll=-8616)
	ClubRotation=(Roll=32768,Yaw=-16384)
	WeaponClass=class'BallisticShieldWeapon'
	ImpactManager=class'IM_GunHit'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_None
	LightMode=MU_None
	TrackAnimMode=MU_Both
	AttachmentBone="bip01 l hand"	 
	Mesh=SkeletalMesh'BWBP_OP_Anim.BallisticShield_TPm'
	RelativeLocation=(X=-10.000000)
	RelativeRotation=(Yaw=-16384,Pitch=25000)
	DrawScale=0.450000
	IdleHeavyAnim="Blade_Idle"
	IdleRifleAnim="Blade_Idle"
	MeleeStrikeAnim="Blade_Smack"
	MeleeAltStrikeAnim="Blade_Swing"
	MeleeBlockAnim="Blade_ShieldBlock"
}
