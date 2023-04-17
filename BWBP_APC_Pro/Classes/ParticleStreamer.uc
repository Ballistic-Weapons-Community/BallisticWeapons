//=============================================================================
// AK47BattleRifle.
//
// A powerful 7.62mm powerhouse. Fills a similar role to the CYLO UAW, albiet is
// far more reliable and has a launchable bayonet in place of the shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ParticleStreamer extends BallisticWeapon
	transient
	HideDropDown
	CacheExempt;

var	ParticleStreamEffectNew		StreamEffect;
var	ParticleStreamEffectChild		StreamEffectChild;
var	bool							bShieldOn;
var	Sound 						ShieldOnSound, ShieldOffSound;
var	float							LastShieldTick;
var	Pawn							DrainTarget, BoostTarget;
var ParticleGameRules			myRules;
var float NextAmmoTickTime;
var float	MaxStreamRange;
var	bool	bAlternateCheck;

replication
{
	reliable if (Role == ROLE_Authority)
		bShieldOn;
	reliable if (Role < ROLE_Authority)
		DisableShield;
}

simulated function PostBeginPlay() 
{
	local GameRules G;
	
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		for (G = Level.Game.GameRulesModifiers; G != None && G.class != class'ParticleGameRules'; G = G.NextGameRules);
		
		if (G.class != class'ParticleGameRules')
		{
			G = spawn(class'ParticleGameRules');
			Level.Game.AddGameModifier(G);
		}
		
		myRules = ParticleGameRules(G);
		myRules.AddStreamer(self);
	}
}

simulated function Destroyed()
{
	if (Role == ROLE_Authority)
		myRules.RemoveStreamer(self);
		
	Super.Destroyed();
}

function AttachToPawn(Pawn P)
{
	local name BoneName;

	Instigator = P;
	if ( ThirdPersonActor == None )
	{
		ThirdPersonActor = Spawn(AttachmentClass,Owner);
		InventoryAttachment(ThirdPersonActor).InitFor(self);
		ParticleStreamAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
	}
	else
		ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	BoneName = P.GetWeaponBoneFor(self);
	if ( BoneName == '' )
	{
		ThirdPersonActor.SetLocation(P.Location);
		ThirdPersonActor.SetBase(P);
	}
	else
		P.AttachToBone(ThirdPersonActor,BoneName);
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (IsFiring())
		return;
		
	Super.ServerSwitchWeaponMode(NewMode);
	
	ParticleStreamAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
}

simulated function ClientSwitchWeaponMode (byte newMode)
{
	if (IsFiring())
		return;
		
	Super.ClientSwitchWeaponMode(NewMode);
	
	ParticleStreamAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (Role == ROLE_Authority)
	{
		if (NextAmmoTickTime < level.TimeSeconds && !FireMode[0].bIsFiring && !FireMode[1].bIsFiring)
		{
			if (MagAmmo < default.MagAmmo && bShieldOn)
				MagAmmo=Min(default.MagAmmo, MagAmmo+3);
			if (bAlternateCheck)
			{
				if (MagAmmo < default.MagAmmo)
				{
					MagAmmo=Min(default.MagAmmo, MagAmmo+1);
					bAlternateCheck = false;
				}
			}	
			else
			bAlternateCheck = true;
			NextAmmoTickTime = level.TimeSeconds + 0.1;
		}
	}
}

