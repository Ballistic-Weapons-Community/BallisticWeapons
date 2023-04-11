//=============================================================================
// AK490BattleRifle.
//
// A powerful 7.62mm powerhouse. Fills a similar role to the CYLO UAW, albiet is
// far more reliable and has a launchable bayonet in place of the shotgun.
//
// by Sarge, based on code by DC
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK490BattleRifle extends BallisticWeapon;

var() name			KnifeLoadAnim;	//Anim for grenade reload
var   bool			bLoaded;

var() name			GrenBone;	
var() name			GrenBoneBase;
var() Sound		    GrenLoadSound;				
var() Sound		    GrenDropSound;		

var() name			KnifeBackAnim;
var() name			KnifeThrowAnim;
var   float			NextThrowTime;

var name			BulletBone, BulletBone2;

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function DrawWeaponInfo(Canvas C)
{
	NewDrawWeaponInfo(C, 0);
}

simulated function NewDrawWeaponInfo(Canvas C, Float YPos)
{
	local float ScaleFactor2;
	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int	TempNum;
	
	ScaleFactor = C.ClipX / 1600;
	ScaleFactor2 = 99 * C.ClipX/3200;
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
    if(bLoaded)
    {
		C.SetPos(C.ClipX - (2.5) * ScaleFactor2, C.ClipY - 110 * ScaleFactor * class'HUD'.default.HudScale);
		C.DrawTile( Texture'BWBP_SKC_Tex.AK490.AK490-KnifeIcon',ScaleFactor2*2, ScaleFactor2, 0, 0, 256, 128);
	}

	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipX / 1600;
	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		TempNum = Ammo[1].AmmoAmount;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(TempNum, false);
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
	}

	// This is pretty damn disgusting, but the weapon seems to be the only way we can draw extra info on the HUD
	// Would be nice if someone could have a HUD function called along the inventory chain
	if (SprintControl != None && SprintControl.Stamina < SprintControl.MaxStamina)
	{
		SprintFactor = SprintControl.Stamina / SprintControl.MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;
		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);
		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

simulated function bool IsKnifeLoaded()
{
	return AK490SecondaryFire(FireMode[1]).bLoaded;
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

	if (Anim == 'Fire' || Anim == 'KnifeFire' || Anim == 'ReloadEmpty')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 2)
		{
			SetBoneScale(2,0.0,BulletBone);
			SetBoneScale(3,0.0,BulletBone2);
		}
	}
	super.AnimEnd(Channel);
}

// Load in a grenade
simulated function LoadKnife()
{
	if (Ammo[1].AmmoAmount < 1 || AK490SecondaryFire(FireMode[1]).bLoaded)
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
			CommonStartReload(i);
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
	AK490SecondaryFire(FireMode[1]).bLoaded = True;
	AK490Attachment(ThirdPersonActor).bLoaded = True;
	FireMode[1].PreFireTime = FireMode[1].default.PreFireTime; 
	AK490MeleeFire(MeleeFireMode).SwitchBladeMode(AK490SecondaryFire(FireMode[1]).bLoaded);
}

simulated function BladeOut()
{
	bLoaded=False;
	AK490Attachment(ThirdPersonActor).bLoaded = False;
	AK490MeleeFire(MeleeFireMode).SwitchBladeMode(false);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (AK490SecondaryFire(FireMode[1]).bLoaded)
		AK490MeleeFire(MeleeFireMode).SwitchBladeMode(AK490SecondaryFire(FireMode[1]).bLoaded);
		
	else
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}
	
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
	}

	super.BringUp(PrevWeapon);
}

function AttachToPawn(Pawn P)
{
	Super.AttachToPawn(P);
	if (AK490SecondaryFire(FireMode[1]).bLoaded)
		AK490Attachment(ThirdPersonActor).bLoaded = True;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(2,1.0,BulletBone);
	SetBoneScale(3,1.0,BulletBone2);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
	{
		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
	}
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
	local float Dist;

	B = Bot(Instigator.Controller);
	
	if ( (B == None) || (B.Enemy == None) )
		return 0;
		
	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	if (Dist < 1024 && FRand() > 0.75)
		return 1;
		
	return 0;
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}
// End AI Stuff =====

