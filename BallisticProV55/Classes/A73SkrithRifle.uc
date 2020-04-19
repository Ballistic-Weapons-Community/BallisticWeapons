//=============================================================================
// A73SkrithRifle.
//
// An alien energy weapon that fires fast moving projectiles that burns through
// enemies. It also has a vicious bayonette for melee attack.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73SkrithRifle extends BallisticWeapon;

var float			HeatLevel;					// Current Heat level, duh...
var float 			HeatDeclineTime;			// Time until heat can decline
var() Sound		OverheatSound;			// Sound to play when it overheats
var Actor GlowFX, HeatFX;

replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientSetHeat;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (HeatLevel >= 7)
	{
		if(Instigator.IsLocallyControlled() && HeatFX == None && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (HeatFX == None || HeatFX.bDeleteMe))
			class'BUtil'.static.InitMuzzleFlash (HeatFX, class'A73HeatGlow', DrawScale, self, 'tip');
	}
	else if (HeatFX != None)
		Emitter(HeatFX).kill();
}

simulated function float ChargeBar()
{
	return HeatLevel / 12;
}

simulated function AddHeat(float Amount, float DeclineTime)
{
	if (bBerserk)
		Amount *= 0.75;
		
	HeatLevel += Amount;
	SoundPitch = 56 + HeatLevel * 9;
	HeatDeclineTime = FMax(Level.TimeSeconds + DeclineTime, HeatDeclineTime);
	
	if (HeatLevel >= 11.75)
	{
		Heatlevel = 12;
		class'BallisticDamageType'.static.GenericHurt (Instigator, 10, None, Instigator.Location, vect(0,0,0), class'DTA73Overheat');
		return;
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

simulated event Tick (float DT)
{
	if (HeatLevel > 0 && Level.TimeSeconds > HeatDeclineTime)
	{
		Heatlevel = FMax(HeatLevel - 10 * DT, 0);
		SoundPitch = 56 + HeatLevel * 9;
	}
	
	super.Tick(DT);
}

simulated function SetScopeBehavior()
{
	bUseNetAim = default.bUseNetAim || bScopeView;
		
	if (bScopeView)
	{
		ViewAimFactor = 1.0;
		ViewRecoilFactor = 1.0;
		AimAdjustTime *= 2;
		AimSpread *= SightAimFactor;
		ChaosAimSpread *= SightAimFactor;
		ChaosDeclineTime *= 2.0;
		ChaosSpeedThreshold *= 0.7;
	}
	else
	{
		//PositionSights will handle this for clients
		if(Level.NetMode == NM_DedicatedServer)
		{
			ViewAimFactor = default.ViewAimFactor;
			ViewRecoilFactor = default.ViewRecoilFactor;
		}

		AimAdjustTime = default.AimAdjustTime;
		AimSpread = default.AimSpread;
		AimSpread *= BCRepClass.default.AccuracyScale;
		ChaosAimSpread = default.ChaosAimSpread;
		ChaosAimSpread *= BCRepClass.default.AccuracyScale;
		ChaosDeclineTime = default.ChaosDeclineTime;
		ChaosSpeedThreshold = default.ChaosSpeedThreshold;
	}
}

//===========================================================================
// AdjustPlayerDamage
//
// Less momentum when holding melee
//===========================================================================
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	SoundPitch = 56;

	GunLength = default.GunLength;

    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'A73GlowFX', DrawScale, self, 'tip');
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
	{
		class'BUtil'.static.KillEmitterEffect (GlowFX);
		class'BUtil'.static.KillEmitterEffect (HeatFX);
	}
	super.Timer();
}

