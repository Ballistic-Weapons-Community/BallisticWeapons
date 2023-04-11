//=============================================================================
// ChaffGrenadeWeapon.
//
// Handheld smoke grenade.
//=============================================================================
class ChaffGrenadeWeapon extends BallisticHandGrenade;

// Fuse ran out before grenade was tossed
simulated function ExplodeInHand()
{
	ClipReleaseTime=666;
	KillSmoke();
	HandExplodeTime = Level.TimeSeconds + 1.0;
	if (IsFiring())
	{
		FireMode[0].bIsFiring=false;
		FireMode[1].bIsFiring=false;
	}
	if (Role == Role_Authority)
	{
		DoExplosionEffects();
		MakeNoise(1.0);
		ConsumeAmmo(0, 1);
	}
	SetTimer(0.1, false);
}

// This is called as soon as grenade explodes. Don't put anything in here that could kill the player.
simulated function DoExplosionEffects()
{
	BallisticGrenadeAttachment(ThirdPersonActor).HandExplode();
	if (level.NetMode == NM_Client)
		CheckNoGrenades();
}
// Anything that does damage for the explosion should happen here.
// This delayed to prevent player being killed before ammo stuff is sorted out.
function DoExplosion()
{
	if (Role == ROLE_Authority)
	{
		SpecialHurtRadius(HeldDamage, HeldRadius, HeldDamageType, HeldMomentum, Location);
		CheckNoGrenades();
	}
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	
	if (Anim == FireMode[0].FireAnim)
	{
		SetBoneScale (0, 1.0, GrenadeBone);
		CheckNoGrenades();
	}
	else if (Anim == SelectAnim)
		PlayIdle();
	else	
    	AnimEnded(Channel, anim, frame, rate);
}

simulated function Timer()
{
	//Do damage
	if (ClipReleaseTime == 666)
	{
		ClipReleaseTime=0.0;
		DoExplosion();
	}
	// Reset
	else if (ClipReleaseTime < 0)
		ClipReleaseTime=0.0;
	// Explode in hand
	else if (ClipReleaseTime > 0)
		ExplodeInHand();
	// Something else
	else
		Super.Timer();
}


simulated function CheckNoGrenades()
{
	local BCGhostWeapon GW;
	if (Ammo[0]!= None && ( Ammo[0].AmmoAmount < 1 || (Ammo[0].AmmoAmount == 1 && (BFireMode[0].ConsumedLoad > 0  || BFireMode[1].ConsumedLoad > 0)) ))
	{
		AIRating = -999;
		Priority = -999;
		Instigator.Weapon = None;
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
		if (Instigator!=None && Instigator.Controller!=None)
			Instigator.Controller.ClientSwitchToBestWeapon();
		Destroy();
	}
	else
	{
		PlayAnim(SelectAnim, 1, 0.0);
		SetBoneRotation('MOACTop', rot(0,0,0));
	}
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

simulated function bool PutDown()
{
	local BCGhostWeapon GW;

	if (Super.PutDown())
	{
		ClipReleaseTime=0.0;
		if (Ammo[0] != None && Ammo[0].AmmoAmount < 1)
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

simulated function Notify_TurnSound()
{
	class'BUtil'.static.PlayFullSound(self, ClipReleaseSound);
}

function ServerStartReload (optional byte i)
{

}

// Charging bar shows throw strength
simulated function float ChargeBar()
{
	return FClamp(FireMode[0].HoldTime - 0.5,  0, 2) / 2;
}

// AI Interface =====
function byte BestMode()
{
	local Bot B;
	local float Dist, Height, result;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	result = 0.5;

	if (Dist > 500)
		result -= 0.4;
	else
		result += 0.4;
	if (Abs(Height) > 32)
		result -= Height / Dist;
	if (result > 0.5)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist, Height;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;

	Result = AIRating;
	// Enemy too far away
	result += Height/-500;
	if (Height > -200)
	{
		if (Dist > 800)
			Result -= (Dist-800) / 2000;
		if (Dist < 500)
			Result -= 1 - Dist/500;
	}
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.2;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}
// End AI Stuff =====

defaultproperties
{
     FuseDelay=14.000000
     HeldDamage=70
     HeldRadius=350
     HeldMomentum=75000
     HeldDamageType=Class'BWBP_SKC_Pro.DTXM84Held'
     GrenadeSmokeClass=Class'BWBP_SKC_Pro.ChaffTrail'
     ClipReleaseSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn',Volume=0.500000,Radius=48.000000,Pitch=1.700000,bAtten=True)
     PinPullSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-PinOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
	 GrenadeBone="MOAC"
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.M4A1.BigIcon_MOAC'
     BigIconCoords=(Y1=16,Y2=240)
     
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     ManualLines(0)="Throws a chaff grenade overarm. Upon striking a surface, it explodes, producing a cloud of smoke, dealing minor damage in a wide radius and extinguishing any nearby FP7 fires."
     ManualLines(1)="Melee attack with the grenade. Damage increases over hold time, with the maximum being reached after 1.5 seconds of holding. As a blunt attack, inflicts a short-duration blind when striking."
     ManualLines(2)="Synergises with the MARS-2."
     SpecialInfo(0)=(Info="60.0;5.0;0.25;30.0;0.0;0.0;0.4")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout')
	 PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway')
	 ParamsClasses(0)=Class'ChaffWeaponParamsComp'
	 ParamsClasses(1)=Class'ChaffWeaponParamsClassic'
	 ParamsClasses(2)=Class'ChaffWeaponParamsRealistic'
     ParamsClasses(3)=Class'ChaffWeaponParamsTactical'
     FireModeClass(0)=Class'BWBP_SKC_Pro.ChaffPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.ChaffSecondaryFire'
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.NRP57InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=7,G=255,R=255,A=166),Color2=(B=255,G=26,R=12,A=229),StartSize1=112,StartSize2=210)
     NDCrosshairInfo=(SpreadRatios=(Y2=0.500000),MaxScale=8.000000)
     SelectAnimRate=2.000000
     PutDownAnimRate=2.000000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="Majestic Firearm 12's MOA-C Chaff Grenade is designed to be barrel fired with any* type of rifle round on the market. There's no need to unload your rifle to fire a grenade; the grenade stem's primer catches the bullet to ignite the shaped charge of the stem while leaving the barrel, offering a two stage propellant system that gives the grenade a greater velocity than standard rifle grenades. The MOA-C Chaff Grenade can also be utilized by infantry not equipped with the G51 Carbine as a hand thrown grenade. The soldier simply primes the grenade by twisting the cap and throws it. Due to the shaped charge still being present at the time of impact, the grenade tends to produce a higher explosive yield when thrown rather than shot from the rifle. Majestic Firearms 12 is not responsible injuries caused by inappropriate use of the grenade in this manner."
     Priority=13
     HudColor=(B=150,G=150,R=150)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     PickupClass=Class'BWBP_SKC_Pro.ChaffPickup'
     PlayerViewOffset=(Y=3.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BWBP_SKC_Pro.ChaffAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.M4A1.SmallIcon_MOAC'
     IconCoords=(X2=127,Y2=31)
     ItemName="MOA-C Chaff Grenade"
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MOAC'
     DrawScale=0.300000
}
