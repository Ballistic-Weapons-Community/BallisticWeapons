//=============================================================================
// FG50MG_TW.
//
// Weapon used for deployed FG50s
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class FG50MG_TW extends FG50Machinegun
    HideDropDown
	CacheExempt;

var() sound		MountFireSound;

function InitTurretWeapon(BallisticTurret Turret)
{
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	BFireMode[0].FirePushbackForce = 0;
    BFireMode[0].XInaccuracy=1.000000;
    BFireMode[0].YInaccuracy=1.000000;
	BFireMode[0].FireRecoil=128.000000;
	BFireMode[0].BrassOffset = vect(0,0,0);
}

simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if ((BallisticTurret(Owner) != None && BallisticTurret(Owner).bWeaponDeployed) || (BallisticTurret(Instigator) != None && BallisticTurret(Instigator).bWeaponDeployed))
	{
		SelectAnim = IdleAnim;
		SelectAnimRate = IdleAnimRate;
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
	if (BallisticTurret(Instigator) != None && Role == ROLE_Authority)
		BallisticTurret(Instigator).UndeployTurret();
}


function ServerWeaponSpecial(optional byte i)
{

   	if (BallisticTurret(Instigator) != None)
	{
		PlayAnim('Undeploy');
      		Notify_UnDeploy();
	}

}

simulated function Notify_Deploy();

simulated function PreDrawFPWeapon()
{
	SetRotation(Instigator.Rotation);
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (anim == 'Undeploy')
	{
		Notify_Undeploy();
		return;
	}
	Super.AnimEnd(Channel);
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

simulated function PlayReload()
{
       ReloadAnim='Reload';

	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated function ApplyAimRotation()
{
	ApplyAimToView();

	BallisticTurret(Instigator).WeaponPivot = (GetAimPivot() + GetRecoilPivot()) * (DisplayFOV / Instigator.Controller.FovAngle);
//	PlayerViewPivot = default.PlayerViewPivot + (GetAimPivot() + GetRecoilPivot()) * (DisplayFOV / Instigator.Controller.FovAngle);
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
//	else
//		PlayAnim('ReloadFinishHandle', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('Cock'))
		PlayAnim('Cock', CockAnimRate, 0.2);
	else
		PlayAnim('Cock', CockAnimRate, 0.2);
}

defaultproperties
{
	ReloadAnimRate=0.800000
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-ClipHit',Volume=0.000000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-ClipOut')
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-ClipIn')
	SightingTime=0.000001
	GunLength=0.000000
	bUseSpecialAim=True
	 

	ParamsClass=Class'FG50TW_WeaponParams'
	SelectAnim="Deploy"
	bCanThrow=False
	bNoInstagibReplace=True
	DisplayFOV=90.000000
	Priority=1
	PlayerViewOffset=(X=-80.000000)
	ItemName="FG50 Turret"
	Mesh=SkeletalMesh'BWBP_SKC_Anim.X83Turret_TPm'
	DrawScale=0.650000
	CollisionHeight=24.000000
}
