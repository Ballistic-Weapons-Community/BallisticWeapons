//=============================================================================
// AK47BattleRifle.
//
// A powerful 7.62mm powerhouse. Fills a similar role to the CYLO UAW, albiet is
// far more reliable and has a launchable bayonet in place of the shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ProtonStreamer extends BallisticWeapon;

var	ProtonStreamEffect			StreamEffect;
var	bool						bShieldOn;
var	Sound 						ShieldOnSound, ShieldOffSound;
var	float						LastShieldTick;
var	Pawn						DrainTarget, BoostTarget;
var ProtonGameRules				myRules;

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
		for (G = Level.Game.GameRulesModifiers; G != None && G.class != class'ProtonGameRules'; G = G.NextGameRules);
		
		if (G.class != class'ProtonGameRules')
		{
			G = spawn(class'ProtonGameRules');
			Level.Game.AddGameModifier(G);
		}
		
		myRules = ProtonGameRules(G);
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
		ProtonStreamAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
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
	
	ProtonStreamAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (Role == ROLE_Authority)
	{
		if (bShieldOn)
		{
			if (AmmoAmount(0) <= 1)
				DisableShield();
			else if (level.TimeSeconds >= LastShieldTick)
			{
				ConsumeAmmo(0, 1);
				LastShieldTick = level.TimeSeconds + 0.3;
			}
		}
	}
}

//===========================================================================
// Stream effect for FP.
//===========================================================================
simulated function RenderOverlays (Canvas C)
{
	Super.RenderOverlays(C);

	if (StreamEffect != None)
	{
		StreamEffect.bHidden = true;
		StreamEffect.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		
		//if (StreamEffect.Target != None)
		
		
			StreamEffect.UpdateEndpoint();
			
		/*else
		{
			StreamEffect.SetRotation(BallisticFire(FireMode[0]).GetFireAim(Start));
			AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
			End = Start + Normal(Vector(AimDir))*1500;
			Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
			if (Other == None)
				HitLocation = End;
				
			/*
			if (FireMode[0].bIsFiring)
				for (i=0; i<3; i++)
					BeamEmitter(StreamEffect.Emitters[i]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(HitLocation - StreamEffect.Location, HitLocation - StreamEffect.Location);
			else BeamEmitter(StreamEffect.Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(HitLocation - StreamEffect.Location, HitLocation - StreamEffect.Location);
			*/
			
			Magnitude = VSize(HitLocation - Start);
			
			HitLocation.X = Magnitude;
			HitLocation.Y = 0;
			HitLocation.Z = 0;
			
			if (FireMode[0].bIsFiring)
				for (i=0; i<3; i++)
					BeamEmitter(StreamEffect.Emitters[i]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(HitLocation, HitLocation);
			else BeamEmitter(StreamEffect.Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(HitLocation, HitLocation);
		}
		*/
		
		C.DrawActor(StreamEffect, false, false, Instigator.Controller.FovAngle);
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

simulated function BonusAmmo(float AppliedDmg)
{
	Ammo[0].AddAmmo(AppliedDmg);
}

simulated function bool MayNeedReload(byte Mode, float Load)
{
	return false;
}

function ServerStartReload (optional byte i);

simulated function string GetHUDAmmoText(int Mode)
{
	return "";
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
		if (Instigator.PlayerReplicationInfo != None)
		{
			if (Instigator.PlayerReplicationInfo.Team == None || Instigator.PlayerReplicationInfo.Team.TeamIndex == 1)
			{
				xPawn(Instigator).SetOverlayMaterial( Material'BWBP_OP_Tex.General.BlueExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBP_OP_Tex.General.BlueExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBP_OP_Tex.General.BlueExplosiveShieldMat', 300, true );
			}
			else
			{
				xPawn(Instigator).SetOverlayMaterial( Material'BWBP_OP_Tex.General.RedExplosiveShieldMat', 300, true );
				ThirdPersonActor.SetOverlayMaterial( Material'BWBP_OP_Tex.General.RedExplosiveShieldMat', 300, true );
				SetOverlayMaterial( Material'BWBP_OP_Tex.General.RedExplosiveShieldMat', 300, true );
			}
		}
	}
	else
	{
		bShieldOn = False;
		PlaySound(ShieldOffSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
		xPawn(Instigator).SetOverlayMaterial ( None, 0, true );
		ThirdPersonActor.SetOverlayMaterial ( None, 0, true );
		SetOverlayMaterial ( None, 0, true );
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

function DisableShield()
{
	bShieldOn = False;
	PlaySound(ShieldOffSound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	SetOverlayMaterial ( None, 0, true );
	ThirdPersonActor.SetOverlayMaterial( None, 0, true );
	xPawn(Instigator).SetOverlayMaterial ( None, 0, true );
}

// Aim goes bad when player takes damage
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (bShieldOn && !DamageType.default.bLocationalHit)
	{
		Damage *= 0.25;
		Momentum *= 0.25;
		return;
	}
	
	Super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 512); 
}

defaultproperties
{
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_OP_Tex.ProtonPack.BigIcon_ProtonPack'
	BigIconCoords=(Y1=32,X2=512,Y2=225)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Energy=True
	bWT_Heal=True
	SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BWBP_OP_Sounds.ProtonPack.Proton-Pullout')
	PutDownSound=(Sound=Sound'BWBP_OP_Sounds.ProtonPack.Proton-Putaway')
	bNoMag=True
	bNonCocking=True
	WeaponModes(0)=(ModeName="Proton Stream",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Neutrino Amplification",ModeID="WM_FullAuto")
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bUseSights=False
	bNoCrosshairInScope=True
	SightPivot=(Pitch=1024,Roll=-768)
	SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
	SightDisplayFOV=40.000000
	ParamsClass=Class'ProtonWeaponParams'
	FireModeClass(0)=Class'BWBPOtherPackPro.ProtonStreamPrimaryFire'
	FireModeClass(1)=Class'BWBPOtherPackPro.ProtonStreamSecondaryFire'
	SelectAnimRate=1.250000
	PutDownAnimRate=1.250000
	PutDownTime=0.600000
	BringUpTime=0.600000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	Description="Psycho-Kinetic Amplifier||Manufacturer: Unknown Skrith Engineers|Primary: Slower moving, Energy Fire|Secondary: Instant Beam||It has a fast fire rate, rechargeable batteries, a good accuracy, low damage, and every Skrith has one. The infamous A42 'Whip', as it was named by the UTC Marines, has been the standard issue Skrith sidearm in both wars. Though it may be accurate, have a fast rate of fire and an unlimited, rechargeable cell, the A42 does very little damage, and has less accuracy than others when running, making it an all-round ineffective weapon. The secondary attack is a recent feature, giving the weapon the ability to charge up a variable shot. This does make the weapon more powerful, yet it is still not as effective as other sidearms. The rechargable cell however, means that it is always there when you need the extra bit of range over the melee weapons."
	Priority=16
	HudColor=(G=75)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=5
	PickupClass=Class'BWBPOtherPackPro.ProtonStreamPickup'
	PlayerViewOffset=(X=40.000000,Y=15.000000,Z=-20.000000)
	PlayerViewPivot=(Pitch=1024,Yaw=-1024)
	AttachmentClass=Class'BWBPOtherPackPro.ProtonStreamAttachment'
	IconMaterial=Texture'BWBP_OP_Tex.ProtonPack.Icon_ProtonPack'
	IconCoords=(X2=127,Y2=31)
	ItemName="E90-N Particle Accelerator"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_ProtonPack'
	DrawScale=0.600000
	SoundPitch=56
	SoundRadius=32.000000
}
