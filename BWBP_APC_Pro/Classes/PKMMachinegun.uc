//=============================================================================
// PKMMachinegun.
//
// The "Guardian" PKM Machinegun has an extremely high fire rate, high ammo
// capacity and decent damage, but is extremely inacurate and can quickly fight
// its way from its owner's control. Secondary allows the user to mount the
// weapon on the ground by crouching.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PKMMachinegun extends BallisticMachinegun;

var() name			KnifeBackAnim;
var() name			KnifeThrowAnim;
var   float			NextThrowTime;

var() name			GrenBone;	
var() name			GrenBoneBase;
var() Sound		GrenLoadSound;				
var() Sound		GrenDropSound;		

var() name			KnifeLoadAnim;	//Anim for grenade reload
var   bool			bLoaded;

//////////////////////////////////////////

simulated function bool IsKnifeLoaded()
{
	return PKMSecondaryFire(FireMode[1]).bLoaded;
}

simulated function bool IsReloadingKnife()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == KnifeLoadAnim)
 		return true;
	return false;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == KnifeLoadAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
	
	super.AnimEnd(Channel);
}

// Load in a grenade
simulated function LoadKnife()
{
	if (Ammo[1].AmmoAmount < 1 || PKMSecondaryFire(FireMode[1]).bLoaded)
		return;
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		PlayAnim(KnifeLoadAnim, 1.1, , 0);
	}		
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	if (seq == KnifeLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingKnife())
		{
			LoadKnife();
			ClientStartReload(1);
		}
		return;
	}
	//log('ServerYes');
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingKnife())
				LoadKnife();
		}
		else
		{
			log('CommonYes');
			CommonStartReload(i);
		}
	}
}

simulated function Notify_BladeLaunch()
{
	SetBoneScale(0, 0.0, GrenBone);
}

simulated function Notify_BladeDrop()
{	
	PlaySound(GrenDropSound, SLOT_Misc,1.5,,32,,);
}

simulated function Notify_BladeAppear()
{
	SetBoneScale(0, 1.0, GrenBone);
	SetBoneScale(1, 1.0, GrenBoneBase);
}

simulated function Notify_BladeLoaded()	
{	
	PlaySound(GrenLoadSound, SLOT_Misc,1.5,,32,,);
	
	bLoaded=True;
	PKMSecondaryFire(FireMode[1]).bLoaded = True;
	PKMAttachment(ThirdPersonActor).bLoaded = True;
	FireMode[1].PreFireTime = FireMode[1].default.PreFireTime; 
}

simulated function BladeOut()
{
	bLoaded=False;
	PKMAttachment(ThirdPersonActor).bLoaded = False;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (PKMSecondaryFire(FireMode[1]).bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}

	super.BringUp(PrevWeapon);
}

function AttachToPawn(Pawn P)
{
	Super.AttachToPawn(P);
	if (PKMSecondaryFire(FireMode[1]).bLoaded)
		PKMAttachment(ThirdPersonActor).bLoaded = True;
}

////////////////////////////////////////////////////////

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

simulated function PlayReload()
{
	PlayAnim('ReloadHold', ReloadAnimRate, , 0.25);
}

simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHold', ReloadAnimRate, 0.2);
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 1024, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
	 BoxBone="MagDrum"
     GrenLoadSound=Sound'BWBP_SKC_Sounds.AK47.Knife-Load'
     GrenDropSound=Sound'BWBP_SKC_Sounds.AK47.Knife-Drop'
	 BoxOnSound=(Sound=Sound'BWBP_CC_Sounds.RPK940.RPK-BoxOn',Volume=1.400000)
     BoxOffSound=(Sound=Sound'BWBP_CC_Sounds.RPK940.RPK-BoxOff',Volume=1.400000)
     FlapUpSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-FlapUp')
     FlapDownSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-FlapDown')
     PlayerSpeedFactor=0.85000
     PlayerJumpFactor=0.850000
	 KnifeLoadAnim="KnifeReload"
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBP_CC_Tex.PKM.BigIcon_PKMA'
     BigIconCoords=(Y1=50,Y2=240)
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic 7.62mm fire. Has a high rate of fire, moderate damage and good sustained damage output. As a machinegun, it has a very long effective range. Large magazine capacity allows the weapon to fire for a long time, but the reload time is long."
     ManualLines(1)=" If a knife is attached, it will be launched, dealing high damage. This attack is hip-accurate and has no recoil. If no knife is attached, one will be attached if available.||This weapon is effective at medium range."
     ManualLines(2)="Rugged, reliable, no fancy attachments needed.  That's the mantra of ZTV Exports PKMA-420 General Purpose Machine Gun, an old timey design brought back from the glory days of the MSR (Merged States Republic).  A 7.62mm belt-fed machine gun that can get the job done even without the frills of optics and other attachments, however there have been upgrades so that it can mount the infamous X8 seen on the AK-490. The PKMA can fight, no matter how harsh the conditions are or how many Krao come surging, nothing can stop this machine gun from performing above and beyond."
     SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.3;0.4;1.0")
	 BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Pullout',Volume=0.220000)
	 PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Putaway',Volume=0.270000)
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BWBP_CC_Sounds.RPK940.RPK-Bolt',Volume=1.500000)
     ReloadAnim="ReloadStart"
     ReloadAnimRate=1.000000
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-ShellOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-ShellIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="Burst of Three")
     WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=3
     bNoCrosshairInScope=True
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=39,R=137,A=255),Color2=(B=148,G=145,R=149,A=255),StartSize1=96,StartSize2=96)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     FireModeClass(0)=Class'BWBP_APC_Pro.PKMPrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.PKMSecondaryFire'
     SelectAnimRate=1.000000
     PutDownTime=0.550000
     BringUpTime=0.500000
	 CockingBringUpTime=2.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.7500000
     CurrentRating=0.7500000
     Description="Rugged, reliable, no fancy attachments needed.  That's the mantra of ZTV Exports PKM-420 General Purpose Machine Gun, an old timey design brought back from the glory days of the MSR (Merged States Republic).  A 7.62mm belt-fed machine gun that can get the job done even without the frills of optics and other attachments, however there have been upgrades so that it can mount the infamous X8 seen on the AK-490. The PKM can fight, no matter how harsh the conditions are or how many Krao come surging, nothing can stop this machine gun from performing above and beyond."
     Priority=43
     HudColor=(G=150,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBP_APC_Pro.PKMPickup'
     PlayerViewOffset=(X=0.000000,Y=5.000000,Z=-11.000000)
	 SightOffset=(X=5.000000,Y=-1.1150000,Z=14.10000)
	 SightPivot=(Pitch=-64)
     AttachmentClass=Class'BWBP_APC_Pro.PKMAttachment'
     IconMaterial=Texture'BWBP_CC_Tex.PKM.SmallIcon_PKMA'
     IconCoords=(X2=127,Y2=31)
     ItemName="PKM-420 GP Machine Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClasses(0)=Class'PKMMachinegunWeaponParamsArena'
	 ParamsClasses(1)=Class'PKMMachinegunWeaponParamsClassic'
	 ParamsClasses(2)=Class'PKMMachinegunWeaponParamsRealistic'
	 ParamsClasses(3)=Class'PKMMachinegunWeaponParamsTactical'
     Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_PKMA'
     DrawScale=0.250000
}