simulated event Destroyed()
{
	if (HeatFX != None)
		HeatFX.Destroy();
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

//===========================================================================
// AI Interface
//===========================================================================
simulated function float RateSelf()
{
	if (HeatLevel > 11)
		CurrentRating = Super.RateSelf() * 0.2;
	else if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
		
	return CurrentRating;
}

// avoid bot suicides
function bool CanAttack(Actor Other)
{
	if (HeatLevel > 11)
		return false;

	return super.CanAttack(Other);
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
		|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	     && (B.Enemy == None || !B.EnemyVisible()) )
		return 0;
	if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
		return 0;

	if (Dist > 300)
		return 0;

	V = B.Squad.GetLinkVehicle(B);
	if ( V == None )
		V = Vehicle(B.MoveTarget);
	if ( V == B.Target )
		return 0;
	if ( (V != None) && (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
		return 0;

	if (Rand(100) < 10)
		return 1;
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
		
	if (RecommendHeal(B))
		return 1.2;
		
	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 3072, 3072); 
}

function bool FocusOnLeader(bool bLeaderFiring)
{
	local Bot B;
	local Pawn LeaderPawn;
	local Actor Other;
	local vector HitLocation, HitNormal, StartTrace;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return false;
	if ( PlayerController(B.Squad.SquadLeader) != None )
		LeaderPawn = B.Squad.SquadLeader.Pawn;
	else
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( V != None )
		{
			LeaderPawn = V;
			bLeaderFiring = (LeaderPawn.Health < LeaderPawn.HealthMax) && (V.LinkHealMult > 0)
							&& ((B.Enemy == None) || V.bKeyVehicle);
		}
	}
	if ( LeaderPawn == None )
	{
		LeaderPawn = B.Squad.SquadLeader.Pawn;
		if ( LeaderPawn == None )
			return false;
	}
	if (!bLeaderFiring)
		return false;
	if ( (Vehicle(LeaderPawn) != None) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		if ( VSize(LeaderPawn.Location - StartTrace) < FireMode[0].MaxRange() )
		{
			Other = Trace(HitLocation, HitNormal, LeaderPawn.Location, StartTrace, true);
			if ( Other == LeaderPawn )
			{
				B.Focus = Other;
				return true;
			}
		}
	}
	return false;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{ return 0.3; }

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.3;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     UsedAmbientSound=Sound'BallisticSounds2.A73.A73Hum1'
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A73'
     BigIconCoords=(Y1=32,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_RapidProj=True
     bWT_Energy=True
     ManualLines(0)="Launches a torrent of energy projectiles. The damage of these projectiles increases at range.||This attack generates heat, and if the weapon overheats, the fire rate is reduced and the player will take damage."
     ManualLines(1)="Launches a single, slower moving yet powerful projectile with minor radius damage. This projectile inflicts a short-duration blind effect and increased damage upon a direct hit. Spreads when used from the hip.||This attack generates substantial heat, and the player will take damage if the weapon overheats."
     ManualLines(2)="Has a melee attack. The damage of this attack increases to its maximum over 1.5 seconds of holding the altfire key. It inflicts more damage on a backstab.||The A73 is effective at close range and very effective at medium range. It is also capable of healing nodes and vehicles with its plasma attacks. As an energy weapon, the A73 has lower recoil than conventional arms and its projectiles penetrate players but not walls and surfaces."
     SpecialInfo(0)=(Info="240.0;20.0;0.9;80.0;0.0;0.4;0.1")
     MeleeFireClass=Class'BallisticProV55.A73MeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.A73.A73Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A73.A73Putaway')
     MagAmmo=32
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipIn')
     ClipInFrame=0.700000
     bNonCocking=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(Value=4.000000)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
	 bNoCrosshairInScope=True
     SightPivot=(Pitch=450)
     SightOffset=(X=10.000000,Z=12.150000)
     SightDisplayFOV=60.000000
     SightAimFactor=0.300000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=0.600000
     AimSpread=16
     AimDamageThreshold=75.000000
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.170000
     FireModeClass(0)=Class'BallisticProV55.A73PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.A73SecondaryFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     bShowChargingBar=True
     Description="The A73 is an energy-based assault rifle. It was one of the most devastating weapons in the first Human-Skrith war, before the production of energy resistant armor. Many UTC divisions suffered immense casualties at the hands of Skrith A73s and the savage manner in which they were used. The weapon uses a 90MW Skrith charge module for ammunition. Despite the dangerous energy projectile of the weapon, capable of burning through metal, the Skrith prefer brutal melee combat to ranged battle so the A73 was outfitted with razor sharp, Triclonium blades, making it even more popular among the alien warriors."
     Priority=39
     HudColor=(B=255,G=175,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=1
     PickupClass=Class'BallisticProV55.A73Pickup'
     PlayerViewOffset=(X=-4.000000,Y=10.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.A73Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A73'
     IconCoords=(X2=127,Y2=31)
     ItemName="A73 Skrith Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BallisticProAnims.A73SkrithRifle'
     DrawScale=0.187500
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticWeapons2.A73.A73AmmoSkin'
     Skins(2)=Shader'BallisticWeapons2.A73.A73Skin_SD'
     Skins(3)=Texture'BallisticWeapons2.A73.A73SkinB'
     Skins(4)=Shader'BallisticWeapons2.A73.A73BladeShader'
     SoundPitch=56
     SoundRadius=32.000000
}
