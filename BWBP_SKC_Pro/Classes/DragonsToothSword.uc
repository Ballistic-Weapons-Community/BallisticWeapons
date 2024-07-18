//=============================================================================
// DragonsToothSword.
//
// A very large and powerful sword capable of one hit kills.
// It is incredibly strong but attacks slower than all other melee weapons.
// Has a secondary lunge capable of extreme damage.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothSword extends BallisticMeleeWeapon;

var Actor	BladeGlow;				// Nano replicators
var Sound	LoopAmbientSound;
var() bool	bIsRed;
var() bool	bIsBlack;
var() bool	bIsGold;

var() BUtil.FullSound	ToothUpSound;		//Sound to play for up movement
var() BUtil.FullSound	ToothDownSound;		//Sound to play for down movement

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	
	bIsRed=false;
	bIsBlack=false;
	bIsGold=false;

	if (InStr(WeaponParams.LayoutTags, "red") != -1)
	{
		bIsRed=true;
	}
	if (InStr(WeaponParams.LayoutTags, "black") != -1)
	{
		bIsBlack=true;
	}
	if (InStr(WeaponParams.LayoutTags, "gold") != -1)
	{
		bIsGold=true;
	}
}

// Anim Notify for up movement
simulated function Notify_ToothUp ()
{
    class'BUtil'.static.PlayFullSound(self, ToothUpSound);
}

// Anim Notify for down movement
simulated function Notify_ToothDown ()
{
    class'BUtil'.static.PlayFullSound(self, ToothDownSound);
}


simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if ((Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.Team != None) )
	{
		if ( bIsRed /*Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 && Level.Game.bTeamGame */)
		{
			//Skins[1] = Shader'BWBP_SKC_Tex.DragonToothSword.DTS-Red';
			if (ThirdPersonActor != None)
				DragonsToothAttachment(ThirdPersonActor).bRedTeam=true;	
		}
	}

	Instigator.AmbientSound = LoopAmbientSound;
	Instigator.SoundVolume = 255;
	Instigator.SoundPitch = 48;
	Instigator.SoundRadius = 128;
	Instigator.bFullVolume = true;
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (BladeGlow != None)	
			BladeGlow.Destroy();

		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;

		return true;
	}
	return false;
}

simulated function Destroyed()
{
	if (BladeGlow != None)	
		BladeGlow.Destroy();

	if (Instigator.AmbientSound != None)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}

	super.Destroyed();
}


simulated function BladeEffectStart()
{
	if (bIsRed)
		class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffectR', DrawScale, self, 'BladeBase');
	else if (!bIsBlack && !bIsGold)
		class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffect', DrawScale, self, 'BladeBase');
	/*if ((Instigator.PlayerReplicationInfo != None) )
	{
		if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 && Level.Game.bTeamGame )
			class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffectR', DrawScale, self, 'BladeBase');
		else
			class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffect', DrawScale, self, 'BladeBase');
	}
	else
		class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffect', DrawScale, self, 'BladeBase');
*/
}

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (VSize(B.Enemy.Location - Instigator.Location) > FireMode[0].MaxRange()*1.5)
		return 1;
	Result = FRand();
	if (vector(B.Enemy.Rotation) dot Normal(Instigator.Location - B.Enemy.Location) < 0.0)
		Result += 0.3;
	else
		Result -= 0.3;

	if (Result > 0.5)
		return 1;
	return 0;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -1;
}
// End AI Stuff =====

defaultproperties
{
	ToothUpSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Up',Volume=1.190000,Radius=24.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	ToothDownSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Down',Volume=1.213000,Radius=24.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	LoopAmbientSound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Loop'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.DragonToothSword.BigIcon_DTS'
	BigIconCoords=(Y1=40,Y2=240)
	
	ManualLines(0)="Strikes once for fatal damage. Has a good range but a very slow swing rate."
	ManualLines(1)="Strikes twice consecutively for good damage. Good for baiting block."
	ManualLines(2)="The Weapon Function key allows the Nanoblade to block incoming frontal melee attacks.||Devastating at close range."
	SpecialInfo(0)=(Info="420.0;20.0;-999.0;-1.0;-999.0;0.9;-999.0")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Draw',Volume=1.000)
	bNoMag=True
	GunLength=0.000000
	bAimDisabled=True
	ParamsClasses(0)=Class'DragonsToothWeaponParamsComp'
	ParamsClasses(1)=Class'DragonsToothWeaponParamsClassic'
	ParamsClasses(2)=Class'DragonsToothWeaponParamsRealistic'
    ParamsClasses(3)=Class'DragonsToothWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.DragonsToothPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.DragonsToothSecondaryFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc11',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(G=207),Color2=(B=255,G=27,R=71,A=93),StartSize1=98,StartSize2=101)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)
	SelectAnim="PulloutFancy"
	SelectAnimRate=1.250000
	PutDownTime=0.500000
	BringUpTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	BlockIdleAnim="bLock"	
	AIRating=0.800000
	CurrentRating=0.800000
	bMeleeWeapon=True
	Description="The Dragon Nanoblade is a technological marvel. A weapon consisting of a nanotechnologically created blade which is dynamically 'forged' on command into a non-eutactic solid. Nanoscale whetting devices ensure that the blade is both unbreakable and lethally sharp. The true weapon of a modern warrior."
	Priority=12
	HudColor=(B=255,G=125,R=75)
	CenteredOffsetY=7.000000
	CenteredRoll=0
	PlayerViewOffset=(X=0.00,Y=0.00,Z=-30.00)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	GroupOffset=5
	PickupClass=Class'BWBP_SKC_Pro.DragonsToothPickup'
	BobDamping=1.000000
	AttachmentClass=Class'BWBP_SKC_Pro.DragonsToothAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.DragonToothSword.SmallIcon_DTS'
	IconCoords=(X2=127,Y2=31)
	ItemName="XM300 Dragon Nanoblade"
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_DTS'
	DrawScale=1.250000
	SoundRadius=32.000000
}
