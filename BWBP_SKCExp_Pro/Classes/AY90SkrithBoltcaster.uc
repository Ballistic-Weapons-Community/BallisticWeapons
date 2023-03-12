//=============================================================================
// AY90 Skrith Boltcaster
//
// The skrith version of a sniper
// 
//
// by Sarge based on code by RS
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90SkrithBoltcaster extends BallisticWeapon;

var Actor GlowFX; //Ambient blue glow + side flames
var Actor GlowFX2; //Side Flames
var Actor StringSpark1;
var Actor StringSpark2;
var Actor StringEnd1;
var Actor StringEnd2;
var float		lastModeChangeTime;
var Vector TheEnd2;
var Vector TheEnd;

var(AY90) 	ScriptedTexture   	WeaponScreen; //Scripted texture to write on
var(AY90) 	Material	        WeaponScreenShader; //Scripted Texture with self illum applied
var(AY90)	int					ScreenIndex; //What texture slot the scripted texture goes in

var(AY90) 	Material	        ScreenBase; //Screen colored background
var(AY90) 	Material	        ScreenPie1; //0-10
var(AY90) 	Material	        ScreenPie2; //10-20
var(AY90) 	Material	        ScreenPie3; //20-30
var(AY90) 	Material	        ScreenPie4; //30-40 pie oh my
var(AY90) 	Material	        ScreenPie1_Y; //Quarter charge
var(AY90) 	Material	        ScreenPie2_Y; //Half charge
var(AY90) 	Material	        ScreenPie3_Y; //Threeourfths charge
var(AY90) 	Material	        ScreenPie4_Y; //full charge

var protected const color MyFontColor; //Why do I even need this?

replication
{
	reliable if (Role == ROLE_Authority)
		ClientScreenStart;
}


exec simulated function CockGun(optional byte Type);
function ServerCockGun(optional byte Type);

//========================== AMMO COUNTER NON-STATIC TEXTURE ============

simulated function ClientScreenStart()
{
	ScreenStart();
}

// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[ScreenIndex] = WeaponScreenShader; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated event RenderTexture( ScriptedTexture Tex )
{

	Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenBase, MyFontColor); //Basic screen
	if (MagAmmo >= 10)
	{
		Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie1, MyFontColor); //Ammo
	}
	if (MagAmmo >= 20)
	{
		Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie2, MyFontColor); //Ammo
	}
	if (MagAmmo >= 30)
	{
		Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie3, MyFontColor); //Ammo
	}
	if (MagAmmo >= 40)
	{
		Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie4, MyFontColor); //Ammo
	}

	if (FireMode[0].bIsFiring == true)
	{
		if (FireMode[0].HoldTime/4 >= 0.25 && MagAmmo >= 10)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie1_Y, MyFontColor); 
		}
		if (FireMode[0].HoldTime/4 >= 0.5 && MagAmmo >= 20)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie2_Y, MyFontColor); 
		}
		if (FireMode[0].HoldTime/4 >= 0.75 && MagAmmo >= 30)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie3_Y, MyFontColor);
		}
		if (FireMode[0].HoldTime/4 >= 1.00 && MagAmmo >= 40)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie4_Y, MyFontColor);
		}
	}
	else if (FireMode[1].bIsFiring == true)
	{
		if (FireMode[1].HoldTime/4 >= 0.25 && MagAmmo >= 10)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie1_Y, MyFontColor); 
		}
		if (FireMode[1].HoldTime/4 >= 0.5 && MagAmmo >= 20)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie2_Y, MyFontColor);
		}
		if (FireMode[1].HoldTime/4 >= 0.75 && MagAmmo >= 30)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie3_Y, MyFontColor);
		}
		if (FireMode[1].HoldTime/4 >= 1.00 && MagAmmo >= 40)
		{
			Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenPie4_Y, MyFontColor);
		}
	}

}
	
simulated function UpdateScreen()
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;

	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}
	
// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	local bool bSuper;

	bSuper = super.ConsumeMagAmmo(Mode, Load, bAmountNeededIsMax);
	UpdateScreen();

	return bSuper;
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	super.Notify_ClipIn();
	UpdateScreen();
}

//=====================================================================

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}
	
	Super.BringUp(PrevWeapon);
//	SoundPitch = 45;

	GunLength = default.GunLength;

    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'AY90AmbientFX', DrawScale, self, 'tip');
	
//	if (level.DetailMode > DM_High)
//	{
//		if (StringSpark1 == None)	class'BUtil'.static.InitMuzzleFlash (StringSpark1, class'AY90EmitterBowString', DrawScale, self, 'LBeamA');
//		if (StringSpark2 == None)	class'BUtil'.static.InitMuzzleFlash (StringSpark2, class'AY90EmitterBowString', DrawScale, self, 'RBeamA');	
//	}
		
}

