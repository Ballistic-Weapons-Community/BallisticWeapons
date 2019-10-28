//================================================
// Riot Shield.
// 
// Transferred from JunkWars to add some shielding into BW.
//================================================
class RiotShield extends BallisticMeleeWeapon;

#exec OBJ LOAD FILE=BallisticProTextures.utx

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return false;
}

// choose between regular or alt-fire
function byte BestMode()
{
	return 0;
}

function float GetAIRating()
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

	if( DamageType.default.bCausedByWorld || HitLocation.Z < Instigator.Location.Z - 22)
        super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);

    else if ( CheckReflect(HitLocation, HitNormal, 0.2) )
    {
    	if (class<BallisticDamageType>(DamageType).default.bCanBeBlocked)
    	{
    		Damage = 0;
    		Momentum *= 2;
    	}
    	else
    	{
			if (class<DT_BWShell>(DamageType) != None)
				Damage = Max(Damage* 0.5, Damage-35);
			else Damage = Max(Damage * 0.25, Damage-35);
			Momentum *= 4;
		}
		
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
     PlayerSpeedFactor=0.950000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticProTextures.Misc.BigIcon_Shield'
     BigIconCoords=(X1=180,Y1=0,X2=320,Y2=255)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=3
     ManualLines(0)="Attacks with the riot shield. The riot shield continues to block whilst attacking. Slow strike rate and low damage."
     ManualLines(1)="As primary."
     ManualLines(2)="The riot shield reduces movement speed whilst active."
     SpecialInfo(0)=(Info="240.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.EKS43.EKS-Putaway')
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     AimSpread=32
     AimDamageThreshold=40.000000
     ChaosSpeedThreshold=3000.000000
     ChaosAimSpread=256
     FireModeClass(0)=Class'BallisticProV55.RiotPrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.RiotPrimaryFire'
     PutDownTime=0.500000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.300000
     CurrentRating=0.300000
     bMeleeWeapon=True
     Description="A defensive weapon capable of blocking many attack types. Reduces incoming frontal damage by 35 or reduces it to 25% of the original amount, whichever is greater. Blocks melee damage outright. Has no effect on non-locational damage such as gas and fire."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=4
     PickupClass=Class'BallisticProV55.RiotPickup'
     PlayerViewOffset=(X=-5.000000,Y=3.000000,Z=-15.000000)
     AttachmentClass=Class'BallisticProV55.RiotAttachment'
     IconMaterial=Texture'BallisticProTextures.Icons.Icon_JWRiot'
     IconCoords=(X2=256,Y2=31)
     ItemName="Riot Shield"
     Mesh=SkeletalMesh'BallisticProAnims.RiotShieldM'
     DrawScale=0.300000
}
