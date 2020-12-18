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
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBPOtherPackTex3.Akeron.BigIcon_Akeron'
     BigIconCoords=(X1=36,Y1=50,X2=486,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     ManualLines(0)="Launches rockets with good fire rate. These rockets travel quickly and deal high damage upon direct impact. The blast of Akeron rockets is directed forwards, so targets perpendicular to or behind the rocket's target vector when it explodes will take very little damage."
     ManualLines(1)="Launches a manually guided rocket. While a rocket is active, the user views through the rocket's nose camera. Rockets are fast and quite manoeuverable, but much as the primary fire, have a directed blast and require the enemy to be struck directly to do much damage."
     ManualLines(2)="The Akeron is effective at close to medium range or in specialist situations where indirect fire is required. As a rocket launcher, it has no recoil, but its size makes it cumbersome to use without stability or aiming."
     SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.G5.G5-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.G5.G5-Putaway')
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.G5.G5-Lever')
     ReloadAnimRate=0.900000
     ClipOutSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOn')
     ClipInSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOff')
     bNonCocking=True
     WeaponModes(0)=(ModeName="Guidance: Slow",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Guidance: Fast",ModeID="WM_FullAuto")
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomType=ZT_Logarithmic
     ScopeXScale=1.333000
     ScopeViewTex=Texture'BWBP4-Tex.Artillery.Artillery-ScopeView'
     FullZoomFOV=10.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(X=-30.000000,Y=-17.000000,Z=15.000000)

     MinZoom=2.000000
     MaxZoom=8.000000
     ZoomStages=2
     ParamsClass=Class'AkeronWeaponParams'
     FireModeClass(0)=Class'BWBPOtherPackPro.AkeronPrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.AkeronSecondaryFire'
     SelectAnimRate=0.600000
     PutDownAnimRate=0.800000
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.80000
     CurrentRating=0.80000
     Description="The AN-56 Akeron Launcher was introduced to fulfill a pressing need for indirect fire options within the UTC ranks. Launching directed-blast rockets for the safety of allied units, it has quickly become a staple due to its optional ability to attack fortifications with manually guided rockets without requiring the user's exposure to enemy fire. However, whilst guiding a rocket, the user is vulnerable to flank attacks, and the weapon is best employed with the support of teammates. Should the user choose to eschew manual guidance, undirected rockets can be launched at a fast rate from the weapon's three barrels."
     Priority=44
     HudColor=(B=80,G=95,R=110)
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPOtherPackPro.AkeronPickup'
     PlayerViewOffset=(X=30.000000,Y=20.000000,Z=-18.000000)
     AttachmentClass=Class'BWBPOtherPackPro.AkeronAttachment'
     IconMaterial=Texture'BWBPOtherPackTex3.Akeron.Icon_Akeron'
     IconCoords=(X2=127,Y2=31)
     ItemName="AN-56 Akeron Launcher"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBPOtherPackAnim3.Akeron_FP'
     DrawScale=0.300000
}
