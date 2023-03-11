//=============================================================================
// M925Machinegun_TW.
//
// Weapon used for M925 Turrets. Properties altered to be more like a deployed weapon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M925Machinegun_TW extends BallisticMachinegun
    HideDropDown
	CacheExempt;
	
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

simulated function Notify_M925HandleOn()
{
	PlaySound(HandleOnSound,,0.5);
}
simulated function Notify_M925HandleOff()
{
	PlaySound(HandleOffSound,,0.5);
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
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
	TeamSkins(1)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=4)
	BeltLength=8
	BoxOnSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-BoxOn')
	BoxOffSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-BoxOff')
	FlapUpSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-LeverUp')
	FlapDownSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-LeverDown')
	HandleOnSound=Sound'BW_Core_WeaponSound.M925.M925-StandOn'
	HandleOffSound=Sound'BW_Core_WeaponSound.M925.M925-StandOff'
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_M925'
	SightFXClass=Class'BallisticProV55.M925SightLEDs'
	
	bWT_Bullet=True
	bWT_Machinegun=True
	SpecialInfo(0)=(Info="360.0;30.0;0.8;40.0;0.0;0.0;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Cock')
	ReloadAnim="ReloadStart"
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-ShellOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-ShellIn')
	bCockOnEmpty=True
	bUseSights=False
	bNoCrosshairInScope=True
	SightPivot=(Pitch=64)
	SightOffset=(X=-18.000000,Z=7.200000)
	SightDisplayFOV=40.000000
	SightingTime=0.450000
	GunLength=0.000000
	bUseSpecialAim=True
	WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto")
	ParamsClasses(0)=Class'M925TW_WeaponParams'
	ParamsClasses(1)=Class'M925TW_WeaponParamsClassic'
	ParamsClasses(2)=Class'M925TW_WeaponParamsRealistic'
    ParamsClasses(3)=Class'M925TW_WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.M925TW_PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.M925SecondaryFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=128),StartSize1=94)
    NDCrosshairInfo=(SpreadRatios=(Y2=1.000000))
	
	SelectAnim="Deploy"
	SelectAnimRate=0.800000
	PutDownTime=0.400000
	BringUpTime=1.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	bCanThrow=False
	bNoInstagibReplace=True
	Description="M925 .50 cal Machinegun||Manufacturer: Black & Wood|Primary: Medium 50 Cal. Fire|Secondary: Mount Machinegun||The M925 was used during the late stages of the first Human-Skrith war when ballistic weapons first came back into large scale usage. The heavy calibre M925 was extremely effective against the Skrith and their allies and became known as the 'Monster' because it was the first weapon that the Skrith truly feared. Although it has a slower rate of fire than the M353, the 'Monster' has a much heavier bullet and can cause much more damage to an enemy soldier or vehicle in a single shot. It was also used extensively during the 'Wasteland Siege', to hose down thousands of Krao, and proved to be very effective at destroying the alien transport ships, as they were landing."
	DisplayFOV=90.000000
	ClientState=WS_BringUp
	Priority=1
	HudColor=(B=175,G=175,R=175)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	GroupOffset=1
	PickupClass=Class'BallisticProV55.M925Pickup'
	PlayerViewOffset=(X=11.000000,Z=-14.000000)
	AttachmentClass=Class'BallisticProV55.M925Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_M925'
	IconCoords=(X2=127,Y2=31)
	ItemName="M925 Machinegun Turret"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=6.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M925Turret'
	DrawScale=0.230000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BW_Core_WeaponTex.M925.M925Small'
	Skins(2)=Texture'BW_Core_WeaponTex.M925.M925Main'
	Skins(3)=Texture'BW_Core_WeaponTex.M925.M925HeatShield'
	Skins(4)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(5)=Texture'BW_Core_WeaponTex.M925.M925AmmoBox'
	CollisionHeight=24.000000
}
