//=============================================================================
// M925Machinegun.
//
// Big 50 Cal machinegun with tons of power, a slow fire rate and horrific
// recoil. Based on standard machingun with belt and box, it comes with a
// secondary stand mod for improved accuracy and stability. Heavy MG is lowered
// when sprinting and slows player movement speed.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M925Machinegun extends BallisticMachinegun;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}
simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock=false;
}

function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local int Forward;

	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	// BallisticPro specific: Can be deployed upon sandbags providing that sandbag is not hosting
	// another weapon already. When deployed upon sandbags, the weapon is automatically deployed 
	// to the centre of the bags.
	
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'M925Turret'.default.CollisionHeight + 15;
	}
	
	else
	{
		HitLoc.Z += class'M925Turret'.default.CollisionHeight - 9;
	}
	
	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'M925Turret', None,, HitLoc, CompressedEq);
	
    if (Turret != None)
    {
    	if (Sandbag(T) != None)
			Sandbag(T).AttachedWeapon = Turret;
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for M925 Machinegun.");
}

simulated function PositionSights ()
{
	super.PositionSights();
	if (SightingPhase <= 0.0)
		SetBoneRotation('TopHandle', rot(0,0,0));
	else if (SightingPhase >= 1.0 )
		SetBoneRotation('TopHandle', rot(0,0,-8192));
	else
		SetBoneRotation('TopHandle', class'BUtil'.static.RSmerp(SightingPhase, rot(0,0,0), rot(0,0,-8192)));
}

simulated function Notify_M925HandleOn()
{
	PlaySound(HandleOnSound,,0.5);
}
simulated function Notify_M925HandleOff()
{
	PlaySound(HandleOffSound,,0.5);
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
	local SandbagLayer Bags;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
    }
 	
   	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;
	    

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	if(BallisticTurret(Instigator) == None && Pickup == None && Instigator.IsHumanControlled() && class'SandbagLayer'.static.ShouldGiveBags(Instigator))
    {
        Bags = Spawn(class'SandbagLayer',,,Instigator.Location);
		
		if (Instigator.Weapon == None)
			Instigator.Weapon = Self;
			
        if( Bags != None )
            Bags.GiveTo(Instigator);
    }
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
	BeltLength=8
	BoxOnSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-BoxOn')
	BoxOffSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-BoxOff')
	FlapUpSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-LeverUp')
	FlapDownSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-LeverDown')
	HandleOnSound=Sound'BW_Core_WeaponSound.M925.M925-StandOn'
	HandleOffSound=Sound'BW_Core_WeaponSound.M925.M925-StandOff'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=3)
	TeamSkins(1)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=5)
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_M925'
	BigIconCoords=(Y1=36,Y2=235)
	SightFXClass=Class'BallisticProV55.M925SightLEDs'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)=".50 caliber fire. High damage per shot, but high recoil and fires in semi-automatic mode when not deployed. Has a very long effective range. Large magazine capacity allows the weapon to fire for a long time, but the reload time is long."
	ManualLines(1)="Deploys the machinegun on the ground or a nearby wall. May also be deployed upon sandbags. Whilst deployed, automatic fire is available. Locational damage (damage which can target an area on the body) taken from the front is significantly reduced."
	ManualLines(2)="The M925, as a heavy machine gun, burdens the player, reducing movement speed and jump height. It also has poor shoulder fire properties and a long sighting time.||It is effective at medium to long range and when employed defensively."
	SpecialInfo(0)=(Info="360.0;30.0;0.8;40.0;0.0;0.0;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Putaway')
	CurrentWeaponMode=0
    WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto")
    WeaponModes(1)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(2)=(bUnavailable=True)
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Cock')
	ReloadAnim="ReloadStart"
	ReloadAnimRate=1.150000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-ShellOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-ShellIn')
	bCockOnEmpty=True
	bNoCrosshairInScope=True
	SightPivot=(Pitch=64)
	SightOffset=(X=-18.000000,Z=7.200000)
	SightDisplayFOV=40.000000
	ParamsClasses(0)=Class'M925WeaponParams'
	ParamsClasses(1)=Class'M925WeaponParamsClassic' //todo: turret
	ParamsClasses(2)=Class'M925WeaponParamsRealistic' //todo: turret
	FireModeClass(0)=Class'BallisticProV55.M925PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.M925SecondaryFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=128),StartSize1=94)
    NDCrosshairInfo=(SpreadRatios=(Y2=1.000000))
	MeleeFireClass=Class'BallisticProV55.M925MeleeFire'
	PutDownTime=0.700000
	BringUpTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	Description="The M925 was used during the late stages of the first Human-Skrith war when ballistic weapons first came back into large scale usage. The heavy calibre M925 was extremely effective against the Skrith and their allies and became known as the 'Monster' because it was the first weapon that the Skrith truly feared. Although it has a slower rate of fire than the M353, the 'Monster' has a much heavier bullet and can cause much more damage to an enemy soldier or vehicle in a single shot. It was also used extensively during the 'Wasteland Siege', to hose down thousands of Krao, and proved to be very effective at destroying the alien transport ships, as they were landing."
	Priority=42
	HudColor=(B=175,G=175,R=175)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	GroupOffset=1
	PickupClass=Class'BallisticProV55.M925Pickup'
	PlayerViewOffset=(X=9.000000,Y=5.000000,Z=-7.000000)
	AttachmentClass=Class'BallisticProV55.M925Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_M925'
	IconCoords=(X2=127,Y2=31)
	ItemName="M925 Heavy Machine Gun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=6.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M925'
	DrawScale=0.140000
	Skins(0)=Texture'BW_Core_WeaponTex.M925.M925Main'
	Skins(1)=Texture'BW_Core_WeaponTex.M925.M925Small'
	Skins(2)=Texture'BW_Core_WeaponTex.M925.M925HeatShield'
	Skins(3)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(4)=Texture'BW_Core_WeaponTex.M925.M925AmmoBox'
	Skins(5)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
