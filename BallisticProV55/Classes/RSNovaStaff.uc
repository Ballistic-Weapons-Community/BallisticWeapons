//============================================================================
// RSNovaStaff.
//
// Possible Staff Differences:
//
// -Nova lightning Heals teammates, nodes, etc
// -Dark plasma? heals teammates, nodes, etc at cost of player health
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaStaff extends BallisticWeapon;

var Emitter		FreeZap;		// The free zap emitter
var bool			bCanKillZap;	// Free zap is being killed and can be destroyed if needed, but we still want it rendered till then

var float		BladeAlpha;

var actor		AmmoGlow, CoverGlow, Blade1Glow, Blade2Glow, Blade3glow, ReloadSteam, Arc1, Arc2, Arc3;

var float		lastModeChangeTime;

var float		NextRegenTime;

var float				SoulPower;
var float				MaxSouls;
var bool					bOnRampage;
var RSNovaWings 	Wings;
var float				WingPhase;
var bool					bWingDown;
var() Sound			WingSound;

var Emitter				FreeChainZap;
var bool					bCanKillChainZap;

//Classic params

var   RSDarkNovaControl	DNControl;

// BladesOpen
// BladesWide
// PetalRoot: NovaUpper

replication
{
	reliable if (Role == ROLE_Authority && bNetOwner)
		SoulPower;
}

simulated function PostNetBeginPlay()
{
	local RSDarkNovaControl DNC;

	super.PostNetBeginPlay();

	if (GameStyleIndex != 0)
	{
		MaxSouls=10;
	}
	
	if (Role == ROLE_Authority && DNControl == None)
	{
		foreach DynamicActors (class'RSDarkNovaControl', DNC)
		{
			DNControl = DNC;
			return;
		}
		DNControl = Spawn(class'RSDarkNovaControl', None);
	}
}

function AddSoul(float Amount)
{
	SoulPower = FClamp(SoulPower+Amount, 0, MaxSouls + 0.2f);
}

function ServerWeaponSpecial(optional byte i)
{
	if (SoulPower >= MaxSouls)
	{
		StartRampage();
		ClientWeaponSpecial(1);
	}
}
simulated function ClientWeaponSpecial(optional byte i)
{
	if (i > 0)
		StartRampage();
	else EndRampage();
}

simulated function StartRampage()
{
	if (bOnRampage)
		return;
	bOnRampage = true;
	RSNovaAttachment(ThirdPersonActor).bRampage = true;
	RSNovaPrimaryFire(BFireMode[0]).ModePowerDrain *= 0.4;

	if (Instigator!=None && Instigator.Controller!=None)
		Instigator.Controller.GotoState('PlayerFlying');
	Instigator.AirSpeed *= 1.25;

	WingPhase = 1.0;
	Wings = spawn(class'RSNovaWings',Instigator,,Instigator.Location,Instigator.Rotation);
	if (Wings != None)
		Wings.SetBase(Instigator);
}

