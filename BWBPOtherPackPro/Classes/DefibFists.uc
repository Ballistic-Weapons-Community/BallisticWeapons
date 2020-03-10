//==============================================================================
// Unarmed attack style 1, "Brawling" FIXME
//
// Just an unarmed attack style using various punches. Nothing complicated, just
// some quick jabs for primary fire and a powerful haymaker or uppercut for alt
// fire, which should be useful for knocking the enemy back.
//
// by Casey "Xavious" Johnson
//==============================================================================
class DefibFists extends BallisticMeleeWeapon;

var() int			ElectroCharge;
var() float			DeflectionAmount;
var() float			PulseCharge;
var() float			PulseInterval;
var	float 			LastPulse;
var	float 			LastRecharge;
var	Actor			LSparks;
var	Actor			RSparks;
var	float			PointsHealed;	// Counter to keep track of points healed, will not exceed 50 x HealRatio (will not regenerate more than 50HP before healing again)
var()	float			HealRatio;		// How many points medic must heal for every 1 HP regenerated
var	float			LastRegen;
var() Sound		PulseSound;	
var	bool			bSetAmbient;
var	bool			bDischarged;
var class<DamageType> PulseDamageType;

simulated function bool HasAmmo()
{
    return true;
}
  
simulated function float ChargeBar()
{
	return float(MagAmmo)/100.0f;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (LSparks != None)
		LSparks.Destroy();
	if (RSparks != None)
		RSparks.Destroy();
	if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	LSparks = None;
		class'BUtil'.static.InitMuzzleFlash (LSparks, class'DefibFistsTazerEffect', DrawScale, self, 'LElectrode');
    	RSparks = None;
		class'BUtil'.static.InitMuzzleFlash (RSparks, class'DefibFistsTazerEffect', DrawScale, self, 'RElectrode');		
	}
	
	//bMedicVision = True;	// MedicVision
}

simulated event Destroyed()
{
	if (LSparks != None)
		LSparks.Destroy();
	if (RSparks != None)
		RSparks.Destroy();		
	super.Destroyed();
}

simulated event Tick (float DT)
{
	if (MagAmmo >= 10 && bDischarged)
	{
		if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
		{
			LSparks = None;
			class'BUtil'.static.InitMuzzleFlash (LSparks, class'DefibFistsTazerEffect', DrawScale, self, 'LElectrode');
			RSparks = None;
			class'BUtil'.static.InitMuzzleFlash (RSparks, class'DefibFistsTazerEffect', DrawScale, self, 'RElectrode');	
			bDischarged = False;			
		}
	}
	
	else if (MagAmmo < 10 && !bDischarged)
	{
		if (LSparks != None)
			Emitter(LSparks).Kill();
		LSparks = None;
		if (RSparks != None)
			Emitter(RSparks).Kill();
		RSparks = None;
		bDischarged = True;
	}
	
	super.Tick(DT);
	
	if (Role == ROLE_Authority)
	{
		if (ElectroCharge < default.ElectroCharge && !bBlocked && Level.TimeSeconds > LastRecharge)
		{
			ElectroCharge = Min(150, ElectroCharge + 5);
			LastRecharge = Level.TimeSeconds + 1.5;
		}
		MagAmmo = ElectroCharge;
	}
	

}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (Role < ROLE_Authority)
		return;
		
	if (Level.TimeSeconds > LastPulse)
	{
		if (bBlocked && ElectroCharge >= PulseCharge)
		{
			if (!bSetAmbient)
			{
				bPlayAmbient(True);
				bSetAmbient = True;
			}
			
			ElectroPulseWave(5, 350, class'DTShockGauntlet', 10000, Instigator.Location);
			LastPulse = Level.TimeSeconds + PulseInterval;
			ElectroCharge -= PulseCharge;			
			DefibFistsAttachment(ThirdPersonActor).DoWave(false);
		}
		
		else if (bSetAmbient)
		{
			bPlayAmbient(False);
			bSetAmbient = False;
		}		
	}
	
	if (Level.TimeSeconds > LastRegen)
	{
		LastRegen = Level.TimeSeconds + 0.50;		
		if (PointsHealed >= HealRatio && Instigator.Health < Instigator.HealthMax * 1.20)
		{
			if (PointsHealed > 250)
				PointsHealed = 250;	
			Instigator.Health++;
			PointsHealed -= HealRatio;
		}
	}
}	

simulated function bPlayAmbient( bool bPulseOn)
{
	if (bPulseOn)
	{
		Instigator.AmbientSound = PulseSound;
		Instigator.SoundVolume = 128;
	}
	else
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = 0;
	}		
}
	
function ElectroPulseWave( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector ShockWaveStart)
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local BallisticPawn PulseTarget;
	local int PrevHealth;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, ShockWaveStart )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if(Victims != Self && (Victims.Role == ROLE_Authority) && Victims.bCanBeDamaged && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Instigator)
		{
			PulseTarget=BallisticPawn(Victims);
			if(IsValidHealTarget(PulseTarget))
			{
				PrevHealth = PulseTarget.Health;			
				DamageAmount = 0;
				PulseTarget.GiveAttributedHealth(5, 100, Instigator);
				PointsHealed += PulseTarget.Health - PrevHealth;						
				continue;
			}
			else
			{
				dir = Victims.Location - ShockWaveStart;
				dist = FMax(1,VSize(dir));
				dir = dir/dist;
				damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
				
				class'BallisticDamageType'.static.GenericHurt
				(
					Victims,
					damageScale * DamageAmount,
					Instigator,
					Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
					damageScale * Momentum * dir,
					PulseDamageType
				);
			}
		}
	}
	bHurtEntry = false;
}

