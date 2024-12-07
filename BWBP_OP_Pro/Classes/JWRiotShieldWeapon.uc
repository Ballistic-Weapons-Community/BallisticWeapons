//================================================
// Riot Shield.
// 
// Transferred from JunkWars to add some shielding into BW.
//================================================
class JWRiotShieldWeapon extends BallisticMeleeWeapon
	transient
	HideDropDown
	CacheExempt;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx

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

	super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

function HandleCrouchBlockingDamageMitigation( out int Damage, out Vector Momentum, class<BallisticDamageType> DamageType)
{
	if (!DamageType.default.bArmorStops)
		return;

	// defend against melee and other blockables completely, but with pushback
	if (DamageType.default.bCanBeBlocked)
	{
		Damage = 0;
		Momentum *= 2;
		return;
	}

	Damage *= 0.2;
	Momentum *= 2;
	return;

	// defend against melee, ballistics and other blockables completely, but with pushback
	// massive damage reduction against
	if (DamageType.default.bCanBeBlocked || DamageType.default.bMetallic) 
	{
		Damage = Max(Damage/6, Damage - 35);
		Momentum *= 2;
		return;
	}

	// locational non-melee non-metallic almost certainly means energy - deal some damage and push back
	if (DamageType.default.bLocationalHit)
	{
		Damage = Max(Damage/6, Damage - 30);
		return;
	}

	Damage = Max(Damage/20, Damage - 50);
	Momentum *= 2;
}

function HandleBlockingDamageMitigation( out int Damage, out Vector Momentum, class<BallisticDamageType> DamageType)
{
	if (!DamageType.default.bArmorStops)
		return;

	// defend against melee and other blockables completely, but with pushback
	if (DamageType.default.bCanBeBlocked)
	{
		Damage = 0;
		Momentum *= 2;
		return;
	}

	Damage *= 0.3;
	Momentum *= 2;
	return;

	// damage reduction against ballistics
	if (DamageType.default.bMetallic)
	{
		Damage = Max(Damage/5, Damage - 20);
		Momentum *= 2;
		return;
	}

	// locational non-melee non-metallic almost certainly means energy - deal some damage and push back
	if (DamageType.default.bLocationalHit)
	{
		Damage = Max(Damage/5, Damage - 20);
		return;
	}

	Damage = Max(1, Damage - 30);
	Momentum *= 2;
}

function HandlePassiveDamageMitigation( out int Damage, out Vector Momentum, class<BallisticDamageType> DamageType)
{
	if (!DamageType.default.bArmorStops)
		return;

	// actually have to block to reduce melee damage
	Damage *= 0.45;
	Momentum *= 2;
	return;

	// moderate passive damage reduction against ballistics
	if (DamageType.default.bMetallic)
	{
		Damage = Max(Damage/3, Damage - 10);
		Momentum *= 2;
		return;
	}

	// locational non-melee non-metallic almost certainly means energy - deal some damage and push back
	if (DamageType.default.bLocationalHit)
	{
		Damage = Max(Damage/2, Damage - 10);
		return;
	}

	// explosions push back
	Damage = Max(Damage/4, Damage - 15);
	Momentum *= 2;
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
	 AimDisplacementBlockThreshold=40.00
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Misc.BigIcon_Shield'
     BigIconCoords=(X1=180,Y1=0,X2=320,Y2=255)
     
     ManualLines(0)="Attacks with the weapon and shield. The shield continues to block whilst attacking."
     ManualLines(1)="Prepared strike with the weapons."
     ManualLines(2)="The ballistic shield reduces movement speed whilst active."
     SpecialInfo(0)=(Info="240.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway')
     bNoMag=True
	 GunLength=0.000000
	 ParamsClasses(0)=Class'BallisticShieldWeaponParamsComp'
     FireModeClass(0)=Class'BWBP_OP_Pro.BallisticShieldPrimaryFire'
     FireModeClass(1)=Class'BWBP_OP_Pro.BallisticShieldSecondaryFire'
     PutDownTime=0.500000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.500000
     CurrentRating=0.5000000
     bMeleeWeapon=True
     Description="Civilian Riot Shield||Manufacturer: Various Civilian Manufacturers|Primary: Smash|Secondary: Prepared Bash||A defensive weapon capable of blocking many attack types. Reduces incoming frontal damage by 35 or reduces it to 25% of the original amount, whichever is greater. Blocks melee damage outright. Has no effect on non-locational damage such as gas and fire."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=200,R=200)
	 NDCrosshairCfg=(Pic1=None,Pic2=Texture'BW_Core_WeaponTex.Crosshairs.R78OutA',USize1=128,VSize1=128,USize2=256,VSize2=256,Color1=(B=0,G=0,R=255,A=255),Color2=(B=255,G=125,R=0,A=255),StartSize1=96,StartSize2=96)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=4
     PickupClass=Class'BWBP_OP_Pro.JWRiotShieldPickup'
     PlayerViewOffset=(Y=75.000000,Z=-100.000000)
     AttachmentClass=Class'BWBP_OP_Pro.JWRiotShieldAttachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.Icon_JWRiot'
     IconCoords=(X2=256,Y2=31)
     ItemName="Civilian Riot Shield"
     Mesh=SkeletalMesh'BWBP_OP_Anim.CivShield_FPm'
     DrawScale=1.250000
}
