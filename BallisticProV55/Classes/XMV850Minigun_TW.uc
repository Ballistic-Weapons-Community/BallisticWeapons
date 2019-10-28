//=============================================================================
// XMV850Minigun_TW.
//
// Minigun used by XMV850 turrets. Much more stable than hand held one.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV850Minigun_TW extends XMV850Minigun
    HideDropDown
	CacheExempt;

// Rotates the player's view according to Aim
// Split into recoil and aim to accomodate no view decline
simulated function ApplyAimToView()
{
	local Rotator BaseAim, BaseRecoil;

	//DC 110313
	if (Instigator.Controller == None || AIController(Instigator.Controller) != None || !Instigator.IsLocallyControlled())
		return;

	BaseRecoil = GetRecoilPivot(true) * ViewRecoilFactor;
	BaseAim = Aim * ViewAimFactor ;
	if (bForceRecoilUpdate || LastFireTime >= Level.TimeSeconds - RecoilDeclineDelay)
	{
		bForceRecoilUpdate = False;
		Instigator.SetViewRotation((BaseAim - ViewAim) + (BaseRecoil - ViewRecoil));
	}
	else
		Instigator.SetViewRotation(BaseAim - ViewAim);
	ViewAim = BaseAim;
	ViewRecoil = BaseRecoil;	
}

function InitTurretWeapon(BallisticTurret Turret)
{
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	FireMode[0].FireAnim = 'Idle';
	FireMode[0].FireLoopAnim = 'Idle';
	BFireMode[0].VelocityRecoil = 0;
	BallisticFire(FireMode[0]).BrassOffset = vect(0,0,0);
}

simulated function Notify_Undeploy ()
{
	PlaySound(UndeploySound, Slot_Interact, 0.7,,64,1,true);
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

	ReAim(0.1);

    if (ClientState == WS_BringUp)
    {
		for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
			if (FireMode[Mode] != None)
				FireMode[Mode].InitEffects();
        PlayIdle();
        ClientState = WS_ReadyToFire;
		if (!bOldCrosshairs && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
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

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;

	SetBoneRotation('Barrels', BT);

	if (CurrentWeaponMode == 0)
		DesiredSpeed = 0.33;

	else	DesiredSpeed = 0.46;

	super.WeaponTick(DT);
}

simulated event RenderOverlays (Canvas C)
{
	DisplayFOV = Instigator.Controller.FovAngle;
	Super.RenderOverlays(C);
}

simulated function ApplyAimRotation()
{
	ApplyAimToView();
	BallisticTurret(Instigator).WeaponPivot = (GetAimPivot() + GetRecoilPivot()) * (DisplayFOV / Instigator.Controller.FovAngle);
}

function byte BestMode()
{
	return 0;
}

defaultproperties
{
     ReloadAnimRate=1.200000
     bUseSights=False
     GunLength=0.000000
     bUseSpecialAim=True
     CrouchAimFactor=1.000000
     HipRecoilFactor=1.000000
     AimAdjustTime=1.000000
     AimSpread=4
     ViewAimFactor=1.000000
     AimDamageThreshold=2000.000000
     ChaosAimSpread=4
     RecoilYawFactor=0.660000
     RecoilXFactor=0.000000
     RecoilDeclineTime=1.100000
     FireModeClass(0)=Class'BallisticProV55.XMV850TW_PrimaryFire'
     SelectAnim="Deploy"
     SelectAnimRate=1.000000
     BringUpTime=1.400000
     bCanThrow=False
     bNoInstagibReplace=True
     DisplayFOV=90.000000
     ClientState=WS_BringUp
     Priority=1
     PlayerViewOffset=(Y=0.000000)
     ItemName="XMV-850 Minigun Turret"
     Mesh=SkeletalMesh'BallisticAnims2.XMV850Turret-1st'
     DrawScale=0.350000
}
