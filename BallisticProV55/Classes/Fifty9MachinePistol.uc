//=============================================================================
// Fifty9MachinePistol.
//
// Dual wieldable weapon with select-fire, bullet style primary, melee blades
// for secondary and a special togglable stock that affect aim properties.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Fifty9MachinePistol extends BallisticWeapon;

var   name		StockOpenAnim;
var   name		StockCloseAnim;
var   bool		bStockOpen, bStockOpenRotated;
var   int StockChaosAimSpread;

// This uhhh... thing is added to allow manual drawing of brass OVER the muzzle flash
struct UziBrass
{
	var() actor Actor;
	var() float KillTime;
};
var   array<UziBrass>	UziBrassList;

replication
{
	reliable if (Role == ROLE_Authority)
		ServerSwitchStock;
}

simulated event WeaponTick (Float DT)
{
	Super.WeaponTick (DT);
	
	if (LastFireTime < Level.TimeSeconds - RecoilDeclineDelay && MeleeFatigue > 0)
		MeleeFatigue = FMax(0, MeleeFatigue - DT/RecoilDeclineTime);
}

simulated function float ChargeBar()
{
	return MeleeFatigue;
}

simulated function RenderSightFX(Canvas Canvas)
{
	local coords C;

	if (SightFX != None)
	{
		C = GetBoneCoords(SightFXBone);
		SightFX.SetLocation(C.Origin);
		if (RenderedHand < 0)
			SightFX.SetRotation( OrthoRotation(C.XAxis, -C.YAxis, C.ZAxis) - rot(0,0,8192) );
		else
			SightFX.SetRotation( OrthoRotation(C.XAxis, C.YAxis, C.ZAxis)  + rot(0,0,8192) );
		Canvas.DrawActor(SightFX, false, false, DisplayFOV);
	}
}

simulated function bool HasAmmoLoaded(byte Mode)
{
	if (Mode == 1)
		return true;
	if (bNoMag)
		return HasNonMagAmmo(Mode);
	else
		return HasMagAmmo(Mode);
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_Fifty9Clip';
}

simulated event RenderOverlays( Canvas Canvas )
{
	local int i;

	super.RenderOverlays (Canvas);

	if (UziBrassList.length < 1)
		return;

    bDrawingFirstPerson = true;
    for (i=UziBrassList.length-1;i>=0;i--)
    {
    	if (UziBrassList[i].Actor == None)
    		continue;
	    Canvas.DrawActor(UziBrassList[i].Actor, false, false, Instigator.Controller.FovAngle);
    	if (UziBrassList[i].KillTime <= level.TimeSeconds)
    	{
    		UziBrassList[i].Actor.bHidden=false;
    		UziBrassList.Remove(i,1);
    	}
    }
    bDrawingFirstPerson = false;
}

function ServerSwitchStock(bool bNewValue)
{
	bStockOpen = bNewValue;
	SwitchStock(bNewValue);
	AdjustUziProperties(false);
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	bStockOpen = !bStockOpen;
	TemporaryScopeDown(0.4);
	ServerSwitchStock(bStockOpen);
	SwitchStock(bStockOpen);
	AdjustUziProperties(false);
}

simulated function SwitchStock(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	SetBoneRotation('Stock', rot(0,0,0));
	if (bNewValue)
		PlayAnim(StockOpenAnim);
	else
		PlayAnim(StockCloseAnim);
}

simulated function AdjustUziProperties (bool bDualMode)
{
	if (bStockOpen)
	{
		BFireMode[0].RecoilPerShot *= 0.75;
		RecoilXFactor		*= 0.75;
		RecoilYFactor		*= 0.75;
		ChaosAimSpread = StockChaosAimSpread;
	}
	else
	{
		BFireMode[0].RecoilPerShot = BFireMode[0].default.RecoilPerShot;
		RecoilXFactor		= default.RecoilXFactor;
		RecoilYFactor		= default.RecoilYFactor;
		ChaosAimSpread = default.ChaosAimSpread;
	}
	
		ChaosAimSpread 		*= BCRepClass.default.AccuracyScale;
}

simulated function SetStockRotation()
{
	if (bStockOpen)
	{
		SetBoneRotation('Stock', rot(32768,0,0));
		bStockOpenRotated = true;
	}
	else
	{
		SetBoneRotation('Stock', rot(0,0,0));
		bStockOpenRotated = false;
	}
}