//===========================================================================
// Stream effect for FP.
//===========================================================================
simulated function RenderOverlays (Canvas C)
{
	local int i;
	local vector	EndEffect;
	local float Magnitude;
	
	Super.RenderOverlays(C);

	if (StreamEffect != None)
	{
		StreamEffect.bHidden = true;
		StreamEffectChild.bHidden = true;
		StreamEffect.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		StreamEffectChild.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		if (StreamEffect.LinkedPawn != None)
		{
			EndEffect = ParticleStreamAttachment(ThirdPersonActor).EndEffect;
			StreamEffect.EndEffect = EndEffect;
			StreamEffectChild.EndEffect = EndEffect;
		}	
//		else
/*		if (StreamEffect.LinkedPawn != None)
		{
			Magnitude = VSize(HitLocation - Start);
			
			HitLocation.X = Magnitude;
			HitLocation.Y = 0;
			HitLocation.Z = 0;
		}*/
		C.DrawActor(StreamEffect, false, false, Instigator.Controller.FovAngle);
		C.DrawActor(StreamEffectChild, false, false, Instigator.Controller.FovAngle);
	}
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

//===========================================================================
// Misc.
//===========================================================================
simulated function FirePressed(float F)
{
	if (bNeedReload && MagAmmo > 0)
		bNeedReload = false;
	super.FirePressed(F);
}

/*simulated function BonusAmmo(float AppliedDmg)
{
	Ammo[0].AddAmmo(AppliedDmg);
}*/

simulated function bool MayNeedReload(byte Mode, float Load)
{
	return false;
}

function ServerStartReload (optional byte i);

simulated function string GetHUDAmmoText(int Mode)
{
	return "";
}

simulated function float AmmoStatus(optional int Mode)
{
    return float(MagAmmo) / float(default.MagAmmo);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (bPreventReload || bServerReloading)
		return;
	ServerWeaponSpecial(i);
	ReloadState = RS_GearSwitch;
	PlayAnim('SwitchPress');
}

function ServerWeaponSpecial(optional byte i)
{
	if (bPreventReload || bServerReloading)
		return;
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	PlayAnim('SwitchPress');
}

function Notify_SwitchPress()
{
	if (!bShieldOn)
	{
		bShieldOn = True;
		PlaySound(ShieldOnSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
		/*if (Instigator.PlayerReplicationInfo != None)
		{
			if (Instigator.PlayerReplicationInfo.Team == None || Instigator.PlayerReplicationInfo.Team.TeamIndex == 1)
			{
				xPawn(Instigator).SetOverlayMaterial( Material'BWBPOtherPackTex.General.BlueExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBPOtherPackTex.General.BlueExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBPOtherPackTex.General.BlueExplosiveShieldMat', 300, true );
			}
			else
			{
				xPawn(Instigator).SetOverlayMaterial( Material'BWBPOtherPackTex.General.RedExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBPOtherPackTex.General.RedExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBPOtherPackTex.General.RedExplosiveShieldMat', 300, true );
			}
		}*/
	}
	else
	{
		bShieldOn = False;
		PlaySound(ShieldOffSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
		/*xPawn(Instigator).SetOverlayMaterial ( None, 0, true );
		ThirdPersonActor.SetOverlayMaterial ( None, 0, true );
		SetOverlayMaterial ( None, 0, true );*/
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		DisableShield();
		return true;
	}
	return false;
}

function byte BestMode()
{
	return 0;
}

function DisableShield()
{
	bShieldOn = False;
	PlaySound(ShieldOffSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	/*SetOverlayMaterial ( None, 0, true );
	ThirdPersonActor.SetOverlayMaterial( None, 0, true );
	xPawn(Instigator).SetOverlayMaterial ( None, 0, true );*/
}

// Aim goes bad when player takes damage
/*function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (bShieldOn && !DamageType.default.bLocationalHit && DamageType.default.bArmorStops)
	{
		Damage = 0;
		Momentum=vect(0,0,0);
		return;
	}
	
	Super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}*/

defaultproperties
{
     ShieldOnSound=Sound'BWBP_OP_Sounds.ProtonPack.Proton-Putaway'
     ShieldOffSound=Sound'BWBP_OP_Sounds.ProtonPack.Proton-Pullout'
     MaxStreamRange=1500.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_OP_Tex.ProtonPack.BigIcon_ProtonPack'
     BigIconCoords=(Y1=32,X2=512,Y2=225)
     bWT_Energy=True
     bWT_Heal=True
     SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BWBP_OP_Sounds.ProtonPack.Proton-Pullout')
     PutDownSound=(Sound=Sound'BWBP_OP_Sounds.ProtonPack.Proton-Putaway')
     bNonCocking=True
     WeaponModes(0)=(ModeName="Gravity Proton Stream",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
	 NDCrosshairCfg=(Pic1=TexRotator'BW_Core_WeaponTex.DarkStar.DarkInA-Rot',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=115,R=113,A=176),Color2=(B=255,G=0,R=109,A=255),StartSize1=74,StartSize2=66)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     CurrentWeaponMode=0
     //bNotifyModeSwitch=True
     bUseSights=False
     bNoCrosshairInScope=True
     SightPivot=(Pitch=1024,Roll=-768)
     SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
     SightingTime=0.200000
     FireModeClass(0)=Class'BWBP_APC_Pro.ParticleStreamPrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.ParticleStreamSecondaryFire'
     SelectAnimRate=1.250000
     PutDownAnimRate=1.250000
     PutDownTime=0.600000
     BringUpTime=0.600000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="E90-N mk.II Proton Pack||Manufacturer: Apollo Industries|Primary: Wrangling Beam|Secondary: Healing Beam||Originally built for calibrating various scientifice instruments in the field, the rugged E90-N Particle Accelerator is able to emit measured streams of exotic particles in a fairly controlled manner with minimal risk of radiation exposure to its operator!||Its utility on the battlefield was put to the test on the arctic research station 379-B61 when a then unknown Cryon menace infected several of the researchers and turned them against the rest. The Cryon threat is now classified as as Class 5 free roaming nano-vapor, and due to its rather incorporeal nature, standard weapons would destroy the hosts it inhabited, but left the nano-swarm itself free to inhabit the next victim. The E90-N Particle Acclerator was on hand at the time, and it has proven highly effective at thoroughly and completely neutronizing the Cryon nanobots directly, and the savior scientist was able to quickly adjust the radiation output in time to bestow restoritive effects on what was left of the final hosts of the Cryon swarm, allowing them to survive a relatively long life without the use of several of their major organs."
     Priority=16
     HudColor=(G=75)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=1
     PickupClass=Class'BWBP_APC_Pro.ParticleStreamPickup'
     PlayerViewOffset=(X=35.000000,Y=15.000000,Z=-20.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BWBP_APC_Pro.ParticleStreamAttachment'
     IconMaterial=Texture'BWBP_OP_Tex.ProtonPack.Icon_ProtonPack'
     IconCoords=(X2=127,Y2=31)
     ItemName="E90-N Particle Accelerator MK.II"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_ProtonPack'
     DrawScale=0.600000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBP_OP_Tex.ProtonPack.proton_gun_SH1'
     SoundPitch=56
	 ParamsClasses(0)=Class'ParticleStreamerWeaponParams'
     SoundRadius=32.000000
}
