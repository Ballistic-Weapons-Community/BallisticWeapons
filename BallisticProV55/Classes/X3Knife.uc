//=============================================================================
// X3Knife.
//
// Its small, its sharp and its always there. Primary is a rapid slashing
// attack and secondary is more deadly, but requires some timing skill. This
// weapon is best for silent, sneak attacks.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X3Knife extends BallisticMeleeWeapon;

#exec OBJ LOAD File=BallisticSounds3.uax

var   bool			bThrowingKinfe;
var() name			KnifeBackAnim;
var() name			KnifeThrowAnim;
var   float			NextThrowTime;


simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (anim == 'PrepThrow' && bThrowingKinfe)
		return;
	super.AnimEnd(Channel);
}
//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (Instigator.bNoWeaponFiring || AmmoAmount(0) < 2 || Level.TimeSeconds < NextThrowTime || bThrowingKinfe)
		return;
	PlayAnim('PrepThrow');
	bThrowingKinfe=true;
	ServerWeaponSpecial(i);
}
function ServerWeaponSpecial(optional byte i)
{
	bThrowingKinfe=true;
}

//simulated function DoWeaponSpecialRelease(optional byte i)
exec simulated function WeaponSpecialRelease(optional byte i)
{
	if (!bThrowingKinfe || AmmoAmount(0) < 2 || Level.TimeSeconds < NextThrowTime)
		return;
	PlaySound(Sound'BallisticSounds3.Knife.KnifeThrow',,1.0,,32,,);
	if (level.NetMode == NM_Client)
		PlayAnim('Throw', 1.5);
	ServerWeaponSpecialRelease(i);
}
function ServerWeaponSpecialRelease(optional byte i)
{
	PlayAnim('Throw');
}
simulated function Notify_X3Throw()
{
	ThrowKnife();
	SetBoneScale(0, 0.0, 'Knife');
}
simulated function ThrowKnife()
{
	bThrowingKinfe=false;
	NextThrowTime = Level.TimeSeconds + 0.6;
	if (Role == ROLE_Authority)
	{
		super.ConsumeAmmo(0, 1);
		DoFireEffect();
	}
}
// Get aim then spawn projectile
function DoFireEffect()
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator RAim;
	local actor Other;
	local Projectile Proj;

    GetViewAxes(X,Y,Z);
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
    StartTrace = Start + X*10;
    if (!WeaponCentered())
	    StartTrace = StartTrace + Hand * Y*10 + Z*0;

	RAim = BFireMode[0].GetFireAim(StartTrace);
	RAim = Rotator(BFireMode[0].GetFireSpread() >> RAim);

	End = Start + (Vector(RAim)*2000);
	Other = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other != None)
		RAim = Rotator(HitLocation-StartTrace);

	Proj = Spawn (class'X3Projectile',,, StartTrace, RAim);
	Proj.Instigator = Instigator;
}

simulated function Notify_X3OutOfSight()
{
	SetBoneScale(0, 1.0, 'Knife');
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
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_X3'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Slashes with the knife. Short range and less damage than other melee weapons."
     ManualLines(1)="Prepared slash. Gains damage over hold time (maximum bonus reached after 1.5 seconds). Deals more damage from behind."
     ManualLines(2)="The Weapon Function key throws a knife, dealing good damage. Thrown knives have a very short range.||The user's movement speed improves with this weapon active."
     SpecialInfo(0)=(Info="0.0;-999.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.Knife.KnifePullOut')
     PutDownSound=(Sound=Sound'BallisticSounds2.Knife.KnifePutaway')
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BallisticProV55.X3PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.X3SecondaryFire'
     SelectAnimRate=2.000000
     PutDownTime=0.200000
     BringUpTime=0.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.200000
     CurrentRating=0.200000
     bMeleeWeapon=True
     Description="The X3 was first designed years ago by Enravion, for the UTC Commando Corps. After the first several years of the Skrith invasion, the humans realised the advantages to melee weapons, seeing how efficeintly the aliens used them. The X3's excellent durability is legendary in the UTC armies and its razor sharp blade a fear among the Skrith invaders. Commando units swear by it and it is now standard issue for all UTC soldeirs following it's success in the first Human-Skrith war."
     Priority=9
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     PickupClass=Class'BallisticProV55.X3Pickup'
     PlayerViewOffset=(X=5.000000,Y=7.000000,Z=-8.000000)
     PlayerViewPivot=(Yaw=32768)
     AttachmentClass=Class'BallisticProV55.X3Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_X3'
     IconCoords=(X2=127,Y2=31)
     ItemName="X3 Knife"
     Mesh=SkeletalMesh'BallisticAnims2.X3'
     DrawScale=0.300000
}