defaultproperties
{
	KnifeLoadAnim="ReloadKnife"
	bLoaded=True
	GrenBone="KnifeBlade"
	GrenBoneBase="AttachKnife"
	GrenLoadSound=Sound'BWBP_SKC_Sounds.AK490.Knife-Load'
	GrenDropSound=Sound'BWBP_SKC_Sounds.AK490.Knife-Drop'
	BulletBone="Bullet1"
	BulletBone2="Bullet2"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.AK490.BigIcon_AK490'
	BigIconCoords=(Y1=32,Y2=220)
	
	bWT_Bullet=True
	ManualLines(0)="Automatic 7.62mm fire. High sustained damage and long effective range, but high recoil and inferior hipfire controllability."
	ManualLines(1)="If a knife is attached, it will be launched, dealing high damage. The user must hold the fire key for a short time to prepare the knife for launch.||If no knife is attached, one will be attached if available."
	ManualLines(2)="The AK-490 has a melee attack option. The damage is weakened if the knife has been fired.||The Weapon Function key ||This weapon is effective at medium range."
	SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.5;0.8;0.0")
	MeleeFireClass=Class'BWBP_SKC_Pro.AK490MeleeFire'
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-Draw',Volume=3.500000)
	PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-Putaway',Volume=3.500000)
	CockAnimPostReload="ReloadEndCock"
	//CockingBringUpTime=1.300000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-Cock',Volume=3.500000)
	ReloadAnimRate=1.250000
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipHit',Volume=3.500000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipOut',Volume=3.500000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipIn',Volume=3.500000)
	ClipInFrame=0.650000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50In',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=255,G=255,R=255,A=172),Color2=(B=0,G=0,R=255,A=197),StartSize1=71,StartSize2=55)
	bCockOnEmpty=True
	WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
	WeaponModes(1)=(bUnavailable=True)
	bNoCrosshairInScope=True

	PlayerViewOffset=(X=5.00,Y=3.50,Z=-4.500000)
	SightOffset=(X=-6.500000,Y=0.02,Z=2.55)
	SightPivot=(Pitch=64)

	ParamsClasses(0)=Class'AK490WeaponParamsComp'
	ParamsClasses(1)=Class'AK490WeaponParamsClassic'
	ParamsClasses(2)=Class'AK490WeaponParamsRealistic'
    ParamsClasses(3)=Class'AK490WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.AK490PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.AK490SecondaryFire'
	IdleAnimRate=0.400000
	SelectAnimRate=1.700000
	PutDownAnimRate=1.750000
	BringUpTime=0.400000
	CockingBringUpTime=2.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	Description="Chambering 7.62mm armor piercing rounds, this rifle is a homage to its distant predecessor, the AK-47. Though the weapons' looks have hardly changed at all, this model features a vastly improved firing mechanism, allowing it to operate in the most punishing of conditions. Equipped with a heavy reinforced stock, launchable ballistic bayonet, and 20 round box mag, this automatic powerhouse is guaranteed to cut through anything in its way. ZVT Exports designed this weapon to be practical and very easy to maintain. With its rugged and reliable design, the AK490 has spread throughout the cosmos and can be found just about anywhere."
	Priority=65
	HudColor=(G=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	GroupOffset=5
	PickupClass=Class'BWBP_SKC_Pro.AK490Pickup'
	SightBobScale=0.15f
	AttachmentClass=Class'BWBP_SKC_Pro.AK490Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.AK490.SmallIcon_AK490'
	IconCoords=(X2=127,Y2=31)
	ItemName="AK-490 Battle Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AK490'
	DrawScale=0.30000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
