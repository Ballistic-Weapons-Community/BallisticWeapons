class XOXOStaff extends BallisticWeapon;

var Actor 						HeartGlow, ProngGlow1, ProngGlow2;
var XOXOStreamEffect		StreamEffect;

var float						Lewdness;
var bool							bLoveMode;
var Emitter						LoveEffect;

var int							ShockwaveDamageRadius;
var int							ShockwaveDamage, ShockwaveMomentum;
var class<DamageType>	ShockwaveDamageType;

replication
{
	reliable if (ROLE == ROLE_Authority)
		Lewdness;
}
function ServerSwitchWeaponMode (byte NewMode)
{
	super.ServerSwitchWeaponMode (NewMode);
	
	if (CurrentWeaponMode == 1)
	{
		RecoilXFactor=0.8;
		RecoilYFactor=1.5;
		RecoilDeclineDelay=0.8;
	}
	
	else
	{
		RecoilXFactor = default.RecoilXFactor;
		RecoilYFactor = default.RecoilYFactor;
		RecoilDeclineDelay = default.RecoilDeclineDelay;
	}
}
simulated function ClientSwitchWeaponModes (byte newMode)
{
	Super.ClientSwitchWeaponModes(newMode);
	
	if (newMode == 1)
	{
		RecoilXFactor=0.8;
		RecoilYFactor=1.5;
		RecoilDeclineDelay=0.8;
	}
	
	else
	{
		RecoilXFactor = default.RecoilXFactor;
		RecoilYFactor = default.RecoilYFactor;
		RecoilDeclineDelay = default.RecoilDeclineDelay;
	}
}

//===========================================================================
// Glow management.
//===========================================================================
simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (HeartGlow != None)
		HeartGlow.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode >= DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	HeartGlow = None;
		class'BUtil'.static.InitMuzzleFlash (HeartGlow, class'XOXOCoverGlow', DrawScale, self, 'HeartGlowSocket');
		Emitter(HeartGlow).Emitters[0].ZTest = False;
	}
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		class'BUtil'.static.KillEmitterEffect(HeartGlow);
		if (bLoveMode)
			ArousalDepleted();
		return true;
	}
	return false;
}

simulated function Destroyed()
{
	class'BUtil'.static.KillEmitterEffect(HeartGlow);
	class'BUtil'.static.KillEmitterEffect(LoveEffect);
	Super.Destroyed();
}

//===========================================================================
// Stream effect for FP.
//===========================================================================
simulated function RenderOverlays (Canvas C)
{
	Super.RenderOverlays(C);

	if (StreamEffect != None)
	{
		StreamEffect.bHidden = true;
		StreamEffect.SetLocation(ConvertFOVs(GetBoneCoords('Muzzle').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		StreamEffect.UpdateEndpoint();
		C.DrawActor(StreamEffect, false, false, Instigator.Controller.FovAngle);
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

//===========================================================================
// Shockwave attack.
//===========================================================================
function Shockwave()
{
	local actor Victims;
	local float damageScale, dist, finalDamage, totaldamage;
	local vector dir;
	
	local int i;
	local Controller C;
	local array<Pawn> HealedAllies;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, ShockwaveDamageRadius, Instigator.Location )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if(Victims != Self && (Victims.Role == ROLE_Authority) && Victims.bCanBeDamaged && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Instigator)
		{
			if (Pawn(Victims) != None && Pawn(Victims).Controller != None && Pawn(Victims).Controller.SameTeamAs(InstigatorController))
				continue;
			dir = Victims.Location - Instigator.Location;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = FClamp(0.5 + 0.5 * (1 - (dist - Victims.CollisionRadius)/ShockwaveDamageRadius), 0, 1);
			finalDamage = damageScale * ShockwaveDamage;
			
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				finalDamage,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				damageScale * ShockwaveMomentum * dir,
				ShockwaveDamageType
			);
			
			if (Pawn(Victims) != None)
				totalDamage += finalDamage;
		}
	}
	
	if (TotalDamage > 0)
	{
		//Distribute total damage done as HP for team.
		for (C = Level.ControllerList; C != None; C = C.NextController)
		{
			if (C.SameTeamAs(Instigator.Controller) && C.Pawn != None && C.Pawn.bProjTarget)
				HealedAllies[HealedAllies.Length] = C.Pawn;
		}
	
		if (TotalDamage >= HealedAllies.Length)
		{
			for (i=0; i<HealedAllies.Length; i++)
			{
				if (BallisticPawn(HealedAllies[i]) != None)
					BallisticPawn(HealedAllies[i]).GiveAttributedHealth(TotalDamage / HealedAllies.Length, HealedAllies[i].SuperHealthMax, Instigator);
				else HealedAllies[i].GiveHealth(TotalDamage / HealedAllies.Length, HealedAllies[i].SuperHealthMax);
			}
		}
	}
	
	bHurtEntry = false;
}

//===========================================================================
// Lewd management.
//===========================================================================
function AddLewd(float Amount)
{
	if (Amount < 0 && bLoveMode)
		Amount *= 0.5;
	Lewdness = FClamp(Lewdness + Amount, 0, 5);
}

simulated function float ChargeBar()
{
	return Lewdness / 5;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other,Pickup);

	if(XOXOPickup(Pickup) != None)
		AddLewd(XOXOPickup(Pickup).Lewdness);
}

