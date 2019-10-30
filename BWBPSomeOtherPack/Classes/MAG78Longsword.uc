//=============================================================================
// EKS43Katana.
//
// A large sword that takes advantage of a sweeping melee attack. More range
// than akinfe, but slower and can't be thrown. Can be used to block otehr
// melee attacks and has a held attack for secondary which sweeps down and is
// prone to headshots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MAG78LongSword extends BallisticMeleeWeapon;

var float		BladeAlpha;
var float		DesiredBladeAlpha;
var float		BladeShiftSpeed;
var float 		NextAmmoTickTime;

var VariableTexPanner	ChainsawPanner;
var float					ChainSpeed;

var bool		bLatchedOn;

replication
{
	reliable if (Role == ROLE_Authority)
		bLatchedOn;
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(128,0,255);
	Canvas.DrawText("Longsword: ChainSpeed: "$ChainSpeed$", Pan Rate: "$ChainsawPanner.PanRate$" BladeAlpha: "$BladeAlpha);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

simulated event Tick (float DT)
{
	super.Tick(DT);

	if (NextAmmoTickTime < level.TimeSeconds)
	{
		if (Ammo[0].AmmoAmount < Ammo[0].MaxAmmo)
			Ammo[0].AddAmmo(3);
		NextAmmoTickTime = level.TimeSeconds + 0.5;
	}
}

simulated event WeaponTick(float DT)
{
	local float AccelLimit;

	TickAim(DT);

	TickSighting(DT);

	if (!BCRepClass.default.bNoLongGun && GunLength > 0)
		TickLongGun(DT);
		
	TickFireCounter(DT);

	//Kab
	if (Instigator.Base != none)
        AimAdjustTime = (default.AimAdjustTime * 2) - (default.AimAdjustTime * (FMin(VSize(Instigator.Velocity - Instigator.Base.Velocity), 375) / 350));
    else
        AimAdjustTime = default.AimAdjustTime;

	if (FireMode[0].IsFiring())
	{
		ChainSpeed = 1;
	}
	
	else if (FireMode[1].IsFiring())
	{
		DesiredBladeAlpha = 0;
		BladeShiftSpeed = 4;

		if (BladeAlpha <= 0)
		{
			if (bLatchedOn && ChainSpeed != 1.5)
			{
				AccelLimit = (0.5 + 4.0*(ChainSpeed/2))*DT;
				ChainSpeed += FClamp(1.5 - ChainSpeed, -AccelLimit, AccelLimit);
			}
			
			else if (!bLatchedOn && ChainSpeed != 2)
			{
				AccelLimit = (0.5 + ChainSpeed) * DT;
				ChainSpeed += FClamp(2 - ChainSpeed, -AccelLimit, AccelLimit);
			}
		}
	}
	else if (ClientState == WS_ReadyToFire && FireMode[1].NextFireTime < level.TimeSeconds - 1)
	{
		if (ChainSpeed != 0)
		{
			AccelLimit = (0.5 + 1.5*(ChainSpeed/2))*DT;
			ChainSpeed += FClamp(-ChainSpeed, -AccelLimit, AccelLimit);
		}
		else
		{
			DesiredBladeAlpha = 1;
			BladeShiftSpeed = 3;
		}
	}
	if (DesiredBladeAlpha == 0)
		SoundPitch = 32 + 32 * ChainSpeed;
	else
		SoundPitch = default.SoundPitch;

	if (ChainsawPanner != None)
		ChainsawPanner.PanRate = -ChainSpeed * 8;
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	
 	ChainsawPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	
 	if (ChainsawPanner!=None)
	{
		ChainsawPanner.Material = Skins[2];
		ChainsawPanner.PanRate = 0;
		ChainsawPanner.PanDirection = rot(0, 0, 0);
 		Skins[2] = ChainsawPanner;
	}
	else
		Log("Failed to allocate chainsaw panner for MAG-78 Longsword");
}

simulated function PlayIdle()
{
	super.PlayIdle();
	if (ChainSpeed <=0)
	{
		DesiredBladeAlpha = 1;
		BladeShiftSpeed = 3;
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	ChainSpeed = 0.25;
	DesiredBladeAlpha = 0;
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		DesiredBladeAlpha = 0;
		BladeShiftSpeed = 3;
		return true;
	}
	return false;
}

simulated function Destroyed()
{
 	if (ChainsawPanner!=None)
 		level.ObjectPool.FreeObject(ChainsawPanner);

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

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = AIRating;
	// Enemy too far away
	if (Dist > 1500)
		return 0.1;			// Enemy too far away
	// Better if we can get him in the back
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0)
		Result += 0.08 * B.Skill;
	// If the enemy has a knife too, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result = FMax(0.0, Result *= 0.7 - (Dist/1000));
	// The further we are, the worse it is
	else
		Result = FMax(0.0, Result *= 1 - (Dist/1000));

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 4;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/1500));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.150000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_EKS43'
     BigIconCoords=(Y1=32,Y2=230)
     BCRepClass=Class'BallisticReplicationInfo'
     ManualLines(0)="Slashes with the longsword. Has a long range and moderate damage output."
     ManualLines(1)="Prepares a thrust, which will be extended to longpoint upon getting within reach of anything, rapidly dealing damage through the animation. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key allows the player to block. Whilst blocking, no attacks are possible, but all melee damage striking the player frontally will be mitigated.||The MAG-SAW is effective at close range, but has lower DPS than shorter ranged melee weapons."
     SpecialInfo(0)=(Info="240.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Putaway')
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'MAG78PrimaryFire'
     FireModeClass(1)=Class'MAG78SecondaryFire'
     PutDownTime=0.500000
     BringUpTime=0.500000
	 RecoilDeclineDelay=1
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.300000
     CurrentRating=0.300000
     bMeleeWeapon=True
	 Description="The MAG-SAW is a robust and efficient weapon that utilizes every surface as a dangerous implement. Developed in direct response to the EKS-43 Katana, the MAG-SAW features numerous cutting edge technologies to maximize effectiveness in any and all situations. Such as a titanium alloy blade to reduce weight, combined with a recently developed and 100% tested electro-magnetic drive system which turns the chain with ease and deadly power, the MAG-SAW easily lends itself to aggressive civilian defense. But it doesn't stop there; as demonstrated in the legendary Purge of Lignus CIXIIV by the mercenary group Kriegsknecht, among whom the MAG-SAW is held in high esteem, the MAG-SAW creates absolute butchery of Krao. In any situation, any place, and against any enemy the MAG-SAW is a fierce competitor against its counterpart."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=1
     PickupClass=Class'EKS43Pickup'
     PlayerViewOffset=(X=10.000000,Z=-20.000000)
     AttachmentClass=Class'MAG78Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_EKS43'
     IconCoords=(X2=127,Y2=31)
     ItemName="MAG-SAW Longsword"
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.ChainsawLongsword_FP'
     DrawScale=1.250000
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBPSomeOtherPackTex.Longsword.ChainsawLongswordShiny'
	 Skins(2)=Texture'BWBP4-Tex.DarkStar.DarkStarChain'
}
