//=============================================================================
// M99_TW.
//
// Weapon used for deployed M99s
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M99_TW extends M99Rifle
    HideDropDown
	CacheExempt;

var() sound		MountFireSound;


simulated event PostNetBeginPlay()
{
	super(BallisticWeapon).PostNetBeginPlay();
}
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
	ReloadAnimRate=1.200000
    ClipHitSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99BoltClose',Volume=100.500000)
    ClipOutSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99OpenBolt',Volume=100.500000)
    ClipInSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99Cartridge',Volume=100.500000)
	SightingTime=0.000001
	GunLength=0.000000
    bUseSights=True
	bUseSpecialAim=True
	ParamsClasses(0)=Class'M99TW_WeaponParams'
	ParamsClasses(1)=Class'M99TW_WeaponParamsClassic'
	ParamsClasses(2)=Class'M99TW_WeaponParamsRealistic'
	ParamsClasses(3)=Class'M99TW_WeaponParamsTactical'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc5',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=130,G=135,R=137,A=62),Color2=(B=0,G=172,R=0,A=80),StartSize1=127,StartSize2=96)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	SelectAnim="Deploy"
    BringUpTime=1.000000
	bCanThrow=False
	bNoInstagibReplace=True
    ClientState=WS_BringUp
	Priority=1
	PlayerViewOffset=(X=-100.000000)
	ItemName="Deployed M99 Turret"
	Mesh=SkeletalMesh'BWBP_JCF_Anims.M99Turret_FPm'
	DrawScale=0.50000
	CollisionHeight=24.000000
}