function DropFrom(vector StartLocation)
{
    local int m;
	local Pickup Pickup;

    if (!bCanThrow)
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
		if(XOXOPickup(Pickup) != None)
			XOXOPickup(Pickup).Lewdness = Lewdness;
    }
    Destroy();
}

//===========================================================================
// Love mode.
//===========================================================================
function ServerWeaponSpecial(optional byte i)
{
	if (Lewdness >= 5)
	{
		LoveMode();
		ClientWeaponSpecial(1);
	}
}
simulated function ClientWeaponSpecial(optional byte i)
{
	if (i > 0)
		LoveMode();
	else
		ArousalDepleted();
}

simulated function LoveMode()
{
	if (bLoveMode)
		return;
	bLoveMode = true;
	XOXOAttachment(ThirdPersonActor).bLoveMode = true;

	LoveEffect = spawn(class'XOXOLoveModeGlow',Instigator,,Instigator.Location,Instigator.Rotation);
	if (LoveEffect != None)
		LoveEffect.SetBase(Instigator);

	WeaponModes[3].bUnavailable=false;
}

simulated function ArousalDepleted()
{
	if (!bLoveMode)
		return;
	bLoveMode = false;
	XOXOAttachment(ThirdPersonActor).bLoveMode = false;

	if (LoveEffect != None)
		LoveEffect.Kill();

	WeaponModes[3].bUnavailable=true;

	CurrentWeaponMode = 0;
	
	XOXOPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	Lewdness = 0;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (bLoveMode)
	{
		Damage *= 0.6;
		Momentum *= -0.2; //attraction
	}
	
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;

	super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function float GetModifiedJumpZ(Pawn P)
{
	if (bLoveMode)
		return super.GetModifiedJumpZ(P) * 2.0;

	return super.GetModifiedJumpZ(P);
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (bLoveMode && Instigator.Weapon != self)
		ArousalDepleted();
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (Role == ROLE_Authority)
	{
		if (bLoveMode)
		{
			Lewdness -= DT/12;
			if (Lewdness <= 0)
			{
				ArousalDepleted();
				ClientWeaponSpecial(0);
			}
		}
	}
}


//===========================================================================
// Misc.
//===========================================================================
simulated function FirePressed(float F)
{
	if (bNeedReload && MagAmmo > 0)
		bNeedReload = false;
	super.FirePressed(F);
}

defaultproperties
{
     ShockwaveDamageRadius=1024
     ShockwaveDamage=80
     ShockwaveMomentum=40000
     ShockwaveDamageType=Class'BWBPOtherPackPro.DTXOXOShockwave'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPOtherPackTex.XOXO.BigIcon_XOXO'
     BigIconCoords=(Y1=16,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="The Bomb firemode shoots Xes and Os, that explode and deal relatively high damage on direct hit and also release smaller, shrapnel-like Xes and Os that deal some area damage. The projectile travels relatively slow though and has to deal with noticeable trajectory.|The Fast Charge has high RPM, deals good damage and travels in a straight line. Gains damage over range.|Lust creates a shockwave, damaging and knocking back nearby enemies. Every shockwave has vampiristic abilities, healing you and random teammates on the map, no matter wher they are, the health of your enemies will be evenly distributed between you and your team. This mode costs Lewdness to use."
     ManualLines(1)="The Stream, with its spazzing movement, performs rather poorly on medium range, on the other hand, continously hitting someone with it at close range increases the base damage until you next miss.. Aiming it at teammates however enables its homing capability, which makes it rather convenient to heal them."
     ManualLines(2)="Has a melee attack.|By killing enemies, you can collect their lewdness (similar to Dark Star and Nova Staff souls) and fill up your luv-o-meter. Filling it up, makes it possible to activate love-mode by pressing the Weapon Special-Key. This gives you damage resistance, improved jump, reduces the Lewdness cost of Lust Shockwave and allows the Sexplosion to be used.||The Sexplosion is an impressive firemode, which creates a gargantuan ball of love, acting bomb-like, but much slower. Upon impact, it explodes violently and kills pretty much everyone in proximity. The Sexplosion however wastes the complete charge of Le Big Xoxo and ends Love-Mode. Think twice, before wasting it!"
     SpecialInfo(0)=(Info="300.0;40.0;1.0;80.0;0.0;1.0;1.0")
     MeleeFireClass=Class'BWBPOtherPackPro.XOXOMeleeFire'
     BringUpSound=(Sound=Sound'BWBPOtherPackSound.XOXO.XOXO-Pullout')
     PutDownSound=(Sound=Sound'BWBPOtherPackSound.XOXO.XOXO-Putdown')
     MagAmmo=70
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-GemHit',Volume=0.700000)
     ClipOutSound=(Sound=Sound'BWBPOtherPackSound.XOXO.XOXO-MagOut',Volume=0.700000)
     ClipInSound=(Sound=Sound'BWBPOtherPackSound.XOXO.XOXO-MagIn',Volume=0.700000)
     ClipInFrame=0.700000
     bNonCocking=True
     WeaponModes(0)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Bomb",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="Lust Shockwave",ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(3)=(ModeName="Sexplosion",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     SightPivot=(Pitch=768)
     SightOffset=(X=5.000000,Y=0.650000,Z=12.500000)
     SightDisplayFOV=40.000000
     SightingTime=0.300000
     GunLength=128.000000
     HipRecoilFactor=3.500000
     SprintOffSet=(Pitch=-1024,Yaw=-1024)
     AimSpread=16
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=2560
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=-0.015000),(InVal=0.300000,OutVal=0.050000),(InVal=0.600000,OutVal=-0.070000),(InVal=0.700000,OutVal=0.050000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.250000
     FireModeClass(0)=Class'BWBPOtherPackPro.XOXOPrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.XOXOSecondaryFire'
     PutDownAnimRate=1.350000
     PutDownTime=0.600000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.650000
     CurrentRating=0.650000
     bShowChargingBar=True
     Description="Le Big Xoxo. Not a soul knows where this artifact came from or who might have created it. It might have been forged by an ancient, forgotten culture or found its way to us by having traveled through the vastness of space before becoming a fabulous, longish meteor. What matters in the end is, that it is an absolutely marvelous addition to the weapon roster, providing completely diverse firemodes, the ability to deal enormous amounts of damage, heal teammates and even improve upon killing enemies and sucking up their lewdness. Remember: Don't judge a book by its cover. (Although I don't see how this ABSOLUTELY ASTONISHING COVER could possibly lead anyone to underestimate Le Big Xoxo's power.)"
     Priority=38
     HudColor=(B=225,G=155,R=235)
     InventoryGroup=5
     GroupOffset=2
     PickupClass=Class'BWBPOtherPackPro.XOXOPickup'
     PlayerViewOffset=(X=5.000000,Y=6.000000,Z=-9.000000)
     AttachmentClass=Class'BWBPOtherPackPro.XOXOAttachment'
     IconMaterial=Texture'BWBPOtherPackTex.XOXO.SmallIcon_XOXO'
     IconCoords=(X2=127,Y2=31)
     ItemName="Le Big XOXO"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightSaturation=64
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.XOXO_FP'
     DrawScale=0.300000
     bFullVolume=True
     SoundRadius=32.000000
}
