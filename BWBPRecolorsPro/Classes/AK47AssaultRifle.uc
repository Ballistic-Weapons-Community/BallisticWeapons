//=============================================================================
// AK47BattleRifle.
//
// A powerful 7.62mm powerhouse. Fills a similar role to the CYLO UAW, albiet is
// far more reliable and has a launchable bayonet in place of the shotgun.
//=============================================================================
class AK47AssaultRifle extends BallisticWeapon;

var() name			KnifeLoadAnim;	//Anim for grenade reload
var   bool			bLoaded;

var() name			GrenBone;	
var() name			GrenBoneBase;
var() Sound		GrenLoadSound;				
var() Sound		GrenDropSound;		

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
		C.DrawTile( Texture'BallisticRecolors3TexPro.AK490.AK490-KnifeIcon',ScaleFactor2*2, ScaleFactor2, 0, 0, 256, 128);
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
	return AK47SecondaryFire(FireMode[1]).bLoaded;
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
	if (Ammo[1].AmmoAmount < 1 || AK47SecondaryFire(FireMode[1]).bLoaded)
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
	AK47SecondaryFire(FireMode[1]).bLoaded = True;
	AK47Attachment(ThirdPersonActor).bLoaded = True;
	FireMode[1].PreFireTime = FireMode[1].default.PreFireTime; 
	AK47MeleeFire(MeleeFireMode).SwitchBladeMode(AK47SecondaryFire(FireMode[1]).bLoaded);
}

simulated function BladeOut()
{
	bLoaded=False;
	AK47Attachment(ThirdPersonActor).bLoaded = False;
	AK47MeleeFire(MeleeFireMode).SwitchBladeMode(false);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (AK47SecondaryFire(FireMode[1]).bLoaded)
		AK47MeleeFire(MeleeFireMode).SwitchBladeMode(AK47SecondaryFire(FireMode[1]).bLoaded);
		
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
	if (AK47SecondaryFire(FireMode[1]).bLoaded)
		AK47Attachment(ThirdPersonActor).bLoaded = True;
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
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
     GrenLoadSound=Sound'PackageSounds4Pro.AK47.Knife-Load'
     GrenDropSound=Sound'PackageSounds4Pro.AK47.Knife-Drop'
     BulletBone="Bullet1"
     BulletBone2="Bullet2"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors3TexPro.AK490.BigIcon_AK490'
     BigIconCoords=(Y1=32,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Automatic 7.62mm fire. Higher sustained damage than other weapons in its class, but greater recoil and inferior hipfire ability."
     ManualLines(1)="Prepares a melee attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. If lacking a knife, becomes a blunt attack, dealing lower base damage but inflicting a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key manages the ballistic knife. If a knife is attached, it will be launched, dealing high damage. This attack is hip-accurate and has no recoil. If no knife is attached, one will be attached if available.||This weapon is effective at medium range."
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.5;0.8;0.0")
     MeleeFireClass=Class'BWBPRecolorsPro.AK47MeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=25
     CockAnimPostReload="ReloadEndCock"
     CockingBringUpTime=1.300000
     CockSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-Cock',Volume=3.500000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-ClipHit',Volume=3.500000)
     ClipOutSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-ClipOut',Volume=3.500000)
     ClipInSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-ClipIn',Volume=3.500000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(bUnavailable=True)
     bNoCrosshairInScope=True
     SightPivot=(Pitch=64)
     SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
     SightDisplayFOV=40.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
	 
     AimSpread=24
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=5000.000000
     ChaosAimSpread=1024
	 
	 ViewRecoilFactor=0.25
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.500000,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.300000,OutVal=0.40000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.10000
     RecoilYFactor=0.10000
	 RecoilDeclineDelay=0.15
     RecoilDeclineTime=0.65	 
	 
     FireModeClass(0)=Class'BWBPRecolorsPro.AK47PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.AK47SecondaryFire'
     IdleAnimRate=0.400000
     SelectAnimRate=1.700000
     PutDownAnimRate=1.750000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     Description="Chambering 7.62mm armor piercing rounds, this rifle is a homage to its distant predecessor, the AK-47. Though the weapons' looks have hardly changed at all, this model features a vastly improved firing mechanism, allowing it to operate in the most punishing of conditions. Equipped with a heavy reinforced stock, launchable ballistic bayonet, and 20 round box mag, this automatic powerhouse is guaranteed to cut through anything in its way. ZVT Exports designed this weapon to be practical and very easy to maintain. With its rugged and reliable design, the AK490 has spread throughout the cosmos and can be found just about anywhere."
     Priority=65
     HudColor=(G=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=5
     PickupClass=Class'BWBPRecolorsPro.AK47Pickup'
     PlayerViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.AK47Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.AK490.SmallIcon_AK490'
     IconCoords=(X2=127,Y2=31)
     ItemName="AK-490 Battle Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.AK490_FPNew'
     DrawScale=0.350000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors3TexPro.AK490.AK490-Main'
     Skins(2)=Texture'BallisticRecolors3TexPro.AK490.AK490-Misc'
}
