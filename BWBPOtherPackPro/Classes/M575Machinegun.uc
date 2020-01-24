class M575Machinegun extends BallisticWeapon;

var   Material		AltScopeTex;
var   bool		bScopeOn;

var   Vector		ScopeSightOffset;
var   name      ScopeOnAnim;
var   name		ScopeOffAnim;
var	  name		ScopeReloadAnim;
var	  name		ScopeCockAnim;
var   name		ScopeIdleAnim;
var   name		ScopePulloutAnim;
var   name		ScopePulloutCockAnim;
var   name		ScopePutawayAnim;

var   name		ScopeFireAnim;
var   name		ScopeAimedFireAnim;

var BUtil.FullSound ScopeZoomInSound, ScopeZoomOutSound;

//Scope Stuff

simulated function AdjustScopeProperties ()
{
	if (bScopeOn)
	{
		//Animations
		
		ReloadAnim=ScopeReloadAnim;
		CockAnim=ScopeCockAnim;
		SelectAnim=ScopePulloutAnim;
		CockSelectAnim=ScopePulloutCockAnim;
		PutDownAnim=ScopePutawayAnim;
		IdleAnim=ScopeIdleAnim;
		M575PrimaryFire(FireMode[0]).AimedFireAnim=ScopeAimedFireAnim;
		M575PrimaryFire(FireMode[0]).FireAnim=ScopeFireAnim;
		
		//Zoom Properties
		
		ZoomInSound=ScopeZoomInSound;
		ZoomOutSound=ScopeZoomOutSound;
		
	}
	else
	{
		//Animations
		
		ReloadAnim=default.ReloadAnim;
		CockAnim=default.CockAnim;
		SelectAnim=default.SelectAnim;
		CockSelectAnim=default.CockSelectAnim;
		PutDownAnim=default.PutDownAnim;
		IdleAnim=default.IdleAnim;
		M575PrimaryFire(FireMode[0]).AimedFireAnim=M575PrimaryFire(FireMode[0]).default.AimedFireAnim;
		M575PrimaryFire(FireMode[0]).FireAnim=M575PrimaryFire(FireMode[0]).default.FireAnim;
		
		//Zoom Properties
		
		ZoomInSound=default.ZoomInSound;
		ZoomOutSound=default.ZoomOutSound;
	}
}

simulated function InitSwitchScope()
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	bScopeOn = !bScopeOn;

	ServerSwitchScope(bScopeOn);
	SwitchScope(bScopeOn);
	AdjustScopeProperties();
}

function ServerSwitchScope(bool bNewValue)
{
	bScopeOn = bNewValue;
	SwitchScope(bNewValue);
	AdjustScopeProperties();
}

simulated function SwitchScope(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(ScopeOnAnim);
	else
		PlayAnim(ScopeOffAnim);
}

simulated function Notify_EndSwitchScope()
{

	if (bScopeOn)
	{
		ZoomType=ZT_Smooth;
		FullZoomFOV=70.000000;
		SightOffset=ScopeSightOffset;
	}
	else
	{
		ZoomType=ZT_Irons;
		FullZoomFOV=default.FullZoomFOV;
		SightOffset=default.SightOffset;
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

simulated function SetScopeBehavior()
{
	bUseNetAim = default.bUseNetAim || bScopeView;
		
	if (bScopeView)
	{
		ViewAimFactor = 1.0;
		ViewRecoilFactor = 1.0;
		AimAdjustTime *= 2;
		AimSpread = 0;
		ChaosAimSpread *= SightAimFactor;
		ChaosDeclineTime *= 2.0;
		ChaosSpeedThreshold *= 0.5;
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

defaultproperties
{
	 ScopeFireAnim="FireScope"
	 ScopeAimedFireAnim="ScopeIn"
	 ScopeSightOffset=(X=2.000000,Y=8.740000,Z=9.150000)
	 ScopeOnAnim="ScopeEngage"
	 ScopeOffAnim="ScopeDisEngage"
	 ScopeReloadAnim="ReloadScope"
	 ScopeCockAnim="CockScope"
	 ScopeIdleAnim="IdleScope"
	 ScopePulloutAnim="PulloutScope"
	 ScopePulloutCockAnim="PulloutCockingScope"
	 ScopePutawayAnim="PutawayScope"
     bScopeOn=False
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
	 ZoomType=ZT_Irons
	 bNoCrosshairInScope=True
     SightPivot=(Pitch=128)
     SightOffset=(X=-10.000000,Y=8.740000,Z=9.150000)
     SightingTime=0.550000
     SightAimFactor=0.700000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     AimSpread=384
     ViewRecoilFactor=0.500000
     ChaosDeclineTime=1.600000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.070000,OutVal=-0.050000),(InVal=0.100000,OutVal=-0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=-0.100000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.450000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=12288.000000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.150000
     FireModeClass(0)=Class'BWBPOtherPackPro.M575PrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.M575SecondaryFire'
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
     PickupClass=Class'BallisticProV55.M353Pickup'
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
