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

#exec OBJ LOAD File=BW_Core_WeaponSound.uax

var   bool			bThrowingKnife;
var() name			KnifeBackAnim;
var() name			KnifeThrowAnim;
var   float			NextThrowTime;


simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (anim == 'PrepThrow' && bThrowingKnife)
		return;
	super.AnimEnd(Channel);
}
//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (Instigator.bNoWeaponFiring || AmmoAmount(0) < 2 || Level.TimeSeconds < NextThrowTime || bThrowingKnife)
		return;
	PlayAnim('PrepThrow');
	bThrowingKnife=true;
	ServerWeaponSpecial(i);
}
function ServerWeaponSpecial(optional byte i)
{
	bThrowingKnife=true;
}

//simulated function DoWeaponSpecialRelease(optional byte i)
exec simulated function WeaponSpecialRelease(optional byte i)
{
	if (!bThrowingKnife || AmmoAmount(0) < 2 || Level.TimeSeconds < NextThrowTime)
		return;
	PlaySound(Sound'BW_Core_WeaponSound.Knife.KnifeThrow',/*slot*/,1.0,/*nooverride*/,256,/* pitch */,/*attenuate*/);
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
	bThrowingKnife=false;
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
	AIRating=0.6
	CurrentRating=0.6
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_X3'
     
     ManualLines(0)="Slashes with the knife. Short range and less damage than other melee weapons."
     ManualLines(1)="Prepared slash. Gains damage over hold time (maximum bonus reached after 1.5 seconds). Deals more damage from behind."
     ManualLines(2)="The Weapon Function key throws a knife, dealing good damage. Thrown knives have a very short range."
     SpecialInfo(0)=(Info="0.0;-999.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePullOut',Volume=0.109000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePutaway',Volume=0.109000)
     bNoMag=True
     GunLength=0.000000
	 bAimDisabled=True
	 ParamsClasses(0)=Class'X3WeaponParamsComp'
	 ParamsClasses(1)=Class'X3WeaponParamsClassic'
	 ParamsClasses(2)=Class'X3WeaponParamsRealistic'
     ParamsClasses(3)=Class'X3WeaponParamsTactical'
     FireModeClass(0)=Class'BallisticProV55.X3PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.X3SecondaryFire'
	 
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.X3InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(R=0,A=192),Color2=(B=255,A=192),StartSize1=103,StartSize2=87)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)
     
     SelectAnimRate=2.000000
     PutDownTime=0.200000
     BringUpTime=0.200000
     SelectForce="SwitchToAssaultRifle"
     bMeleeWeapon=True
     Description="The X3 was first designed years ago by Enravion, for the UTC Commando Corps. After the first several years of the Skrith invasion, the humans realised the advantages to melee weapons, seeing how efficeintly the aliens used them. The X3's excellent durability is legendary in the UTC armies and its razor sharp blade a fear among the Skrith invaders. Commando units swear by it and it is now standard issue for all UTC soldeirs following it's success in the first Human-Skrith war."
     Priority=9
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     PickupClass=Class'BallisticProV55.X3Pickup'
     PlayerViewOffset=(X=2.750000,Y=7.000000,Z=-8.000000)
     PlayerViewPivot=(Yaw=32768)
     SmallViewOffset=(X=2.750000,Y=7.000000,Z=-8.000000)	 
     AttachmentClass=Class'BallisticProV55.X3Attachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_X3'
     IconCoords=(X2=127,Y2=31)
     ItemName="X3 Knife"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_X3'
     DrawScale=0.300000
}
