//================================================
// Riot Shield.
// 
// Transferred from JunkWars to add some shielding into BW.
//================================================
class BallisticShieldWeapon extends BallisticMeleeWeapon;

#exec OBJ LOAD FILE=BallisticProTextures.utx

var float AimDisplacementBlockThreshold; //Blocking melee will displace the shield. The duration of the displacement is based on how close the damage is to the threshold.

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	return 0;
}

//always offhand
function AttachToPawn(Pawn P)
{
	local name BoneName;

	Instigator = P;
	if ( ThirdPersonActor == None )
	{
		ThirdPersonActor = Spawn(AttachmentClass,Owner);
		InventoryAttachment(ThirdPersonActor).InitFor(self);
	}
	else
		ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	BoneName = P.GetOffhandBoneFor(self);
	if ( BoneName == '' )
	{
		ThirdPersonActor.SetLocation(P.Location);
		ThirdPersonActor.SetBase(P);
	}
	else
		P.AttachToBone(ThirdPersonActor,BoneName);
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
    local vector HitNormal;
    local float DF;
	local float AimDisplacementDuration;
	
	local class<BallisticDamageType> BDT;
	
	if (InstigatedBy != None && InstigatedBy.Controller != None && InstigatedBy.Controller.SameTeamAs(InstigatorController))
		return;
	
	if (bBerserk)
		Damage *= 0.75;

	BDT = class<BallisticDamageType>(DamageType);
	
	if (BDT != None && CheckReflect(HitLocation, HitNormal, 0.2))
	{
		if (bBlocked)
		{
			if (Instigator.bIsCrouched)	
				HandleCrouchBlockingDamageMitigation(Damage, Momentum, BDT);
			else 
				HandleBlockingDamageMitigation(Damage, Momentum, BDT);
		}
		else 
			HandlePassiveDamageMitigation(Damage, Momentum, BDT);

		BallisticAttachment(ThirdPersonActor).UpdateBlockHit();
	}

	if (BDT.default.bDisplaceAim && Damage >= BDT.default.AimDisplacementDamageThreshold && Level.TimeSeconds + BDT.default.AimDisplacementDuration > AimDisplacementEndTime)
	{
		AimDisplacementDuration = BDT.default.AimDisplacementDuration * AimDisplacementDurationMult;
	
		if (bBlocked && !IsFiring() && level.TimeSeconds > LastFireTime + 1 && BDT.default.bCanBeBlocked &&
			Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()) > 0.4
			&& AimDisplacementEndTime < Level.TimeSeconds && AimDisplacementFactor == 0)
		{
			Damage = 0;
			//BallisticAttachment(ThirdPersonActor).UpdateBlockHit();
			if (instigatedBy != None && BallisticWeapon(instigatedBy.Weapon) != None)
				BallisticWeapon(instigatedBy.Weapon).ApplyBlockFatigue();
			AimDisplacementEndTime = Level.TimeSeconds + FMin(2, 1.00 * (float(Damage)/AimDisplacementBlockThreshold));	
			ClientDisplaceAim(FMin(2, 1.00 * (float(Damage)/AimDisplacementBlockThreshold)));	
			return;
		}		
	
		if (BDT.default.AimDisplacementDamageThreshold == 0)
		{
			AimDisplacementEndTime = Level.TimeSeconds + FMin(2, AimDisplacementDuration);
			ClientDisplaceAim(FMin(2, AimDisplacementDuration));
		}
		else
		{
			AimDisplacementEndTime = Level.TimeSeconds + FMin(2, AimDisplacementDuration * (float(Damage)/BDT.default.AimDisplacementDamageThreshold));
			ClientDisplaceAim(FMin(2, AimDisplacementDuration * (float(Damage)/BDT.default.AimDisplacementDamageThreshold)));
		}
	}

	super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

function HandleCrouchBlockingDamageMitigation( out int Damage, out Vector Momentum, class<BallisticDamageType> DamageType)
{
	// defend against melee, ballistics and other blockables completely, but with pushback
	// massive damage reduction against
	if (DamageType.default.bCanBeBlocked || DamageType.default.bMetallic) 
	{
		Damage = 0;
		Momentum *= 2;
		return;
	}

	// locational non-melee non-metallic almost certainly means energy - deal some damage and push back
	if (DamageType.default.bLocationalHit)
	{
		Damage = Max(1, Damage - 30);
		return;
	}

	Damage = Max(1, Damage - 40);
	Momentum *= 2;
}