simulated function EndRampage()
{
	if (!bOnRampage)
		return;
	bOnRampage = false;
	RSNovaAttachment(ThirdPersonActor).bRampage = false;

	if (Instigator!=None && Role==Role_Authority)
		PlayerController(Instigator.Controller).Restart();

	Instigator.AirSpeed /= 1.25;

	if (Wings != None)
		Wings.Kill();

	SoulPower = 0; //fix for slightly negative soul power
	
	if (Role == ROLE_Authority && !Instigator.IsLocallyControlled())
		ClientWeaponSpecial();
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (bOnRampage)
	{
		Damage *= 0.6;
		Momentum = vect(0,0,0);
	}
		
	if (FireMode[1].bIsFiring)
		Momentum *= 0.6;

	super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function SetBladesOpen(float Alpha)
{
	BladeAlpha = FClamp(Alpha, 0.0, 1.0);
	AnimBlendParams(1, BladeAlpha, 0.0, 0.2, 'NovaUpper');
	LoopAnim('BladesWide',, 0.0, 1);
}

simulated function AddRecoil (float Amount, float FireChaos, optional byte Mode)
{
	super.AddRecoil(Amount, FireChaos, Mode);
	if (Mode == 0)
	{
		if (CurrentWeaponMode == 0)
			SetBladesOpen(BladeAlpha + 0.2);
		else if (CurrentWeaponMode == 1)
			SetBladesOpen(BladeAlpha + 0.1);
	}
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (bOnRampage && Instigator.Weapon != self)
		EndRampage();
}

simulated event WeaponTick(float DT)
{
	local Vector End;

	super.WeaponTick(DT);

	if (Role == ROLE_Authority)
	{
		if (GameStyleIndex != 0 && Instigator.Health > 0 && level.TimeSeconds >= NextRegenTime)
		{
			if (bOnRampage)
				Instigator.GiveHealth(2, Instigator.SuperHealthMax);
			else// if (Instigator.Health < Instigator.HealthMax + Instigator.SuperHealthMax / 2)
				Instigator.GiveHealth(1, Instigator.HealthMax + (Instigator.SuperHealthMax-Instigator.HealthMax) / 1.96);
			NextRegenTime = level.TimeSeconds + 0.5;
		}
	
		if (bOnRampage)
		{
			SoulPower -= DT/5;
			if (SoulPower <= 0)
				EndRampage();
		}
	}

	if (bOnRampage)
	{
		if (bWingDown)
		{
			Instigator.Velocity -= vect(0,0,300) * DT;
			WingPhase += DT * 2;
			if (WingPhase >= 1.0)
			{
				WingPhase = 1.0;
				bWingDown = false;
				PlaySound(WingSound, SLOT_None, 1.0);
			}
		}
		else
		{
			WingPhase -= DT * 4;
			Instigator.Velocity += vect(0,0,600) * DT;
			if (WingPhase <= -1.0)
			{
				WingPhase = -1.0;
				bWingDown = true;
			}
		}
		if (Wings != None)
			Wings.UpdateWings(WingPhase);
	}

	if (FireMode[0].IsFiring())
	{
		if (CurrentWeaponMode > 1)
			SetBladesOpen(BladeAlpha + DT);
	}
	else if (FireMode[1].IsFiring())
	{
		SetBladesOpen(BladeAlpha + DT);
	}
	else
		SetBladesOpen(BladeAlpha - DT / 0.8);

	if (BladeAlpha > 0)
	{
		if (Arc1 == None)
			class'BUtil'.static.InitMuzzleFlash (Arc1, class'RSNovaArc', DrawScale, self, 'Arc1Src');
		if (Arc2 == None)
			class'BUtil'.static.InitMuzzleFlash (Arc2, class'RSNovaArc', DrawScale, self, 'Arc2Src');
		if (Arc3 == None)
			class'BUtil'.static.InitMuzzleFlash (Arc3, class'RSNovaArc', DrawScale, self, 'Arc3Src');
	}
	if (Arc1 != None)
	{
		if (BladeAlpha <= 0)
		{
			Arc1.Destroy();
			Arc1 = None;
		}
		else
		{
			Arc1.bHidden=false;
			End = GetBoneCoords('Arc3b').Origin;
			Arc1.SetRotation(Rotator(End - Arc1.Location));
			End = vect(1,0,0) * VSize(End - Arc1.Location);
			BeamEmitter(Emitter(Arc1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		}
	}
	if (Arc2 != None)
	{
		if (BladeAlpha <= 0)
		{
			Arc2.Destroy();
			Arc2 = None;
		}
		else
		{
			Arc2.bHidden=false;
			End = GetBoneCoords('Arc1b').Origin;
			Arc2.SetRotation(Rotator(End - Arc2.Location));
			End = vect(1,0,0) * VSize(End - Arc2.Location);
			BeamEmitter(Emitter(Arc2).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		}
	}
	if (Arc3 != None)
	{
		if (BladeAlpha <= 0)
		{
			Arc3.Destroy();
			Arc3 = None;
		}
		else
		{
			Arc3.bHidden=false;
			End = GetBoneCoords('Arc2b').Origin;
			Arc3.SetRotation(Rotator(End - Arc3.Location));
			End = vect(1,0,0) * VSize(End - Arc3.Location);
			BeamEmitter(Emitter(Arc3).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		}
	}
}

simulated function RSNova_TrackingZap GetTargetZap()
{
	if (ThirdPersonActor == None)
		return None;
	return RSNovaAttachment(ThirdPersonActor).TargetZap;
}
// Activate the target zap and/or give it the list of targets (Server->Attachment->Client)
simulated function SetTargetZap(Actor Targ, bool bHealing)
{
	if (Role == ROLE_Authority)
		RSNovaAttachment(ThirdPersonActor).SetTargetZap(Targ, bHealing);
	if (!Instigator.IsLocallyControlled())
		return;
	KillFreeZap();
}
// Activate free zap (Server->Attachment->Client)
simulated function SetFreeZap()
{
	if (Role == ROLE_Authority)
		RSNovaAttachment(ThirdPersonActor).SetFreeZap();
	if (!Instigator.IsLocallyControlled())
		return;
	if (FreeZap != None)
	{	if (bCanKillZap)	FreeZap.Destroy();
		else				return;
	}
	KillTargetZap();
	FreeZap = spawn(class'RSNova_FreeZap', self);
	FreeZap.bHidden = true;
	bCanKillZap = false;
}
// Kill all zaps (Server->Attachment->Client)
simulated function KillZap()
{
	if (Role == ROLE_Authority)
		RSNovaAttachment(ThirdPersonActor).KillZap();
	if (Instigator.IsLocallyControlled())
	{	KillTargetZap();		KillFreeZap();		}
}
// Kill the target zap (local only)
simulated function KillTargetZap()
{
	Instigator.SoundPitch=64;
}
// Kill the free zap (local only)
simulated function KillFreeZap()
{
	if (FreeZap != None)
	{	FreeZap.Kill();	bCanKillZap = true;	}
}

simulated function SetChainZap()
{
	if (Role == ROLE_Authority)
		RSNovaAttachment(ThirdPersonActor).SetChainZap(RSNovaPrimaryFire(Firemode[0]));
	if (!Instigator.IsLocallyControlled())
		return;
	KillFreeChainZap();
}
simulated function SetFreeChainZap()
{

	if (Role == ROLE_Authority)
		RSNovaAttachment(ThirdPersonActor).SetFreeChainZap();
	if (!Instigator.IsLocallyControlled())
		return;
	if (FreeChainZap != None)
	{	if (bCanKillChainZap)	FreeChainZap.Destroy();
		else				return;
	}
	KillChainZap();
	FreeChainZap = spawn(class'RSNova_FreeChainZap', self);
	FreeChainZap.bHidden = true;
	bCanKillChainZap = false;

}
// Kill all zaps (Server->Attachment->Client)
simulated function KillChainZaps()
{
	if (Role == ROLE_Authority)
		RSNovaAttachment(ThirdPersonActor).KillChainZaps();
	if (Instigator.IsLocallyControlled())
	{	KillChainZap();		KillFreeChainZap();		}
}
// Kill the target zap (local only)
simulated function KillChainZap()
{
	Instigator.SoundPitch=64;
}
// Kill the free zap (local only)
simulated function KillFreeChainZap()
{
	if (FreeChainZap != None)
	{	FreeChainZap.Kill();	bCanKillChainZap = true;	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

//	AmmoGlow, CoverGlow, Blade1Glow, Blade2Glow, Blade3glow;
	if (CoverGlow != None)
		CoverGlow.Destroy();
	if (Blade1Glow != None)
		Blade1Glow.Destroy();
	if (Blade2Glow != None)
		Blade2Glow.Destroy();
	if (Blade3Glow != None)
		Blade3Glow.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode >= DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	CoverGlow = None;
    	Blade1Glow = None;
    	Blade2Glow = None;
    	Blade3Glow = None;
//		CoverGlow = Spawn(class'GRS9AmbientFX');
//		class'BallisticEmitter'.static.ScaleEmitter(Emitter(CoverGlow), DrawScale);

		class'BUtil'.static.InitMuzzleFlash (CoverGlow, class'RSNovaCoverGlow', DrawScale, self, 'gem');
		class'BUtil'.static.InitMuzzleFlash (Blade1Glow, class'RSNovaBladeGlow', DrawScale, self, 'blade1');
		class'BUtil'.static.InitMuzzleFlash (Blade2Glow, class'RSNovaBladeGlow', DrawScale, self, 'blade2');
		class'BUtil'.static.InitMuzzleFlash (Blade3Glow, class'RSNovaBladeGlow', DrawScale, self, 'blade3');
	}
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (bOnRampage)
			EndRampage();
		return true;
	}
	return false;
}

exec simulated function CockGun(optional byte Type);
function ServerCockGun(optional byte Type);

simulated function Notify_NovaOpenFX ()
{
	if (ReloadSteam != None)
	{
		ReloadSteam.Destroy();
		ReloadSteam=None;
	}
	class'BUtil'.static.InitMuzzleFlash (ReloadSteam, class'RSNovaSteam', DrawScale, self, 'fX');
	ReloadSteam.SetRelativeRotation(rot(0,32768,0));
}
simulated function Notify_NovaOpenGlow ()
{
	class'BUtil'.static.InitMuzzleFlash (AmmoGlow, class'RSNovaAmmoGlow', DrawScale, self, 'Ammo');
}
simulated function Notify_NovaCloseGlow ()
{
	class'BUtil'.static.KillEmitterEffect (AmmoGlow);
}
simulated function bool StartFire(int Mode)
{
	if (AmmoGlow != None)
		AmmoGlow.Destroy();
	return super.StartFire(Mode);
}
simulated event Timer()
{
	if (Clientstate == WS_PutDown)
	{
		class'BUtil'.static.KillEmitterEffect (CoverGlow);
		class'BUtil'.static.KillEmitterEffect (Blade1Glow);
		class'BUtil'.static.KillEmitterEffect (Blade2Glow);
		class'BUtil'.static.KillEmitterEffect (Blade3Glow);
	}
	super.Timer();
}

simulated event RenderOverlays (Canvas C)
{
	local vector End, X,Y,Z;
	Super.RenderOverlays(C);
	if (FreeChainZap != None)
	{
		GetViewAxes(X,Y,Z);
		FreeChainZap.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		FreeChainZap.SetRotation(rotator(Vector(GetAimPivot()*0.5) >> Instigator.GetViewRotation()));

		C.DrawActor(FreeChainZap, false, false, Instigator.Controller.FovAngle);
	}
	if (FreeZap != None)
	{
		GetViewAxes(X,Y,Z);
		FreeZap.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		FreeZap.SetRotation(rotator(Vector(GetAimPivot()*0.5) >> Instigator.GetViewRotation()));
		End = X * 1000;
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Min -= 200 * Abs(X.Z);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Max += 200 * Abs(X.Z);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Min -= 200 * Abs(X.X);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Max += 200 * Abs(X.X);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Min -= 200 * (1-Abs(X.Z));
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Max += 200 * (1-Abs(X.Z));

		BeamEmitter(FreeZap.Emitters[2]).BeamEndPoints[0].Offset = BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset;

		C.DrawActor(FreeZap, false, false, Instigator.Controller.FovAngle);
	}
	if (GetTargetZap() != None)
	{
		GetTargetZap().bHidden = true;
		GetTargetZap().SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		GetTargetZap().UpdateTargets();
		C.DrawActor(GetTargetZap(), false, false, Instigator.Controller.FovAngle);
	}
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

simulated function Destroyed()
{
	if (FreeZap != None)
		FreeZap.Destroy();
	if (Instigator.AmbientSound == UsedAmbientSound || Instigator.AmbientSound == RSNovaPrimaryFire(FireMode[0]).FireSoundLoop)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}

	if (bOnRampage)
		EndRampage();

	if (ReloadSteam != None)
		ReloadSteam.Destroy();
	if (AmmoGlow != None)
		AmmoGlow.Destroy();
	if (CoverGlow != None)
		CoverGlow.Destroy();
	if (Blade1Glow != None)
		Blade1Glow.Destroy();
	if (Blade2Glow != None)
		Blade2Glow.Destroy();
	if (Blade3Glow != None)
		Blade3Glow.Destroy();

	if (Arc1 != None)
		Arc1.Destroy();
	if (Arc2 != None)
		Arc2.Destroy();
	if (Arc3 != None)
		Arc3.Destroy();
	super.Destroyed();
}

simulated function FirePressed(float F)
{
	if (bNeedReload && MagAmmo > 0)
		bNeedReload = false;
	super.FirePressed(F);
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}

simulated function float ChargeBar()
{
	return SoulPower/MaxSouls;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other,Pickup);

	if(RSNovaPickup(Pickup) != None)
		AddSoul(RSNovaPickup(Pickup).SoulPower);
}

function DropFrom(vector StartLocation)
{
    local int m;
	local Pickup Pickup;

    if (!bCanThrow)// || !HasAmmo())
        return;

	if (AmbientSound != None)
		AmbientSound = None;

    ClientWeaponThrown();

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None && FireMode[m].bIsFiring)
            StopFire(m);
    }

	if ( Instigator != None )
		DetachFromPawn(Instigator);

	Pickup = Spawn(PickupClass,self,, StartLocation);
	if ( Pickup != None )
	{
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
    	Pickup.InitDroppedPickupFor(self);
	    Pickup.Velocity = Velocity;
		if(RSNovaPickup(Pickup) != None)
			RSNovaPickup(Pickup).SoulPower = SoulPower;
    }
    Destroy();
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return 0;

	Dist = VSize(Instigator.Location - B.Enemy.Location);
	
	if (MagAmmo < 1 || ReloadState != RS_None || Dist < FireMode[1].MaxRange())
		return 1;

	if (level.TimeSeconds - lastModeChangeTime < 1.4 - B.Skill*0.15)
		return 0;

	if (Dist > 2048 && MagAmmo > 4)
	{
		if (CurrentWeaponMode != 0)
		{
			lastModeChangeTime = level.TimeSeconds;
			CurrentWeaponMode = 0;
			RSNovaPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	else
	{
		if (CurrentWeaponMode != 1)
		{
			lastModeChangeTime = level.TimeSeconds;
			CurrentWeaponMode = 1;
			RSNovaPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}

	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Dist;
	
	if (Instigator != None && Instigator.Health < 50)
		return 0.3; // dark star eats hp to fire

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		if (RecommendHeal(B))
			return 1.2;
	}

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	return class'BUtil'.static.DistanceAtten(Super.GetAIRating(), 0.5, Dist, 3072, 3072);
}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	 return 0.2;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.2;	}

// End AI Stuff =====

defaultproperties
{
	MaxSouls=5.0
	WingSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Flying'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.NovaStaff.BigIcon_NovaStaff'
	BigIconCoords=(Y1=32,Y2=230)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Heal=True
	ManualLines(0)="Slow Bolts deal high damage, gain damage over range and leech enemy HP for the user. This mode damages the user if used from the hip.|Rapid Fire bolts have moderate damage and gain damage over range.|The Lightning mode locks onto an enemy, deals damage and inflicts blind. Alternatively, it can be used to rapidly heal allies. It costs low soul power.|Thunder Strike mode generates a thunder bolt with medium range and excellent damage output. It inflicts severe damage at high soul cost.|Chain Lightning attacks multiple enemies on screen in the same fashion as Lightning, but drains soul power at an alarming rate."
	ManualLines(1)="Melee attack. Damage increases the longer Altfire is held, up to 1.5 seconds for maximum bonus. Deals more damage from behind. Leeches half of the damage dealt as health for the wielder."
	ManualLines(2)="Enemies killed by this weapon leave souls behind. These can be collected to power the Lightning, Thunder Strike and Chain Lightning modes. Use of those modes without external soul power will cause the user's soul to be used instead, dealing significant backlash damage.||With full soulpower, the weapon can enter rampage mode, reducing all damage taken and granting the ability to fly. In this mode, soulpower will drain over time.||Effective at close and medium range."
	SpecialInfo(0)=(Info="300.0;40.0;1.0;80.0;1.0;0.0;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Putaway')
	PutDownAnimRate=1.4
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-CrystalOut',Volume=0.700000)
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-CrystalIn',Volume=0.700000)
	ClipInFrame=0.700000
	WeaponModes(0)=(ModeName="Slow Bolt",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
	WeaponModes(2)=(ModeName="Lightning")
	WeaponModes(3)=(ModeName="Thunder Strike",ModeID="WM_FullAuto")
	WeaponModes(4)=(ModeName="Chain Lightning",ModeID="WM_FullAuto",bUnavailable=True)
	CurrentWeaponMode=0
	SightPivot=(Pitch=512)
	SightOffset=(X=-60.000000,Z=15.000000)
	SightDisplayFOV=40.000000
	GunLength=128.000000
	ParamsClasses(0)=Class'RSNovaWeaponParams'
	ParamsClasses(1)=Class'RSNovaWeaponParamsClassic'
	ParamsClasses(2)=Class'RSNovaWeaponParamsRealistic'
    ParamsClasses(3)=Class'RSNovaWeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.RSNovaPrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.RSNovaMeleeFire'
	
	NDCrosshairCfg=(Pic1=TexRotator'BW_Core_WeaponTex.NovaStaff.NovaOutA-Rot',Pic2=TexRotator'BW_Core_WeaponTex.NovaStaff.NovaInA-Rot',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(G=221,A=130),Color2=(B=184,G=187,R=185,A=229),StartSize1=106,StartSize2=50)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.250000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.500000
    
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.70000
	bShowChargingBar=True
	Description="During a mining excavation of the large crater in sector-547b on one of the distant Outword planets, a strage, magnificent artifact was discovered. Generating great interest in the isolated facility, superstitious miners beleived it to be a magical device capable of everything from allowing god to read their minds to teleportation and the summoning of demons. The artifact was subjected to all manner of tests, but proved to be a confounding subject and revealed very little. It was made of an unimaginably strong material and appeared apparently undamaged despite it's intricate construction. For all they could say, it may have been nothing more than a candlestick.|Finally, mine coordinator R Peters, who had had a greedy eye fixed on the artifact since day one, ordered the tests cancelled and retired the artifact to his office."
	DisplayFOV=47.000000
	Priority=9
	HudColor=(B=255,G=175,R=100)
	InventoryGroup=5
	GroupOffset=3
	PickupClass=Class'BallisticProV55.RSNovaPickup'
	PlayerViewOffset=(X=20.000000,Y=5.000000,Z=-6.000000)
	AttachmentClass=Class'BallisticProV55.RSNovaAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.NovaStaff.SmallIcon_NovaStaff'
	IconCoords=(X2=127,Y2=31)
	ItemName="Nova Staff"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=96
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_NovaStaff'
	DrawScale=0.300000
	bFullVolume=True
	SoundRadius=32.000000
}
