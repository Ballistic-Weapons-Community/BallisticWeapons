class LightningRifle extends BallisticWeapon;

var float		            ChargePower;	//Charge power of secondary fire - affects damage, ammo usage and conductivity. Max is 1

var LightningProjectile     ComboTarget;    // used by AI
var bool                    bRegisterTarget;
var bool                    bWaitForCombo;
var vector                  ComboStart;

struct RevInfo
{
	var() name	BoneName;
};

simulated function PostNetBeginPlay()
{
	SetBoneScale(1, 0.0, 'ScreenFlap');
	Super.PostNetBeginPlay();
}

simulated function float ChargeBar()
{
	return ChargePower;
}

simulated function SetChargePower(float NewChargePower)
{
	ChargePower = NewChargePower;
}

// AI Interface =====

function SetComboTarget(LightningProjectile L)
{
    if ( !bRegisterTarget || (bot(Instigator.Controller) == None) || (Instigator.Controller.Enemy == None) )
        return;

    bRegisterTarget = false;
    ComboStart = Instigator.Location;
    ComboTarget = L;
    //ComboTarget.Monitor(Bot(Instigator.Controller).Enemy);
}

function float RangedAttackTime()
{
    local bot B;

    B = Bot(Instigator.Controller);
    if ( (B == None) || (B.Enemy == None) )
        return 0;

    if ( B.CanComboMoving() )
        return 0;

    return FMin(2,0.3 + VSize(B.Enemy.Location - Instigator.Location)/class'LightningProjectile'.default.Speed);
}

simulated function bool StartFire(int mode)
{
    if ( bWaitForCombo && (Bot(Instigator.Controller) != None) )
    {
        if ( (ComboTarget == None) || ComboTarget.bDeleteMe )
            bWaitForCombo = false;
        else
            return false;
    }
    return Super.StartFire(mode);
}

function DoCombo()
{
    if ( bWaitForCombo )
    {
        bWaitForCombo = false;
        if ( (Instigator != None) && (Instigator.Weapon == self) )
            StartFire(0);
    }
}

function byte BestMode()
{
    local float EnemyDist, MaxDist;
    local bot B;

    bWaitForCombo = false;
    B = Bot(Instigator.Controller);
    if ( (B == None) || (B.Enemy == None) )
        return 0;

    if (B.IsShootingObjective())
        return 0;

    if ( !B.EnemyVisible() )
    {
        if ( (ComboTarget != None) && !ComboTarget.bDeleteMe && B.CanCombo() )
        {
            bWaitForCombo = true;
            return 0;
        }
        ComboTarget = None;
        if ( B.CanCombo() && B.ProficientWithWeapon() )
        {
            bRegisterTarget = true;
            return 1;
        }
        return 0;
    }

    EnemyDist = VSize(B.Enemy.Location - Instigator.Location);
    if ( B.Skill > 5 )
        MaxDist = 4 * class'LightningProjectile'.default.Speed;
    else
        MaxDist = 3 * class'LightningProjectile'.default.Speed;

    if ( (EnemyDist > MaxDist) || (EnemyDist < 150) )
    {
        ComboTarget = None;
        return 0;
    }

    if ( (ComboTarget != None) && !ComboTarget.bDeleteMe && B.CanCombo() )
    {
        bWaitForCombo = true;
        return 0;
    }

    ComboTarget = None;

    if ( (EnemyDist > 2500) && (FRand() < 0.5) )
        return 0;

    if ( B.CanCombo() && B.ProficientWithWeapon() )
    {
        bRegisterTarget = true;
        return 1;
    }
    if ( FRand() < 0.7 )
        return 0;
    return 1;
}

