//=============================================================================
// X8Knife.
//
// The X3's launchable brother! Designed as a bayonet and not a handheld knife!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class X8Knife extends BallisticMeleeWeapon;

var() name				KnifeBone;		//Bone of whole grenade. Used to hide grenade at the right time
var() name				PinBone;			//Bone of pin. Used to hide pin
var() BUtil.FullSound	PinPullSound;		//Sound to play for pin pull


simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	SetBoneScale (0, 1.0, KnifeBone);
	SetBoneScale (1, 1.0, PinBone);
}

simulated function bool PutDown()
{
	local BCGhostWeapon GW;
	if (Super.PutDown())
	{
		SetBoneScale (1, 1.0, PinBone);
		if (Ammo[0].AmmoAmount < 1)
		{
			// Save a ghost of this weapon so it can be brought back
			GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);
        		if(GW != None)
	        	{
    	    			GW.MyWeaponClass = class;
				GW.GiveTo(Instigator);
			}
			Timer();
			PickupClass=None;
			DropFrom(Location);
			return true;
		}
		return true;
	}
	return false;
}


simulated function PlayIdle()
{
	super.PlayIdle();
	SetBoneScale (1, 0.0, PinBone);
}


simulated function Notify_KnifeLeaveHand()
{
	SetBoneScale (0, 0.0, KnifeBone);
}
// Anim Notify for pin pull
simulated function Notify_KnifePinPull ()
{
    class'BUtil'.static.PlayFullSound(self, PinPullSound);
}


simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == FireMode[1].FireAnim)
	{
		SetBoneScale (1, 1.0, PinBone);
		SetBoneScale (0, 1.0, KnifeBone);
		CheckNoGrenades();
	}
	else if (Anim == SelectAnim)
		PlayIdle();
	else
		Super.AnimEnd(Channel);
}


simulated function CheckNoGrenades()
{
	local Inventory Inv;
	local BCGhostWeapon GW;

	if (Ammo[0]!= None && ( Ammo[0].AmmoAmount < 1 || (Ammo[0].AmmoAmount == 1 && (BFireMode[0].ConsumedLoad > 0  || BFireMode[1].ConsumedLoad > 0)) ))
	{
		AIRating = -999;
		Priority = -999;

		// Save a ghost of this wepaon so it can be brought back
		if (Role == ROLE_Authority)
		{
			GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);
    	    if(GW != None)
        	{
        		GW.MyWeaponClass = class;
				GW.GiveTo(Instigator);
			}
		}

		if (Instigator != None)
		{
			if (PlayerController(Instigator.Controller) != None)
				Instigator.Controller.ClientSwitchToBestWeapon();
			else if (AIController(Instigator.Controller) != None)
			{
				for (Inv = Instigator.Inventory; Inv != None; Inv = Inv.Inventory)
					if (Weapon(Inv) != None && Weapon(Inv) != Self)
					{
						if(!Weapon(Inv).HasAmmo())
							continue;
						Instigator.PendingWeapon = Weapon(Inv);
						Instigator.ChangedWeapon();
						break;
					}
			}
		}
		//Instigator.Weapon = None;
		Destroy();
	}
	else
		PlayAnim(SelectAnim, SelectAnimRate, 0.0);
}

simulated function RemoteKill()
{
	local BCGhostWeapon GW;
	AIRating = -999;
	Priority = -999;
	// Save a ghost of this wepaon so it can be brought back
	if (Role == ROLE_Authority)
	{
		GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);
    	    	if(GW != None)
        	{
        		GW.MyWeaponClass = class;
			GW.GiveTo(Instigator);
		}
	}
	Destroy();
}


/*simulated event Tick (float DT) //Damn it. Resorting to tick for remote kills. No longer really remote...
{
	if (Ammo[0].AmmoAmount == 0)
	{
		RemoteKill();
	}

	super.Tick(DT);
}*/

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (InstigatedBy != None && InstigatedBy.Controller != None && InstigatedBy.Controller.SameTeamAs(InstigatorController))
		return;
		
	if (VSize(Instigator.Location - InstigatedBy.Location) < 512 && VSize(Momentum) < 60)
		Momentum = vect(0,0,0);
	else Momentum *= 0.5;
		
	if (bBerserk)
		Damage *= 0.75;
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
	local BallisticWeapon BW;
	local vector Dir;
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None)
		return AIRating;
		
	if (B.Enemy == None)
		return 0; // almost certainly useless against non-humans
		
	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);
	
	// favour melee when attacking the enemy's back
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0)
		Rating += 0.08 * B.Skill;
	
	BW = BallisticWeapon(B.Enemy.Weapon);
	
	if (BW != None)
	{ 
		// discourage melee-on-melee
		if (BW.bMeleeWeapon)
			Rating *= 0.75;
			
		// trying this against a shotgun or a PDW is a very bad idea
		if (BW.bWT_Shotgun || BW.InventoryGroup == 3)
			Rating = 0;	
	}
	
	Rating = class'BUtil'.static.DistanceAtten(Rating, 0.3, Dist, 128, 128);
	
	return Rating;
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
	bCanBlock=False
	KnifeBone="Blade"
	PinBone="Pin"
	PinPullSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.075000,Radius=24.000000,Slot=SLOT_Interact,Pitch=1.600000,bAtten=True)
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.BigIcon_X8'
	BigIconCoords=(Y1=25,Y2=230)
	bShowChargingBar=False
	ManualLines(0)="Slashes rapidly with the knife."
	ManualLines(1)="When held, readies the ballistic knife. When released, the knife is fired in a straight trajectory, dealing good damage to targets hit."
	ManualLines(2)="Effective at close range and while moving."
	SpecialInfo(0)=(Info="0.0;-999.0;-999.0;-1.0;-999.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePullOut',Volume=0.110000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePutaway',Volume=0.110000)
	MagAmmo=1
	bNoMag=True
	WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.X3InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(R=129,A=192),Color2=(G=196,R=0,A=192),StartSize1=99,StartSize2=107)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)
    CurrentWeaponMode=0
	bUseSights=False
	GunLength=0.000000
	bAimDisabled=True
	ParamsClasses(0)=Class'X8WeaponParamsComp'
	ParamsClasses(1)=Class'X8WeaponParamsClassic'
	ParamsClasses(2)=Class'X8WeaponParamsRealistic'
    ParamsClasses(3)=Class'X8WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.X8PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.X8SecondaryFire'
	SelectAnimRate=2.500000
	PutDownAnimRate=2.000000
	PutDownTime=0.200000
	BringUpTime=0.400000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	bMeleeWeapon=True
	Description="A counterpart to Enravion�s X3 Knife, the X8 Ballistic Knife is the Eastern Bloc�s preferred way to deal with CQC enemies. While primarily used as a bayonet on the venerable AK490, the X8 is still quite effective in hand to hand fighting thanks to its lethally sharp blade. When opponents are too far to gut personally, the unique gas propellant mechanism inside the hilt of the knife lets the user turn their knife into a fast moving spear. Several unfortunate accidents have caused the X8 to be considered unfit for civilian use."
	Priority=13
	HudColor=(B=25,G=25,R=200)
	CenteredOffsetY=7.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	GroupOffset=7
	PickupClass=Class'BWBP_SKC_Pro.X8Pickup'
	PlayerViewOffset=(X=20.000000,Z=-10.000000)
	AttachmentClass=Class'BWBP_SKC_Pro.X8Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.SmallIcon_X8'
	IconCoords=(X2=128,Y2=32)
	ItemName="X8 Ballistic Knife"
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_X8Knife'
	DrawScale=0.300000
}
