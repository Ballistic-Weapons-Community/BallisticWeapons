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

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if ((Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.Team != None) )
	{
		if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
		{
			Instigator.SoundPitch = 48;
			Skins[1] = Shader'BallisticRecolors3TexPro.DragonToothSword.DTS-Red';
			if (ThirdPersonActor != None)
				DragonsToothAttachment(ThirdPersonActor).bRedTeam=true;	
		}
	}

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = 192;
	Instigator.SoundPitch = 64;
	Instigator.SoundRadius = 768;
	Instigator.bFullVolume = false;
}

simulated function BladeEffectStart()
{
	if ((Instigator.PlayerReplicationInfo != None) )
	{
		if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
			class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffectR', DrawScale, self, 'BladeBase');
		else
			class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffect', DrawScale, self, 'BladeBase');
	}
	else
		class'bUtil'.static.InitMuzzleFlash(BladeGlow, class'DragonsToothBladeEffect', DrawScale, self, 'BladeBase');

}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (BladeGlow != None)	BladeGlow.Destroy();
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
	if (BladeGlow != None)	BladeGlow.Destroy();
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
     PlayerSpeedFactor=1.150000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticRecolors3TexPro.DragonToothSword.BigIcon_DTS'
     BigIconCoords=(Y1=40,Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Strikes once for fatal damage. Has a good range but a very slow swing rate."
     ManualLines(1)="Strikes twice consecutively for good damage. Good for baiting block."
     ManualLines(2)="The Weapon Function key allows the Nanoblade to block incoming frontal melee attacks.||Devastating at close range."
     SpecialInfo(0)=(Info="420.0;20.0;-999.0;-1.0;-999.0;0.9;-999.0")
     BringUpSound=(Sound=Sound'PackageSounds4Pro.DTS.DragonsTooth-Draw',Volume=16.100000)
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BWBPRecolorsPro.DragonsToothPrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.DragonsToothSecondaryFire'
     SelectAnim="PulloutFancy"
     SelectAnimRate=1.250000
     PutDownTime=0.500000
     BringUpTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     bMeleeWeapon=True
     Description="The Dragon Nanoblade is a technological marvel. A weapon consisting of a nanotechnologically created blade which is dynamically 'forged' on command into a non-eutactic solid. Nanoscale whetting devices ensure that the blade is both unbreakable and lethally sharp. The true weapon of a modern warrior."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=125,R=75)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=5
     PickupClass=Class'BWBPRecolorsPro.DragonsToothPickup'
     BobDamping=1.000000
     AttachmentClass=Class'BWBPRecolorsPro.DragonsToothAttachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.DragonToothSword.SmallIcon_DTS'
     IconCoords=(X2=127,Y2=31)
     ItemName="XM300 Dragon Nanoblade"
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.DragonToothFP'
     DrawScale=1.250000
     SoundRadius=32.000000
}
