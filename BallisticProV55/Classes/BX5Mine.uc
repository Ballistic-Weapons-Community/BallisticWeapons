//=============================================================================
// BX5Mine.
//
// A versatile land mine that can be deployed as a concentrated anti vehicle
// mine or a jumping anti infantry mine. Can be picked up after deployed.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5Mine extends BallisticWeapon;

var   bool				bSpringMode;		// Mine will be deployed in secondary jumping mode
var() name				SpringOnAnim;		// Anim when switching to spring mode
var() name				SpringOffAnim;		// Anim when leaving spring mode
var() BUtil.FullSound	DeploySound;		// Sound to play when deployed
var() BUtil.FullSound	OpenSound;			// Sound when switching to spring mode
var() BUtil.FullSound	CloseSound;			// Sound when leaving spring mode
var   float				LastMineCheckTime;	// Time when bot last checked for nearby mines
var   float				Failure;			// A measure of a bots failure at being allowed to place mines. Decreases over time

replication
{
	// Things the client should send to the server.
	reliable if(Role<ROLE_Authority)
		ServerSetSringMode;
	reliable if(Role==ROLE_Authority)
		ClientPlayMineDeploy;
}

simulated function ClientPlayMineDeploy()
{
	BX5PrimaryFire(FireMode[0]).ClientPlayMineDeploy();
}

function ServerSetSringMode(bool bNewValue)
{
	bSpringMode = bNewValue;
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	SwitchSpringMode();
}

simulated function SwitchSpringMode()
{
	if (!bSpringMode)
		PlayAnim(SpringOnAnim, 1.0, 0.1);
	else
		PlayAnim(SpringOffAnim, 1.0, 0.1);
	bSpringMode = !bSpringMode;
	if (bSpringMode)
	{
		IdleAnim='SecIdle';
	    SelectAnim='SecPullout';
    	PutDownAnim='Secputaway';
    	FireMode[0].FireAnim='SecDeploy';
	}
	else
	{
		IdleAnim='Idle';
	    SelectAnim='Pullout';
    	PutDownAnim='putaway';
    	FireMode[0].FireAnim='Deploy';
    }
	if (level.NetMode == NM_Client)
		ServerSetSringMode(bSpringMode);
}

simulated function Notify_BX5Open()
{
    class'BUtil'.static.PlayFullSound(self, OpenSound);
}
simulated function Notify_BX5Close()
{
    class'BUtil'.static.PlayFullSound(self, CloseSound);
}
simulated function Notify_BX5Deploy()
{
    class'BUtil'.static.PlayFullSound(self, DeploySound);
	SetBoneScale(0, 0.0, 'Mine');
	if (AmmoAmount(0) < 1/* && Role == ROLE_Authority*/)
		KillWeapon(true);
}
simulated function Notify_BX5OutOfSight()
{
	if (AmmoAmount(0) > 0)
		SetBoneScale(0, 1.0, 'Mine');
	else// if (Role == ROLE_Authority)
		KillWeapon(true);
}

simulated function KillWeapon(optional bool bCreateGhost)
{
	local BCGhostWeapon GW;
	local Weapon W;
	local Inventory Inv;

	AIRating = -999;
	Priority = -999;
	Instigator.Weapon = None;
	if (Role == ROLE_Authority)
	{
		if (bCreateGhost)
		{
			GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);
			if(GW != None)
			{
				GW.MyWeaponClass = class;
				GW.GiveTo(Instigator);
			}
		}
		if (AIController(Instigator.Controller) != None)
		{
			for (Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory)
				if (Weapon(Inv) != None && Inv != self)
					break;
			if (Inv == None)
			{
				W = Spawn(class'NullGun',Instigator,,Instigator.Location);
				if(W != None)
					W.GiveTo(Instigator);
			}
		}
	}

	if (Instigator != None)
	{
		if (PlayerController(Instigator.Controller) != None)
			Instigator.Controller.ClientSwitchToBestWeapon();
		else if (AIController(Instigator.Controller) != None)
		{
			for (Inv = Instigator.Inventory; Inv != None; Inv = Inv.Inventory)
				if (Weapon(Inv) != None && Weapon(Inv) != Self)
				{
					if (!Weapon(Inv).HasAmmo())
						continue;
					Instigator.PendingWeapon = Weapon(Inv);
					Instigator.ChangedWeapon();
					break;
				}
		}
	}
	//Instigator.Weapon = None;
	Destroy();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	SetBoneScale(0, 1.0, 'Mine');

	if (AIController(Instigator.Controller) != None)
		bSpringMode = (FRand() > 0.5);
}

function DropFrom(vector StartLocation)
{
    if (!bCanThrow && PickupClass != None)
        return;
	if (!HasAmmo())
		PickupClass=None;
	super.DropFrom(StartLocation);
}

// AI Interface =====
function bool ShouldFireWithoutTarget()
{
	return true;
}