simulated event WeaponTick(float DT)
{
	local Vector End;
	local Vector Start;
	local Vector DirVec;
	local Vector SpecVec;

	super.WeaponTick(DT);

	if (MagAmmo > 0)
	{
		if (StringSpark1 == None)
			class'BUtil'.static.InitMuzzleFlash (StringSpark1, class'AY90EmitterBowString', DrawScale, self, 'LBeamSrc');
		if (StringSpark2 == None)
			class'BUtil'.static.InitMuzzleFlash (StringSpark2, class'AY90EmitterBowString', DrawScale, self, 'RBeamSrc');
		if (StringEnd1 == None)
			class'BUtil'.static.InitMuzzleFlash (StringEnd1, class'AY90EmitterBowStringEnd', DrawScale, self, 'LBeamB');
		if (StringEnd2 == None)
			class'BUtil'.static.InitMuzzleFlash (StringEnd2, class'AY90EmitterBowStringEnd', DrawScale, self, 'RBeamB');
	}
	
	if (StringSpark1 != None)
	{
		if (MagAmmo <= 0)
		{
			StringSpark1.Destroy();
			StringSpark1 = None;
		}
		else
		{
			StringSpark1.bHidden=false;
			//BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End-StringSpark1.Location,End-StringSpark1.Location);

			//Rotator type
//			StringSpark1.bHidden=false;
//			End = GetBoneCoords('LBeamB').Origin;
//			StringSpark1.SetRotation(Rotator(End - StringSpark1.Location));
//			End = vect(1,0,0) * VSize(End - StringSpark1.Location);
//			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End,End);
			
			//Velocity Type
			/*
			End = GetBoneCoords('LBeamB').Origin;
			DirVect = End - StringSpark1.Location;
			StringSpark1.SetRotation(Rotator(End - StringSpark1.Location));
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamDistanceRange.Min = VSize(End - StringSpark1.Location);
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamDistanceRange.Max = VSize(End - StringSpark1.Location);
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.X.Min = DirVect.x;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.X.Max = DirVect.x;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Y.Min = DirVect.y;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Y.Max = DirVect.y;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Z.Min = DirVect.z;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Z.Max = DirVect.z; */

			//Rotator type test
			StringSpark1.bHidden=false;
			End = GetBoneCoords('LBeamB').Origin;
			Start = StringSpark1.Location;
			StringSpark1.SetRotation(Rotator(End - Start));
			End = vect(1,0,0) * (VSize(GetBoneCoords('tip').Origin - End)-6);
			SpecVec = vect(0,0,1) * (VSize(GetBoneCoords('tip').Origin - Start)-14);
			DirVec = End + SpecVec;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(DirVec,DirVec);
			
			//Easy way out - emitter.startoffset.y = 10*chargePercentage
			
		}
	}
	if (StringSpark2 != None)
	{
		if (MagAmmo <= 0)
		{
			StringSpark2.Destroy();
			StringSpark2 = None;
		}
		else
		{
			//Rotator type test
			StringSpark2.bHidden=false;
			End = GetBoneCoords('RBeamB').Origin;
			Start = StringSpark2.Location;
			End = vect(1,0,0) * VSize(End - Start);
			SpecVec = vect(0,0,1) * (VSize(GetBoneCoords('tip').Origin - Start)-14);
			DirVec = End - SpecVec;
			BeamEmitter(Emitter(StringSpark2).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(DirVec,DirVec);
			
			//StringSpark2.bHidden=false;
			//End = GetBoneCoords('RBeamB').Origin;
			//StringSpark2.SetRotation(Rotator(End - StringSpark2.Location));
			//End = vect(1,0,0) * VSize(End - StringSpark2.Location);
			//BeamEmitter(Emitter(StringSpark2).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		}
	}
	
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
	{
		class'BUtil'.static.KillEmitterEffect (GlowFX);
		class'BUtil'.static.KillEmitterEffect (StringSpark1);
		class'BUtil'.static.KillEmitterEffect (StringSpark2);
	}
	super.Timer();
}

simulated event Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;
	if (GlowFX != None)
		GlowFX.Destroy();
	if (StringSpark1 != None)
		StringSpark1.Destroy();
	if (StringSpark2 != None)
		StringSpark2.Destroy();
	if (StringEnd1 != None)
		StringEnd1.Destroy();
	if (StringEnd2 != None)
		StringEnd2.Destroy();
	super.Destroyed();
}


simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	local Vehicle V;

	if (MagAmmo < 1)
		return 1;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return Rand(2);

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

	if (Dist < FireMode[1].MaxRange())
		return 1;
//	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
//		return 1;
//	if (FRand() > Dist/500)
//		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;
	local DestroyableObjective O;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( (V != None)
			&& (VSize(Instigator.Location - V.Location) < 1.5 * FireMode[0].MaxRange())
			&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) )
			return 1.2;

		if ( Vehicle(B.RouteGoal) != None && B.Enemy == None && VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * FireMode[0].MaxRange()
		     && Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
			return 1.2;

		O = DestroyableObjective(B.Squad.SquadObjective);
		if ( O != None && B.Enemy == None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity
	    	 && VSize(Instigator.Location - O.Location) < 1.1 * FireMode[0].MaxRange() && B.LineOfSightTo(O) )
			return 1.2;
	}

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (!HasMagAmmo(0) && Ammo[0].AmmoAmount < 1)
	{
		if (Dist > 400)
			return 0;
		return Result / (1+(Dist/400));
	}
	// Enemy too far away
	if (Dist > 1300)
		Result -= (Dist-1000) / 3000;
	if (Dist < 500)
		Result += 0.5;

	return Result;
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
function float SuggestAttackStyle()	{	 if (!HasNonMagAmmo(0) && !HasMagAmmo(0)) return 1.2; return 0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====


// Returns true if gun will need reloading after a certain amount of ammo is consumed. Subclass for special stuff
simulated function bool MayNeedReload(byte Mode, float Load)
{
	if (!bNoMag && BFireMode[1]!= None && BFireMode[1].bUseWeaponMag && (MagAmmo - Load < 5))
		return true;
	return bNeedReload;
//		return true;
//	return false;
}

simulated function float ChargeBar()
{
	if (FireMode[1].bIsFiring == true)
		return FMin(FireMode[1].HoldTime/4, 1);
	else
		return FMin(FireMode[0].HoldTime/4, 1);
}

defaultproperties
{
    ScreenIndex=6
	WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.SkrithBow.SKBow-ScriptLCD'
	WeaponScreenShader=Shader'BWBP_SKC_Tex.SkrithBow.SKBow-ScriptLCD-SD'
	
	ScreenBase=Texture'BWBP_SKC_Tex.SkrithBow.SKBow-ScreenBase'
	ScreenPie1=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie1'
	ScreenPie2=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie2'
	ScreenPie3=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie3'
	ScreenPie4=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie4'
	ScreenPie1_Y=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie1_Y'
	ScreenPie2_Y=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie2_Y'
	ScreenPie3_Y=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie3_Y'
	ScreenPie4_Y=Texture'BWBP_SKC_Tex.SkrithBow.SBow-ScreenPie4_Y'
	MyFontColor=(B=255,G=255,R=255,A=255)
	
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
     UsedAmbientSound=Sound'BW_Core_WeaponSound.A73.A73Hum1'
     BigIconMaterial=Texture'BWBP_SKC_Tex.SkrithBow.BigIcon_SBow'
     bWT_RapidProj=True
     bWT_Energy=True
     SpecialInfo(0)=(Info="300.0;25.0;0.5;85.0;0.2;0.2;0.2")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Putaway')
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipIn')
     ClipInFrame=0.700000
     bNonCocking=True
     bShowChargingBar=True
	 MagAmmo=40
     WeaponModes(0)=(ModeName="Charged Fire",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Plasma Charge",ModeID="WM_FullAuto",bUnavailable=True)
     WeaponModes(2)=(ModeName="ALaser",bUnavailable=True)
     WeaponModes(3)=(ModeName="BLaser",bUnavailable=True)
     WeaponModes(4)=(ModeName="CLaser",bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=768)
     SightOffset=(Y=4.700000,Z=8.000000)
     SightDisplayFOV=40.000000
     ParamsClasses(0)=Class'AY90WeaponParamsArena'
     ParamsClasses(1)=Class'AY90WeaponParamsClassic'
	 ParamsClasses(2)=Class'AY90WeaponParamsRealistic'
	 ParamsClasses(3)=Class'AY90WeaponParamsClassic'
     FireModeClass(0)=Class'BWBP_SKCExp_Pro.AY90PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKCExp_Pro.AY90SecondaryFire'
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc3',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=93,R=0,A=112),Color2=(B=0,G=212,R=226,A=255),StartSize1=110,StartSize2=55)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	 BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bMeleeWeapon=True
     Description="AY90 Skrith Boltcaster||Manufacturer: Unknown Skrith Engineers|Primary: Variable Charge Shot|Secondary: Charged Bolt Spread|Named after a certain bird of prey, the AY90 ''Wyvern'' is a Skrith's companion to take down terrans without being seen or heard.  A boltcaster with all the signs that it's Skrith in origin; blades on the bow arms, blue in color and firing powerful plasma with this weapon taking the form of a variable charge system.  Able to fire rapid shots for swift getaways or a full charge to snipe a soldier from a distance, and if that wasn't enough; the Wyvern has a charged bolt spread to eliminate multiple enemies in rapid succession.  A versatile, deadly tool of destruction without being heard, just ask the PTSD ridden troops of UTC's elite division on Ravenos; who watched 90% of their squad dying to plasma bolts without their enemies being known."
	 Priority=92
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=19
     PickupClass=Class'BWBP_SKCExp_Pro.AY90Pickup'
     PlayerViewOffset=(X=5.000000,Y=2.000000,Z=-6.000000)
     BobDamping=2.200000
	 MeleeFireClass=Class'BWBP_SKCExp_Pro.AY90MeleeFire'
     AttachmentClass=Class'BWBP_SKCExp_Pro.AY90Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.SkrithBow.SmallIcon_SBow'
     IconCoords=(X2=127,Y2=31)
     ItemName="AY90 Skrith Boltcaster"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_SkrithCrossbow'
     DrawScale=0.188000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
