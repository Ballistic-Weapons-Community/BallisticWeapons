//=============================================================================
// MJ51Carbine.
//
// Medium range, controllable 3-round burst carbine.
// Lacks power and accuracy at range, but is easier to aim
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MJ51Carbine extends BallisticWeapon;

var() name		GrenadeLoadAnim;	//Anim for grenade reload
var()   bool		bLoaded;


var() name		GrenBone;			
var() name		GrenBoneBase;
var() Sound		GrenSlideSound;		//Sounds for grenade reloading
var() Sound		ClipInSoundEmpty;		//			

var() name			BulletBone;
var() name			BulletBone2;


static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_STANAGChaff';
}

//Chaff grenade spawn moved here
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
			GenerateLayout(BallisticWeaponPickup(Pickup).LayoutIndex);
			GenerateCamo(BallisticWeaponPickup(Pickup).CamoIndex);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		}
		else
		{
			GenerateLayout(255);
			GenerateCamo(255);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
            MagAmmo = MagAmmo + (int(!bNonCocking) *  int(bMagPlusOne) * int(!bNeedCock));
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
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }

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
	
	if ( Instigator.FindInventoryType(class'BCGhostWeapon') != None ) //ghosts are scary
	return;

	if(Instigator.FindInventoryType(class'BWBP_SKC_Pro.ChaffGrenadeWeapon')!=None )
	{
		W = Spawn(class'BWBP_SKC_Pro.ChaffGrenadeWeapon',,,Instigator.Location);
		if( W != None)
		{
			W.GiveTo(Instigator);
			W.ConsumeAmmo(0, 9999, true);
			W.ConsumeAmmo(1, 9999, true);
		}
	}
}
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'Fire' || Anim == 'ReloadEmpty')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 2)
		{
			SetBoneScale(4,0.0,BulletBone);
			SetBoneScale(5,0.0,BulletBone2);
		}
	}
	super.AnimEnd(Channel);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (!bLoaded)
	{
		SetBoneScale (2, 0.0, GrenBone);
		SetBoneScale (3, 0.0, GrenBoneBase);
	}
		else
	{
		SetBoneScale (2, 1.0, GrenBone);
		SetBoneScale (3, 1.0, GrenBoneBase);
	}
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{

		SetBoneScale(4,0.0,BulletBone);
		SetBoneScale(5,0.0,BulletBone2);
		ReloadAnim = 'ReloadEmpty';
	}
	
	else
	{
		ReloadAnim = 'Reload';
	}

	super.BringUp(PrevWeapon);

}

simulated function bool PutDown()
{

	if (!bLoaded)
	{
		SetBoneScale (2, 0.0, GrenBone);
		SetBoneScale (3, 0.0, GrenBoneBase);
	}

	if (super.PutDown())
	{
		return true;
	}
	return false;
}


// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || bLoaded)
		return;
	if (ReloadState == RS_None)
	{
		ReloadState = RS_GearSwitch;
		PlayAnim(GrenadeLoadAnim, ReloadAnimRate+0.1, , 0);
	}
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(4,1.0,BulletBone);
	SetBoneScale(5,1.0,BulletBone2);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
	{
		SetBoneScale(4,0.0,BulletBone);
		SetBoneScale(5,0.0,BulletBone2);
	}
}


// Notifys for greande loading sounds
simulated function Notify_GrenVisible()	{	SetBoneScale (2, 1.0, GrenBone); SetBoneScale (3, 1.0, GrenBoneBase);	ReloadState = RS_PreClipIn;}
simulated function Notify_GrenSlide()	{	PlaySound(GrenSlideSound, SLOT_Misc, 2.2, ,64);	}
simulated function Notify_GrenLoaded()	
{
    local Inventory Inv;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;

	MJ51Attachment(ThirdPersonActor).bGrenadier=true;	
	MJ51Attachment(ThirdPersonActor).IAOverride(True);

	Ammo[1].UseAmmo (1, True);
	bLoaded = true;
	if (Ammo[1].AmmoAmount == 0)
	{
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
			if (ChaffGrenadeWeapon(Inv) != None)
			{
				ChaffGrenadeWeapon(Inv).RemoteKill();	
				break;
			}
	}
}
simulated function Notify_GrenReady()	{	ReloadState = RS_None;	}
simulated function Notify_GrenLaunch()	
{
	SetBoneScale (2, 0.0, GrenBone); 	
	MJ51Attachment(ThirdPersonActor).IAOverride(False);
	MJ51Attachment(ThirdPersonActor).bGrenadier=false;
}
simulated function Notify_GrenInvisible()	{ SetBoneScale (3, 0.0, GrenBoneBase);	}


