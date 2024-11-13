//=============================================================================
// A42SkrithPistol.
//
// Alien energy sidearm with recharging ammo, a rapid fire projectile fire for
// primary and a charged up beam for secondary. Primary heals vehicles and
// power nodes.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42SkrithPistol extends BallisticHandgun;

var float NextAmmoTickTime;
var Actor			GlowFX;

var float			HeatLevel;					// Current Heat level, duh...
var float 			HeatDeclineTime;			// Time until heat can decline
var() Sound			OverheatSound;				// Sound to play when it overheats

replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientSetHeat;
}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0 && OtherGun != None && A42SkrithPistol(Othergun) == None)
		return false;
	return super.CanAlternate(Mode);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (GlowFX != None)
		GlowFX.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	if (LayoutIndex == 1)
		{
			GlowFX = None;
			class'BUtil'.static.InitMuzzleFlash (GlowFX, class'A42AmbientFXRed', DrawScale, self, 'tip');
		}
		else if (LayoutIndex == 2)
		{
			GlowFX = None;
			class'BUtil'.static.InitMuzzleFlash (GlowFX, class'A42AmbientFXGreen', DrawScale, self, 'tip');
		}
		else
		{
			GlowFX = None;
			class'BUtil'.static.InitMuzzleFlash (GlowFX, class'A42AmbientFX', DrawScale, self, 'tip');
		}
		
		if (GlowFX != None)
		{
			if ((IsSlave() && Othergun.Hand >= 0) || (!IsSlave() && Hand < 0))
				GlowFX.SetRelativeRotation(rot(0,0,32768));
		}
	}
}

simulated function bool MayNeedReload(byte Mode, float Load)
{
	return false;
}

function ServerStartReload (optional byte i);

simulated function string GetHUDAmmoText(int Mode)
{
	return "";
}

simulated function float AmmoStatus(optional int Mode)
{
    return float(MagAmmo) / float(default.MagAmmo);
}

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

simulated event Tick (float DT)
{
	super.Tick(DT);

	if (NextAmmoTickTime < level.TimeSeconds)
	{
		if (MagAmmo < default.MagAmmo)
			MagAmmo=Min(default.MagAmmo, MagAmmo+1);
		NextAmmoTickTime = Level.TimeSeconds + 0.35;
	}
	if (HeatLevel > 0 && Level.TimeSeconds > HeatDeclineTime)
	{
		HeatLevel = FMax(HeatLevel - 10 * DT, 0);
	}
}

simulated event WeaponTick(float DT)
{
	local float f;
	super.WeaponTick(DT);

	if (FireMode[1].IsFiring())
	{
		f = 56 + 32 * (FMin(FireMode[1].HoldTime, 2) / 2);
		SoundPitch = f;
	}
}

simulated function AddHeat(float Amount, float DeclineTime)
{
	if (bBerserk)
		Amount *= 0.75;
		
	HeatLevel += Amount;
	HeatDeclineTime = FMax(Level.TimeSeconds + DeclineTime, HeatDeclineTime);
	
	if (HeatLevel >= 9.75)
	{
		HeatLevel = 10;
		return;
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None) // spam primary against objectives
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (AmmoAmount(0) < FireMode[1].AmmoPerFire)
		return 0;

	if (B.Squad!=None)
	{
		if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
			|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	    	 && (B.Enemy == None || !B.EnemyVisible()) )
			return 0;
		if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
			return 0;

		V = B.Squad.GetLinkVehicle(B);
		if ( V == None )
			V = Vehicle(B.MoveTarget);
		if ( V == B.Target )
			return 0;
		if ( (V != None) && (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
			return 0;
	}

	if (Dist > 1024)
		return 1;
		
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	if (IsSlave())
		return 0;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	if (RecommendHeal(B))
		return 1.1;		

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	
	switch (BestMode())
	{
		case 0:
			return class'BUtil'.static.DistanceAtten(Result, 0.33, Dist, 1024, 2048);
		case 1:
			return 0.5; // a42 charge beam is never a great option
	}
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
function float SuggestAttackStyle()	{	return 0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.7;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====

simulated function float ChargeBar()
{
	
	if (FireMode[1].IsFiring())
		return FMin(FireMode[1].HoldTime, 1);
	else
		return HeatLevel / 10;
}

defaultproperties
{
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_A42'
	BigIconCoords=(X1=80,Y1=24,X2=410,Y2=230)
	
	MeleeFireClass=Class'BallisticProV55.A42MeleeFire'
	bWT_RapidProj=True
	bWT_Energy=True
	ManualLines(0)="Launches moderate damage plasma projectiles at a good rate of fire. These projectiles gain damage over range."
	ManualLines(1)="A charging hitscan beam whose lethality increases with charge. Both pistols will charge and fire simultaneously if dual wielded."
	ManualLines(2)="Due to rechargeable batteries, the A42 will regain ammo at a slow rate when not in use. It is moderately effective at close range, with low recoil and good hipfire. A42 plasma will repair nodes and vehicles. The projectile attack will only penetrate players and not the environment."
	SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Pullout',Volume=0.148500)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Putaway',Volume=0.151000)
	MagAmmo=18
	bShouldDualInLoadout=False
	bNonCocking=True
	bNoCrosshairInScope=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc10',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=160,G=44,R=89,A=137),Color2=(B=151,R=0,A=202),StartSize1=84,StartSize2=61)
    NDCrosshairInfo=(SpreadRatios=(X1=0.300000,Y1=0.300000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.700000

	PlayerViewOffset=(X=32,Y=19,Z=-13)
	SightOffset=(X=-80.000000,Y=-6.000000,Z=18.250000)
	SightPivot=(Pitch=1024)
	SightBobScale=0.35f

	ParamsClasses(0)=Class'A42WeaponParamsComp'
	ParamsClasses(1)=Class'A42WeaponParamsClassic'
	ParamsClasses(2)=Class'A42WeaponParamsRealistic'
    ParamsClasses(3)=Class'A42WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.A42PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.A42SecondaryFire'
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.6000
	CurrentRating=0.600000
	bShowChargingBar=True
	Description="The A42 is an energy pistol of Skrith origin. Nicknamed 'Whip' by the UTC Marines, it has been the standard issue Skrith sidearm in both wars."
	Priority=16
	HudColor=(B=255,G=175,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	PickupClass=Class'BallisticProV55.A42Pickup'

	AttachmentClass=Class'BallisticProV55.A42Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_A42'
	IconCoords=(X2=127,Y2=31)
	ItemName="A42 Skrith Sidearm"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.A42_FPm'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BW_Core_WeaponTex.A42.A42Skin_SD'
	SoundPitch=56
	SoundRadius=32.000000
	

}