function ElectroShockWave( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector ShockWaveStart)
{
	local actor Victims;
	local float damageScale, dist, finalDamage;
	local vector dir;
	local BallisticPawn ShockTarget;
	local int PrevHealth;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, ShockWaveStart )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if(Victims != Self && (Victims.Role == ROLE_Authority) && Victims.bCanBeDamaged && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Instigator)
		{
			ShockTarget=BallisticPawn(Victims);
			if(IsValidHealTarget(ShockTarget))
			{
				PrevHealth = ShockTarget.Health;
				DamageAmount = 0;
				ShockTarget.GiveAttributedHealth(15, 100, Instigator);
				PointsHealed += ShockTarget.Health - PrevHealth;	
				continue;
			}
			else
			{
				dir = Victims.Location - ShockWaveStart;
				dist = FMax(1,VSize(dir));
				dir = dir/dist;
				damageScale = FClamp(1 - (dist - Victims.CollisionRadius)/DamageRadius, 0, 1);
				finalDamage = damageScale * DamageAmount;
				
				class'BallisticDamageType'.static.GenericHurt
				(
					Victims,
					finalDamage,
					Instigator,
					Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
					damageScale * Momentum * dir,
					DamageType
				);
			}
		}
	}
	bHurtEntry = false;
}

function bool IsValidHealTarget(Pawn PulseTarget)
{
	if(PulseTarget==None||PulseTarget==Instigator)
		return False;

	if(PulseTarget.Health<=0)
		return False;

	if(!Level.Game.bTeamGame)
		return False;

	if(Vehicle(PulseTarget)!=None)
		return False;

	return (PulseTarget.Controller!=None&&Instigator.Controller.SameTeamAs(PulseTarget.Controller));
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local int Drain;
	
	if (ElectroCharge > 0 &&
	bBlocked && 
	!IsFiring() && 
	level.TimeSeconds > LastFireTime + 1 && 
	class<BallisticDamageType>(DamageType) != None && 
	Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()) > 0.4)
	{
		if (class<BallisticDamageType>(DamageType).default.bCanBeBlocked)
			Damage = 0;
		else
		{
			if (Damage - DeflectionAmount < 0)
			{
				Drain = Damage * 0.25;
				Damage = 0;
			}
			else
			{
				Drain = DeflectionAmount * 0.25;
				Damage -= DeflectionAmount;
			}
			ElectroCharge = Max(ElectroCharge - Drain, 0);
		}
		BallisticAttachment(ThirdPersonActor).UpdateBlockHit();		
	}
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
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

simulated function float AmmoStatus(optional int Mode)
{
    return float(MagAmmo) / float(default.MagAmmo);
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
     ElectroCharge=100
     DeflectionAmount=35.000000
     PulseCharge=10.000000
     PulseInterval=0.500000
     HealRatio=5.000000
     PulseSound=Sound'BWBP2-Sounds2.LightningGun.LG-FireLoop'
     PulseDamageType=Class'BWBPOtherPackPro.DTShockGauntletPulse'
     PlayerSpeedFactor=1.100000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPOtherPackTex.DefibFists.BigIcon_DefibFists'
     BigIconCoords=(X1=96,Y1=10,X2=418,Y2=245)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=6
     bWT_Heal=True
     ManualLines(0)="Strike with the gauntlets. Deals minor damage when charged and blinds the opponent for a short duration. When discharged, deals poor damage. Allies struck by this attack will be healed. A successful strike depletes charge."
     ManualLines(1)="Uppercut with the gauntlets. Deals good damage with some charge remaining. Allies struck will be healed. With over 55% charge, gains power, discharging a shockwave which increases the effectiveness of the attack and causes some radius damage. A successful or empowered strike depletes charge."
     ManualLines(2)="Holding Weapon Function allows the defibrillators to block. This generates a frontal shield which reduces damage from attacks by 35. The weapon will also project pulses which inflict poor healing or damage upon nearby targets. Melee attacks are blocked regardless of charge. Charge drains over time with the shield engaged.||Effective in a defensive and supporting role."
     SpecialInfo(0)=(Info="0.0;-999.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     MagAmmo=100
     WeaponModes(0)=(ModeName="Strikes")
     WeaponModes(1)=(ModeName="KILL!",ModeID="WM_FullAuto")
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BWBPOtherPackPro.DefibFistsPrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.DefibFistsSecondaryFire'
     PutDownTime=0.660000
     BringUpTime=0.660000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.200000
     CurrentRating=0.200000
     bMeleeWeapon=True
     bCanThrow=False
     Description="The FMD H14 Combat Defibrillator is the go-to weapon of combat medics everywhere. Discharging electrical pulses from a pair of gauntlets, it can be used in both offensive and defensive roles. However, charge is limited, and when it is depleted the weapon becomes nearly useless."
     DisplayFOV=65.000000
     Priority=1
     HudColor=(G=0)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=1
     PickupClass=Class'BWBPOtherPackPro.DefibFistsPickup'
     PlayerViewOffset=(X=40.000000,Z=-10.000000)
     AttachmentClass=Class'BWBPOtherPackPro.DefibFistsAttachment'
     IconMaterial=Texture'BWBPOtherPackTex.DefibFists.Icon_DefibFists'
     IconCoords=(X2=127,Y2=31)
     ItemName="FMD H14 Combat Defibrillator"
     Mesh=SkeletalMesh'BWBPOtherPackAnim.DefibFists'
     DrawScale=0.600000
     bFullVolume=True
     SoundVolume=64
     SoundRadius=128.000000
}
