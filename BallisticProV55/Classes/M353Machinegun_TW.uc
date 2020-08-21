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

simulated function TickAim(float DT)
{
	Super(BallisticWeapon).TickAim(DT);
}

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
     BoxOnSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOn')
     BoxOffSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOff')
     FlapUpSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapUp')
     FlapDownSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapDown')
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M353'
     SightFXClass=Class'BallisticProV55.M353SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M353.M353-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M353.M353-Putaway')
     MagAmmo=100
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.M353.M353-Cock')
     ReloadAnim="ReloadStart"
     ReloadAnimRate=1.250000
     ClipOutSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(1)=(ModeName="Burst of Three")
     WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=3
     bUseSights=False
     bNoCrosshairInScope=True
     SightPivot=(Pitch=100)
     SightOffset=(X=-4.000000,Z=5.200000)
     GunLength=0.000000
     bUseSpecialAim=True
     SightAimFactor=0.300000
     HipRecoilFactor=1.000000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     AimAdjustTime=0.800000
     AimSpread=0
     ViewAimFactor=1.000000
     AimDamageThreshold=2000.000000
     ChaosDeclineTime=0.320000
     ChaosSpeedThreshold=3000.000000
     ChaosAimSpread=0
     RecoilXCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
     RecoilYCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.03000
     RecoilYFactor=0.03000
     RecoilMax=12288.000000
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.150000
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
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M353'
     IconCoords=(X2=127,Y2=31)
     ItemName="M353 Machinegun Turret"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticAnims2.M353Turret-1st'
     DrawScale=0.600000
     CollisionHeight=26.000000
}