function float GetAIRating()
{
    local Bot B;

    B = Bot(Instigator.Controller);
    if ( B == None )
        return AIRating;

    if ( B.Enemy == None )
    {
        if ( (B.Target != None) && VSize(B.Target.Location - B.Pawn.Location) > 8000 )
            return 0.9;
        return AIRating;
    }

    if ( bWaitForCombo )
        return 1.5;
    if ( !B.ProficientWithWeapon() )
        return AIRating;
    if ( B.Stopped() )
    {
        if ( !B.EnemyVisible() && (VSize(B.Enemy.Location - Instigator.Location) < 5000) )
            return (AIRating + 0.5);
        return (AIRating + 0.3);
    }
    else if ( VSize(B.Enemy.Location - Instigator.Location) > 1600 )
        return (AIRating + 0.1);
    else if ( B.Enemy.Location.Z > B.Location.Z + 200 )
        return (AIRating + 0.15);

    return AIRating;
}
// end AI Interface

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.9;	}
// End AI Stuff =====

defaultproperties
{
    ZoomInAnim="ZoomIn"
    ScopeViewTex=Texture'BWBP_OP_Tex.Arc.ARCRifleScope'
    ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
    ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
    FullZoomFOV=20.000000
    bNoCrosshairInScope=True
    SightOffset=(Z=51.000000)
    MinZoom=2.000000
    MaxZoom=8.000000
    ZoomStages=4
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
    BigIconMaterial=Texture'BWBP_OP_Tex.Arc.BigIcon_LightningRifle'
    
    bWT_Bullet=True
    ManualLines(0)="Uncharged lightning bolt shot. Deals reasonable damage for a small ammo cost."
    ManualLines(1)="Charged lightning bolt. The rifle will fire when the fire key is released, or immediately upon becoming fully charged. Damage improves with charge, and more ammo is consumed."
    ManualLines(2)="Upon releasing a charged lightning bolt, the electricity will arc between nearby players. The number of conducting players, radius and damage dropoff depends on the charge."
    SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
    BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Pickup')
    PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Deselect')
    ReloadAnimRate=0.9
    ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.Law-TubeLock')
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Up')
    ClipInFrame=0.650000
    bNonCocking=True
    WeaponModes(0)=(ModeName="Semi")
    WeaponModes(1)=(bUnavailable=True)
    WeaponModes(2)=(bUnavailable=True)
	NDCrosshairCfg=(Pic1=TexRotator'BW_Core_WeaponTex.DarkStar.DarkOutA-Rot',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross4',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=196,G=194,R=191,A=139),Color2=(B=255,G=69,R=0,A=90),StartSize1=96,StartSize2=38)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
    CurrentWeaponMode=0
    GunLength=60.000000
    BobDamping=0.800000
    ParamsClasses(0)=Class'LightningWeaponParamsComp'
    ParamsClasses(1)=Class'LightningWeaponParams'
    ParamsClasses(2)=Class'LightningWeaponParamsTactical'
    ParamsClasses(3)=Class'LightningWeaponParamsTactical'
    FireModeClass(0)=Class'BWBP_OP_Pro.LightningPrimaryFire'
    FireModeClass(1)=Class'BWBP_OP_Pro.LightningSecondaryFire'
    PutDownTime=0.700000
    BringUpTime=0.600000
    SelectForce="SwitchToAssaultRifle"
    AIRating=0.800000
    CurrentRating=0.800000
    bSniping=True
    bShowChargingBar=True
    Description="ARC-79 Lightning Rifle||Manufacturer: JAX Industrial Firm|Primary: Single lightning bolt|Secondary: Charged lightning bolt with arcing to nearby players"
    DisplayFOV=55.000000
    Priority=33
    HudColor=(B=50,G=50,R=200)
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=9
    GroupOffset=2
    PickupClass=Class'BWBP_OP_Pro.LightningPickup'
    PlayerViewOffset=(X=20.000000,Y=16.000000,Z=-30.000000)
    AttachmentClass=Class'BWBP_OP_Pro.LightningAttachment'
    IconMaterial=Texture'BWBP_OP_Tex.Arc.SmallIcon_LightningRifle'
    IconCoords=(X2=127,Y2=31)
    ItemName="ARC-79 Lightning Rifle"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=30
    LightSaturation=150
    LightBrightness=150.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_LightningRifle'
    DrawScale=0.800000
}
