//=============================================================================
// MACWeapon_TW.
//
// Weapon used by HAMR turrets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACWeapon_TW extends MACWeapon
    HideDropDown
	CacheExempt;

// Rotates the player's view according to Aim
// Split into recoil and aim to accomodate no view decline
simulated function ApplyAimToView()
{
	local Rotator AimPivotDelta, RecoilPivotDelta;

	//DC 110313
	if (Instigator.Controller == None || AIController(Instigator.Controller) != None || !Instigator.IsLocallyControlled())
		return;

	RecoilPivotDelta 	= RcComponent.CalcViewPivotDelta();
	AimPivotDelta 		= AimComponent.CalcViewPivotDelta();
	
	if (RcComponent.ShouldUpdateView())
		Instigator.SetViewRotation(AimPivotDelta + RecoilPivotDelta);
	else
		Instigator.SetViewRotation(AimPivotDelta);	
}

simulated function GetViewAxes( out vector xaxis, out vector yaxis, out vector zaxis )
{
	GetAxes( Instigator.GetViewRotation(), xaxis, yaxis, zaxis );
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (level.TimeSeconds >= NextBeaconTime && MACPrimaryFire(FireMode[0]) != None)
	{
		NextBeaconTime = level.TimeSeconds + 1;
		MACPrimaryFire(FireMode[0]).TurretLaunchBeacon();
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	local int i;

	super.BringUp(PrevWeapon);

	SetBoneScale(2, 1.0, Shells[2]);

	for (i=0;i<2;i++)
		if ((bPendingShellLoad && MagAmmo <= i) || (!bPendingShellLoad && MagAmmo-1 <= i))
			SetBoneScale(i, 0.0, Shells[i]);
		else
			SetBoneScale(i, 1.0, Shells[i]);
}

simulated function bool WeaponCentered()
{
	return true;
}

function InitTurretWeapon(BallisticTurret Turret)
{
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	BFireMode[0].FirePushbackForce = 0;
	BFireMode[0].FireChaos=0.05;
	BFireMode[0].FireRecoil=256.000000;
	BallisticFire(FireMode[0]).BrassOffset = vect(0,0,0);
}
simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if ((BallisticTurret(Owner) != None && BallisticTurret(Owner).bWeaponDeployed) || (BallisticTurret(Instigator) != None && BallisticTurret(Instigator).bWeaponDeployed))
	{
		SelectAnim=IdleAnim;
		SelectAnimRate=IdleAnimRate;
		BringUpTime = 0.1;
	}
}

simulated event Timer()
{
    if (ClientState == WS_BringUp && BallisticTurret(Instigator) != None)
     	BallisticTurret(Instigator).bWeaponDeployed = true;

	super.Timer();
}

simulated function Notify_Undeploy ()
{
	local int i;

	for (i=0;i<Beacons.length;i++)
	{
		if (Beacons[i].Trail != None)
			Beacons[i].Trail.Destroy();
		if (Beacons[i].Sphere != None)
			Beacons[i].Sphere.Destroy();
	}

	PlaySound(UndeploySound, Slot_Interact, 0.7,,64,1,true);
	if (BallisticTurret(Instigator) != None && Role == ROLE_Authority)
		BallisticTurret(Instigator).UndeployTurret();
}

simulated function Notify_Deploy ();

simulated function PreDrawFPWeapon()
{
	SetRotation(Instigator.Rotation);
}

function AttachToPawn(Pawn P)
{
	Instigator = P;
	if ( ThirdPersonActor == None )
	{
		ThirdPersonActor = Spawn(AttachmentClass,Owner);
		InventoryAttachment(ThirdPersonActor).InitFor(self);
	}
	else
		ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;

	ThirdPersonActor.SetLocation(P.Location);
	ThirdPersonActor.SetBase(P);
}

simulated event RenderOverlays (Canvas C)
{
	DisplayFOV = Instigator.Controller.FovAngle;
	Super.RenderOverlays(C);
}

simulated function ApplyAimRotation()
{
	ApplyAimToView();

	BallisticTurret(Instigator).WeaponPivot = GetFireRot() * (DisplayFOV / Instigator.Controller.FovAngle);
}

function byte BestMode()
{
	return 0;
}

defaultproperties
{
	TeamSkins(0)=(SkinNum=1)
	ReloadAnimRate=2.500000
	SightingTime=0.100000
	GunLength=0.000000
	bUseSpecialAim=True
	 
	Begin Object Class=RecoilParams Name=Arena_TW_RecoilParams
	 	ViewBindFactor=0.000000
		PitchFactor=0.100000
		YawFactor=0.500000
		XRandFactor=0.300000
		YRandFactor=0.200000
		DeclineTime=1.500000
		MinRandFactor=0.350000
	End Object
	RecoilParamsList(0)=RecoilParams'Arena_TW_RecoilParams'

	Begin Object Class=AimParams Name=Arena_TW_AimParams
		ViewBindFactor=1
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		AimSpread=(Min=8,Max=32)
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=3500.000000
		AimDamageThreshold=2000
	End Object
	AimParamsList(0)=AimParams'Arena_TW_AimParams'

	FireModeClass(0)=Class'BallisticProV55.MACTW_PrimaryFire'
	SelectAnim="Deploy"
	BringUpTime=1.500000
	bCanThrow=False
	bNoInstagibReplace=True
	DisplayFOV=90.000000
	ClientState=WS_BringUp
	Priority=1
	PlayerViewOffset=(Y=0.000000)
	ItemName="HAMR Turret"
	Mesh=SkeletalMesh'BWBP4b-Anims.Artillery-Turret'
	DrawScale=0.250000
	PrePivot=(Z=8.000000)
	Skins(1)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