function HandleBlockingDamageMitigation( out int Damage, out Vector Momentum, class<BallisticDamageType> DamageType)
{
	// defend against melee and other blockables completely, but with pushback
	if (DamageType.default.bCanBeBlocked)
	{
		Damage = 0;
		Momentum *= 2;
		return;
	}
	
	// damage reduction against ballistics
	if (DamageType.default.bMetallic)
	{
		Damage = Max(1, Damage - 65);
		Momentum *= 2;
		return;
	}

	// locational non-melee non-metallic almost certainly means energy - deal some damage and push back
	if (DamageType.default.bLocationalHit)
	{
		Damage = Max(1, Damage - 30);
		return;
	}

	Damage = Max(1, Damage - 40);
	Momentum *= 2;
}

function HandlePassiveDamageMitigation( out int Damage, out Vector Momentum, class<BallisticDamageType> DamageType)
{
	// defend against melee and other blockables completely, but with pushback
	if (DamageType.default.bCanBeBlocked)
	{
		Damage = 0;
		Momentum *= 2;
		return;
	}
	
	// moderate passive damage reduction against ballistics
	if (DamageType.default.bMetallic)
	{
		Damage = Max(3, Damage - 30);
		Momentum *= 2;
		return;
	}

	// locational non-melee non-metallic almost certainly means energy - deal some damage and push back
	if (DamageType.default.bLocationalHit)
	{
		Damage = Max(6, Damage - 15);
		return;
	}

	// explosions push back
	Damage = Max(10, Damage - 20);
	Momentum *= 2;
}

simulated function ClientPlayerDamaged(byte DamageFactor)
{
	local float DF;
	if (level.NetMode != NM_Client)
		return;
	DF = float(DamageFactor)/255;
	ApplyDamageFactor(DF);
	bForceReaim=true;
}

simulated function ApplyDamageFactor (float DF)
{
	Reaim(0.1, 0.3*AimAdjustTime, DF*2, DF*2*(-6000 + 12000 * FRand()), DF*2*(-6000 + 12000 * FRand()));
}

function bool CheckReflect( Vector HitLocation, out Vector RefNormal, int AmmoDrain )
{
    local Vector HitDir;
    local Vector FaceDir;

    FaceDir = Vector(Instigator.Controller.Rotation);
    HitDir = Normal(Instigator.Location - HitLocation + Vect(0,0,8));

    RefNormal = FaceDir;

    if ( FaceDir dot HitDir < 0 )
        return true;

    return false;
}

function float GetAIRating()
{
	// bot should fall back to riot shield if no weapon within current range is more viable than 0.55 AI rating
	return AIRating; 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1.0;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -1.0;
}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=0.950000
	 AimDisplacementBlockThreshold=40.000000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPSomeOtherPackTex.BallisticShield.BigIcon_BallisticShield'
     BigIconCoords=(X1=180,Y1=0,X2=320,Y2=255)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=5
     ManualLines(0)="Attacks with the weapon and shield. The shield continues to block whilst attacking."
     ManualLines(1)="Prepared strike with the weapons."
     ManualLines(2)="Hold Weapon Function to block with the shield, which dramatically increases its defensive effectiveness at the cost of your ability to see. The shield is further bolstered in effectiveness if the user is crouching while blocking.||The ballistic shield reduces movement speed whilst active."
     SpecialInfo(0)=(Info="240.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Putaway')
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     AimSpread=32
     ChaosSpeedThreshold=3000.000000
     ChaosAimSpread=256
     FireModeClass(0)=Class'BWBPSomeOtherPack.BallisticShieldPrimaryFire'
     FireModeClass(1)=Class'BWBPSomeOtherPack.BallisticShieldSecondaryFire'
     PutDownTime=0.500000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.500000
     CurrentRating=0.5000000
     bMeleeWeapon=True
     Description="RSH-1034 Riot Shield||Manufacturer: Apollo Industries|Primary: Smash|Secondary: Prepared Bash||A defensive weapon capable of blocking many attack types. Reduces incoming frontal damage by 35 or reduces it to 25% of the original amount, whichever is greater. Blocks melee damage outright. Has no effect on non-locational damage such as gas and fire."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=4
     PickupClass=Class'BWBPSomeOtherPack.BallisticShieldPickup'
     PlayerViewOffset=(Y=75.000000,Z=-125.000000)
     AttachmentClass=Class'BWBPSomeOtherPack.BallisticShieldAttachment'
     IconMaterial=Texture'BWBPSomeOtherPackTex.BallisticShield.Icon_BallisticShield'
     IconCoords=(X2=256,Y2=31)
     ItemName="RSH-1034 Riot Shield"
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.BallisticShield_FP'
     DrawScale=1.250000
	 AimDisplacementDurationMult=0.0
}
