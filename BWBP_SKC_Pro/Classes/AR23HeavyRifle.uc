//=============================================================================
// AR23HeavyRifle.
//
// AR23 Punisher. A ridiculous .50 Beowulf firing automatic rifle.
// Also comes with a 40mm underslung shotgun for extra insanity.
// Kills your enemies and probably also your shoulders.
//
// by Marc "Sgt. Kelly" Moylan
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23HeavyRifle extends BallisticWeapon;

var() bool		bFirstDraw;
var() name		GrenadeLoadAnim;	//Anim for grenade reload
var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//
var() name		IronSightBone;		
var() name		IronSightBone2;
var() name		IronSightBone3;				
var() name		ReflexSightBone;			

replication
{
	unreliable if (Role == Role_Authority)
		ClientGrenadePickedUp;
}

// Notifys for greande loading sounds
simulated function Notify_AR23GrenadeOut()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_AR23GrenadeIn()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	AR23SecondaryFire(FireMode[1]).bLoaded = true;	}

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else
			AR23SecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientGrenadePickedUp();
}

simulated function ClientGrenadePickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadGrenade();
		else
			AR23SecondaryFire(FireMode[1]).bLoaded=true;
	}
}

simulated function bool IsGrenadeLoaded()
{
	return AR23SecondaryFire(FireMode[1]).bLoaded;
}

// Tell our ammo that this is the M46 it must notify about grenade pickups
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
//	if (Ammo[1] != None && Ammo_M46Grenades(Ammo[1]) != None)
//		Ammo_M46Grenades(Ammo[1]).DaM46 = self;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == GrenadeLoadAnim)
	{
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
	//if (Anim == FireMode[1].FireAnim && !AR23SecondaryFire(FireMode[1]).bLoaded)
	//	LoadGrenade();
	//else
		Super.AnimEnd(Channel);
}

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || AR23SecondaryFire(FireMode[1]).bLoaded)
	{
		if(!AR23SecondaryFire(FireMode[1]).bLoaded)
			PlayIdle();
		return;
	}
	if (ReloadState == RS_None)
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
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
	if (seq == GrenadeLoadAnim)
		return;

	if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1)
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1/*MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1*/)
		{
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	SetBoneScale (0, 0.0, IronSightBone2);
	Super.BringUp(PrevWeapon);

}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();
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
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
			return false;
		}
	}
	return super.CanAttack(Other);
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (Dist > 700)
		Result += 0.3;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 3000)
		Result -= (Dist-3000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     IronSightBone="IronsFront"
     IronSightBone2="IronsRear"
     IronSightBone3="GLIrons"
     ReflexSightBone="Holo"
	 GrenadeLoadAnim="GrenadeReload"
     GrenOpenSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
     GrenLoadSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
     GrenCloseSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_SKC_Tex.AR23.BigIcon_AR23'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Splash=True
     bWT_Machinegun=True
     bWT_Projectile=True
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
     MagAmmo=18
     bCockOnEmpty=False
     CockSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_Cock',Volume=1.100000)
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_ClipHit',Volume=1.000000)
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_ClipOut',Volume=1.000000)
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_ClipIn',Volume=1.000000)
     ClipInFrame=0.700000
     ParamsClasses(0)=Class'AR23WeaponParamsArena'
     ParamsClasses(1)=Class'AR23WeaponParamsClassic'
     ParamsClasses(2)=Class'AR23WeaponParamsRealistic'
	 WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
     WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
     FullZoomFOV=55.000000
     bNoCrosshairInScope=True
	 SightPivot=(Pitch=-800,Yaw=0,Roll=0)
     SightDisplayFOV=40.000000
     FireModeClass(0)=Class'BWBP_SKC_Pro.AR23PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.AR23SecondaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.R78InA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc4',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=116,R=144,A=255),Color2=(B=42,G=44,R=40,A=116),StartSize1=115,StartSize2=116)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     AIRating=0.600000
     CurrentRating=0.600000
     bSniping=True
     Description="Originally designed for boar hunting, the .50 Beowulf Cartridge is a novel yet powerful round that big game hunters across the several galaxies used to take down the biggest of beasties.  Wot Ya Packing was inspired by this big bullet and managed to make an automatic rifle out of it; the AR23 ''Punisher'' Heavy Rifle.  Chambered in the titular .50 Beowulf Cartridge, the AR23 can fire several of these rounds at a rate of fire around 500RPM, not the fastest but more than makes up for it in accuracy.  The AR23 also comes with a customized underslung grenade launcher that specializes in launching 40mm Canister Grenades that can flush bad guys out of their hiding holes like the boars.  When it was released, the AR23 was compared to the Hawk; not a practical weapon for military use and only a niche weapon for paramilitary forces or gun enthusiasts wanting to add to their collection, yet actually became useful for shattering Cryons like a bull in a china shop."
     DisplayFOV=55.000000
     Priority=62
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBP_SKC_Pro.AR23Pickup'
     PlayerViewOffset=(X=7.000000,Y=7.00000,Z=-12.000000)
     PlayerViewPivot=(Pitch=384)
     BobDamping=2.000000
     AttachmentClass=Class'BWBP_SKC_Pro.AR23Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.AR23.SmallIcon_AR23'
     IconCoords=(X2=127,Y2=31)
     ItemName="AR23 Heavy Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AR23'
     DrawScale=0.300000
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	 Skins(1)=Shader'BWBP_SKC_Tex.AR23.AR23-MainShine'
	 Skins(2)=Shader'BWBP_SKC_Tex.AR23.AR23-MiscShine'
	 Skins(3)=Shader'BWBP_SKC_Tex.AR23.AR23-HoloShine'
	 Skins(4)=Texture'BWBP_SKC_Tex.AR23.Muzzle_2D_View'
}