simulated function PlayIdle()
{
	if (bStockOpen && !bStockOpenRotated)
	{
		SetStockRotation();
		IdleTweenTime=0.0;
		super.PlayIdle();
		IdleTweenTime=default.IdleTweenTime;
	}
	else if (!bStockOpen && bStockOpenRotated)
		SetStockRotation();
	else
		super.PlayIdle();
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function PostBeginPlay()
{
	SetBoneRotation('tip', rot(0,0,8192));
	super.PostbeginPlay();
}

simulated function Notify_Fifty9Melee()
{
	if (Role == ROLE_Authority)
		Fifty9SecondaryFire(BFireMode[1]).NotifiedDoFireEffect();
	PlayOwnedSound(BFireMode[1].BallisticFireSound.Sound,
		BFireMode[1].BallisticFireSound.Slot,
		BFireMode[1].BallisticFireSound.Volume,
		BFireMode[1].BallisticFireSound.bNoOverride,
		BFireMode[1].BallisticFireSound.Radius,
		BFireMode[1].BallisticFireSound.Pitch,
		BFireMode[1].BallisticFireSound.bAtten);
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

	if (!HasAmmoLoaded(0))
		return 1;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 200)
		return 0;
	if (Dist < FireMode[1].MaxRange())
		return 1;
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

simulated function SetScopeBehavior()
{
	Super.SetScopeBehavior();
	AdjustUziProperties(false);
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.9;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

defaultproperties
{
	AIRating=0.85
	CurrentRating=0.85
	 AimDisplacementDurationMult=0.33
     StockOpenAnim="StockOut"
     StockCloseAnim="StockIn"
     StockChaosAimSpread=2048
     PlayerSpeedFactor=1.100000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_Fifty9'
     BigIconCoords=(Y1=24)
     SightFXClass=Class'BallisticProV55.Fifty9SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Sprays low-calibre bullets. Has an extremely high fire rate and very high DPS, but suffers from recoil and hip stability problems and has low penetration and awful effective range."
     ManualLines(1)="Continually slashes with the attached blade. Damage output is modest and range is low."
     ManualLines(2)="The Fifty-9's stock can be engaged or disengaged with the Weapon Function key. With the stock engaged, the recoil is reduced but the hipfire spread increases. The Fifty-9 is extremely effective at very close range."
     SpecialInfo(0)=(Info="120.0;10.0;0.8;40.0;0.0;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=24
     CockSound=(Sound=Sound'BallisticSounds2.UZI.UZI-Cock',Volume=0.800000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.UZI.UZI-ClipOut',Volume=0.700000)
     ClipInSound=(Sound=Sound'BallisticSounds2.UZI.UZI-ClipIn',Volume=0.700000)
     ClipInFrame=0.650000
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="Burst")
     bNoCrosshairInScope=True
     SightOffset=(X=-10.000000,Z=10.500000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     CrouchAimFactor=0.750000
     SightAimFactor=0.500000
     HipRecoilFactor=2.250000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=0.450000
     AimSpread=16
     ChaosSpeedThreshold=7500.000000
     RecoilXCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.300000
     RecoilMax=6144.000000
     RecoilDeclineDelay=0.120000
     FireModeClass(0)=Class'BallisticProV55.Fifty9PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.Fifty9SecondaryFire'
     PutDownTime=0.400000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     bShowChargingBar=True
     Description="Krome Firepower is a reletively new arms company, with the aim of producing guns with 'style'. The Fifty-9 is one such weapon. Taking an original small arm, and replacing certain parts, adding new attachments, custom paint jobs, etc. Krome weapons are designed for civilian purposes, self defense, bounty hunters, enthusiasts, and collectors. This particular model comes with attached Krome blades, to add some extra flair to the weapon."
     Priority=31
     HudColor=(B=255,G=125,R=75)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PickupClass=Class'BallisticProV55.Fifty9Pickup'
     PlayerViewOffset=(X=14.000000,Y=8.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.Fifty9Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_Fifty9'
     IconCoords=(X2=127,Y2=31)
     ItemName="Fifty-9 Machine Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProAnims.UZI'
     DrawScale=0.300000
}
