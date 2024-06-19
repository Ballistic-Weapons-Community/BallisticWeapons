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

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}

simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock=false;
}

// Rotates the player's view according to Aim
// Split into recoil and aim to accomodate no view decline
simulated function ApplyAimToView()
{
	local Rotator AimPivotDelta, RecoilPivotDelta;

	//DC 110313
	if (Instigator.Controller == None || AIController(Instigator.Controller) != None || !Instigator.IsLocallyControlled())
		return;

	RecoilPivotDelta 	= RcComponent.CalcViewPivotDelta();
	AimPivotDelta  		= AimComponent.CalcViewPivotDelta();
	
	if (RcComponent.ShouldUpdateView())
		Instigator.SetViewRotation(AimPivotDelta + RecoilPivotDelta);
	else
		Instigator.SetViewRotation(AimPivotDelta);	
}

function InitTurretWeapon(BallisticTurret Turret)
{
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	BFireMode[0].FirePushbackForce = 0;
	BFireMode[0].BrassOffset = vect(0,0,0);
}

simulated function Notify_Undeploy ()
{
	if (BallisticTurret(Instigator) != None && Role == ROLE_Authority)
		BallisticTurret(Instigator).UndeployTurret();
}

simulated function Notify_Deploy ();

simulated function PreDrawFPWeapon()
{
	SetRotation(Instigator.Rotation);
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super(BallisticWeapon).GiveTo(Other, Pickup);
}

//attachment fix for deployed
simulated event Timer()
{
	local int Mode;

	AimComponent.Reaim(0.1);

    if (ClientState == WS_BringUp)
    {
		for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
			if (FireMode[Mode] != None)
				FireMode[Mode].InitEffects();
        PlayIdle();
        ClientState = WS_ReadyToFire;
		if (CrosshairMode != CHM_Unreal && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
			PlayerController(Instigator.Controller).MyHud.bCrosshairShow = false;

		if (bNeedCock)
		{
			if (MagAmmo > 0)
				CommonCockGun();
		}
		

		//handle attachment here, hack to force apparition
		//without this tracers will not appear in 1st when 
		//wep is first deployed
		if (Role < ROLE_Authority)
		return;
		
		if (ThirdPersonActor != None )
		{
			ThirdPersonActor.Destroy();
			ThirdPersonActor = Spawn(AttachmentClass,Owner);
			InventoryAttachment(ThirdPersonActor).InitFor(self);
		}

		ThirdPersonActor.SetLocation(Instigator.Location);
		ThirdPersonActor.SetBase(Instigator);
    }
    
    else if (ClientState == WS_PutDown)
    {
		if (SightFX != None)
		{
			SightFX.Destroy();
			SightFX=None;
		}

		if ( Instigator.PendingWeapon == None )
		{
			PlayIdle();
			ClientState = WS_ReadyToFire;
		}
		else
		{
			ClientState = WS_Hidden;
			Instigator.ChangedWeapon();
			for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
				if (FireMode[Mode] != None)
					FireMode[Mode].DestroyEffects();
			if (PlayerSpeedFactor != 0 && PlayerSpeedUp)
			{
				Instigator.GroundSpeed *= (1/PlayerSpeedFactor);
				PlayerSpeedUp = false;
			}
		}
    }
	else if (Clientstate == WS_None && Instigator.PendingWeapon == none && bNeedCock)
	{
		if (MagAmmo > 0)
			CommonCockGun();
	}
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
exec simulated function MeleeHold()
{
	return;
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
//	PlayerViewPivot = default.PlayerViewPivot + GetFireRot() * (DisplayFOV / Instigator.Controller.FovAngle);
}

simulated function PlayReload()
{
       ReloadAnim='Reload';

	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
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

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

defaultproperties
{
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-ClipHit',Volume=0.000000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-ClipOut')
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-ClipIn')
	SightingTime=0.000001
	GunLength=0.000000
    bUseSights=False
	bUseSpecialAim=True
	ParamsClasses(0)=Class'FG50TW_WeaponParamsComp'
	ParamsClasses(1)=Class'FG50TW_WeaponParamsClassic'
	ParamsClasses(2)=Class'FG50TW_WeaponParamsRealistic'
    ParamsClasses(3)=Class'FG50TW_WeaponParamsTactical'
	WeaponModes(0)=(ModeName="Controlled",AimParamsIndex=1)
	WeaponModes(1)=(bUnavailable=True)
	SelectAnim="Deploy"
    BringUpTime=1.600000
	bCanThrow=False
	bNoInstagibReplace=True
	DisplayFOV=90.000000
    ClientState=WS_BringUp
	Priority=1
	PlayerViewOffset=(X=-80.000000)
	ItemName="FG50 Turret"
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_FG50_Turret'
	DrawScale=0.50000
	CollisionHeight=24.000000
}
