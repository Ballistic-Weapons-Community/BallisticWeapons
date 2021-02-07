//=============================================================================
// Defib Fists Secondary.
//
// Devastating uppercut which can also heal allies.
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class DefibFistsSecondaryFire extends BallisticMeleeFire;

var int				ElectroDamageBonus, ElectroHeal;
var int				RequiredBonusCharge, RequiredShockwaveCharge;
var bool 			bCharged;
var BUtil.FullSound DischargedFireSound;

simulated function bool HasAmmo()
{
	return true;
}
	
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	local BallisticPawn BPawn;
	local int PrevHealth;

	if (Mover(Target) != None || Vehicle(Target) != None)
		return;

	BPawn = BallisticPawn(Target);

	if(IsValidHealTarget(BPawn))
	{
		if (DefibFists(BW).ElectroCharge >= RequiredBonusCharge)
		{
			PrevHealth = BPawn.Health;

			BPawn.GiveAttributedHealth(ElectroHeal, BPawn.HealthMax, Instigator);
			DefibFists(Weapon).PointsHealed += BPawn.Health - PrevHealth;
			DefibFists(BW).ElectroCharge -= RequiredBonusCharge;
			DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
			return;
		}
	}

	if (DefibFists(Weapon).ElectroCharge >= RequiredBonusCharge)
	{
		Damage += ElectroDamageBonus;
		DefibFists(Weapon).ElectroCharge -= RequiredBonusCharge;
	}

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Pawn(Target).AddVelocity(vect(0, 0, 450));
		
	DefibFists(BW).LastRegen = Level.TimeSeconds + 1;
}

function DoFireEffect()
{
	if (DefibFists(Weapon).ElectroCharge >= RequiredShockwaveCharge)
	{
		DefibFists(Weapon).ElectroShockWave(30, 350, class'DTShockGauntletWave', 50000, Instigator.Location);
		DefibFists(Weapon).ElectroCharge -= 30;
		DefibFistsAttachment(Weapon.ThirdPersonActor).DoWave(true);
	}
	Super(BallisticMeleeFire).DoFireEffect();
}

function bool IsValidHealTarget(Pawn Target)
{
	if(Target==None||Target==Instigator)
		return False;

	if(Target.Health<=0)
		return False;
		
	if (!Target.bProjTarget)
		return false;

	if(!Level.Game.bTeamGame)
		return False;

	if(Vehicle(Target)!=None)
		return False;

	return (Target.Controller!=None&&Instigator.Controller.SameTeamAs(Target.Controller));
}

function MeleeDoTrace (Vector InitialStart, Rotator Dir, bool bWallHitter, int Weight)
{
	local int						i;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLocation;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLocation=End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			LastHitLocation=HitLocation;
			// Water
			if (bWallHitter && ((FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume)))
			{
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}
			else
				LastHitLocation=HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				for(i=0;i<SwipeHits.length;i++)
					if (SwipeHits[i].Victim == Other)
					{
						if(SwipeHits[i].Weight < Weight)
						{
							SwipeHits.Remove(i, 1);
							i--;
						}
						else
							break;
					}
				if (i>=SwipeHits.length)
				{
					SwipeHits.Length = SwipeHits.length + 1;
					SwipeHits[SwipeHits.length-1].Victim = Other;
					SwipeHits[SwipeHits.length-1].Weight = Weight;
					SwipeHits[SwipeHits.length-1].HitLoc = HitLocation;
					SwipeHits[SwipeHits.length-1].HitDir = X;
					LastOther = Other;

					if (bWallHitter && Vehicle(Other) != None)
					{
						bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					}
				}
				if (Mover(Other) == None)
					Break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				if (bWallHitter)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * Other.CollisionRadius * 2);
				End = Start + X * Dist;
				continue;
			}
			break;
		}
		else
			break;
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall && bWallHitter)
		NoHitEffect(X, InitialStart, LastHitLocation, WaterHitLoc);
	Weapon.bTraceWater=false;
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (DefibFists(BW).ElectroCharge < 10)
		Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

//Do the spread on the client side
function PlayFiring()
{		
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (DefibFists(BW).ElectroCharge < 10)
			Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

defaultproperties
{
	 DischargedFireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Radius=32.000000,bAtten=True)
	 RequiredBonusCharge=33
	 RequiredShockwaveCharge=75
	 ElectroDamageBonus=50
	 ElectroHeal=50
     FatiguePerStrike=0.150000
     bCanBackstab=False
     Damage=50.000000
     
     TraceRange=(Min=130,Max=130)
     DamageType=Class'BWBPOtherPackPro.DTShockGauntletAlt'
     DamageTypeHead=Class'BWBPOtherPackPro.DTShockGauntletAlt'
     DamageTypeArm=Class'BWBPOtherPackPro.DTShockGauntletAlt'
     KickForce=2500
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
     bAISilent=True
     PreFireAnim="UppercutPrep"
     FireAnim="Uppercut"
     FireAnimRate=1.500000
     FireRate=1.000000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_DefibCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
