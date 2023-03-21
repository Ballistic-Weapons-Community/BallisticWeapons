class SandbagLayer extends BallisticWeapon;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx

var Sound DropSound;

static function bool ShouldGiveBags(Pawn Other)
{
	local int Count;
	local Inventory Inv;

	if (Other.FindInventoryType(class'SandbagLayer') != None)
		return false;
		
	for (Inv = Other.Inventory; Inv != None && Count < 1000; Count++)
	{
		if (BCGhostWeapon(Inv) != None && BCGhostWeapon(Inv).MyWeaponClass == class'SandbagLayer')
			return false;

		Inv=Inv.Inventory;
	}

	return true;
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		if (Ammo[0].AmmoAmount < 1)
			SaveGhost();
		return true;
	}
	return false;
}

function SaveGhost()
{
	local BCGhostWeapon GW;

	// Save a ghost of this weapon so it can be brought back
	GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);

	if(GW != None)
	{
		GW.MyWeaponClass = class;
		GW.GiveTo(Instigator);
	}
}

function bool CanAttack(Actor Other)
{
	return false;
}

// choose between regular or alt-fire
function byte BestMode()
{
	return 0;
}

function float GetAIRating()
{
	return 0;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
    local vector HitNormal;

	if( DamageType.default.bCausedByWorld || HitLocation.Z < Instigator.Location.Z - 22)
        super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);

    else if ( CheckReflect(HitLocation, HitNormal, 0.6) )
    {
    	if (class<BallisticDamageType>(DamageType).default.bCanBeBlocked)
    	{
    		Damage = 0;
    		Momentum *= 2;
    	}
    	else
    	{
			if (class<DT_BWShell>(DamageType) != None)
				Damage = Max(Damage* 0.5, Damage-35);
			else Damage = Max(Damage * 0.25, Damage-35);
			Momentum *= 4;
		}
		
		AimComponent.ApplyDamageFactor(Damage);
    }

	else super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

function bool CheckReflect( Vector HitLocation, out Vector RefNormal, int AmmoDrain )
{
    local Vector HitDir;
    local Vector FaceDir;

    FaceDir = Vector(Instigator.Controller.Rotation);
    HitDir = Normal(Instigator.Location - HitLocation + Vect(0,0,8));

    RefNormal = FaceDir;

    if ( FaceDir dot HitDir < 0.5 )
        return true;

    return false;
}

function Notify_Deploy ()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local Sandbag Sb;
    local float Forward;

	if (Role < ROLE_Authority)
		return;
		
	if (Instigator.HeadVolume.bWaterVolume)
		return;
		
	// Trace forward and then down. make sure bag is being deployed:
	//  on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	//  May also accept sandbags
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
			
		// Stop abuse.
		End = HitLoc + vect(0,0,100);
		if (!FastTrace(End, HitLoc))
			continue;
			
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && (T.bWorldGeometry && BallisticTurret(T) == None && Sandbag(T) == None) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	CompressedEq = Instigator.Rotation;
	
	//Rotator compression fix
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Sb = Spawn(class'Sandbag', None,, HitLoc, CompressedEq);

    if (Sb == None)
    {
		log("Notify_Deploy: Could not spawn sandbag", 'Warning');
		return;
	}
	
	PlaySound(DropSound);
	ConsumeAmmo(0,1);
	
	if (!HasAmmo())
	{
		SaveGhost();
		AIRating = -999;
		Priority = -999;

		Instigator.Weapon = None;

		if (Instigator!=None && Instigator.Controller!=None && Instigator.PendingWeapon == None)
			Instigator.Controller.ClientSwitchToBestWeapon();

		Destroy();
	}
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bJustSpawned;

    Instigator = Other;

    W = Weapon(Other.FindInventoryType(class));

    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;

        Super(Inventory).GiveTo(Other);

        W = self;

		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;

		ParamsClasses[GameStyleIndex].static.Initialize(self);
    }

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	W.ClientWeaponSet(False);

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

defaultproperties
{
	DropSound=Sound'PlayerSounds.BFootsteps.BFootstepSnow5'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Sandbags.Icon_Sandbags'
	
	SpecialInfo(0)=(Info="240.0;10.0;-999.0;-1.0;-999.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway')
	bNoMag=True
	bUseSights=False
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(ModeName="Place")
	GunLength=0.000000
	ParamsClasses(0)=Class'SandbagWeaponParams'
	ParamsClasses(1)=Class'SandbagWeaponParams'
	ParamsClasses(2)=Class'SandbagWeaponParams'
    ParamsClasses(3)=Class'SandbagWeaponParams'
	FireModeClass(0)=Class'BallisticProV55.SandbagFire'
	FireModeClass(1)=Class'BallisticProV55.SandbagFire'
	PutDownTime=0.900000
	BringUpTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.000000
	CurrentRating=0.000000
	bMeleeWeapon=True
	bNoInstagibReplace=True
	Description="Generic sandbags, as used in militaries for decades. Useful for laying temporary cover. Can be used as a base for most deployed weapons, reducing the chance of the user being directly hit by attacks. May be picked up with the Use key when no other players are near them. Vulnerable to destruction if hit by high-powered weaponry."
	DisplayFOV=65.000000
	Priority=12
	HudColor=(G=200)
	CenteredOffsetY=7.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=0
	GroupOffset=8
	PickupClass=Class'BallisticProV55.SandbagPickup'
	PlayerViewOffset=(X=40.000000,Z=-10.000000)
	AttachmentClass=Class'BallisticProV55.SandbagAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Sandbags.SmallIcon_Sandbags'
	IconCoords=(X2=127,Y2=31)
	ItemName="Sandbags"
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SandBags'
	DrawScale=0.600000
	SoundVolume=150
	TransientSoundRadius=256.000000
}
