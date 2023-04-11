//=============================================================================
// Akeron Launcher.
// 
// Fires medium rockets with guidance and homing capability.
//=============================================================================
class AkeronLauncher extends BallisticWeapon;

var float PanicThreshold;
var AkeronWarhead ActiveWarhead;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientSetViewRotation;
}
function LostWarhead()
{
	GoToState('ControllerRecovery');
}

state ControllerRecovery
{
	Begin:
		Sleep(1);
		RecoverController();
		GoToState('');
}

function RecoverController()
{
	if ( InstigatorController == None || InstigatorController.Pawn == Instigator)
		return;
		
	InstigatorController.SetRotation(ActiveWarhead.InitialControllerRotation);
	ClientSetViewRotation(ActiveWarhead.InitialControllerRotation);
	
	InstigatorController.UnPossess();
	
	if ( !InstigatorController.IsInState('GameEnded') )
	{
		if ( (Instigator != None) && (Instigator.Health > 0) )
			InstigatorController.Possess(Instigator);
		else
		{
			if ( Instigator != None )
			{
				InstigatorController.Pawn = Instigator;
				PlayerController(InstigatorController).SetViewTarget(Instigator);
			}
			else
				InstigatorController.Pawn = None;
			InstigatorController.PawnDied(InstigatorController.Pawn);
		}
	}

	if (!ActiveWarhead.bExploded)
		ActiveWarhead.BlowUp(ActiveWarhead.Location);
	ActiveWarhead = None;
}

simulated function ClientSetViewRotation(Rotator R)
{
	Level.GetLocalPlayerController().SetRotation(R);
}

// Aim goes bad when player takes damage
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (bBerserk)
		Damage *= 0.75;
		
	//Recover the controller immediately if in danger
	if (ActiveWarhead != None && (InstigatedBy.Controller == None || InstigatedBy.Controller == InstigatorController || ( !InstigatedBy.Controller.SameTeamAs(InstigatorController) )) && Damage > PanicThreshold)
		RecoverController();
		
	if (AimKnockScale == 0)
          return;

	AimComponent.ApplyDamageFactor(Damage);
}

function byte BestMode()
{
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
     PanicThreshold=4.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBP_OP_Tex.Akeron.BigIcon_Akeron'
     BigIconCoords=(X1=36,Y1=50,X2=486,Y2=220)
     
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     ManualLines(0)="Launches rockets with good fire rate. These rockets travel quickly and deal high damage upon direct impact. The blast of Akeron rockets is directed forwards, so targets perpendicular to or behind the rocket's target vector when it explodes will take very little damage."
     ManualLines(1)="Launches a manually guided rocket. While a rocket is active, the user views through the rocket's nose camera. Rockets are fast and quite manoeuverable, but much as the primary fire, have a directed blast and require the enemy to be struck directly to do much damage."
     ManualLines(2)="The Akeron is effective at close to medium range or in specialist situations where indirect fire is required. As a rocket launcher, it has no recoil, but its size makes it cumbersome to use without stability or aiming."
     SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Putaway')
     CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff')
     bNonCocking=True
     //WeaponModes(0)=(ModeName="Barrage",ModeID="WM_BigBurst",Value=3)
	 //WeaponModes(1)=(ModeName="High Velocity",ModeID="WM_FullAuto",Value=1)
	 //WeaponModes(2)=(bUnavailable=True)
     //CurrentWeaponMode=0
     ScopeXScale=1.333000
     ScopeViewTex=Texture'BW_Core_WeaponTex.Artillery.Artillery-ScopeView'
     FullZoomFOV=10.000000
     bNoCrosshairInScope=True
     SightOffset=(X=20.000000,Y=-17.000000,Z=-1.5000000)

     MinZoom=2.000000
     MaxZoom=8.000000
     ZoomStages=2
     ParamsClasses(0)=Class'AkeronWeaponParamsComp'
     ParamsClasses(1)=Class'AkeronWeaponParamsClassic'
     ParamsClasses(2)=Class'AkeronWeaponParamsRealistic'
     ParamsClasses(3)=Class'AkeronWeaponParamsTactical'
     FireModeClass(0)=Class'BWBP_OP_Pro.AkeronPrimaryFire'
     FireModeClass(1)=Class'BWBP_OP_Pro.AkeronSecondaryFire'
     SelectAnimRate=0.600000
     PutDownAnimRate=0.800000
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,Color1=(G=78,R=155,A=54),Color2=(G=235,R=1),StartSize1=181,StartSize2=14)
     NDCrosshairInfo=(SpreadRatios=(Y2=0.500000))
     AIRating=0.80000
     CurrentRating=0.80000
     Description="The AN-56 Akeron Light Missile Launcher was introduced to fulfill a pressing need for mobile indirect fire options within the UTC ranks. Launching directed-blast rockets for the safety of allied units, it has quickly become a staple due to its optional ability to attack fortifications with manually guided rockets without requiring the user's exposure to enemy fire. However, whilst guiding a rocket, the user is vulnerable to flank attacks, and the weapon is best employed with the support of teammates. Should the user choose to eschew manual guidance, undirected rockets can be launched at a fast rate from the weapon's three barrels."
     Priority=44
     HudColor=(B=80,G=95,R=110)
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBP_OP_Pro.AkeronPickup'
     PlayerViewOffset=(X=5.000000,Y=13.000000,Z=-6.000000)
     AttachmentClass=Class'BWBP_OP_Pro.AkeronAttachment'
     IconMaterial=Texture'BWBP_OP_Tex.Akeron.Icon_Akeron'
     IconCoords=(X2=127,Y2=31)
     ItemName="AN-56 Akeron Launcher"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Akeron'
     DrawScale=0.300000
}
