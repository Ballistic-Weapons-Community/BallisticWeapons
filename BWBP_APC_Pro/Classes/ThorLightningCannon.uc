//=============================================================================
// AK47BattleRifle.
//
// A powerful 7.62mm powerhouse. Fills a similar role to the CYLO UAW, albiet is
// far more reliable and has a launchable bayonet in place of the shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ThorLightningCannon extends BallisticWeapon
	transient
	HideDropDown
	CacheExempt;

var	ThorLCStreamEffectNew			StreamEffect;
var	ThorLCStreamEffectChild			StreamEffectChild;
var ThorLCGameRules					myRules;
var	Pawn							DrainTarget, BoostTarget;
var float							MaxStreamRange;
var	bool							bAlternateCheck;
var float	ClawAlpha;			// An alpha amount for claw movement interpolation

simulated function PostBeginPlay() 
{
	local GameRules G;
	
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		for (G = Level.Game.GameRulesModifiers; G != None && G.class != class'ThorLCGameRules'; G = G.NextGameRules);
		
		if (G.class != class'ThorLCGameRules')
		{
			G = spawn(class'ThorLCGameRules');
			Level.Game.AddGameModifier(G);
		}
		
		myRules = ThorLCGameRules(G);
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
		ThorLCAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
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
	
	ThorLCAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
}

simulated function ClientSwitchWeaponMode (byte newMode)
{
	if (IsFiring())
		return;
		
	Super.ClientSwitchWeaponMode(NewMode);
	
	ThorLCAttachment(ThirdPersonActor).ModeColor = CurrentWeaponMode;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (FireMode[0].bIsFiring)	
	{	
		if (ClawAlpha < 1)
		{
			ClawAlpha = FClamp(ClawAlpha + DT, 0, 1);
			SetBoneRotation('Claw1', rot(4096,0,0),0,ClawAlpha);
			SetBoneRotation('Claw2', rot(-4096,0,0),0,ClawAlpha);
			SetBoneRotation('Claw3', rot(-4096,0,0),0,ClawAlpha);
			SetBoneRotation('Claw1B', rot(4096,0,0),0,ClawAlpha);
			SetBoneRotation('Claw2B', rot(-4096,0,0),0,ClawAlpha);
			SetBoneRotation('Claw3B', rot(-4096,0,0),0,ClawAlpha);
		}	
	}
	else if (ClawAlpha > 0)
	{
		ClawAlpha = FClamp(ClawAlpha - DT/3, 0, 1);
		SetBoneRotation('Claw1', rot(4096,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2', rot(-4096,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3', rot(-4096,0,0),0,ClawAlpha);
		SetBoneRotation('Claw1B', rot(4096,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2B', rot(-4096,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3B', rot(-4096,0,0),0,ClawAlpha);
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
			EndEffect = ThorLCAttachment(ThirdPersonActor).EndEffect;
			StreamEffect.EndEffect = EndEffect;
			StreamEffectChild.EndEffect = EndEffect;
		}	
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

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		return true;
	}
	return false;
}

function byte BestMode()
{
	return 0;
}

defaultproperties
{
     MaxStreamRange=1500.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_OP_Tex.ProtonPack.BigIcon_ProtonPack'
     BigIconCoords=(Y1=32,X2=512,Y2=225)
     bWT_Energy=True
     bWT_Heal=True
     SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BWBP_CC_Sounds.ThorLG.Pullout')
     PutDownSound=(Sound=Sound'BWBP_CC_Sounds.ThorLG.Putaway')
	 ClipOutSound=(Sound=Sound'BWBP_CC_Sounds.ThorLG.ClipOut',Volume=1.250000)
	 ClipInSound=(Sound=Sound'BWBP_CC_Sounds.ThorLG.ClipIn',Volume=1.250000)
     bNonCocking=True
     WeaponModes(0)=(ModeName="Gravity Proton Stream",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
	 NDCrosshairCfg=(Pic1=TexRotator'BW_Core_WeaponTex.DarkStar.DarkInA-Rot',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=115,R=113,A=176),Color2=(B=255,G=0,R=109,A=255),StartSize1=74,StartSize2=66)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     CurrentWeaponMode=0
     bUseSights=False
     bNoCrosshairInScope=True
     SightPivot=(Pitch=1024,Roll=-768)
     SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
     SightingTime=0.200000
     FireModeClass(0)=Class'BWBP_APC_Pro.ThorLCPrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.ThorLCSecondaryFire'
     PutDownTime=1.100000
	 BringUpTime=1.100000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="To Add"
     Priority=16
     HudColor=(G=75)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=1
	 bShowChargingBar=True
     PickupClass=Class'BWBP_APC_Pro.ThorLCPickup'
     PlayerViewOffset=(X=7.000000,Y=10.000000,Z=-10.000000)
     AttachmentClass=Class'BWBP_APC_Pro.ThorLCAttachment'
     IconMaterial=Texture'BWBP_OP_Tex.ProtonPack.Icon_ProtonPack'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] BR-99 'Thor' Lightning Cannon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_ThorLG'
     DrawScale=0.250000
     SoundPitch=56
     SoundRadius=32.000000
	 ParamsClasses(0)=Class'ThorLCWeaponParams'
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
