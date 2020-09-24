//================================================
// Riot Shield.
// 
// Transferred from JunkWars to add some shielding into BW.
//================================================
class JWJunkShieldWeapon extends BallisticMeleeWeapon;

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
	
	if (BDT != None)
	{
		if (BDT.default.bDisplaceAim && Damage >= BDT.default.AimDisplacementDamageThreshold && Level.TimeSeconds + BDT.default.AimDisplacementDuration > AimDisplacementEndTime)
		{
			AimDisplacementDuration = BDT.default.AimDisplacementDuration * AimDisplacementDurationMult;
		
			if (bBlocked && !IsFiring() && level.TimeSeconds > LastFireTime + 1 && BDT.default.bCanBeBlocked &&
				Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()) > 0.4
				&& AimDisplacementEndTime < Level.TimeSeconds && AimDisplacementFactor == 0)
			{
				Damage = 0;
				BallisticAttachment(ThirdPersonActor).UpdateBlockHit();
				if (instigatedBy != None && BallisticWeapon(instigatedBy.Weapon) != None)
					BallisticWeapon(instigatedBy.Weapon).ApplyAttackFatigue();
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
			if (bScopeView)
				StopScopeView();
		}
	}
		
	if (AimKnockScale == 0)
		return;

	DF = FMin(1, (float(Damage)/AimDamageThreshold) * AimKnockScale);
	ApplyDamageFactor(DF);
	ClientPlayerDamaged(255*DF);
	bForceReaim=true;

	if( DamageType.default.bCausedByWorld || HitLocation.Z < Instigator.Location.Z - 22 || AimDisplacementEndTime > Level.TimeSeconds || AimDisplacementFactor > 0 )
        super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);

    else if ( CheckReflect(HitLocation, HitNormal, 0.2) )
    {
		if (class<DT_BWShell>(DamageType) != None)
			Damage = Max(Damage* 0.5, Damage-35);
		else if (BDT.default.bCanBeBlocked)
			Damage = Damage * 0.50;
		else Damage = Max(Damage * 0.25, Damage-35);
		Momentum *= 4;
		
		BallisticAttachment(ThirdPersonActor).UpdateBlockHit();
		DF = FMin(1, float(Damage)/AimDamageThreshold);
		ApplyDamageFactor(DF);
		ClientPlayerDamaged(255*DF);
		bForceReaim=true;
    }

	else super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
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
	 AimDisplacementBlockThreshold=40.00
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPSomeOtherPackTex.OtherShields.BigIcon_JWJunkShield'
     BigIconCoords=(X1=180,Y1=0,X2=320,Y2=255)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=2
     ManualLines(0)="Attacks with the weapon and shield. The shield continues to block whilst attacking."
     ManualLines(1)="Prepared strike with the weapons."
     ManualLines(2)="The ballistic shield reduces movement speed whilst active."
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
     Description="Scavenged Junk Shield||Manufacturer: N/A|Primary: Smash|Secondary: Prepared Bash||A defensive weapon capable of blocking many attack types. Reduces incoming frontal damage by 35 or reduces it to 25% of the original amount, whichever is greater. Blocks melee damage outright. Has no effect on non-locational damage such as gas and fire."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=4
     PickupClass=Class'BWBPSomeOtherPack.JWJunkShieldPickup'
     PlayerViewOffset=(Y=75.000000,Z=-100.000000)
     AttachmentClass=Class'BWBPSomeOtherPack.JWJunkShieldAttachment'
     IconMaterial=Texture'BWBPSomeOtherPackTex.OtherShields.Icon_JWJunkShield'
     IconCoords=(X2=132,Y2=32)
     ItemName="Scavenged Junk Shield"
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.JWJunkShield_FP'
     DrawScale=1.250000
	 AimDisplacementDurationMult=0.0
}
