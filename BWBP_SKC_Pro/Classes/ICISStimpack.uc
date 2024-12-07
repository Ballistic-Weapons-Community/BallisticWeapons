//=============================================================================
// Stimpack. Grants health over time.
//=============================================================================
class ICISStimpack extends BallisticWeapon;

var() sound		HealSound;
var float       LastRegenTick;

simulated function Notify_SelfInject()
{
	//local ICISPoisoner IP;
	
	PlaySound(HealSound, SLOT_Misc, 1.5, ,64);

    /*
    if (Role == ROLE_Authority)
	{
		if(Instigator == None || Vehicle(Instigator) != None || Instigator.Health <= 0)
			return;
		Ammo[1].UseAmmo (1, True);
		
		IP = Spawn(class'ICISPoisoner', Instigator.Controller);
		IP.Instigator = Instigator;

		if(Instigator.Role == ROLE_Authority && Instigator.Controller != None)
			IP.InstigatorController = Instigator.Controller;

		IP.Initialize(Instigator);
	}
    */
}

simulated function Tick(float DT)
{
	super.Tick(DT);

	if (!IsFiring() && Level.TimeSeconds >= LastRegenTick)
    {
        Ammo[0].AddAmmo(1);
        LastRegenTick = level.TimeSeconds + 1;
    }
}


simulated function bool PutDown()
{
	local BCGhostWeapon GW;
	if (Super.PutDown())
	{
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

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == FireMode[0].FireAnim)
		CheckNoGrenades();
	else if (Anim == SelectAnim)
		PlayIdle();
	else
		Super.AnimEnd(Channel);
}

simulated function CheckNoGrenades()
{
	local BCGhostWeapon GW;
	local Inventory Inv;
	
	if (Ammo[0]!= None && ( Ammo[0].AmmoAmount < 1 || (Ammo[0].AmmoAmount == 1 && (BFireMode[0].ConsumedLoad > 0  || BFireMode[1].ConsumedLoad > 0)) ))
	{
		AIRating = -999;
		Priority = -999;
		if (Instigator.Weapon == Self)
		Instigator.Weapon = None;
		// Save a ghost of this weapon so it can be brought back
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
			{
				//Instigator.Controller.ClientSwitchToBestWeapon();
			}
			else if (AIController(Instigator.Controller) != None)
			{
				for (Inv = Instigator.Inventory; Inv != None; Inv = Inv.Inventory)
					if (Weapon(Inv) != None && Weapon(Inv) != Self)
					{
						if (!Weapon(Inv).HasAmmo())
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

function float GetAIRating()
{
	local Bot B;
	
	B = Bot(Instigator.Controller);
	
	if (B == None)
		return AIRating;
		
	// attempt to stim when not attacking
	if (Instigator.Health < Instigator.HealthMax * 0.5 && B.Enemy == None)
		return 1;
		
	return 0;
}

//Overwrites old HasAmmo() so that we can use our weapons when there is still ammo in the mag
simulated function bool HasAmmo()
{
	return true;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return -1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return 1;
}

// End AI Stuff =====

defaultproperties
{
     HealSound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-Heal'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.Stim.BigIcon_Stim'
     BigIconCoords=(Y1=24,Y2=230)
     
     ManualLines(0)="Injects self with the stimpack, granting 80 health over 10 seconds."
     ManualLines(1)="Melee attack. Damage improves over hold time, with max bonus reached after 1.5 seconds. Deals increased damage from behind."
	 ManualLines(2)="Attacking allies with the stimpack will apply its effect to them."
     SpecialInfo(0)=(Info="0.0;-999.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePullOut',Volume=0.112000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePutaway',Volume=0.112000)
     bNoMag=True
     bNonCocking=True
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bUseSights=False
     SightingTime=0.000000
     GunLength=0.000000
     bAimDisabled=True
	 ParamsClasses(0)=Class'ICISWeaponParamsComp'
	 ParamsClasses(1)=Class'ICISWeaponParamsClassic'
	 ParamsClasses(2)=Class'ICISWeaponParamsRealistic'
     ParamsClasses(3)=Class'ICISWeaponParamsTactical'
	 FireModeClass(0)=Class'BWBP_SKC_Pro.ICISPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.ICISSecondaryFire'
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.X3InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(R=129,A=192),Color2=(G=196,R=0,A=192),StartSize1=99,StartSize2=107)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=8.000000)
     SelectAnimRate=2.500000
     PutDownAnimRate=1.500000
     PutDownTime=0.200000
     BringUpTime=0.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.200000
     CurrentRating=0.200000
     bMeleeWeapon=True
     Description="Chemical Formula KFBR382, serum #25 is one in a long line of exerimental military stimulants, and is one of the more successful prototypes. It is supplied alongside the heavy-duty Intravenous Chemical Injection System for troop use in dangerous situations, and while previous serums were never able to breach the 50% mortality mark, No. 25 is showing serious potential and is being fielded to select testing groups. Studies show that #25 increases aggression, suppresses pain receptors, and allows troops to continue fighting past fatigue points that were previously thought impossible. Unfortunately, some #25-injected troops are already showing signs of severe psychosis and a few others have already died of unforeseen cardiac explosions."
     Priority=13
     HudColor=(B=210,G=210,R=75)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     PickupClass=Class'BWBP_SKC_Pro.ICISPickup'
     PlayerViewOffset=(X=20.000000,Z=-10.000000)
     AttachmentClass=Class'BWBP_SKC_Pro.ICISAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.Stim.SmallIcon_Stim'
     IconCoords=(X2=128,Y2=32)
     ItemName="FMD ICIS-25 Stimpack"
     Mesh=SkeletalMesh'BWBP_SKC_Anim.Stimpack_FPm'
     DrawScale=0.300000
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BWBP_SKC_Tex.Stim.Stim-Main'
	 Skins(2)=Texture'ONSstructureTextures.CoreGroup.Invisible'
	 Skins(3)=Shader'XEffectMat.goop.GoopShader'
}
