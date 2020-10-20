class M575Machinegun extends BallisticWeapon;

var rotator ScopeSightPivot;
var vector ScopeSightOffset;
var() Material ScopeScopeViewTex;

//===========================================================================
// Dual scoping
//===========================================================================
exec simulated function ScopeView()
{
	if (bNoMeshInScope && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		if (bNoMeshInScope)
		{
			SightPivot = default.SightPivot;
			SightOffset = default.SightOffset;
			ZoomType = ZT_Irons;
			ScopeViewTex=None;
			SightingTime = default.SightingTime;
			bNoMeshInScope = false;
		}
	}
	
	Super.ScopeView();
}

exec simulated function ScopeViewRelease()
{
	if (bNoMeshInScope && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

simulated function ScopeViewTwo()
{
	if (!bNoMeshInScope && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		ScopeViewTex = ScopeScopeViewTex;
		
		if (!bNoMeshInScope)
		{
			SightPivot = ScopeSightPivot;
			SightOffset = ScopeSightOffset;
			ZoomType = ZT_Fixed;
			SightingTime = 0.4;
			bNoMeshInScope = true;
		}
	}
	
	Super.ScopeView();
}

simulated function ScopeViewTwoRelease()
{
	if (!bNoMeshInScope && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

// Swap sighted offset and pivot for left handers
simulated function SetHand(float InHand)
{
	super.SetHand(InHand);
	if (Hand < 0)
	{
		if (bNoMeshInScope)
		{
			SightOffset.Y = ScopeSightOffset.Y * -1;
			SightPivot.Roll = ScopeSightPivot.Roll * -1;
			SightPivot.Yaw = ScopeSightPivot.Yaw * -1;
		}
		
		else
		{
			SightOffset.Y = default.SightOffset.Y * -1;
			SightPivot.Roll = default.SightPivot.Roll * -1;
			SightPivot.Yaw = default.SightPivot.Yaw * -1;
		}
	}
	else
	{
		if (bNoMeshInScope)
		{
			SightOffset.Y = ScopeSightOffset.Y;
			SightPivot.Roll = ScopeSightPivot.Roll;
			SightPivot.Yaw = ScopeSightPivot.Yaw;
		}
		else
		{
			SightOffset.Y = default.SightOffset.Y;
			SightPivot.Roll = default.SightPivot.Roll;
			SightPivot.Yaw = default.SightPivot.Yaw;
		}
	}
}

//End of Scope Stuff

simulated function TickAim(float DT)
{
	Super(BallisticWeapon).TickAim(DT);
}

simulated function PlayReload()
{
	PlayAnim('Reload', ReloadAnimRate, , 0);
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
		
	if(BallisticTurret(Instigator) == None && Instigator.FindInventoryType(class'SandbagLayer') == None)
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

defaultproperties
{
	 ScopeSightPivot=(Roll=-8192)
     ScopeSightOffset=(X=-10.000000,Y=3.750000,Z=13.500000)
	 ScopeScopeViewTex=Texture'BWBPJiffyPackTex.M575.G36ScopeViewDot'
     PlayerSpeedFactor=0.850000
     PlayerJumpFactor=0.900000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBPOtherPackTex2.M575.BigIcon_M575'
     BigIconCoords=(Y1=50,Y2=240)
     SightFXClass=Class'BallisticProV55.M353SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Automatic 5.56mm fire. Has a high rate of fire, moderate damage and good sustained damage output. As a machinegun, it has a very long effective range. Large magazine capacity allows the weapon to fire for a long time, but the reload time is long."
     ManualLines(1)="Deploys the machinegun upon the ground or a nearby wall. May also be deployed upon sandbags. Whilst deployed, becomes perfectly accurate, loses its iron sights and gains a reduction in recoil. Locational damage (damage which can target an area on the body) taken from the front is significantly reduced."
     ManualLines(2)="The M575 is a more cumbersome and heavy weapon, and accordingly has poor hipfire and takes some time to aim.||It is effective at medium to long range."
     SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M353.M353-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M353.M353-Putaway')
     MagAmmo=100
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.M353.M353-Cock')
     ReloadAnimRate=1.450000
     ClipOutSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="Burst of Three")
     WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=3
	 bNoCrosshairInScope=True
     SightPivot=(Pitch=128)
     SightOffset=(X=-10.000000,Y=8.740000,Z=9.150000)
     SightingTime=0.550000
     SightAimFactor=0.700000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     AimSpread=384

     ChaosDeclineTime=1.600000
	 ChaosAimSpread=3072
	 
	Begin Object Class=RecoilParams Name=M575RecoilParams
		ViewBindFactor=0.500000
		XCurve=(Points=(,(InVal=0.070000,OutVal=-0.050000),(InVal=0.100000,OutVal=-0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=-0.100000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.450000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=12288.000000
		DeclineTime=1.500000
		DeclineDelay=0.150000
	End Object
	RecoilParamsList(0)=RecoilParams'M575RecoilParams'

     FireModeClass(0)=Class'BWBPOtherPackPro.M575PrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.M575ScopeFire'
     SelectAnimRate=1.350000
     PutDownTime=0.550000
     BringUpTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     Description="The M353 'Guardian' Machinegun has seen some of the most brutal battles ever recorded in recent history, and has helped win many of them, the most famous being the bloody 'Wasteland Seige' where 12 million Krao were slaughtered along a 500 mile line of defences. Used primarily as a defensive weapon, the M353's incredible rate of fire can quickly and effectively destroy masses of oncoming foes, especially melee attackers. When the secondary mode is activated, the Guardian becomes much more accurate when the user mounts it on the ground, allowing it to be a very effective defensive weapon. With its high rate of fire and high damage, the M353 becomes very inaccurate after just a few rounds and with its high ammo capacity, comes the difficulty of longer reload times than smaller weapons."
     DisplayFOV=50.000000
     Priority=43
     HudColor=(G=150,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBPOtherPackPro.M575Pickup'
     PlayerViewOffset=(X=3.000000,Y=-1.000000,Z=-6.000000)
     AttachmentClass=Class'BWBPOtherPackPro.M575Attachment'
     IconMaterial=Texture'BWBPOtherPackTex2.M575.SmallIcon_M575'
     IconCoords=(X2=127,Y2=31)
     ItemName="M575 Light Machine Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.M575_FP'
     DrawScale=0.350000
}
