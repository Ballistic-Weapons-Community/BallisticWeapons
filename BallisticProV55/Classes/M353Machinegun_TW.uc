//=============================================================================
// M353Machinegun_TW.
//
// Weapon used for M353 Turrets. Properties altered to be more like a deployed wepaon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M353Machinegun_TW extends BallisticMachinegun
    HideDropDown
	CacheExempt;
	
function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;

	bJustSpawned = true;
    Super(BallisticWeapon).GiveTo(Other);
    bPossiblySwitch = true;
    W = self;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
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


simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

function InitTurretWeapon(BallisticTurret Turret)
{
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	BallisticFire(FireMode[0]).BrassOffset = vect(0,0,0);
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

//attachment fix
simulated event Timer()
{
	local int Mode;

	AimComponent.ReAim(0.1);

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

simulated event RenderOverlays (Canvas C)
{
	DisplayFOV = Instigator.Controller.FovAngle;
	Super.RenderOverlays(C);
}

simulated function ApplyAimRotation()
{
	ApplyAimToView();

	BallisticTurret(Instigator).WeaponPivot = (GetFireRot()) * (DisplayFOV / Instigator.Controller.FovAngle);
}

simulated function PlayReload()
{
	PlayAnim('ReloadHandle', ReloadAnimRate, , 0.25);
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHandle', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function PositionSights ()
{
	super.PositionSights();
	if (SightingPhase <= 0.0)
		SetBoneRotation('TopHandle', rot(0,0,0));
	else if (SightingPhase >= 1.0 )
		SetBoneRotation('TopHandle', rot(0,0,-8192));
	else
		SetBoneRotation('TopHandle', class'BUtil'.static.RSmerp(SightingPhase, rot(0,0,0), rot(0,0,-8192)));
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
	BoxOnSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-BoxOn')
	BoxOffSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-BoxOff')
	FlapUpSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-FlapUp')
	FlapDownSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-FlapDown')
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_M353'
	SightFXClass=Class'BallisticProV55.M353SightLEDs'
	
	bWT_Bullet=True
	bWT_Machinegun=True
	SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Putaway')
	CockSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Cock')
	ReloadAnim="ReloadStart"
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-ShellOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-ShellIn')
	ClipInFrame=0.650000
	bCockOnEmpty=True
	WeaponModes(1)=(ModeName="Burst of Three")
	WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
	WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=128),Color2=(A=246),StartSize1=89)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.100000,Y2=0.100000))
    
	CurrentWeaponMode=3
	bUseSights=False
	bNoCrosshairInScope=True
	SightPivot=(Pitch=100)
	SightOffset=(X=-4.000000,Z=5.200000)
	GunLength=0.000000
	bUseSpecialAim=True
	ParamsClasses(0)=Class'M353TW_WeaponParamsComp'
	ParamsClasses(1)=Class'M353TW_WeaponParamsClassic'
	ParamsClasses(2)=Class'M353TW_WeaponParamsRealistic'
    ParamsClasses(3)=Class'M353TW_WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.M353TW_PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.M353SecondaryFire'
	SelectAnim="Deploy"
	PutDownTime=0.400000
	BringUpTime=1.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	bCanThrow=False
	bNoInstagibReplace=True
	Description="M353 MachineGun||Manufacturer: Enravion Combat Solutions|Primary: Very fast inaccurate fire|Secondary: Mount Machinegun||The M353 'Guardian' Machinegun, has seen some of the most brutal battles ever recorded in recent history, and has helped win many of them, the most famous being the bloody 'Wasteland Seige' where 12 million Krao were slaughtered along a 500 mile line of defences. Used primarily as a defensive weapon, the M353's incredible rate of fire can quickly and effectively destroy masses of oncoming foes, especially melee attackers. When the secondary mode is activated, the Guardian, becomes much more accurate when the user mounts it on the ground, allowing it to be a very effective defensive weapon. With it's high rate of fire and high damage, the M353 becomes very inaccurate after just a few rounds and with its high ammo capacity, comes the difficulty of longer reload times than smaller weapons."
	DisplayFOV=90.000000
	ClientState=WS_BringUp
	Priority=1
	HudColor=(G=150,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	PickupClass=Class'BallisticProV55.M353Pickup'
	PlayerViewOffset=(X=11.000000,Z=-14.000000)
	AttachmentClass=Class'BallisticProV55.M353Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_M353'
	IconCoords=(X2=127,Y2=31)
	ItemName="M353 Machinegun Turret"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.M353Turret_FPm'
	DrawScale=0.600000
	CollisionHeight=26.000000
}