// return false if out of range, can't see target, etc.
function bool CanAttack(Actor Other)
{
    local float Dist;
//    local int i;
    local BallisticProjectile BP;

	if (AmmoAmount(0) < 1)
		return false;

    if ( (Instigator == None) || (Instigator.Controller == None) )
        return false;

    if (Other != None)
    {
		Dist = VSize(Instigator.Location - Other.Location);
	    if ( (Dist < 80 || (bSpringMode && Dist < 150)) && AIController(Instigator.Controller).Skill > Rand(7) )
	    {
	    	if (level.TimeSeconds - LastMineCheckTime > 1.0)
	    	{
				// Rules too strict, can't change weapon, just go nuts!
				if (Failure > level.TimeSeconds + 5)
				{
					Failure = 0;
					return true;
				}
				LastMineCheckTime = level.TimeSeconds;
				if (Failure < level.TimeSeconds)
					Failure = level.TimeSeconds;
				else
					Failure += 2.0;
	    	}
    		return false;
    	}
    }

	if (level.TimeSeconds - LastMineCheckTime > 1.0)
	{
		// Rules too strict, can't change weapon, just go nuts!
		if (Failure > level.TimeSeconds + 5)
		{
			Failure = 0;
			return true;
		}
		LastMineCheckTime = level.TimeSeconds;
		foreach VisibleCollidingActors( class 'BallisticProjectile', BP, 150, Instigator.Location )
		{
			if ( BX5VehicleMine(BP) != None || BX5SpringMine(BP) != none )
			{
				if (Failure < level.TimeSeconds)
					Failure = level.TimeSeconds;
				else
					Failure += 2.0;
				return false;
			}
		}
	}
	else
		return false;
    return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if (B == None)
		return Super.GetAIRating();

	// If we are failing too much, this is not the right weapon...
	if (Failure > level.TimeSeconds + 4)
		return 0.1;
	if (level.TimeSeconds - Instigator.LastPainTime < 4.0)
		return 0.2;
	if (level.TimeSeconds - Instigator.LastPainTime < 8.0)
		return 0.4;

	if (B.Enemy == None)
		return 1.0;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	if (Vehicle(B.Enemy) != None && Vehicle(B.Enemy).bStationary && (Dist / VSize(B.Enemy.Velocity) > 3) && (level.TimeSeconds - Instigator.LastPainTime > 3) && Normal(B.Enemy.Velocity) Dot Normal(Dir) < -0.7)
		Result=0.8;

	return Super.GetAIRating();
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	if (level.TimeSeconds-Failure > 2) return 1.0; return -1.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
	SpringOnAnim="SecStart"
	SpringOffAnim="SecFinish"
	DeploySound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-Deploy',Volume=1.000000,Radius=48.000000,Pitch=1.000000)
	OpenSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn',Volume=1.000000,Radius=48.000000,Pitch=1.000000)
	CloseSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff',Volume=1.000000,Radius=48.000000,Pitch=1.000000)
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_BX5'
	BigIconCoords=(Y1=24,Y2=240)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Trap=True
	ManualLines(0)="Places a BX5 mine."
	ManualLines(1)="Changes the mode of the mine. With the base extended outwards, the mine will spring off its base and explode in the air after a short delay. It will have a greater trigger radius in this mode. With the base not extended, the mine will explode immediately, but only upon direct contact."
	ManualLines(2)="This weapon is no longer available due to its effectiveness being independent of skill and its primary usage being to trap places where it cannot be avoided."
	SpecialInfo(0)=(Info="260.0;20.0;0.6;60.0;0.0;0.0;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-Putaway')
	bNoMag=True
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bUseSights=False
	GunLength=0.000000
	bAimDisabled=True
	ParamsClass=Class'BX5WeaponParams'
	FireModeClass(0)=Class'BallisticProV55.BX5PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.BX5SecondaryFire'
	PutDownTime=0.700000
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.300000
	CurrentRating=0.300000
	Description="Land mines have been around for centuries, changing little in their time. Used mainly for anti-vehicle use, the BX5 Mine is an efficient killer when used correctly. Mines can be easily hidden under dirt and leaves, and wait for unsuspecting vehicles to drive over them. The BX5 Switching Mine is a greatly modified version of the standard device with increased trigger sensitivity and the new jumping ability to make it an anti-infantry weapon. When approached, the device will spring from its unfolded base, and then explode, causing much harm to anyone unfortunate enough to be within its radius. As the Skrith did not know of such devices, the Terrans used them with great effectiveness against their oblivious troops and vehicles."
	Priority=0
	HudColor=(B=25,G=150,R=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=0
	GroupOffset=21
	PickupClass=Class'BallisticProV55.BX5Pickup'
	PlayerViewOffset=(X=5.000000,Z=-6.000000)
	AttachmentClass=Class'BallisticProV55.BX5Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_BX5'
	IconCoords=(X2=127,Y2=31)
	ItemName="BX5-SM Land Mine"
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_BX5'
	DrawScale=0.100000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BW_Core_WeaponTex.BX5.BX5Skin'
}
