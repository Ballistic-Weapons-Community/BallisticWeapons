//=============================================================================
// MRT6Shotgun.
//
// A very short, powerful and fast double barreled sidearm like shotgun. It has
// A very low range and ridiculous spread, but is devestaing very close up and
// reloads fast. Seondary fires only one barrel.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRT6Shotgun extends BallisticProShotgun;

var bool bLeftLoaded;
var bool bRightLoaded;

var byte LeftChamber;                       //0=Empty, 1=Brass, 2=Loaded
var byte RightChamber;

//==============================================================================
// "Tactical Reload" Stuff >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//==============================================================================
/*
//Allows reload at full mag
function ServerStartReload (optional byte i)
{
	local int m;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (MagAmmo >= default.MagAmmo + (int(bMagPlusOne) * (int(LeftChamber == 2) + int(RightChamber == 2))))
		return;
	if (Ammo[0].AmmoAmount < 1)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	CommonStartReload(i);	//Server animation
	ClientStartReload(i);	//Client animation
}
// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;
	class'BUtil'.static.PlayFullSound(self, ClipInSound, true);
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo - MagAmmo + (int(bMagPlusOne) * (int(LeftChamber == 2) + int(RightChamber == 2)));
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo+=AmmoNeeded;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
}
//Startup weapons are fully loaded.  Full mag + 2, in this shotgun's case (todo refactor)
function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
		{
			//log("gun received with Layout "$BallisticWeaponPickup(Pickup).LayoutIndex$" and Camo "$BallisticWeaponPickup(Pickup).CamoIndex); 
			GenerateLayout(BallisticWeaponPickup(Pickup).LayoutIndex);
			GenerateCamo(BallisticWeaponPickup(Pickup).CamoIndex);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		}
		else
		{
			//log("randomizing"); 
			GenerateLayout(255);
			GenerateCamo(255);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
            MagAmmo = MagAmmo + (int(bMagPlusOne) * (int(LeftChamber == 2) + int(RightChamber == 2)));
		}
    }
 	
   	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;
    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
			W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}
simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		if (MagAmmo > 1)
		   LeftChamber = 2;
	    if (MagAmmo > 0)
	       RightChamber = 2;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		AimComponent.ReAim(0.05);
	    return;
    }
    super.AnimEnded(Channel, anim, frame, rate);
}*/
//==============================================================================
// End "Tactical Reload" Stuff <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//==============================================================================

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_12GaugeClips';
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (0, 0.0, 'Shell');
	super.PlayReload();
}
/*
simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	Else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}
*/
/*
simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
	if ((!bRightLoaded || (bRightLoaded && bLeftLoaded)) && bNeedCock && MagAmmo > 0)
		CommonCockGun();
}
*/
simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
//	if ((!bRightLoaded || (bRightLoaded && bLeftLoaded)) && bNeedCock && MagAmmo > 0 &&
//		(OtherGun == None || !CanAlternate(0) || OtherGun.bNeedCock) )
	if ((!bRightLoaded || (bRightLoaded && bLeftLoaded)) && bNeedCock && MagAmmo > 0 )
		CommonCockGun();
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (0, 1.0, 'Shell');
}

simulated function CommonCockGun(optional byte Type)
{
	super.CommonCockGun(Type);
	bLeftLoaded=true;
	bRightLoaded=true;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 700)
		return 1;
	else if (Dist < 300)
		return 0;
	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

defaultproperties
{
    AIRating=0.7
    CurrentRating=0.7
    ManualLines(0)="Fires both barrels. Wide spread and good damage, but requires cocking after every shot."
    ManualLines(1)="Fires one barrel at a time."
    ManualLines(2)="Effective at very close range. Spreads less from the hip than other shotguns."

    bLeftLoaded=True
    bRightLoaded=True
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
    BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_MRT6'
    
    bWT_Shotgun=True
    bWT_Sidearm=True
    SpecialInfo(0)=(Info="180.0;10.0;-999.0;25.0;0.0;0.8;-999.0")
    BringUpSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6Pullout')
    PutDownSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6Putaway')
    CockSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6Cock')
    ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6ClipHit')
    ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6ClipOut')
    ClipInSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6ClipIn')
    bCockOnEmpty=True
    bAltTriggerReload=True
    WeaponModes(0)=(ModeName="Single Fire")
    WeaponModes(1)=(bUnavailable=True)
    WeaponModes(2)=(bUnavailable=True)
    CurrentWeaponMode=0
    GunLength=24.000000
    ParamsClasses(0)=Class'MRT6WeaponParamsComp'
    ParamsClasses(1)=Class'MRT6WeaponParamsClassic'
    ParamsClasses(2)=Class'MRT6WeaponParamsRealistic'
    ParamsClasses(3)=Class'MRT6WeaponParamsTactical'
    FireModeClass(0)=Class'BallisticProV55.MRT6PrimaryFire'
    FireModeClass(1)=Class'BallisticProV55.MRT6SecondaryFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M763OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M763InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(G=255,A=128),Color2=(B=53,G=86,R=110,A=192),StartSize1=168,StartSize2=166)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)

    Description="MRT6 Shotgun Sidearm||Manufacturer: Wot ya Packin Gun Corp|Primary: Dual Barrel Shot|Secondary: Single Barrel Shot||One of Wot Ya Packin's most famous creations, the ridiculous MRT6 has grown quite a reputaton. A favourite of gangsters, thieves and countless other such criminals, the MRT6 is a small, fairly light shotgun that can easily be mistaken for a pistol. It has two barrels that can be fired simultaneously, it can be reloaded quickly and has an eight shell magazine. It is rarely seen in professional military use due to its loud noise, short range and extreme spread, but it is has a very high damage when used at close range, as anyone that is unfortunate enough to be aboard an unsuspecting ship attacked by a band of cargo raiders would testify. In fact, during an incident where Var Dehidra's pirates boarded a private exploration vessel, already being attacked by another band. They used their MRT6's to defeat the entire band of over thirty B1 'Possum' wielding marauders as well as the ship's defenders."
    Priority=35
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=2
    GroupOffset=9
    PickupClass=Class'BallisticProV55.MRT6Pickup'

    PlayerViewOffset=(X=1.000000,Y=3.000000,Z=-5.500000)
	SightPivot=(Pitch=768)
    SightOffset=(X=-10.000000,Z=6.500000)
    SightZoomFactor=1.2
	SightAnimScale=0.5
	SightBobScale=0.7f

    AttachmentClass=Class'BallisticProV55.MRT6Attachment'
    IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_MRT6'
    IconCoords=(X2=127,Y2=31)
    ItemName="MRT-6 Shotgun"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=25
    LightSaturation=130
    LightBrightness=150.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_MRT6'
    DrawScale=0.300000
    Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Texture'BW_Core_WeaponTex.MRT6.MRT6Skin'
    Skins(2)=Texture'BW_Core_WeaponTex.MRT6.MRT6Small'
}
