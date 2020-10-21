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
	local Rotator AimPivotDelta, RecoilPivotDelta;

	//DC 110313
	if (Instigator.Controller == None || AIController(Instigator.Controller) != None || !Instigator.IsLocallyControlled())
		return;

	RecoilPivotDelta = RcComponent.CalcViewPivotDelta();
	AimPivotDelta = AimComponent.CalcViewPivotDelta();
	
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
	FireMode[0].FireAnim = 'Idle';
	FireMode[0].FireLoopAnim = 'Idle';
	BFireMode[0].FirePushbackForce = 0;
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

	AimComponent.Reaim(0.1);

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
	ReloadAnimRate=1.200000
	bUseSights=False
	GunLength=0.000000
	bUseSpecialAim=True
	 
	Begin Object Class=RecoilParams Name=XMV850_TWRecoilParams
		XCurve=(Points=(,(InVal=0.1,OutVal=0.03),(InVal=0.2,OutVal=-0.05),(InVal=0.3,OutVal=-0.07),(InVal=0.4,OutVal=0.0),(InVal=0.5,OutVal=0.1),(InVal=0.6,OutVal=0.18),(InVal=0.7,OutVal=0.05),(InVal=0.8,OutVal=0),(InVal=1,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.350000,OutVal=0.400000),(InVal=0.500000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		ViewBindFactor=1.000000
		CrouchMultiplier=1.000000
		HipMultiplier=1.000000
		DeclineTime=1.100000
	End Object
	RecoilParamsList(0)=RecoilParams'XMV850_TWRecoilParams'

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=1
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpOffSet=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=1
		AimSpread=(Min=0,Max=0)
		ChaosSpeedThreshold=350.000000
		AimDamageThreshold=2000.000000
	End Object
	AimParamsList(0)=AimParams'ArenaAimParams'
	 
	FireModeClass(0)=Class'BallisticProV55.XMV850TW_PrimaryFire'
	WeaponModes(0)=(ModeName="1200 RPM",ModeID="WM_FullAuto")
	WeaponModes(1)=(bUnavailable=False)
	WeaponModes(2)=(bUnavailable=False)
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