simulated function PlayReload()
{

    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadEmpty';
       ClipHitSound.Sound=ClipInSoundEmpty;
    }
    else
    {
       ReloadAnim='Reload';
       ClipHitSound.Sound=default.ClipHitSound.Sound;
    }
	if (!bLoaded)
	{
		SetBoneScale (2, 0.0, GrenBone);
		SetBoneScale (3, 0.0, GrenBoneBase);
	}
	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated function IndirectLaunch()
{
//	StartFire(1);
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	if (bNoaltfire)
		return 0;	
	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.Skill > Rand(6))
	{
		if (AimComponent.GetChaos() < 0.1 || AimComponent.GetChaos() < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}
	else if (FRand() > 0.75)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{ 
     GrenadeLoadAnim="LoadGrenade"
     GrenBone="Grenade"
     GrenBoneBase="GrenadeHandle"
     GrenSlideSound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-GrenLock'
     ClipInSoundEmpty=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagInEmpty'
     BulletBone="Bullet1"
     BulletBone2="Bullet2"
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;0.8;0.7;0.2")
     AIReloadTime=1.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_APC_Tex.MJ51.BigIcon_MJ51'
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-PullOut',Volume=0.223000)
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Putaway',Volume=0.270000)
     WeaponModes(0)=(ModeName="Semi-Auto")
     WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
     WeaponModes(2)=(bUnavailable=True)
     WeaponModes(3)=(ModeName="Automatic",bUnavailable=True,ModeID="WM_FullAuto")
     CurrentWeaponMode=1
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50In',USize1=128,VSize1=128,USize2=128,VSize2=128,Color1=(B=0,G=0,R=255,A=158),Color2=(B=0,G=255,R=255,A=255),StartSize1=75,StartSize2=72)
     bNoCrosshairInScope=True
	 PlayerViewOffset=(X=-10.000000,Y=10.000000,Z=-15.500000)
     SightOffset=(X=0.0000000,Y=-6.4500000,Z=20.5000000)
	 SightBobScale=0.200000
     CockSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Cock',Volume=1.800000)
	 CockSelectSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Cock',Volume=1.800000)
     //ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagInEmpty',Volume=1.800000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagOut',Volume=1.800000)
	 ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagInEmpty',Volume=1.800000)
	 CockingBringUpTime=1.200000
     ClipInFrame=0.650000
     LongGunOffset=(X=10.000000)
     bWT_Bullet=True
     SightingTime=0.200000
     GunLength=50.000000
     FireModeClass(0)=Class'BWBP_APC_Pro.MJ51PrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.MJ51SecondaryFire'
     IdleAnimRate=0.200000
     PutDownTime=0.700000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="MJ51 Carbine"
     Priority=41
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PickupClass=Class'BWBP_APC_Pro.MJ51Pickup'
	 SightAnimScale=0.300000
     AttachmentClass=Class'BWBP_APC_Pro.MJ51Attachment'
     IconMaterial=Texture'BWBP_APC_Tex.MJ51.SmallIcon_MJ51'
     IconCoords=(X2=127,Y2=31)
     ItemName="MJ51 Carbine"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_APC_Anim.MJ51Carbine_FPm'
	 ParamsClasses(0)=Class'MJ51WeaponParamsArena'
     ParamsClasses(1)=Class'MJ51WeaponParamsClassic'
     ParamsClasses(2)=Class'MJ51WeaponParamsRealistic'
	 ParamsClasses(3)=Class'MJ51WeaponParamsTactical'
     DrawScale=0.300000
}